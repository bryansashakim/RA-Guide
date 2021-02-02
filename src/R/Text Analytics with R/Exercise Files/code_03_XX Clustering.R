#**************************************************************************
#                  Chapter 3 : Clustering
#**************************************************************************

#install.packages("tm")
library(tm)

#--------------------------------------------------------------------------
#                  3.2 : Preparing data for Clustering
#--------------------------------------------------------------------------

#Read movie hashtags into a data frame
movie_hashtags <- read.csv("C:/Users/Kumaran Ponnambalam/Desktop/Exercise Files/hashtags/Course-Hashtags.csv")
movie_hashtags

#Load hastags into a corpus
hashtags <- VCorpus(VectorSource(movie_hashtags$HashTags))

#replace comma with spaces
clean_hashtags <- tm_map(hashtags, 
                         content_transformer(
                            function(x) gsub(","," ",x)
                            )
                         )

inspect(clean_hashtags[[1]])

#Generate the Document Term matrix
hashtags_dtm <- DocumentTermMatrix(clean_hashtags)

#Inspect to Document Term matrix
inspect(hashtags_dtm)

#--------------------------------------------------------------------------
#                  3.3 : K-Means Clustering
#--------------------------------------------------------------------------

#Setting the seed ensures repeatable results
set.seed(100)

#Create 3 clusters
movie_clusters <-  kmeans(hashtags_dtm, 3)

#Inspect the results
movie_clusters$cluster

#Add cluster information to the original data frame 
for ( movie in 1:nrow(movie_hashtags)) {
  movie_hashtags$Cluster[movie] = movie_clusters$cluster[movie]
}

#Sort by cluster and review results
print(movie_hashtags[order(movie_hashtags$Cluster),c(1,3)]  )

#--------------------------------------------------------------------------
#                  3.4 : K-Means Optimization
#--------------------------------------------------------------------------

#Function to find the optimum no. of clusters
optimal_cluster_plot <- function(data, iterations=10, seed=1000){
  
  #Set within-sum-of-squares for a single cluster
  wss <- (nrow(data)-1)*sum(apply(data,2,var))
  
  #Iterate upto 10 clusters and measure wss.
  for (i in 2:iterations){
    set.seed(seed)
    wss[i] <- sum(kmeans(data, centers=i)$withinss)
  }
  
  #Plot wss for each value of k and find the elbow
  plot(1:iterations, wss, type="b", xlab="Number of Clusters",
       ylab="Within groups sum of squares", col="red")}

#Execute the function
optimal_cluster_plot(hashtags_dtm)

#--------------------------------------------------------------------------