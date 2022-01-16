generate.supply.sale <- function(way, dataType, min, max, makeHead){
  #определим названия заголовков столбцов
  title<-switch(dataType, "in"="Поставка", 'out'="Продажа")
  
  dio <- data.frame('День'=1:7)
  dio[, title] <- as.integer(runif(n=7, min, max))
  
  write.table(x = dio, file = paste0(way, title, ".txt"), col.names = makeHead)
}
# проверка работы функции
generate.supply.sale(way="/Users/yanalazareva/Documents/УНИВЕР/Программирование/R/123", dataType = "out", min = 2, max = 102, makeHead = TRUE)