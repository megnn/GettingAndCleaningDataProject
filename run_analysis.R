
#Begin by loading the data into R

features <- read.table('~/data/UCIHAR/features.txt',header=FALSE); 
activityType <- read.table('~/data/UCIHAR/activity_labels.txt',header=FALSE); 
subjectTrain <- read.table('~/data/UCIHAR/train/subject_train.txt',header=FALSE); 
xTrain <- read.table('~/data/UCIHAR/train/x_train.txt',header=FALSE); 
yTrain <- read.table('~/data/UCIHAR/train/y_train.txt',header=FALSE); 


colnames(activityType)  = c('activityId','activityType');
colnames(subjectTrain)  = "subjectId";
colnames(xTrain) = features[,2]; 
colnames(yTrain) = "activityId";

#Merges the training and the test sets to create one data set.

trainingData = cbind(yTrain,subjectTrain,xTrain);


subjectTest = read.table('~/data/UCIHAR/test/subject_test.txt',header=FALSE); 
xTest = read.table('~/data/UCIHAR/test/x_test.txt',header=FALSE); 
yTest = read.table('~/data/UCIHAR/test/y_test.txt',header=FALSE); 

colnames(subjectTest) = "subjectId";
colnames(xTest) = features[,2]; 
colnames(yTest) = "activityId";


# Create the final test set by merging the xTest, yTest and subjectTest data and training and test data for final data set
testData = cbind(yTest,subjectTest,xTest);
finalData = rbind(trainingData,testData);


colNames  = colnames(finalData); 

# Create a logicalVector that contains TRUE values for the ID, mean() & stddev() columns and FALSE for all others
logicalVector = (grepl("activity..",colNames) | grepl("subject..",colNames) | grepl("-mean..",colNames) & !grepl("-meanFreq..",colNames) & !grepl("mean..-",colNames) | grepl("-std..",colNames) & !grepl("-std()..-",colNames));

finalData = finalData[logicalVector==TRUE];


# Merge the finalData set with the acitivityType table to include descriptive activity names
finalData = merge(finalData,activityType,by='activityId',all.x=TRUE);

# Updating the colNames vector to include the new column names after merge
colNames  = colnames(finalData); 

#Appropriately label the data set with descriptive activity names. 

# Cleaning up the variable names
for (i in 1:length(colNames)) 
{
  colNames[i] = gsub("\\()","",colNames[i])
  colNames[i] = gsub("-std$","StdDev",colNames[i])
  colNames[i] = gsub("-mean","Mean",colNames[i])
  colNames[i] = gsub("^(t)","time",colNames[i])
  colNames[i] = gsub("^(f)","freq",colNames[i])
  colNames[i] = gsub("([Gg]ravity)","Gravity",colNames[i])
  colNames[i] = gsub("([Bb]ody[Bb]ody|[Bb]ody)","Body",colNames[i])
  colNames[i] = gsub("[Gg]yro","Gyro",colNames[i])
  colNames[i] = gsub("AccMag","AccMagnitude",colNames[i])
  colNames[i] = gsub("([Bb]odyaccjerkmag)","BodyAccJerkMagnitude",colNames[i])
  colNames[i] = gsub("JerkMag","JerkMagnitude",colNames[i])
  colNames[i] = gsub("GyroMag","GyroMagnitude",colNames[i])
};

# Reassigning the new descriptive column names to the finalData set
colnames(finalData) = colNames;

#Create a second, independent tidy data set with the average of each variable for each activity and each subject. 

finalDataNoActivity  = finalData[,names(finalData) != 'activityType'];

tidyData    = aggregate(finalDataNoActivity[,names(finalDataNoActivity) != c('activityId','subjectId')],by=list(activityId=finalDataNoActivity$activityId,subjectId = finalDataNoActivity$subjectId),mean);

tidyData    = merge(tidyData,activityType,by='activityId',all.x=TRUE);

write.table(tidyData, './tidyData.txt',row.names=TRUE,sep='\t');
