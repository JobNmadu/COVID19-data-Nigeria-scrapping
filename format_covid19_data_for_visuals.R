
library(readxl)
Day2 <- read_excel("Daily/Daily171220.xlsx") #the cumulative data in the current day
Day1 <- read_excel("Daily/Daily161220.xlsx") #the cumulative data in the previous day
Day0 <- read_excel("Daily/States.xlsx") # list of states for disaggreating the data
Day00 <- read_excel("Daily/States1.xlsx") #list of states for aggregating the data

Day1 <- Day1[order(Day1$`States Affected`),] # data sorted by states
Day2 <- Day2[order(Day2$`States Affected`),]

# deduct the previous dyas cases from current day to get the cases for te current day
DD <- data.frame(Day0, date = "2020-12-17", confirmed = Day2$`No. of Cases (Lab Confirmed)` - Day1$`No. of Cases (Lab Confirmed)`, active = Day2$`No. of Cases (on admission)` - Day1$`No. of Cases (on admission)`, recovered = Day2$`No. Discharged` - Day1$`No. Discharged`, death = Day2$`No. of Deaths` - Day1$`No. of Deaths`)

DD100 <- data.frame(Day00,  Year ="2020", Month = "December", Date = "2020-12-17", confirmed = Day2$`No. of Cases (Lab Confirmed)` - Day1$`No. of Cases (Lab Confirmed)`, active = Day2$`No. of Cases (on admission)` - Day1$`No. of Cases (on admission)`, recovered = Day2$`No. Discharged` - Day1$`No. Discharged`, death = Day2$`No. of Deaths` - Day1$`No. of Deaths`)

#data is formated as may be required.
library(tidyverse)
DD1 <- DD %>%
  pivot_longer(-c(Country.Region,Province.State, County, Lat, Long, date), names_to = "type", values_to = "cases")
DD2 <- filter(DD1, cases >= 1)
DD2 <- as.data.frame(DD2)
DD2$date <- as.Date(DD2$date)

#Data is appended to the previous data and saved.
cumDat <- read_excel("data/cumDat.xlsx")
cumDat <- as.data.frame(rbind(cumDat, DD2))
xlsx::write.xlsx2(cumDat, file = "data/cumDat.xlsx", col.names = TRUE, row.names = FALSE)

DD10 <- DD100 %>%
  pivot_longer(-c(Region, County, Country, Year, Month, Date, Lat, Long), values_to = "Cases", names_to = "Type")
DD20 <- filter(DD10, Cases >= 1, Type == "confirmed")
DD20 <- as.data.frame(DD20)
DD20$Date <- as.Date(DD20$Date)
cumDat1 <- read_excel("data/cumDat.xlsx")
cumDat1 <- as.data.frame(rbind(cumDat1, DD20))
xlsx::write.xlsx2(cumDat1, file = "data/cumDat.xlsx", col.names = TRUE, row.names = FALSE)

#the complete data as at the current day is also saved
write_delim(Day2, "data/today.csv", delim = ",")
