summary_table<-final_table%>%group_by(Subjects)%>%distinct(Activities)
summary_table<-data.frame(summary_table)
emptycol<-data.frame(empty = 1:180)
for(i in 3:68){
  print(i)
  summary_table[,i]<-emptycol
}

colnames(summary_table)<-names(final_table)

activity_list<-activity_labels[,2]
activity_list<-sort(activity_list)

count<-1

for(i in 1:30){
  for(j in activity_list){
    temp_table<-filter(final_table, final_table$Subjects == 1, final_table$Activities == j)
    for(k in 3:68){
      summary_table[count,k]<-mean(temp_table[,k])
    }
    
    count<-count + 1
    print(count)   
  }
 
}

write.table(summary_table, "./DataCleaningProj_table2.txt", row.name=FALSE)
