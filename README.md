# Earthquake Analysis in Marmara Region 

## Packages 

```R
library(dplyr)
library(ggplot2)
library(ggmap)
```
## Data

I downloaded the eartquake dataset from  http://www.koeri.boun.edu.tr/sismo/zeqdb/ , specially dates between 1900 and 2019. I uploaded 
the datasets into GitHub.

```R
data <- read.delim("C:/Users/User/Desktop/Earthquake Analysis/data.txt", stringsAsFactors = FALSE)
```
```R
head(data, 5)
  No  Deprem.Kodu Olus.tarihi Olus.zamani   Enlem  Boylam Der.km.  xM MD  ML  Mw Ms Mb Tip   Yer
1  1 2.019023e+13  2019.02.28 10:14:14.16 39.5725 28.8385     9.4 3.6  0 3.6 3.5  0  0  Ke   CAMHARMAN-DURSUNBEY (BALIKESIR) [South West  1.7 km]
2  2 2.019022e+13  2019.02.24 01:22:24.57 40.3800 27.1757    11.1 3.9  0 3.9 3.9  0  0  Ke   CAKIRLI-BIGA (CANAKKALE) [North East  0.7 km]
3  3 2.019022e+13  2019.02.24 01:05:39.75 40.3932 27.1682     9.7 3.6  0 3.5 3.6  0  0  Ke   CAKIRLI-BIGA (CANAKKALE) [North West  2.2 km]
4  4 2.019022e+13  2019.02.20 19:42:06.62 39.6255 26.4203     7.0 3.8  0 3.8 3.6  0  0  Ke   SAPANCA-AYVACIK (CANAKKALE) [South East  2.7 km]
5  5 2.019022e+13  2019.02.20 18:23:27.94 39.6173 26.4088     8.2 5.4  0 5.4 5.0  0  0  Ke   AYVACIK (CANAKKALE) [North East  1.6 km]
                                                            
```

I select "Olus.tarihi, Olus.zamani, Enlem, Boylam, Der.km., xM, Yer" columns and sort rows in increasing dates.

```R
earthquake <- data%>%
  select(Olus.tarihi, Olus.zamani, Enlem, Boylam, Der.km., xM, Yer)%>%
  arrange(Olus.tarihi, Olus.zamani)
```

## Short Description of Variables

**Olus.tarihi** : the date when earthquake occured
**Olus.zamani** : the time when earthquake occured
**Enlem** : latitude
**Boylam** : longitude
**Der.km.** : depth of earthquake in km
**xM** : magnitude 
**Yer** : location 

## Box Plots 

```R
ggplot(earthquake, aes(y = Enlem))+
  geom_boxplot(fill = "palegreen")+
  coord_flip()+
  ylab("latitude")+
  xlab("")
```
![latitude](https://github.com/erolkibris/EarthquakeAnalysis/blob/master/graphs/latitude.jpeg)

```R
ggplot(earthquake, aes(y = Boylam))+
  geom_boxplot(fill = "palegreen")+
  coord_flip()+
  xlab("")+
  ylab("longitude")
```
![longitude](https://github.com/erolkibris/EarthquakeAnalysis/blob/master/graphs/longitude.jpeg)

```R
ggplot(earthquake, aes(y = Der.km.))+
  geom_boxplot(fill = "palegreen")+
  coord_flip()+
  xlab("")+
  ylab("Depth")
```
![depth](https://github.com/erolkibris/EarthquakeAnalysis/blob/master/graphs/Depth.jpeg)

```R
ggplot(earthquake, aes(y = xM))+
  geom_boxplot(fill = "palegreen")+
  coord_flip()+
  xlab("")+
  ylab("Magnitude")
```
![magnitude](https://github.com/erolkibris/EarthquakeAnalysis/blob/master/graphs/Magnitude.jpeg)


## Density Plots

```R
ggplot(earthquake, aes(x = Der.km.))+
  geom_density(fill = "light blue")+
  xlab("")+
  ylab("Depth")
```
![d-density](https://github.com/erolkibris/EarthquakeAnalysis/blob/master/graphs/depth-density.jpeg)

```R
ggplot(earthquake, aes(x = Enlem))+
  geom_density(fill = "light blue")+
  xlab("")+
  ylab("Latitude")
```
![la-density](https://github.com/erolkibris/EarthquakeAnalysis/blob/master/graphs/latitude-density.jpeg)

```R
ggplot(earthquake, aes(x = Boylam))+
  geom_density(fill = "light blue")+
  xlab("")+
  ylab("Longitude")
```
![longitude](https://github.com/erolkibris/EarthquakeAnalysis/blob/master/graphs/longitude-density.jpeg)

```R
ggplot(earthquake, aes(x= Der.km., y= xM))+
  geom_point()+
  guides(fill = FALSE)+
  xlab("Derinlik (km)")+
  ylab("Büyüklük")
```
![der-mag](https://github.com/erolkibris/EarthquakeAnalysis/blob/master/graphs/xM-Der.jpeg)

## Visualizing Data on Map

First, we need a Google API key. You can take it from developers.google.com.

```R
ggmap::register_google(key = "[KEY]")
```

We are bounding the map 26-31 and 39-42. These are Marmara region coordinates. 

```R
marmara <- c(left = 26, bottom = 39, right = 31, top = 42)
```
And we plot the map. 

```R
get_stamenmap(marmara, zoom = 5, maptype = "toner-lite") %>% ggmap() 
```
![map](https://github.com/erolkibris/EarthquakeAnalysis/blob/master/graphs/marmara.jpeg)

We create ggmap plot which contains Google Map of Marmara region and add ggplot layer to plot where earthquakes occured.
```R
qmplot(Boylam, Enlem, data = earthquake, maptype = "toner-lite", color = I("red"))
```
![harita](https://github.com/erolkibris/EarthquakeAnalysis/blob/master/graphs/harita.jpeg)

Finally, we plot the density of points.

```R
qmplot(Boylam, Enlem, data = earthquake, geom = "blank", 
       zoom = 5, maptype = "toner-background", darken = .7, legend = "bottomright"
) +
  stat_density_2d(aes(fill = ..level..), geom = "polygon", alpha = .3, color = NA) +
  scale_fill_gradient2("Eartquakes\nDensity", low = "white", mid = "yellow", high = "red", midpoint = 0.15)+
  theme(legend.text=element_text(size=rel(0.5)),
        legend.title = element_text(size = 5))
```
![yoğunluk](https://github.com/erolkibris/EarthquakeAnalysis/blob/master/graphs/yogunluk.jpeg)





