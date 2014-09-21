#stringr library for string related functions
library(stringr)

#reading list of attributes
features <- read.table("features.txt")
names(features) <- c("featureid","feature_name")

activitylist <- read.table("activity_labels.txt")
names(activitylist) <- c("activityid","activity_name")

#identifying indexes of attributes which have -mean() and -std() as part of their names. These
#are the only relevant ones
relevantfeaturesind <- c(which(!is.na(str_match(features$feature_name, "-mean\\(\\)"))),
                         which(!is.na(str_match(features$feature_name, "-std\\(\\)"))))
relevantfeaturesind <- relevantfeaturesind[order(relevantfeaturesind)]

#reading train data set activity
trainactivity <- read.table("train/y_train.txt")
names(trainactivity) <- "activityid"

#reading train data set subject
trainsubject <- read.table("train/subject_train.txt")
names(trainsubject) <- "subject"

#reading and filtering out only relevant attributes from train data set
traindata  <- read.table("train/X_train.txt")
relevanttraindata <- traindata[,relevantfeaturesind]
names(relevanttraindata) <- features$feature_name[relevantfeaturesind]

#making tidy train data by clubbing subject,activity and the actual train data
tidytraindata <- cbind(trainsubject,trainactivity,relevanttraindata)


#reading test data set activity
testactivity <- read.table("test/y_test.txt")
names(testactivity) <- "activityid"

#reading test data set subject
testsubject <- read.table("test/subject_test.txt")
names(testsubject) <- "subject"

#reading and filtering out only relevant attributes from test data set
testdata  <- read.table("test/X_test.txt")
relevanttestdata <- testdata[,relevantfeaturesind]
names(relevanttestdata) <- features$feature_name[relevantfeaturesind]

#making tidy test data by clubbing subject, activity and actual test data
tidytestdata <- cbind(testsubject,testactivity,relevanttestdata)

#clubbing train and test data
df1 <- rbind(tidytraindata,tidytestdata)

#Getting activiy name by joining with activity list
tidydata <- merge(df1,activitylist, by = "activityid")

#ordering the columnns so that activity id and name are together
tidydata <- tidydata[, c(2,1,69,c(3:68))]

#ordering the rows
tidydata <- tidydata[order(tidydata$subject,tidydata$activityid),]

#computing mean of values for every subject and activity combination
df2 <- aggregate(tidydata[,-3], by = list(tidydata$subject,tidydata$activityid),  FUN = mean)

#removing two additional columns created by aggregate function
df2 <- df2[,c(-1,-2)]

#Getting activity name by joining with activity list
aggdata <- merge(df2,activitylist, by = "activityid")

#ordering the columnns so that activity id and name are together
aggdata <- aggdata[, c(2,1,69,c(3:68))]

#ordering the rows
aggdata <- aggdata[order(aggdata$subject,aggdata$activityid),]

#removing row names
rownames(aggdata) <- NULL

#writing output to text file
write.table(aggdata, file = "output.txt", row.names = FALSE)