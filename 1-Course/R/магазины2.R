DATA_IN <- 1
DATA_OUT <- 2

FILE_IN <- "in2"
FILE_OUT <-"out2"

generate.supply.sale <- function(way, dataType, min, max, makeHead){
  
  #определим названия заголовков столбцов
  title<-switch(dataType, "Поставка", "Продажа")
  filename <- switch(dataType, FILE_IN, FILE_OUT)
  
  dio <- data.frame('День'=1:7)
  dio[, title] <- as.integer(runif(n=7, min, max))
  
  # Проверка 
  if (dataType = DATA_OUT) {
    filenameIn <- paste0(way, FILE_IN, ".txt")
    dataIn <- read.table(file = fileNameIn, header = TRUE)
    
    for(i in 1: length(dio$"День")){
      if (dio[i,2]>dataIn[i,2]){
        dio[i,2] <- dataIn[i,2]
      }
    }
  }
  
  write.table(x = dio, file = paste0(way, filename, ".txt"), row.names = F, col.names = makeHead)
}
# проверка работы функции
generate.supply.sale(way="/Users/yanalazareva/Documents/УНИВЕР/Программирование/R/123", dataType = "out", min = 2, max = 102, makeHead = TRUE)