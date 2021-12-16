#######################################################
#
# R in brief
#
# Robert Froese
# School of Forest Resources and Environmental Science
# Michigan Technological University, Houghton MI 49931
#
#######################################################

# R is just an overgrown calculator
2+2
exp(-2)
rnorm(15)

###jdkbckjsbcjksbckjbsdjkbsv

# assignments
x <- 2 
x
x+x
# vectorized arithmetic
weight <- c(60, 72, 57, 90, 95, 72)
weight
height <- c(1.75, 1.80, 1.65, 1.90, 1.74, 1.91)
bmi <- weight/height^2
bmi
sum(weight)
sum(weight)/length(weight)
xbar <- sum(weight)/length(weight)
weight-xbar
(weight-xbar)^2
sum((weight-xbar)^2)
sqrt(sum((weight-xbar)^2)/(length(weight)-1))
mean(weight)
sd(weight)

# vectors
c("Huey","Dewey","Louie")
c('Huey','Dewey','Louie')
c(T,T,F,T)
bmi > 25

# missing values
NA
x <- NA
x
x <- c(NA,NA,NA,NA,NA)
x

# functions that create vectors
c(42,57,12,39,1,3,4)
seq(4,9)
seq(4,10,2)
4:9
oops <- c(7,9,13)
rep(oops,3)
rep(oops,1:3)
rep(1:2,c(10,15))

# matrices and arrays
x <- 1:12
dim(x) <- c(3,4)
x
matrix(1:12,nrow=3,byrow=T)
x <- matrix(1:12,nrow=3,byrow=T)
rownames(x) <- LETTERS[1:3]
x
t(x)
cbind(A=1:4,B=5:8,C=9:12)
rbind(A=1:4,B=5:8,C=9:12)

# data types: factors
pain <- c(0,3,2,2,1)
fpain <- factor(pain,levels=0:3)
levels(fpain) <- c("none","mild","medium","severe")
fpain
as.numeric(fpain)

# data types: lists
intake.pre <- c(5260,5470,5640,6180,6390,6515,6805,7515,7515,8230,8770)
intake.post <- c(3910,4220,3885,5160,5645,4680,5265,5975,6790,6900,7335)
mylist <- list(before=intake.pre,after=intake.post)
mylist
mylist$before

# data types: data frames
d <- data.frame(intake.pre,intake.post)
d
names(d) <- c("before","after")
d$before

# indexing
intake.pre[5]
intake.pre[c(3,5,7)]
v <- c(3,5,7)
intake.pre[v]
intake.pre[1:5]
intake.pre[-c(3,5,7)]

# conditional selection
# comparison operators == != > < >= <=
# logical operators & | !

intake.post[intake.pre > 7000]
intake.post[intake.pre > 7000 & intake.post <= 8000]
intake.pre > 7000 & intake.post <= 8000

# indexing data frames

d <- data.frame(intake.pre,intake.post)
d[5,1]
d[5,]
d[d$intake.pre>7000,]
i <- d$intake.pre>7000
i
d[i,]

# reading and writing data from files
redpine <- read.table(file="../data.raw/redpinedata.csv",sep=",",header=T)
#write.table(redpine,file="redpinedata.csv",sep=",")
save(redpine,file="redpinedata.Rdata")
load(file="redpinedata.Rdata")

# grouped data
ex <- redpine[redpine$plot==1,]
ex
ex.JP <- ex[ex$spp=="JP",]
ex.JP

# sorting
ex$spp
sort(ex$spp)
order(ex$spp)
ex[order(ex$spp),]
ex[order(ex$spp,ex$dbh),]

# implicit looping
m <- matrix(rnorm(12),4)
m
apply(m,1,min)
tapply(redpine$dbh,list(redpine$spp),mean)
tapply(redpine$dbh,list(redpine$spp,redpine$plot),mean)
table(redpine$spp,redpine$plot)

# graphics
plot(ex$dbh,ex$ht,xlab="",ylab="",col="red")
title(main="Hypothetical Red Pine Data", xlab="DBH (in.)",ylab="Height (ft).")
abline(0,3)
hist(redpine$dbh,xlim=c(0,30),ylim=c(0,10),xlab="",ylab="",main="")
title(main="Hypothetical Red Pine Data", xlab="DBH (in.)",ylab="Height (ft).")
    
# writing graphics to files
pdf(file="myplot.pdf")
 plot(ex$dbh,ex$ht,xlab="",ylab="",col="red")
 title(main="Hypothetical Red Pine Data", xlab="DBH (in.)",ylab="Height (ft).")
 abline(0,3)
dev.off()

# looping
x <- seq(0,1,.05)
plot(x,x,ylab="y",type="l")
for (j in 2:8) {
  lines(x,x^j)
}

# if
if(mean(ex$dbh)<10) stand <- "small" else stand <- "large"
stand

# misc
ls()
rm("stand")
ls()
?plot
help.search("regres*")
fix(redpine)

# bringing it all together
par(mfrow=c(3,1))
for (p in 1:3) {
  i <- redpine$plot==p
  plot(redpine$dbh[i],redpine$ht[i],ylab="Height (ft)",xlab="DBH (in)",main=paste("Sample Plot",p))
}
par(mfrow=c(1,1))
clist <- c("red","blue","green")
plot(0,0,type="n",xlim=c(0,max(redpine$dbh)),ylim=c(0,max(redpine$ht)),ylab="Height (ft)",xlab="DBH (in)",main="Red Pine by Sample Plot")
for (p in 1:3) {
  i <- redpine$plot==p
  points(redpine$dbh[i],redpine$ht[i],col=clist[p])
}
legend(15,15,legend=c("Plot 1","Plot 2","Plot 3"),col=clist,pch=1)

#######################################################