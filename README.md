# Case Study: Convert casual cyclistic riders into annual members

## Scenario
You are a junior data analyst working in the marketing analyst team at Cyclistic, a bike-share company in Chicago. The director
of marketing believes the company’s future success depends on maximizing the number of annual memberships. Therefore,
your team wants to understand how casual riders and annual members use Cyclistic bikes differently. From these insights,
your team will design a new marketing strategy to convert casual riders into annual members. But first, Cyclistic executives
must approve your recommendations, so they must be backed up with compelling data insights and professional data
visualizations

## About the company
In 2016, Cyclistic launched a successful bike-share offering. Since then, the program has grown to a fleet of 5,824 bicycles that
are geotracked and locked into a network of 692 stations across Chicago. The bikes can be unlocked from one station and
returned to any other station in the system anytime.

Until now, Cyclistic’s marketing strategy relied on building general awareness and appealing to broad consumer segments.
One approach that helped make these things possible was the flexibility of its pricing plans: single-ride passes, full-day passes,
and annual memberships. Customers who purchase single-ride or full-day passes are referred to as casual riders. Customers
who purchase annual memberships are Cyclistic members.

## The Stakeholders
1. Lily Moreno: The director of marketing and my manager. Moreno is responsible for the development of campaigns and initiatives to promote the bike-share program.
2. Cyclistic marketing analytics team: A team of data analysts who are responsible for collecting, analyzing, and reporting data that helps guide Cyclistic marketing strategy.
3. Cyclistic executive team: A notoriously detail-oriented team which will decide whether to approve the recommended marketing program

## The Business Result
The goal of this case study is to provide clear insights for designing marketing strategies aimed at converting casual riders into annual members. Towards this goal, I asked the following questions:

-- How do annual members and casual riders use Cyclistic bikes differently?


## Preparing the Data
This case study uses Cyclistic's historical trip data (previous 12 months) to analyze and identify trends. The data has been made available by Motivate International Inc. under an open license.

This data is reliable, original, comprehensive and current as it is internally collected and stored safely by Cyclistic from April 2021 to March 2022. Personally identifiable information such as credit card numbers has been removed because of data-privacy issues.

The data selected for use covers the last 12 months from April 2021 to March 2022. Each month has a separate dataset. The datasets are organized in tabular format and have 13 identical columns. Combined, the datasets have 5723532 rows. The member_casual column will allow me to group, aggregate and compare trends between casual riders and member riders.

## Processing the Data from Dirty to Clean

### Tools
To process the data from dirty to clean, I chose to use R. This is because R is relatively fast and thus useful in dealing with huge datasets. R is also heavily supported by handy open-source libraries too.

### Cleaning & Transforming the data
After reading in and combining the 12 datasets into a single dataframe, the first step in data cleaning was to identify which columns and rows have missing data. I discovered that 4716 rows had missing values which were not included in the analysis.

Next, I added columns for date, month, year, day of the week into the data frame.

Next, I created the ride_length column by getting the difference between the ended_at and started_at columns. This yielded a time delta object. I figured, the data frame includes 650 row entries when bikes were taken out of docks and checked for quality by company where ride_length was negative or "zero" making it invalid for analysis.

### Analyzing data to answer question
In this step, I analyzed the cleaned data to find out how annual members and casual riders use Cyclistic bikes differently.

First, I got the total number of bike hired by casual riders and member riders.

Next, I examined how total bike hires were distributed per month. This revealed some interesting trends that I shall discuss in the share stage.

Next, I wanted to compare the difference in average ride length between casual riders and member riders. I discovered that casual riders tend to ride for longer periods of time compared to member riders. I was intrigued and decided to explore how the average ride length compares for both rider categories on daily and monthly basis.

### Sharing Insights Through Visualization
In this step, I created intuitive visualizations using R programming to communicate the results of my analysis. The visualizations and insights gleaned can be found [here](https://docs.google.com/presentation/d/1n6mFyrmfWjnxnMkCvnEv_OPghU_AqFxKhPU-dHbjMMY/edit?usp=sharing).

