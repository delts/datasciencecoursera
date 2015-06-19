# You should create one R script called run_analysis.R that does the following. 
# Step 0 - Install packages to load the necessary data sets.
# Step 1 - Merge the training and the test sets to create a single data set.
# Step 2 - Extract only measurements of mean and SD for each measurement.
# Step 3 - Use descriptive activity names to name the activities in the data set.
# Step 4 - Appropriately labels the data set with descriptive variable names.
# Step 5 - Using data in Step 4, create a second, independent, tidy data set
#          with the average of each variable


# Install the appropriate packages
if (!require("data.table")) {install.packages("data.table")}
if (!require("reshape2")) {install.packages("reshape2")}
require("data.table")
require("reshape2")


# Load and process the test data
activity_labels <- read.table("./UCI HAR Dataset/activity_labels.txt")[,2]
features <- read.table("./UCI HAR Dataset/features.txt")[,2]
  extract_features <- grepl("mean|std", features)
X_test <- read.table("./UCI HAR Dataset/test/X_test.txt")
y_test <- read.table("./UCI HAR Dataset/test/y_test.txt")
subject_test <- read.table("./UCI HAR Dataset/test/subject_test.txt")

names(X_test) = features
X_test = X_test[,extract_features]
y_test[,2] = activity_labels[y_test[,1]]
names(y_test) = c("Activity_ID", "Activity_Label")
names(subject_test) = "subject"


# Bind the multiple tests together
test_data <- cbind(as.data.table(subject_test), y_test, X_test)


# Load and process the train data
X_train <- read.table("./UCI HAR Dataset/train/X_train.txt")
y_train <- read.table("./UCI HAR Dataset/train/y_train.txt")
subject_train <- read.table("./UCI HAR Dataset/train/subject_train.txt")

names(X_train) = features
X_train = X_train[,extract_features]
y_train[,2] = activity_labels[y_train[,1]]
names(y_train) = c("Activity_ID", "Activity_Label")
names(subject_train) = "subject"


# Bind the multiple trains together
train_data <- cbind(as.data.table(subject_train), y_train, X_train)


# Bind the test and train data together
data = rbind(test_data, train_data)


# Creates the initial data set with the proper names
id_labels = c("subject", "Activity_ID", "Activity_Label")
data_labels = setdiff(colnames(data), id_labels)
melt_data = melt(data, id = id_labels, measure.vars = data_labels)


# Creates tidy data with the averages from the prior and outputs it
tidy_data   = dcast(melt_data, subject + Activity_Label ~ variable, mean)
write.table(tidy_data, file = "./tidy_data.txt", row.name = FALSE)