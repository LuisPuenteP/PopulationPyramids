
# Population pyramids
Mexico's ageing population, animated with R using saveGIF


## Data 

Data from CONAPO. [CONAPO](http://www.conapo.gob.mx/work/models/CONAPO/Datos_Abiertos/Proyecciones2018/pob_mit_proyecciones.csv)

Population at mid-year for the period 1950-2050 

Tecnical details [here](https://www.gob.mx/conapo/acciones-y-programas/conciliacion-demografica-de-mexico-1950-2015-y-proyecciones-de-la-poblacion-de-mexico-y-de-las-entidades-federativas-2016-2050)


### Prerequisites

```
library(idbr) # devtools::install_github('walkerke/idbr')
library(ggplot2)
library(animation) # install.packages(“animation”)
library(dplyr)
library(ggthemes)
```

### Prepare the data

```
pop_mex  <- read_csv("http://www.conapo.gob.mx/work/models/CONAPO/Datos_Abiertos/Proyecciones2018/pob_mit_proyecciones.csv"))

pop_mex$POBLACION[pop_mex$SEXO == "Hombres"] <- -pop_mex$POBLACION[pop_mex$SEXO == "Hombres"]

pop_mex$POBLACION <- pop_mex$POBLACION/1000000

pop_mex = subset(pop_mex, ENTIDAD == "República Mexicana")

```

## Running a single year
```
data = subset(pop_mex, AÑO == 2050)

n1 <- ggplot(data, aes(x = EDAD, y = POBLACION, fill = SEXO)) + 
  geom_bar(aes(fill=SEXO), stat = "identity", width = 1) + 
  geom_bar(aes(fill=SEXO), stat = "identity", width = 1) + 
  scale_y_continuous(limits =c (-1.2,1.2), breaks = seq(-1.2, 1.2, .2), 
                     labels = paste0(as.character(c(seq(1.2, 0, -.2), seq(.2, 1.2, .2))), "m")) + 
  coord_flip() + 
  theme_bw(base_size = 7) +
  scale_fill_manual(values = c("blue", "red")) +
  labs(x = "Edad", y = "Millones de personas",
       title = "Pirámide poblacional de México: 1950-2050",
       subtitle = title,
       caption = "Fuente: CONAPO. \n  GitHub: LuisPuenteP") 

print(n1)
```
![alt text](https://github.com/LuisPuenteP/PopulationPyramids/blob/master/Code/Mex_pop2050.png "example")


### Runnin the Gif with saveGIF


```

saveGIF({
  
  for (i in 1950:2050) {
    
    title <- as.character(i)
    
    year_data <- filter(pop_mex, AÑO == i)
    
    n1 <- ggplot(year_data, aes(x = EDAD, y = POBLACION, fill = SEXO)) + 
      geom_bar(aes(fill=SEXO), stat = "identity", width = 1) + 
      geom_bar(aes(fill=SEXO), stat = "identity", width = 1) + 
      scale_y_continuous(limits =c (-1.2,1.2), breaks = seq(-1.2, 1.2, .2), 
                         labels = paste0(as.character(c(seq(1.2, 0, -.2), seq(.2, 1.2, .2))), "m")) + 
      coord_flip() + 
      theme_bw(base_size = 17) +
      scale_fill_manual(values = c("blue", "red")) +
      labs(x = "Edad", y = "Millones de personas",
           title = "Pirámide poblacional de México: 1950-2050",
           subtitle = title,
           caption = "Datos de CONAPO. \n GitHub: LuisPuenteP \n Twitter:@LuisPuenteP")
    
    print(n1)
    
  }
  
}, movie.name = 'piramide_mex.gif', interval = 0.1, ani.width = 700, ani.height = 600)
```

![alt text](https://github.com/LuisPuenteP/PopulationPyramids/blob/master/Code/piramide_mex.gif "Example")

## Author

* **Luis Puente** 

