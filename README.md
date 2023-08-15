This repository holds data, code, figures, and a compendium with additional methodological explanations and further details on selections for the paper Sand-Eriksen, A. 2023. "Exploring affordances: Late Neolithic and Bronze Age settlement locations and human-environment engagements in southeast Norway"

### 1. GIS and Access
All GIS analyses were run in QGIS 3.16.14-Hannover (Q. D. Team 2020). The coordinate system used is WGS84/UTM zone 32N (EPSG:32632). All attribute table exported from QGIS, were unified into one excel-file using Microsoft Access 2016 available as Dataset.xlxs.

### 2. R
The statistical analyses were run using R 4.1.2 (R. C. Team 2020)  on Windows 10. The following additional libraries used were FactoMineR (Lê et al. 2008), Factoextra (Kassambara & Mundt 2020), dplyr (Wickham et al. 2023), readxl (Wickham & Bryan 2023), and ggplot2 (Wickham 2016). The main script is Analysis.R

### 3. Data and Licenses
The natural variables follow the source data from freely available mapped datasets retrieved from the Norwegian Mapping Authority, with source data belonging to the following different research institutes in Norway:
-	Freshwater: The Norwegian Water Resources and Energy Directorate
-	Wetland: The Norwegian Institute of Bioeconomy Research
-	Forest: The Norwegian Institute of Bioeconomy Research
-	Clay: The Geological Survey of Norway
-	Terminal moraine: The Geological Survey of Norway
-	Dry grazing land:  The Norwegian Institute of Bioeconomy Research and The Norwegian Environment Agency
-	Suitable agricultural soil: The Norwegian Institute of Bioeconomy Researc

This data is under the Norwegian Licence for Open Government Data (NLOD) 2.0: https://data.norge.no/nlod/en/2.0

The variable sea has no direct source data, but DEM were clipped after shoreline displacement data (Prøsch-Danielsen 1997; Sørensen 2002; Romundset et al. 2014; Sørensen et al. 2014). 

Accept from information retrieved from reviewing excavation reports, the data on the cultural variables is not open. All utilized reports are searchable after site names in duo.uio.no, community ‘Museene’ and then ‘Kulturhistorisk museum’. The remaining data have been retrieved from archaeological databases which are semi-open, belonging to Norwegian cultural resource management (CRM). Information on sites and finds are from the Norwegian museum’s database Unimus/Musit (partly accessible from unimus.no but the database itself is for cultural heritage personnel), while rock art sites and grave contexts are from The Directorate for Cultural Heritage’s database Askeladden (askeladden.ra.no). This his is not open, but you can apply for access, the site kulturminnesok.no, holding some of the same information, is freely available.

### 6. Updates and changes in repository
The compendium ha been updated following the peer-review of the paper. A minor error in the dataset was detected and a updated version has been upladed. The error was that finds were named sites and the other way around, which would not have any direct effect on the analysi or the results. I have also added an list of finds, as this information can be difficult to get hold on. 

### 5. References
Kassambara, A., & Mundt, F., 2020. Factoextra: Extract and Visualize the Results of Multivariate Data Analyses. https://CRAN.R-project.org/package=factoextra 

Lê, S., Josse, J., & Husson, F., 2008. FactoMineR: An R Package for Multivariate Analysis. Journal of Statistical Software., 1-18. 

Prøsch-Danielsen, L., 1997. New light on the Holocene shore displacement curve on Lista, the southernmost part of Norway. Norsk Geografisk Tidsskrift - Norwegian Journal of Geography, 51(2), 83–101. https://doi.org/doi:10.1080/00291959708552368

Romundset, A., Fredin, O., & Høgaas, F., 2014. A Holocene sea-level curve and revised isobase map based on isolation basins from near the southern tip of Norway. Boreas, 44(2), 383–400. https://doi.org/doi:10.1111/bor.12105

Sørensen, R., 2002. Hurumlandskapets utvikling gjennom 300 millioner år. Det norske vitenskaps-Akademi. Årbok, 1999. Universitetsforlaget, 323–333.

Sørensen, R., Henningsmoen, K. E., Høeg, H. I., & Gälman, V., 2014. Holocene landhevningsstudier i søndre Vestfold of sørøstre Telemark – revidert kurve. In: P. P. Stine Melvold ed. Vestfoldbaneprosjektet. Arkeologiske undersøkelser i forbindelse med ny jernbane mellom Larvik og Porsgrunn. Bind 1. Tidlig- og mellommesolittiske lokaliteter i Vestfold og Telemark. Oslo: Portal forlag, 36–47.

Team, Q. D., 2020. QGIS Geographic Information System. In http://qgis.org

Team, R. C., 2020. R: A language and environment for statistical computing. R Foundation for Statistical Computing.

Wickham, H., 2016. ggplot2: Elegant Graphics For Data Analysis. 2 ed. New York: Springer.

Wickham, H., & Bryan, J., 2023. readxl: Read Excel Files. https://readxl.tidyverse.org 

Wickham, H., François, R., Henry, L., Müller, K., & Vaughan, D., 2023. dplyr: A Grammar of Data Manipulation.



