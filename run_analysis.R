## load the x training data

# set pwd / temporary
setwd("~/Documents/@Learning/coursera/getData/project")

# --------------------------------------------------------------------------------------------------
### Let's import the training data, and append subject and activity to the data frame

# load x variables (561 variables * 7352 observations)
x_train <- read.table("UCI\ HAR\ Dataset/train/X_train.txt") 

# load activity id (1 variable * 7351 observations)
y_train <- read.table("UCI\ HAR\ Dataset/train/Y_train.txt")

# load subject for whom the observations were made
sbj_train <- read.table("UCI\ HAR\ Dataset/train/subject_train.txt")

## put together the subject, activity_id, and the x variables
sbj_xy_train <- cbind(sbj_train, y_train, x_train)

# --------------------------------------------------------------------------------------------------
### Let's import the test data, and append subject and activity to the data frame

# load x variables (561 variables * 7352 observations)
x_test <- read.table("UCI\ HAR\ Dataset/test/X_test.txt") 

# load activity id (1 variable * 7351 observations)
y_test <- read.table("UCI\ HAR\ Dataset/test/Y_test.txt")

# load subject for whom the observations were made
sbj_test <- read.table("UCI\ HAR\ Dataset/test/subject_test.txt")

## put together the subject, activity_id, and the x variables
sbj_xy_test <- cbind(sbj_test, y_test, x_test)

# --------------------------------------------------------------------------------------------------
### Merge the training and the test sets to create one data set.
sbj_xy_all <- rbind (sbj_xy_train, sbj_xy_test)

# --------------------------------------------------------------------------------------------------
###  Use descriptive activity names to name the activities in the data set

# load the activity labels table from provided file
activity_labels <- read.table("UCI\ HAR\ Dataset/activity_labels.txt")

# convert ACTIVITY key to label name (eg. convert 1,2,..etc info WALKING, WALKING_UPSTAIRS, ..etc.)

sbj_xy_all_labeled <- sbj_xy_all
for (i in 1:nrow(activity_labels)) {
    activity_key   <- activity_labels[i,1]
    activity_label <- as.character(activity_labels[i,2])
    sbj_xy_all_labeled[sbj_xy_all[2] == activity_key,2] <- activity_label
}

# --------------------------------------------------------------------------------------------------
### Add appropriate labels to the entire data set, based on the activity labels that were defined in the data provided
# we will replace those we choose to keep with much more descriptive names later

# let's start with the provided features.txt file to label our data, for a start
feature_names <- read.table("UCI\ HAR\ Dataset/features.txt")

# the first two columns are the subject id, and activity name; the rest are the 561 feature names
colnames(sbj_xy_all_labeled) <- c("Subject", "Activity", as.vector(feature_names[[2]]))


# --------------------------------------------------------------------------------------------------
### Extracts only the measurements on the mean and standard deviation for each measurement.
# we use grep to extract the names that end in -mean() but doesn't include columns that contain meanFreq

mean_feature_names <- feature_names[grep (".*-mean[(]+.*[XYZ]$", feature_names[[2]], perl=TRUE),]
std_feature_names <- feature_names[grep (".*-std[(].*[XYZ]", feature_names[[2]], perl=TRUE),]

mean_and_stddev_names <- c("Subject", "Activity",
                            as.vector(mean_feature_names[[2]])
                            ,as.vector(std_feature_names[[2]]))

select_sbj_xy_all_labeled <- sbj_xy_all_labeled[mean_and_stddev_names]

# --------------------------------------------------------------------------------------------------
### Appropriately labels the data set with descriptive variable names. 
# We have stored descriptive label names in file "better_labels.txt"
# .. which we will use to replace the standard label

better_labels <- read.table("UCI\ HAR\ Dataset/better_labels.txt", sep=",", header=TRUE)

colnames(select_sbj_xy_all_labeled) <- c(as.vector(better_labels[[2]]))

# - Appropriately labels the data set with descriptive variable names. 

# --------------------------------------------------------------------------------------------------
###  From the data set in step 4, creates a second, independent tidy data
### set with the average of each variable for each activity and each subject.

aggregate_data <- aggregate(select_sbj_xy_all_labeled, by=list(select_sbj_xy_all_labeled$Subject, select_sbj_xy_all_labeled$Activity), FUN=mean, na.rm=TRUE)

aggregate_data["Subject"] <- NULL
aggregate_data["Activity"] <- NULL
colnames(aggregate_data)[1] <- "Subject"
colnames(aggregate_data)[2] <- "Activity"

aggregate_data_sort <- agg[order(agg$Subject),]

# let's write the new tidy data to a file:

write.table(aggregate_data_sort, file = "tidy_aggregate_data.txt")
