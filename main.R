library(dplyr)
library(ggplot2)
library(ggmap)


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

ggplot(earthquake, aes(x= Der.km., y= xM))+
  geom_point()+
  guides(fill = FALSE)+
  xlab("Derinlik (km)")+
  ylab("Büyüklük")


ggmap::register_google(key = "AIzaSyCkTHJTK17IPtU4d3n1ZWgGDxJFkdsYs-g")

marmara <- c(left = 26, bottom = 39, right = 31, top = 42)
get_stamenmap(marmara, zoom = 5, maptype = "toner-lite") %>% ggmap() 

qmplot(Boylam, Enlem, data = earthquake, maptype = "toner-lite", color = I("red"))

qmplot(Boylam, Enlem, data = earthquake, geom = "blank", 
       zoom = 5, maptype = "toner-background", darken = .7, legend = "bottomright"
) +
  stat_density_2d(aes(fill = ..level..), geom = "polygon", alpha = .3, color = NA) +
  scale_fill_gradient2("Eartquakes\nDensity", low = "white", mid = "yellow", high = "red", midpoint = 0.15)+
  theme(legend.text=element_text(size=rel(0.5)),
        legend.title = element_text(size = 5))

  
  