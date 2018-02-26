library("ggmap")
library("ggplot2")

#Charge ton tableau avec tes coordonnées : latitude/longitude

latilongi <-read.csv("../defline/souchotheque_gps_coordinates.csv", header=T, sep=",")

# charge la carte: il y en a différentes, personnellement je m’intéressai au monde entier

map.world <-map_data(map ="world")


#Puis plot les 2 avec gégé

map <-ggplot(map.world,aes(x = long, y = lat, group = group, fill="#7a9ebe"))
map <- map +scale_fill_manual(values="#7a9ebe")   #Couleur des continents
map <- map + geom_polygon()
map <- map + geom_point(data=latilongi, aes(x=Longitude, y=Latitude, group=NA), size=1 )
map <- map + theme(legend.position = "none")
map <- map + labs(title= "Strains sampling locations")

#print(map)
ggsave(file="UBOCC_strains_geographic_origins.jpeg",
       plot = map, units = "mm", height= 210, width= 297, dpi= 300)                              
                              
