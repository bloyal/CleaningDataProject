paths <- c(
        "subject_test" = "C:\\Users\\BBLOYA\\Documents\\GitHub\\CleaningDataProject\\UCI HAR Dataset\\test\\subject_test.txt",
        "X_test" = "C:\\Users\\BBLOYA\\Documents\\GitHub\\CleaningDataProject\\UCI HAR Dataset\\test\\X_test.txt",
        "y_test" = "C:\\Users\\BBLOYA\\Documents\\GitHub\\CleaningDataProject\\UCI HAR Dataset\\test\\y_test.txt",
        "subject_train" = "C:\\Users\\BBLOYA\\Documents\\GitHub\\CleaningDataProject\\UCI HAR Dataset\\train\\subject_train.txt",
        "X_train" = "C:\\Users\\BBLOYA\\Documents\\GitHub\\CleaningDataProject\\UCI HAR Dataset\\train\\X_train.txt",
        "y_train" = "C:\\Users\\BBLOYA\\Documents\\GitHub\\CleaningDataProject\\UCI HAR Dataset\\train\\y_train.txt",
        "features" = "C:\\Users\\BBLOYA\\Documents\\GitHub\\CleaningDataProject\\UCI HAR Dataset\\features.txt",
        "activities" = "C:\\Users\\BBLOYA\\Documents\\GitHub\\CleaningDataProject\\UCI HAR Dataset\\activity_labels.txt"
        )


## open files and load into a list of 6 data
loadData <- function(paths){

        rawData <- list(
                "subjectTest" =  read.table(paths["subject_test"]),
                "XTest" = read.table(paths["X_test"]),
                "yTest" = read.table(paths["y_test"]),
                "subjectTrain" = read.table(paths["subject_train"]),
                "XTrain" = read.table(paths["X_train"]),
                "yTrain" = read.table(paths["y_train"])                
                )        
}

##create vector of feature names
getFeatureNames <- function(featurePath){
        features<-read.table(featurePath)  
        as.character(features[,2])
}

##create activity lookup table
getActivityNames <- function(activityPath){
        activities<-read.table(activityPath)
        colnames(activities)<-c("index","activityName")
        activities
}

##combine subject, X, and y tables into single data frame
createDataSet <- function(rawDataList, features){
        testSet<- cbind(rawDataList[["subjectTest"]],rawDataList[["yTest"]],rawDataList[["XTest"]])
        colnames(testSet) <- c("subjects","activities",features)
        trainSet<- cbind(rawDataList[["subjectTrain"]],rawDataList[["yTrain"]],rawDataList[["XTrain"]])
        colnames(trainSet) <- c("subjects","activities",features)        
        rbind(testSet,trainSet)
}

##filter out for only mean and standard deviation columns using regular expression
selectMeanAndStdData <- function(dataSet){
        selections<-c(1,2,grep("mean\\(\\)",names(dataSet)),grep("std\\(\\)",names(dataSet)))
        dataSet[,selections]        
}

##use merge() function to perform inner join on mean and standard deviation data and activity lookup table
labelActivities <- function(dataSet,activityLookup){
        merge(x=dataSet,y=activityLookup,by.x="activities",by.y="index")   
}

##create summarized, tidy data set with the average values of each variable by activity and subject
summarizeData <- function(labeledDataSet){
        #this isn't done!
        by(labeled[,c(3:68)],labeled$activityName,colMeans, simplify=TRUE)        
}
