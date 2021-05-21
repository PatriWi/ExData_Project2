library(dplyr)
library(ggplot2)

NEI <- readRDS("summarySCC_PM25.rds")
SCC <- readRDS("Source_Classification_Code.rds")


data <- left_join(NEI, SCC, by = c("SCC" = "SCC"))

data <- data[grepl("[Cc]oal", data$EI.Sector), ]

data_plot <-
    data %>%
    group_by(year) %>%
    summarise(Emissions = sum(Emissions, na.rm = TRUE) /
                  1000)

png(filename = "plot4.png",
    width = 480,
    height = 480)


ggplot(data = data_plot, aes(x = as.factor(year), y = Emissions, fill = as.factor(year))) +
    geom_bar(stat = "identity") +
    ggtitle("Total PM2.5 emission from coal comustion-related sources") + 
    ylab("Emissions in kiltons") + 
    xlab("year") + 
    theme(legend.position = "none") + 
    ylim(0,600)
dev.off()


