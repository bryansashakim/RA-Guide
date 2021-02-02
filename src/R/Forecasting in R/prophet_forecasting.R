############################################
## prophet package - used for forecasting ## 
############################################
library(prophet);library(ggplot2)
df=read.csv("/Users/bryankim/Documents/TEMPORARY FILES/example_wp_log_peyton_manning.csv")
# fit a model to your historical data. You do this by calling the prophet() function using your prepared dataframe as an input:
m=prophet(df) # ** need ds and y columns  
# you can now start making predictions for future dates. 
# Prophet has a built-in helper function make_future_dataframe to create a dataframe of future dates. 
# The make_future_dataframe function lets you specify the frequency and number of periods you would like 
# to forecast into the future. By default, the frequency is set to days. Since we are using daily periodicity data in 
# this example, we will leave freq at it’s default and set the periods argument to 365, indicating that we would 
# like to forecast 365 days into the future.
future <- make_future_dataframe(m, periods = 365); tail(future)
# We can now use the predict() function to make predictions for each row in the future dataframe.
forecast <- predict(m, future); tail(forecast[c('ds', 'yhat', 'yhat_lower', 'yhat_upper')])

#########
# plots # uses ggplot2 within the package!!
#########
plot(m, forecast) +
  xlab("Date") +
  ylab("Data") +
  theme_bw() + 
  theme_bw() + 
  theme(panel.grid.major = element_blank(),
        panel.grid.minor = element_blank(), 
        axis.line = element_line(colour = "black")) +
  ggtitle("Learning How to Use Prophet")
# or interactively
dyplot.prophet(m, forecast)
# If you want to visualize the individual forecast components, you can use Prophet’s built-in plot_components function:
prophet_plot_components(m, forecast)

ggplot(NULL, aes(ds, y)) + 
    geom_step(data = forecast)
