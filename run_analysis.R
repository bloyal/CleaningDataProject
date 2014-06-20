paths <- c(
        "subject_test" = "C:\\Users\\BBLOYA\\Documents\\GitHub\\CleaningDataProject\\UCI HAR Dataset\\test\\subject_test.txt",
        "X_test" = "C:\\Users\\BBLOYA\\Documents\\GitHub\\CleaningDataProject\\UCI HAR Dataset\\test\\X_test.txt",
        "y_test" = "C:\\Users\\BBLOYA\\Documents\\GitHub\\CleaningDataProject\\UCI HAR Dataset\\test\\y_test.txt",
        "subject_train" = "C:\\Users\\BBLOYA\\Documents\\GitHub\\CleaningDataProject\\UCI HAR Dataset\\train\\subject_train.txt",
        "X_train" = "C:\\Users\\BBLOYA\\Documents\\GitHub\\CleaningDataProject\\UCI HAR Dataset\\train\\X_train.txt",
        "y_train" = "C:\\Users\\BBLOYA\\Documents\\GitHub\\CleaningDataProject\\UCI HAR Dataset\\train\\y_train.txt",
        "features" = "C:\\Users\\BBLOYA\\Documents\\GitHub\\CleaningDataProject\\UCI HAR Dataset\\features.txt"
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


getFeatureNames <- function(featurePath){
        features<-read.table(featurePath)  
        as.character(features[,2])
}

##combine subject, X, and y tables into single data frame
createDataSet <- function(rawDataList, features){
        testSet<- cbind(rawDataList[["subjectTest"]],rawDataList[["yTest"]],rawDataList[["XTest"]])
        colnames(testSet) <- c("subjects","activities",features)
        trainSet<- cbind(rawDataList[["subjectTrain"]],rawDataList[["yTrain"]],rawDataList[["XTrain"]])
        colnames(trainSet) <- c("subjects","activities",features)
        
        rbind(testSet,trainSet)
}