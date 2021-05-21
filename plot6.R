library(dplyr)
library(ggplot2)

NEI <- readRDS("summarySCC_PM25.rds")
SCC <- readRDS("Source_Classification_Code.rds")

data <- left_join(NEI, SCC, by = c("SCC" = "SCC"))

data <- data[grepl("[Vv]ehicle", data$EI.Sector),]


data_plot <- data %>% 
    filter(fips %in% c("24510", "06037")) %>% 
    group_by(year, fips) %>%
    summarise(Emissions = sum(Emissions, na.rm = TRUE) /
                  1000) %>% 
    mutate(county = case_when(fips == "24510" ~ "Baltimore City", fips == "06037" ~ "Los Angeles County"))
data_plot$county <- as.factor(data_plot$county)

png(filename="plot6.png", width=480,height=480)
qplot(
    data_plot$year,
    data_plot$Emissions,
    color = data_plot$county,
    ylim = c(0,5),
    xlab = "year",
    ylab = "Emissions in kilotons"
) +
    labs(title = "Comparison of emissions from Baltimore City and Los Angeles County",
         color = "county")+ 
    geom_line() + 
    theme(legend.justification = "top")
dev.off()
