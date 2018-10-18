

library(idbr) # devtools::install_github('walkerke/idbr')
library(ggplot2)
library(animation)
library(dplyr)
library(ggthemes)
library(readr)

getwd()
pop_mex  <- read_csv("pob_ini_proyecciones.csv", local = locale(encoding = "latin1"))
pop_mex$POBLACION[pop_mex$SEXO == "Hombres"] <- -pop_mex$POBLACION[pop_mex$SEXO == "Hombres"]
pop_mex$POBLACION <- pop_mex$POBLACION/1000000
head(pop_mex)
pop_mex = subset(pop_mex, ENTIDAD == "República Mexicana")

data = subset(pop_mex, AÑO == 2050)

n1 <- ggplot(data, aes(x = EDAD, y = POBLACION, fill = SEXO)) + 
  geom_bar(aes(fill=SEXO), stat = "identity", width = 1) + 
  geom_bar(aes(fill=SEXO), stat = "identity", width = 1) + 
  scale_y_continuous(limits =c (-1.2,1.2), breaks = seq(-1.2, 1.2, .2), 
                     labels = paste0(as.character(c(seq(1.2, 0, -.2), seq(.2, 1.2, .2))), "m")) + 
  coord_flip() + 
  theme_bw(base_size = 6) +
  scale_fill_manual(values = c("blue", "red")) +
  labs(x = "Edad", y = "Millones de personas",
       title = "Pirámide poblacional de México: 1950",
       subtitle = title,
       caption = "Datos de CONAPO. \n GitHub: LuisPuenteP \n Twitter:@LuisPuenteP")

print(n1)
ggsave("Mex_pop2050.png")

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