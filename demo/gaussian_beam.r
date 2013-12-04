
## ----, echo=FALSE,results='hide'-----------------------------------------
library(knitr)
library(ggplot2)
opts_chunk$set(fig.path="gaussianbeam/",
               warning=FALSE,error=FALSE,message=FALSE,tidy=TRUE)
library(ggplot2)
theme_set(theme_minimal() + theme(panel.border=element_rect(fill=NA)))


## ----, results='hide'----------------------------------------------------
library(planar)
library(ggplot2)
library(plyr)
w0 <- 1e3 # beam waist 1 micron
alpha <- 70*pi/180 # incident angle


## ----depth---------------------------------------------------------------
xyz <- as.matrix(expand.grid(x=seq(5e3,5e4,length=10), y=0, z=seq(1, 500, length=50)))
res <- adply(xyz, 1, gaussian_field, 
             wavelength=500, w0=w0, ni=1.5+0i, alpha=alpha, maxEval=500)
xyz <- data.frame(xyz, field=res[[2]])
ggplot(xyz, aes(z, field, colour=x, group=x))+
  geom_line()



## ----GH------------------------------------------------------------------
xyz <- as.matrix(expand.grid(x=seq(-5*w0, 5*w0,length=200), y=0, z=seq(0, 100,by=10)))
res <- adply(xyz, 1, gaussian_field, wavelength=500, psi=pi/2, maxEval = 1000, 
             w0=w0, ni=1.5+0i, alpha=alpha)
xyz <- data.frame(xyz, field=res[[2]])

ggplot(xyz, aes(x, field, colour=z, group=z))+
  geom_line() +
  geom_vline(aes(x=0,y=NULL),lty=2)


## ----map-----------------------------------------------------------------
xyz <- as.matrix(expand.grid(x=seq(-3*w0, 3*w0, length=50), y=seq(-3*w0, 3*w0, length=50),
                             z=10))
res <- adply(xyz, 1, gaussian_field, wavelength=500, maxEval = 200, 
             w0=w0, ni=1.5+0i, alpha=alpha)
xyz <- data.frame(xyz, field=res[[2]])

  ggplot(xyz, aes(x/1e3, y/1e3, fill=field))+
  geom_raster(interpolate=TRUE) +
  scale_x_continuous(expand=c(0,0))+
  scale_y_continuous(expand=c(0,0)) +
  labs(x="x / um", y="y / um", fill=expression("|E|"^2)) + 
  coord_fixed()


