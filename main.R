library(dplyr)
library(ggplot2)
library(plotly)

data <- read.delim("C:/Users/Erol/Desktop/Earthquake Analysis/data.txt", stringsAsFactors = FALSE)

earthquake <- data%>%
  select(Olus.tarihi, Olus.zamani, Enlem, Boylam, Der.km., xM, Yer)%>%
  arrange(Olus.tarihi, Olus.zamani)

ggplot(earthquake, aes(y = Enlem))+
  geom_boxplot(fill = "palegreen")+
  coord_flip()+
  ylab("latitude")+
  xlab("")

ggplot(earthquake, aes(y = Boylam))+
  geom_boxplot(fill = "palegreen")+
  coord_flip()+
  xlab("")+
  ylab("longitude")

ggplot(earthquake, aes(y = Der.km.))+
  geom_boxplot(fill = "palegreen")+
  coord_flip()+
  xlab("")+
  ylab("Depth")

ggplot(earthquake, aes(y = xM))+
  geom_boxplot(fill = "palegreen")+
  coord_flip()+
  xlab("")+
  ylab("Magnitude")

ggplot(earthquake, aes(x = Der.km.))+
  geom_density(fill = "light blue")+
  xlab("")+
  ylab("Depth")

ggplot(earthquake, aes(x = Enlem))+
  geom_density(fill = "light blue")+
  xlab("")+
  ylab("Latitude")

ggplot(earthquake, aes(x = Boylam))+
  geom_density(fill = "light blue")+
  xlab("")+
  ylab("Longitude")
