#Set working directory. The data files( folder UCI HAR Dataset should present in this directory)
WD <- getwd()
if (!is.null(WD)) setwd(WD)

#Read files X_test,X_train.y_test,y_train,Subject_test,Subject_train,features and activity_lables text files into dataframes
x_train <- read.table("~\\UCI HAR Dataset\\train\\X_train.txt", header = FALSE, sep="")
y_train <- read.table("~\\UCI HAR Dataset\\train\\y_train.txt", header = FALSE, sep="")
subject_train <- read.table("~\\UCI HAR Dataset\\train\\subject_train.txt", header = FALSE, sep="")
x_test <- read.table("~\\UCI HAR Dataset\\test\\X_test.txt", header = FALSE, sep="")
y_test <- read.table("~\\UCI HAR Dataset\\test\\y_test.txt", header = FALSE, sep="")
subject_test <- read.table("~\\UCI HAR Dataset\\test\\subject_test.txt", header = FALSE, sep="")
features <- read.table("~\\UCI HAR Dataset\\features.txt", header = FALSE, sep="")
act <- read.table("~\\UCI HAR Dataset\\activity_labels.txt", header = FALSE, sep="")

#Column bind Dataframes y_test and subject_test and add column names Activity and Subject to it. ->A
A <- cbind(y_test, subject_test)
names(A) <- c("Activity", "Subject")

#Column bind Dataframes y_train and subject_train and add column names Activity and Subject to it. ->B
B <- cbind(y_train, subject_train)
names(B) <- c("Activity", "Subject")

#Merge or Row bind A and B(test and train activity and subject)  ->C
C <- rbind(A,B)

#Row bind test and train data  ->D
D <- rbind(x_test,x_train )

names(D) <- features[,2]


#Eliminate columns from D which do not have "mean()" or "std()" in the column names. ->E 

E <- D[, (grepl ("mean", names(D)) |  grepl ("std", names(D)))]

F <- cbind(C,E)



if("data.table" %in% rownames(installed.packages()) == FALSE) {install.packages("data.table")}

library(data.table)

#Calculate mean for all columns except activity and subject 
#Store the column names other than Activity and subject to keys vector
keys <- setdiff(names(F), c("Activity","Subject") )
F1 <- data.table(F)
meanF <- F1[, lapply(.SD, mean), by=c("Activity","Subject"), .SDcols=keys]

# Join meanF and act on primaty key Activity
setkey(meanF, Activity)
act <- data.table(act)
setkey(act, V1)
#merges datasets meanF and Activity labels(act)
finalmeanF <- na.omit(meanF[act])

#Replace activity numbers by descriptive labels
# remove activity id column
finalmeanF <- subset( finalmeanF, select = -Activity )
library(plyr)
finalmeanF <- rename(finalmeanF,c('V2'='ActivityName'))

# write dataset to text file - 180 observations
write.table(finalmeanF, file="~\\tidydataset.txt", sep = " ", row.names=FALSE)

