# -*- coding: utf-8 -*-

# @Name: Assignment2.R
# @Auth: CongZhenglong
# @Date: 2023/12/6

rm(list=ls())
getwd()
#设置路径
mypath <- "D:/R_Project/bigdata/homework/homework2/"
filepath = "D:/bigdata/data/assignment_idaccuracy/Aminer/"

file.exists(mypath)
setwd(mypath)
dir()
library("readr")

#1.使用R中的数据读写，文件路径，for循环语句，读入路径“/assignment_idaccuracy/Aminer”总的所有文件，并将数据合并成为一个data.frame输出。
###(1)
setwd(filepath)
file_list <- list.files(pattern = ".csv")
merged_data1 <- data.frame()
# for循环读取文件并合并
for (w in dir(filepath)){
  file <- read.csv(paste(filepath,w,sep=''), header = TRUE)
  merged_data1 <- rbind(merged_data1,file)
}
getwd()
setwd("D:/R_Project/bigdata/homework/homework2/")
write.csv(merged_data1,file="merged_data1.csv",row.names = FALSE)

###(2)
setwd("D:/bigdata/data/assignment_idaccuracy/Aminer/")
files <- list.files("D:/bigdata/data/assignment_idaccuracy/Aminer/")
merged_data2 <- data.frame()
# 用for循环遍历所有文件
for (file in files) {
  data <- read.csv(file, sep = ",", header = TRUE)
  data <- data[,c("doi", "年份", "期刊", "标题","作者") ]
  merged_data2 <- rbind(merged_data2, data)
}
# 导出合并后的data.frame为一个csv文件
getwd()
setwd("D:/R_Project/bigdata/homework/homework2/")
write.csv(merged_data2, file = "merged_data2.csv", row.names = FALSE)

#2.使用apply家族函数替代上述步骤中的for循环
###(1)这个不知道为什么少观测？？？
getwd()
mypath = "D:/bigdata/data/assignment_idaccuracy/Aminer/"
file.exists(mypath)
setwd(mypath)
merged_data3 <- data.frame()
merged_data3 <- do.call(rbind, lapply(files, read.csv))
#输出数据集
getwd()
setwd("D:/R_Project/bigdata/homework/homework2/")
write.csv(merged_data3, "merged_data3.csv", row.names = FALSE)
###(2)
setwd("D:/bigdata/data/assignment_idaccuracy/Aminer/")
merged_data4 <- lapply(list.files(), function(file) {
  data <- read.csv(file, sep = ",", header = TRUE)
  data[, c("doi", "年份", "期刊", "标题","作者")]
})
merged_data4 <- do.call(rbind, merged_data4)
getwd()
setwd("D:/R_Project/bigdata/homework/homework2/")
write.csv(merged_data4, "merged_data4.csv", row.names = FALSE)


#3.函数模块化
# 在命令行输入 Rscript merge_data_script.R 文件所在文件夹路径D:/bigdata/data/assignment_idaccuracy/Aminer/即可运行脚本。
getwd()
source("merge_data_script.R")
