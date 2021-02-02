# equivalent of stata's "merge 1:1 ..." command to get the _merge indicator variable!
stata_merge <- function(x,y){
  x$new1 = 1
  y$new2 = 2
  df = full_join(x,y,by = c("source","sourceid"))
  df$merge_result = rowSums(df[,c("new1", "new2")], na.rm=TRUE)
  df$new1 = NULL
  df$new2= NULL
  return(df)
}