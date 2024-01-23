library(scatterplot3d)
content1=read.csv("/Users/admin/Desktop/code/pod_lean1.csv")
content1=content1[-1,-8]
colnames(content1)[1]  <- "Title"
colnames(content1)[2]  <- "neutral"
colnames(content1)[3]  <- "happy"
colnames(content1)[4]  <- "sad"
colnames(content1)[5]  <- "anger"
colnames(content1)[6]  <- "fear"
colnames(content1)[7]  <- "length"
content1$Title[1:nrow(content1)]=1



content2=read.csv("/Users/admin/Desktop/code/pod_lean2.csv")
content2=content2[-1,-8]
colnames(content2)[1]  = "Title"
colnames(content2)[2]  = "neutral"
colnames(content2)[3]  = "happy"
colnames(content2)[4]  = "sad"
colnames(content2)[5]  = "anger"
colnames(content2)[6]  = "fear"
colnames(content2)[7]  = "length"
content2$Title[1:nrow(content2)]=2
content3=read.csv("/Users/admin/Desktop/code/pod_lean3.csv")
content3=content3[-1,-8]
colnames(content3)[1]  <- "Title"
colnames(content3)[2]  <- "neutral"
colnames(content3)[3]  <- "happy"
colnames(content3)[4]  <- "sad"
colnames(content3)[5]  <- "anger" 
colnames(content3)[6]  <- "fear"
colnames(content3)[7]  <- "length"
content3$Title[1:nrow(content3)]=3


model1 <- lm(content1$length ~  content1$neutral +content1$happy+content1$sad+content1$anger+content1$fear)
summary(model1)
model2 <- lm(content2$length ~  content2$neutral +content2$happy+content2$sad+content2$anger+content2$fear)
summary(model2)
model3 <- lm(content3$length ~  content3$neutral +content3$happy+content3$sad+content3$anger+content3$fear)
summary(model3)
plot(content1$neutral,content1$length)
abline(model1)
plot(content1$happy,content1$length)
abline(model1)
plot(content1$sad,content1$length)
abline(model1)
plot(content1$anger,content1$length)
abline(model1)
plot(content1$fear,content1$length)
abline(model1)

plot(content2$neutral,content2$length)
abline(model2)
plot(content2$happy,content2$length)
abline(model2)
plot(content2$sad,content2$length)
abline(model2)
plot(content2$anger,content2$length)
abline(model2)
plot(content2$fear,content2$length)
abline(model2)

plot(content3$neutral,content3$length)
abline(model3)
plot(content3$happy,content3$length)
abline(model3)
plot(content3$sad,content3$length)
abline(model3)
plot(content3$anger,content3$length)
abline(model3)
plot(content3$fear,content3$length)
abline(model3)
model3$coefficients