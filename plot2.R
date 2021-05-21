library(dplyr)

NEI <- readRDS("summarySCC_PM25.rds")
SCC <- readRDS("Source_Classification_Code.rds")

NEI_plot <- NEI %>%
    filter(fips == "24510") %>% 
    group_by(year) %>% 
    summarise(Emissions= sum(Emissions, na.rm = TRUE)/1000)

png(filename="plot2.png", width=480,height=480)
barplot(
    NEI_plot$Emissions,
    names = NEI_plot$year,
    xlab = "years",
    ylab = "Emissions in kilotons",
    ylim = c(0,4),
    main = "Total PM2.5 emission in Baltimore City for 1999-2008",
    col = c("paleturquoise4", "paleturquoise2", "paleturquoise3", "paleturquoise1")
)
box()
dev.off ()
