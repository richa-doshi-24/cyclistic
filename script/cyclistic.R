install.packages("tidyverse")
install.packages("dplyr")
install.packages("geosphere")

library("tidyverse")
library("dplyr")
library("geosphere")

apr_2021_tripdata <- read.csv('202104-divvy-tripdata.csv')
may_2021_tripdata <- read.csv('202105-divvy-tripdata.csv')
jun_2021_tripdata <- read.csv('202106-divvy-tripdata.csv')

aug_2021_tripdata <- read.csv('202108-divvy-tripdata.csv')
jul_2021_tripdata <- read.csv('202107-divvy-tripdata.csv')
sep_2021_tripdata <- read.csv('202109-divvy-tripdata.csv')
oct_2021_tripdata <- read.csv('202110-divvy-tripdata.csv')
nov_2021_tripdata <- read.csv('202111-divvy-tripdata.csv')
dec_2021_tripdata <- read.csv('202112-divvy-tripdata.csv')


jan_2022_tripdata <-  read.csv('202201-divvy-tripdata.csv')
feb_2022_tripdata <-  read.csv('202202-divvy-tripdata.csv')
mar_2022_tripdata <-  read.csv('202203-divvy-tripdata.csv')
apr_2022_tripdata <-  read.csv('202204-divvy-tripdata.csv')

View(apr_2021_tripdata)
str(dec_2021_tripdata)
summary(dec_2021_tripdata)

all_trips <- bind_rows(apr_2021_tripdata,may_2021_tripdata,jun_2021_tripdata,jul_2021_tripdata,aug_2021_tripdata,sep_2021_tripdata,oct_2021_tripdata
                  ,nov_2021_tripdata,dec_2021_tripdata,jan_2022_tripdata,feb_2022_tripdata,mar_2022_tripdata)


View(all_trips)
colnames(all_trips)
str(all_trips)
summary(all_trips)
dim(all_trips) # 5723532      13

cleaned_trip_data <- drop_na(all_trips)
str(cleaned_trip_data)
dim(cleaned_trip_data) # 5718816      13
cleaned_trip_data <- distinct(cleaned_trip_data) #remove duplicates
dim(cleaned_trip_data) # 5718816 13

cleaned_trip_data$date <- as.Date(cleaned_trip_data$started_at)
cleaned_trip_data$month <- format(as.Date(cleaned_trip_data$date), "%m")
cleaned_trip_data$day <- format(as.Date(cleaned_trip_data$date), "%d")
cleaned_trip_data$year <- format(as.Date(cleaned_trip_data$date), "%Y")
cleaned_trip_data$day_of_week <- format(as.Date(cleaned_trip_data$date), "%A")

view(cleaned_trip_data)
str(cleaned_trip_data)
dim(cleaned_trip_data)

cleaned_trip_data$ride_length <- difftime(cleaned_trip_data$ended_at, cleaned_trip_data$started_at)

is.numeric(cleaned_trip_data$ride_length)
cleaned_trip_data$ride_length <- as.numeric(as.character(cleaned_trip_data$ride_length))
cleaned_trip_data <- cleaned_trip_data[!cleaned_trip_data$ride_length<1,] #get rid of negative rides
dim(cleaned_trip_data) # 5718157      19
str(cleaned_trip_data)
summary(cleaned_trip_data)


cleaned_trip_data$ride_distance <- distGeo(matrix(c(cleaned_trip_data$start_lng, cleaned_trip_data$start_lat), ncol=2), matrix (c(cleaned_trip_data$end_lng, cleaned_trip_data$end_lat), ncol=2))

cleaned_trip_data$ride_distance <- cleaned_trip_data$ride_distance/1000 #distance in km
dim(cleaned_trip_data)

trip_data_clean <- cleaned_trip_data
dim(trip_data_clean)
glimpse(trip_data_clean)

trip_data_clean %>% 
  group_by(member_casual) %>%
  summarise(average_ride_length = mean(ride_length), median_length = median(ride_length), 
            max_ride_length = max(ride_length), min_ride_length = min(ride_length))

pieData <- table(trip_data_clean$member_casual)
piepercent<- round(100*pieData/sum(pieData), 1)
pie(pieData,label=piepercent,main = "Member vs Casual rider Distribution", col = rainbow(length(pieData))) 
legend("bottomleft",c("casual","member"), fill = rainbow(length(pieData)))

# lets order the days of the week
trip_data_clean$day_of_week <- ordered(trip_data_clean$day_of_week, 
                                       levels=c("Sunday", "Monday", "Tuesday", "Wednesday", "Thursday", "Friday", "Saturday"))
trip_data_clean %>% 
  group_by(member_casual, day_of_week) %>%  #groups by member_casual
  summarise(number_of_rides = n() #calculates the number of rides and average duration 
            ,average_ride_length = mean(ride_length),.groups="drop") %>% # calculates the average duration
  arrange(member_casual, day_of_week)  %>% #sort
  ggplot(aes(x = day_of_week, y = number_of_rides, fill = member_casual)) +
  theme(legend.position="bottom")+
  labs(title ="Total Bike Hire Per Rider Category Per Day") +
  geom_col(width=0.5, position = position_dodge(width=0.5)) +
  scale_y_continuous(labels = function(x) format(x, scientific = FALSE))

trip_data_clean %>%  
  group_by(member_casual, day_of_week) %>% 
  summarise(average_ride_length = mean(ride_length), .groups="drop") %>%
  ggplot(aes(x = day_of_week, y = average_ride_length, fill = member_casual)) +
  theme(legend.position="bottom") +
  geom_col(width=0.5, position = position_dodge(width=0.5)) + 
  labs(title ="Average Ride Length Per Rider Category Per Day")


trip_data_clean %>%  
  group_by(member_casual,month) %>%
  summarise(number_of_rides = n(),.groups="drop") %>% 
  ggplot(aes(x=month,y=number_of_rides,fill=member_casual)) +
  labs(title ="Total Bike Hire Per Rider Category Per Month") +
  theme(axis.text.x = element_text(angle = 45), legend.position = "bottom") +
  geom_col(width=0.5, position = position_dodge(width=0.5)) +
  scale_y_continuous(labels = function(x) format(x, scientific = FALSE))

trip_data_clean %>% 
  group_by(member_casual) %>% drop_na() %>%
  summarise(average_ride_distance = mean(ride_distance)) %>%
  ggplot() + 
  geom_col(mapping= aes(x= member_casual,y= average_ride_distance,fill=member_casual), show.legend = FALSE)+
  labs(title = "Mean distance traveled by Members and Casual riders")




