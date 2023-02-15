#Install necessary packages

install.packages("tidyverse")
install.packages("dplyr")
install.packages("ggplot2")
install.packages("janitor")
install.packages("lubridate")


library(tidyverse)
library(dplyr)
library(ggplot2)
library(janitor)
library(lubridate)


#Load the data

trip_11_2021 <- read.csv("E:/Google Data Course/Case Study/bike data/202111-divvy-tripdata.csv")
trip_12_2021 <- read.csv("E:/Google Data Course/Case Study/bike data/202112-divvy-tripdata.csv")
trip_1_2022 <- read.csv("E:/Google Data Course/Case Study/bike data/202201-divvy-tripdata.csv")
trip_2_2022 <- read.csv("E:/Google Data Course/Case Study/bike data/202202-divvy-tripdata.csv")
trip_3_2022 <- read.csv("E:/Google Data Course/Case Study/bike data/202203-divvy-tripdata.csv")
trip_4_2022 <- read.csv("E:/Google Data Course/Case Study/bike data/202204-divvy-tripdata.csv")
trip_5_2022 <- read.csv("E:/Google Data Course/Case Study/bike data/202205-divvy-tripdata.csv")
trip_6_2022 <- read.csv("E:/Google Data Course/Case Study/bike data/202206-divvy-tripdata.csv")
trip_7_2022 <- read.csv("E:/Google Data Course/Case Study/bike data/202207-divvy-tripdata.csv")
trip_8_2022 <- read.csv("E:/Google Data Course/Case Study/bike data/202208-divvy-tripdata.csv")
trip_9_2022 <- read.csv("E:/Google Data Course/Case Study/bike data/202209-divvy-tripdata.csv")
trip_10_2022 <- read.csv("E:/Google Data Course/Case Study/bike data/202210-divvy-tripdata.csv")

#Check for column consistency

colnames(trip_11_2021)
colnames(trip_12_2021)
colnames(trip_1_2022)
colnames(trip_2_2022)
colnames(trip_3_2022)
colnames(trip_4_2022)
colnames(trip_5_2022)
colnames(trip_6_2022)
colnames(trip_7_2022)
colnames(trip_8_2022)
colnames(trip_9_2022)
colnames(trip_10_2022)

#Combine the data

total_trips <- rbind(trip_11_2021,trip_12_2021,trip_1_2022,trip_2_2022,trip_3_2022,trip_4_2022,
                     trip_5_2022,trip_6_2022,trip_7_2022,trip_8_2022,trip_9_2022,trip_10_2022)

#Remove irrelevant fields

total_trips <- total_trips %>%
  select(-c(start_lat, start_lng, end_lat, end_lng))

##Clean Start and End Times

total_trips$started_at <- lubridate::ymd_hms(total_trips$started_at)
total_trips$ended_at <- lubridate::ymd_hms(total_trips$ended_at)

#Inspect the new table

colnames(total_trips)
nrow(total_trips)
dim(total_trips)
head(total_trips)
tail(total_trips)
str(total_trips)
summary(total_trips)

table(total_trips$member_casual)

View(total_trips)

#Get starting and ending hours

total_trips$start_hour <- lubridate::hour(total_trips$started_at)
total_trips$end_hour <- lubridate::hour(total_trips$ended_at)

#Add columns listing the day, month, and year of each ride

total_trips$date <- as.Date(total_trips$started_at)
total_trips$month <- format(as.Date(total_trips$date), "%m")
total_trips$day <- format(as.Date(total_trips$date), "%d")
total_trips$year <- format(as.Date(total_trips$date), "%Y")
total_trips$day_of_week <- format(as.Date(total_trips$date), "%A")

#Calculate ride length in seconds and add it to table

total_trips$ride_length <- difftime(total_trips$ended_at,total_trips$started_at)

#Inspect structure of table

str(total_trips)

#Convert ride length to numeric
#New numeric column is called "ride_lengthS"

is.factor(total_trips$ride_length)
is.numeric(total_trips$ride_length)

total_trips$ride_lengthS <- as.numeric(as.character(total_trips$ride_length))

is.numeric(total_trips$ride_lengthS)

#Make new table without empty values or negative ride lengths

total_trips_v2 <- total_trips[!(total_trips$start_station_name == "HQ QR" | total_trips$ride_lengthS<0),]

View(total_trips_v2)

##ANALYSIS
#View summary of ride lengths

summary(total_trips_v2$ride_lengthS)

#Compare members and casual users

aggregate(total_trips_v2$ride_lengthS ~ total_trips_v2$member_casual, FUN = mean)
aggregate(total_trips_v2$ride_lengthS ~ total_trips_v2$member_casual, FUN = median)
aggregate(total_trips_v2$ride_lengthS ~ total_trips_v2$member_casual, FUN = max)
aggregate(total_trips_v2$ride_lengthS ~ total_trips_v2$member_casual, FUN = min)

#Compare average ride times by each day
#Put days of week in order for simplicity 

total_trips_v2$day_of_week <- ordered(total_trips_v2$day_of_week, levels=c("Sunday","Monday",
                                                                           "Tuesday","Wednesday",
                                                                           "Thursday","Friday",
                                                                           "Saturday"))

aggregate(total_trips_v2$ride_lengthS ~ total_trips_v2$member_casual + total_trips_v2$day_of_week,
          FUN = mean)

#Visual of number of rides per weekday by type of rider

total_trips_v2%>%
  mutate(weekday = wday(started_at, label = TRUE)) %>%
  group_by(member_casual, weekday) %>%
  summarise(number_of_rides = n()
            ,average_duration = mean(ride_length)) %>%
  arrange(member_casual, weekday) %>%
  ggplot(aes(x = weekday, y = number_of_rides, fill = member_casual)) +
  geom_col(position = "dodge") +
  labs(x = 'Day of Week', y = 'Total Number of Rides', title = 'Rides per Day of the Week', fill = 'Type of Membership') +
  scale_y_continuous(labels = function(x) format(x, scientific = FALSE))

#Visual of number of rides per month by type of rider

total_trips_v2%>%
  mutate(month = month(started_at, label = TRUE)) %>%
  group_by(member_casual, month) %>%  
  summarise(number_of_rides = n()
            ,average_duration = mean(ride_length)) %>%
  arrange(member_casual, month) %>%
  ggplot(aes(x = month, y = number_of_rides, fill = member_casual)) +
  geom_col(position = "dodge") +
  labs(x = 'Month', y = 'Total Number of Rides', title = 'Rides per Month', fill = 'Type of Membership') +
  scale_y_continuous(labels = function(x) format(x, scientific = FALSE))

#Visual for average duration per weekday

total_trips_v2%>%
  mutate(weekday = wday(started_at, label = TRUE)) %>%
  group_by(member_casual, weekday) %>%
  summarise(number_of_rides = n()
            ,average_duration = mean(ride_length)) %>%
  arrange(member_casual, weekday) %>%
  ggplot(aes(x = weekday, y = average_duration, fill = member_casual)) +
  geom_col(position = "dodge") +
  labs(x = 'Day of Week', y = 'Average Ride Duration', title = 'Average Ride Duration per Day of the Week', 
       fill = 'Type of Membership')  


#Export new data for visualization

counts <- aggregate(total_trips_v2$ride_lengthS ~ total_trips_v2$member_casual +
                      total_trips_v2$day_of_week, FUN = mean)
write.csv(counts, file = 'E:/Google Data Course/Case Study/bike data/avg_ride_length.csv')

write.csv(total_trips_v2, file = 'E:/Google Data Course/Case Study/bike data/total_cleaned.csv')
