# Load up the RGA package. This is the package that has the smarts to actually
# connect to and pull data from the Google Analytics API
#library("RGA")
#library("ggplot2")

# Authorize the Google Analytics account
ga_token <- authorize(client.id = "1076502656589-pbs8ljm9h3k0deqll9l8lfo0pbnok25d.apps.googleusercontent.com", 
                      client.secret = "48fpt5Tdw5jBrOVQ1DkejO43")
#Wonderboo SE Master
viewid <- "ga:132479669"

# Perform a simple query and assign the results to a "data frame" called gaData.
# 'gaData' is just an arbitrary name, while get_ga is a function inside the RGA package.
#dimensions = "ga:date", sort = NULL, filters = NULL,

gaData <- get_ga(profileId = viewid,
                 start.date = "90daysAgo",
                 end.date = "yesterday",
                 metrics = c("ga:users", "ga:sessions","ga:pageviews","ga:transactions"), 
                 dimensions = c("ga:date","ga:deviceCategory"), 
                 sort = NULL, 
                 filters = NULL,
                 segment = NULL, 
                 samplingLevel = NULL, 
                 start.index = NULL,
                 max.results = NULL, 
                 include.empty.rows = NULL, 
                 fetch.by = NULL, 
                 ga_token)


# Create a simple line chart.
# This is putting the "date" values from gaData as the x "values," the number of sessions
# (the "sessions" value) as the y values, and is then specifying that it should be plotted
# as a line chart (type="l"). The "ylim" forces a 0-base y-axis by specifying a "vector"
# that goes from 0 to the maximum value for sessions in the gaData data frame.
plot(gaData$date,gaData$sessions,type="l",ylim=c(0,max(gaData$sessions)))

# Transactions over time with som colour on it
ggplot(data = gaData, mapping = aes(x = date, y = transactions)) + 
  geom_point() +
  geom_point(colour = 'blue', size = 0) +
  theme_bw() +
  ylim(10,NA) 
#ylim = 

# Now lets do the same thing, but with a bar chart
ggplot(data = gaData, mapping = aes(x = date, y = sessions)) + 
  # Only line that changes
  geom_bar(stat = "identity") +
  theme_bw() +
  ylim(0,NA) 

# Now let's scatter plot pageviews vs. users by changing the mapping directive
ggplot(data = gaData, mapping = aes(x = users, y = pageviews)) + 
  # Line that changes for the scatter
  geom_point() +
  theme_bw() +
  ylim(0,NA) 

# Invoke a ggplot with date vs. sessions data, segmented by device category
ggplot(data = gaData, mapping = aes(x = date, y = sessions, colour = deviceCategory) ) + 
  geom_line() +
  theme_bw() +
  ylim(0,NA) 

# Split different device categories in to three different line charts
ggplot(data = gaData, mapping = aes(x = date, y = sessions) ) + 
  geom_line() +
  facet_grid(deviceCategory ~ .) +
  theme_bw() +
  ylim(0,NA)
