# Cyclistic Case Study
### Dylan Roberts
### 2023-1-2
## Introduction
### Background

Cyclistic is a bike-share company that offers different tiers of service: charging by the minute, buying a day pass, or annual memberships. Causal riders are those who either pay for individual rides by the minute, or buy day passes. Members are the riders who have annual memberships. Currently, only around 30% of users use the bikes to commute, while the rest use them for leisure.

### Business task
The director of Cyclistic wants to get as many people on annual memberships as possible because they believe that will bring the most profit. In order to get an idea of how marketing efforts should be focused, the data analyst team needs to find out the differences in how casual riders and members use their services.

### Data Sources
The data used for this analysis was retrieved from https://divvy-tripdata.s3.amazonaws.com/index.html. It comes from the bike share service Divvy, but we are using it as data for a fictional company called Cyclistic for the purpose of this case study. Motivate International Inc. has made this data available for use. In order to perform our analysis, I pulled the 12 most recent months of trip data and combined it into one dataset.

## Clean data and add new variables for analysis
Next, we need to clean up the data and record certain metrics needed for our analysis. To begin, we remove the latitude and longitude variables as these are not needed. Following this, we separate our time data into individual categories (date, month, day, year, day of week). The last variable to add is the ride length in seconds, which I found by taking the start and end times and applying the difftime function in R. Finally, we make a new data set that removes bikes taken by maintenance as well as any negative ride lengths. 

## Analysis 
Now that the data is cleaned, it is time to perform analysis. I began by comparing summary statistics of casual riders and members

### Maximum Ride Length in Seconds:

![max](https://user-images.githubusercontent.com/121322428/219533755-2e9eef06-52b9-4ee8-a2c3-e20e365c769e.PNG)

### Average Ride Length in Seconds:

![mean](https://user-images.githubusercontent.com/121322428/219533758-32289219-5e38-477c-9a5f-01e354abd4ff.PNG)

### Median Ride Length in Seconds:

![median](https://user-images.githubusercontent.com/121322428/219533759-7a4e5b7e-744e-4aa6-b1a2-73a7120a234c.PNG)

### Minimum Ride Length in Seconds:

![min](https://user-images.githubusercontent.com/121322428/219533762-fc8c95dc-2af9-4346-9970-f5dbeda57016.PNG)

It appears that casual members have an average ride length of over double that of member riders and a maximum ride length well above that of member riders. This is expected given that member riders are likely using the bikes for pre-determined trips, such as work trips. Additionally, the members who use them for work have likely determined the fastest ways to get to work, which would cut down on the average time spent riding. On the other hand, casuals are more likely to use the bikes for leisure and therefore are not as restricted by time, which explains the higher average and maximum times.

## Visuals
To better identify any trends, let's visualize our data. 

### Number of rides per weekday by type of rider

![rides per weekday](https://user-images.githubusercontent.com/121322428/219538371-cf7ee14e-98d5-418d-985f-8e5e23c123b3.PNG)

As we can see in this visual, casual and member riders have inverted ride amounts throughout the week. This means that casual riders tend to be more active on the weekends and less active on weekdays, while members are more active throughout the week and less so on weekends. Interestingly, despite these trends, casuals and members share a similar number of rides on the weekends, suggesting that most people who use this service enjoy using it for leisure regardless of membership status.

### Number of rides per month by type of rider

![rides per month](https://user-images.githubusercontent.com/121322428/219538503-db2a0ca5-dc7e-477b-8f84-63c6ae979ec5.PNG)

It is clear that the majority of rides are in the summer season (June through September) for both casual riders and members. This is likely due to a combination of better weather and more free time for customers.

### Average ride duration per Day of the Week

![average ride duration per weekday](https://user-images.githubusercontent.com/121322428/219537979-e5c34f11-139e-4f52-9908-6f6aee9ed4c2.PNG)

This visual illustrates the average ride duration for casuals and members by weekday. As discovered earlier, casuals clearly ride for much longer than members, especially on weekends. Additionally, casuals have more variance in ride times across the week, which lines up with the idea that members have a more consistent dependency on bikes than casuals.

## Conclusions and Recommendations

Given our results, there are a few potential marketing strategies Cyclistic could adopt to convert casual riders to members and maximize profits.

The first marketing strategy is to advertise more right before the summer months. Our monthly analysis reveals that bikes are most popular around summertime. Not only does summer offer better weather, but for some people like students, there will be more free time to ride bikes for fun. Therefore, as casuals begin to demand more bikes leading up to summer, it would be crucial to capture that interest with heavier advertising beginning in spring.

The second marketing strategy would be to offer discounts on membership passes in the winter months. Lowering the price of a membership would increase demand for it when it would otherwise be low. Focusing on the long-term aspect of a yearly membership would cause more casual riders to justify their purchase. By causing casuals to simultaneously save money and be thinking out to the future, they will be more convinced that a membership is worth it for them.  Additionally, since the overall popularity of rides would be low in the colder months anyway, it would be wise to secure more year-long commitments during this time.

The third and final marketing strategy would involve offering promotions and partner discounts for membership holders, especially ones that target casual riders. Specifically, these promotions should be geared mostly towards weekend activities, as well as any form of leisure, in order to capture more of the casual market. These could involve partnerships with various food establishments or different bike features that are unavailable to non-members. Additionally, they could increase profits by offering bundle deals with multiple membership purchases. For example, if you bought a membership for yourself and got another membership half off for a friend, that would add another member rider, increasing profits. All of these would make the annual memberships look more appealing, as they would offer greater value in comparison. 


