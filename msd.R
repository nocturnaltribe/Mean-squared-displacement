rm(list=ls())
#
#------------------ library
suppressMessages (library("magicaxis"))

args <- commandArgs(trailingOnly = TRUE)
infile=args[1]
#
#------------------ imort data
#
base.data = read.table(infile, header = FALSE)
#
#------------------ plotting
#
xsym <- expression(paste(frac(ta^2,D[o])))
ysym <- expression(paste("<",rr,">","/",a^2))
y1sym <- expression(N[sample])

legcol <- rainbow( ncol(base.data)-1 )
#legcol=c('red','blue','black')
lgnd <- c('X', 'Y','Z', y1sym)
ltype <- c(1,1,1,2)

time <- base.data[,1]
msd  <- base.data[,2:4]
Nsamp<- base.data[,5]


pdf("msd.pdf")
y_range <- range(msd,Nsamp)
par(mar=c(5,4,4,5)+.1)
plot(time,msd[,1],'l',col=legcol[1], lty=ltype[1], log = "y", ylim=y_range,xlab='', ylab='', axes=FALSE )
magaxis(side=c(1,2),frame.plot=TRUE,  xlab= xsym, ylab= ysym )
lines(time,msd[,2], lty=ltype[2], col=legcol[2] )
lines(time,msd[,3], lty=ltype[3], col=legcol[3] )
par(new=TRUE)
plot(time,Nsamp,'l', lty=ltype[4], col=legcol[4], xaxt='n',yaxt='n',xlab='',ylab='', axes=FALSE )
magaxis(side=c(1,4),frame.plot=TRUE )
mtext(y1sym,side=4,line=3)
legend("bottomleft", inset=c(0,0),lgnd, lty=ltype, lwd=1, col=legcol)
dev.off()
