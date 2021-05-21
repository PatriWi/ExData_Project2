library(dplyr)
library(ggplot2)

NEI <- readRDS("summarySCC_PM25.rds")
SCC <- readRDS("Source_Classification_Code.rds")

NEI_plot <- NEI %>%
    filter(fips == "24510") %>% 
    group_by(type, year) %>% 
    summarise(Emissions= sum(Emissions, na.rm = TRUE)/1000) 

NEI_plot$type <- tolower(NEI_plot$type)

png(filename="plot3.png", width=480,height=480)
qplot(
    NEI_plot$year,
    NEI_plot$Emissions,
    color = NEI_plot$type,
    xlab = "year",
    ylab = "Emissions in kilotons"
) +
    labs(title = "Total PM2.5 emission in Baltimore City for 1999-2008 by type",
         color = "types")+ 
    geom_line()
dev.off()

       