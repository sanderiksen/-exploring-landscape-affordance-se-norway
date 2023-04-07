# Load packages
library(dplyr)
library(tidyr)
library(FactoMineR)
library(factoextra)
#library(patchwork)
#library(corrplot)
library(ggplot2)
library(readxl)

# Read data
Dataset <- read_excel("Dataset.xlsx")
View(Dataset)

# Check data
glimpse(Dataset)
summary(Dataset)

#### Correspondence analysis (CA) ####

# The data set has 5 columns: sites (values 1-30 corresponding to selected settlement sites), ID (corresponding to the individual point’s placement 
# within the grid), distance (values based on the points placement from the site based on the 250-meter lag), variables (values 1-12) and the
# variables type. The variables are binary data, meaning that numbers indicate a presence of the point, while absent variables are NA).  
# The structure of the data set does not follow the regular layout of a correspondence analysis, i.e. an contingency table with observations
# and its value in regard to the variable. The rows in the dataset represents the points in the 5 km grid of each site after present
# variable. The distance is not part of the CA, but will be used to structure the data in the  box plots. 


# Summary of variables after site
datasum <- Dataset %>% count(Site, Variable) 

datawide <- datasum %>% # make into table
  group_by(Site) %>%  
  pivot_wider(names_from = Variable,
              values_from = n)

glimpse(datawide) # check data


# Add regions
datawide$region <- c("Agder", "Agder", "Agder", "Agder", "Agder", 
                     "Telemark", 
                     "Vestfold", "Vestfold", "Vestfold", 
                     "Østfold", "Østfold", "Østfold", "Østfold", "Østfold", "Østfold", "Østfold", "Østfold", "Østfold", "Østfold", "Østfold",
                     "Akershus", "Akershus", "Akershus", "Akershus", "Akershus", "Akershus", "Akershus", "Akershus",
                     "Buskerud",
                     "Hedmark")

# Middle value based on combination of all dates from the settlement sites
datawide$date <- c(1255, 879, 1189, 1174, 792, 
                   681, 
                   1406, 1778, 1581, 
                   1301, 1402, 883, 573, 783, 1687, 932, 1678, 1296, 1365, 660,  
                   1138, NA, 1342, 1468, 1580, 1550, 1018, 967, 
                   1742, 
                   654)
# Add site names
datawide$site_name <- c("Arctander", "Romsletta", "Homme", "Klepland", "Moi", 
                        "Larønningen", 
                        "Eidsten", "Nordby", "Løveskogen", 
                        "Heimdal", "Rør", "Borge", "Kjenne", "Glemmen", "Opstad", "Grimstad", "Stensrød", "Øberg", "Rudskogen", "Østereng",
                        "Nordre Moer", "Holstad", "Løken", "Tanum", "Huseby", "Asak", "Svarstad", "Haug",
                        "Rudsøgard",
                        "Nes")


# The above 48 130 rows are now made into 30 rows representing the sites, and 15 columns representing the 12 variables analysed through the 
# spatial point pattern analysis and one column for the site numbers/names. The NA values indicate that the variable were absent during the analysis, 
# meaning that it is not an unknown, and can therefore be made into a 0.

datawide[is.na(datawide)] <- 0

glimpse(datawide) # check data
View(datawide)


## Results
CA(datawide[,-1], ncp = 5, graph = TRUE) # CA factor map

cadat <- datawide[2:ncol(datawide)] # Remove above mentioned column for sites

glimpse(cadat) # check data

# Remove column Site, region and date and make site_name until row name
cadat <- datawide %>% 
  ungroup() %>% 
  select(-Site, -region, -date) %>% 
  tibble::column_to_rownames(var = "site_name")

cares <- CA(cadat, graph = FALSE)

print(cares)

fviz_screeplot(cares, addlabels = TRUE, ylim = c(0, 50)) # scree plot

fviz_ca_biplot(cares, repel = TRUE)

## Row analysis
row <- get_ca_row(cares)
row

head(row$coord, 30)   # coordinates
head(row$cos2, 30)   # quality on the factor map
head(row$contrib, 30)   # contributions to the principal components

row$inertia   # the sum of the row inertias
sum(row$inertia)  # the portion of each row out of the total inertia
row$inertia/sum(row$inertia)  # the portion of each row out of the total inertia
round(row$inertia/sum(row$inertia)*1000, digits=0)  # as permills




# Plot row with site name and color by regions
fviz_ca_row(cares, title = "a", col.row = "black", invisible = "quali",
            shape.row = 21, pointsize = 2.9, fill = datawide$region,
            repel = TRUE)  +
  scale_fill_brewer(palette = "YlOrRd", name = "District")



# Plot with site name and color by date
fviz_ca_row(cares, title = "b", col.row = "black", invisible = "quali",
            shape.row = 21, pointsize = 2.9, fill = datawide$date, 
            gradient.cols = c("#00AFBB", "#E7B800", "#FC4E07"), 
            repel = TRUE)

# Simple plot
plt1 <-  fviz_ca_row(cares, title = "Sites", col.row = "black", invisible = "quali",
        repel = TRUE)
plt1

# Contribution of rows to the first two dimensions
fviz_contrib(cares, choice = "row", axes = 1:2)

## Column analysis
col <- get_ca_col(cares)
col

head(col$coord, 12)   # coordinates
head(col$cos2, 12)  # quality on the factor map
head(col$contrib, 12)   # contributions to the principal components

