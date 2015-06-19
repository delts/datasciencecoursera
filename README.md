Step 0 - Sets up requirements for installation of the mandatory packages
         for loading the important data sets to work with
Step 1 - Using multiple steps of cbind and rbind, merge the training and
         test sets to create a single data set
Step 2 - Extract only the measurements of mean and SD for each of the
         data using extract_features
Step 3 - Use descriptive activity names to name the activities within
         the dataset, something available to us within the package
Step 4 - Create a melt data set which has the variables appropriately
         described and labeled
Step 5 - Using the data in Step 4, create a second, independent, tidy
         data set with the average of each variable
