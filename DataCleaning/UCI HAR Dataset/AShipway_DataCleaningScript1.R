library(dplyr)

test_data<-read.table("./test/X_test.txt")
test_subjects<-read.table("test/subject_test.txt")
test_activities<-read.table("test/y_test.txt")

train_data<-read.table("./train/X_train.txt")
train_subjects<-read.table("train/subject_train.txt")
train_activities<-read.table("train/y_train.txt")

variable_names<-read.table("features.txt")
activity_labels<-read.table("activity_labels.txt")

test_activities2<-left_join(test_activities, activity_labels, by = "V1")
train_activities2<-left_join(train_activities, activity_labels, by = "V1")

test_table<-test_subjects
test_table$Activities<-test_activities2$V2
colnames(test_table)<-c("Subjects", "Activities")
colnames(test_data)<-variable_names$V2



train_table<-train_subjects
train_table$Activities<-train_activities2$V2
colnames(train_table)<-c("Subjects", "Activities")
colnames(train_data)<-variable_names$V2

variable_names<-variable_names$V2

meanloc<-grepl("mean()", variable_names)
meanFreqloc<-grepl("meanFreq", variable_names)
meanlocfinal<-(meanloc & !meanFreqloc)
stdloc<-grepl("std()", variable_names)
locfinal<-(meanlocfinal | stdloc)

for(i in 1:561){
  
  index<-locfinal[i]
  
  if(index){
    
    colname<-variable_names[i]
    
    test_table[[colname]]<-test_data[,i]
    train_table[[colname]]<-train_data[,i]
  }
}

final_table<-rbind(test_table, train_table)
final_table<-final_table[order(final_table$Subjects, final_table$Activities),]

write.table(final_table, "./DataCleaningProj_table1.txt", row.name=FALSE)