col$inertia   # the sum of the row inertia
sum(col$inertia)  # the portion of each row out of the total inertia
col$inertia/sum(col$inertia)  # the portion of each row out of the total inertia
round(col$inertia/sum(col$inertia)*1000, digits=0)  # as permills

# Plot column

# Column point plot Color by cos2 values: quality on the factor map
fviz_ca_col(cares, title = "Variables", col.col = "cos2", 
                 gradient.cols = c("#00AFBB", "#E7B800", "#FC4E07"),
                 repel = TRUE)

plt2 <- fviz_ca_col(cares, title = "Variables", col.col = "indianred", invisible = "quali", 
            repel = TRUE)
plt2

# Contribution of columns to the first two dimensions
fviz_contrib(cares, choice = "col", axes = 1:2)


# Variables biplotted with sites
fviz_ca_biplot(cares, title = "Variables",
               labelsize = 4, pointsize = 2, col.col = "red4",
               col.row = "honeydew3", invisible = "quali",
               repel = TRUE)


#### Box plots ####

## All sites
boxplot(Dataset$Distance ~ Dataset$Variable,
        xlab = "Variable",
        ylab = "Distance in meters",
        main = "All site")

## Individual sites: this is an example - all box plots are available in repository
# Information on specific site (here no. 10 Heimdal) first has to be filtered out from the entire dataset
# This can simply be changed by filtering by a different site no. or change the filter to another type
# E.g. changing to filtering by variables, as demonstrated below
Data_Heimdal <- Dataset %>% filter(Site  %in% c("10"))

# Filtered information visualized 
boxplot(Data_Heimdal$Distance ~ Data_Heimdal$Variable,
        xlab = "Variable",
        ylab = "Distance in meters",
        main = "Heimdal (#10)")

## Individual variable: an example - all box plots are available in repository
# Information on specific variable (here no. 1 Sea) first has to be filtered out from the entire dataset
Data_Sea <- Dataset %>% filter(Variable  %in% c("1"))

# Filtered information visualized 
boxplot(Data_Sea$Distance ~ Data_Sea$Site,
        xlab = "Site",
        ylab = "Distance in meters",
        main = "Sea (#1)")

View(Data_Sea) #to double check presence and absence

Data_variable <- Dataset %>% filter(Variable  %in% c("7"))
View(Data_variable)

#### Distances relations to sites ####
## Calculation
mean_data_grave <- Dataset %>%
  select(Variable, Distance, Site)%>%
  filter(Variable %in% c ("9")) %>%       #for grave context
  group_by(Site)%>%
  summarise(average = mean(Distance))

mean_data_rock_art <- Dataset %>%
  select(Variable, Distance, Site)%>%
  filter(Variable %in% c ("10")) %>%       #for rock art
  group_by(Site)%>%
  summarise(average = mean(Distance))

mean_data_wetland <- Dataset %>%
  select(Variable, Distance, Site)%>%
  filter(Variable %in% c ("3")) %>%       #for bog
  group_by(Site)%>%
  summarise(average = mean(Distance))

mean_data_dry_grazing <- Dataset %>%
  select(Variable, Distance, Site)%>%
  filter(Variable %in% c ("7")) %>%       #for dry grazing land
  group_by(Site)%>%
  summarise(average = mean(Distance))

### Visualizing
mean_data_rock_art %>% 
  ggplot(aes(Site,average))+
  geom_point(size = 2)+
  labs(x = "Site",
       y = "Distance in meters",
       title = "Settlements relation to rock art sites")+
  scale_x_continuous(breaks = c(1, 2, 3, 4, 5, 6, 7, 8, 9, 10, 11, 12, 13, 14, 15, 16, 17, 18, 19, 20, 21, 22, 23, 24, 25, 26, 27, 28, 29, 30))+
  theme_minimal(base_size = 13)

mean_data_wetland %>% 
  ggplot(aes(Site,average))+
  geom_point(size = 2)+
  labs(x = "Site",
       y = "Distance in meters",
       title = "Settlements relation to wetlands")+
  scale_x_continuous(breaks = c(1, 2, 3, 4, 5, 6, 7, 8, 9, 10, 11, 12, 13, 14, 15, 16, 17, 18, 19, 20, 21, 22, 23, 24, 25, 26, 27, 28, 29, 30))+
  theme_minimal(base_size = 13)

mean_data_grave %>% 
  ggplot(aes(Site,average))+
  geom_point(size = 2)+
  labs(x = "Site",
       y = "Distance in meters",
       title = "Settlements relation to grave context")+
  scale_x_continuous(breaks = c(1, 2, 3, 4, 5, 6, 7, 8, 9, 10, 11, 12, 13, 14, 15, 16, 17, 18, 19, 20, 21, 22, 23, 24, 25, 26, 27, 28, 29, 30))+
  theme_minimal(base_size = 13)

mean_data_dry_grazing %>% 
  ggplot(aes(Site,average))+
  geom_point(size = 2)+
  labs(x = "Site",
       y = "Distance in meters",
       title = "Settlements relation to dry grazing landscapes")+
  scale_x_continuous(breaks = c(1, 2, 3, 4, 5, 6, 7, 8, 9, 10, 11, 12, 13, 14, 15, 16, 17, 18, 19, 20, 21, 22, 23, 24, 25, 26, 27, 28, 29, 30))+
  theme_minimal(base_size = 13)


