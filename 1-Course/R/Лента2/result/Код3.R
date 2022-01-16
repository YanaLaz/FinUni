DEBUG_OFF <- FALSE
DEBUG_ON <- TRUE

generate.sale.level <- function(way="/Users/yanalazareva/Documents/УНИВЕР/Программирование/R/Лента2/Магазин", type = "/in", saleLevel = 50, days = 7, countproducts = 1, isDebug = TRUE) {
  
  if (type == "/in") { 
    
    vproducts <- c(1:countproducts)
    # Создаю пустой вектор, куда будут введены продукты с клавиатуры 
    products <- vector()
    
    for (i in vproducts) {
      products <- append(products, as.character(readline("Введите продукт: ")))
    }  
    
    # Запись идет в файл поставки(в '/Users/yanalazareva/Documents/УНИВЕР/Программирование/R/Лента2/Магазин/in1.txt')
    for (i in (1:10)) { # Проделывается 10 раз, так как у нас 10 магазинов 
      #создаю таблицу
      in1 <- data.frame("Weekday" = (1:days), check.names=FALSE)
      #Добавляю в таблицу столбец с названием продукта и со сгенерированным вектором
      for (j in vproducts) {
        x <- sample(10:55, days)
        in1[products[j]] <- x
      }
      
      #Путь в файл
      way_to_file <- paste0(way, as.character(i),type, ".txt")
      
      if (isDebug) { # Если TRUE, то заголовки в таблице создаются 
        write.table(in1, file=way_to_file, col.names=TRUE, row.names=FALSE, sep =' ', dec=',')
      } else { # Если FALSE, то заголовки в таблице не создаются
        write.table(in1, file=way_to_file, col.names=FALSE, row.names=FALSE, sep =' ', dec=',')
      }
    }
  } else if (type == "/out") { # Запись идет в файл поставки(в '/Users/yanalazareva/Documents/УНИВЕР/Программирование/R/Лента2/Магазин/out1.txt')
    
    for (i in (1:10)) { # Проделывается 10 раз, так как у нас 10 магазинов 
      
      file1 <- read.table(file = paste0("/Users/yanalazareva/Documents/УНИВЕР/Программирование/R/Лента2/Магазин", as.character(i), "/in", ".txt"), header = TRUE)
      out1 <- data.frame("Weekday" = (1:days), check.names=FALSE)
      
      for (m in (2:length(names(file1)))) {
        # Загружаю в file1 таблицу из соответствующего магазина, чтобы осуществлять проверку для максимального значения
        zavoz <- file1[,m]
        prodazha <- vector()
        
        for (el in zavoz) {
          prodazha <- append(prodazha, round(el * saleLevel/100))
        }
        
        out1[names(file1)[m]] <- prodazha
        
      }
      
      #Путь в файл
      way_to_file <- paste0(way, as.character(i), type, ".txt")
      
      
      if (isDebug) { # Если TRUE, то заголовки в таблице создаются 
        write.table(out1, file=way_to_file, col.names=TRUE, row.names=FALSE, sep =' ', dec=',')
      } else { # Если FALSE, то заголовки в таблице не создаются
        write.table(out1, file=way_to_file, col.names=FALSE, row.names=FALSE, sep =' ', dec=',')
      }
    } 
  } 
}

generate.sale.level(countproducts = 4, saleLevel = 80)
generate.sale.level(type = "/out") # генерация файлов



setwd("/Users/yanalazareva/Documents/УНИВЕР/Программирование/R/Лента2/Анализ") # перехожу в папку с файлами поставки и продажи
#считываю таблицы из файлов в переменные

in1 <- read.table('store1_in.txt', header = TRUE)
in2 <- read.table('store2_in.txt', header = TRUE)
in3 <- read.table('store3_in.txt', header = TRUE)
in4 <- read.table('store4_in.txt', header = TRUE)
in5 <- read.table('store5_in.txt', header = TRUE)
in6 <- read.table('store6_in.txt', header = TRUE)
in7 <- read.table('store7_in.txt', header = TRUE)
in8 <- read.table('store8_in.txt', header = TRUE)
in9 <- read.table('store9_in.txt', header = TRUE)
in10 <- read.table('store10_in.txt', header = TRUE)
out1 <- read.table('store1_out.txt', header = TRUE)
out2 <- read.table('store2_out.txt', header = TRUE)
out3 <- read.table('store3_out.txt', header = TRUE)
out4 <- read.table('store4_out.txt', header = TRUE)
out5 <- read.table('store5_out.txt', header = TRUE)
out6 <- read.table('store6_out.txt', header = TRUE)
out7 <- read.table('store7_out.txt', header = TRUE)
out8 <- read.table('store8_out.txt', header = TRUE)
out9 <- read.table('store9_out.txt', header = TRUE)
out10 <- read.table('store10_out.txt', header = TRUE)




number_of_products <- length(names(in1))-1 # количество продуктов
name_of_products <- names(in1)[-1]

tabls <- c()
for (i in 1:number_of_products){
  rev <- rep(0,12)
  profit <- rep(0, length(rev))
  res.tab <- data.frame('выручка'=rev, 'прибыль'=profit) # выручка и прибыль
  sale <-rep(0, nrow(res.tab))
  res.tab$"реализация" <- sale # реализация
  res.tab[2] <- 0
  res.tab$"списание" <- 0 #списание
  res.tab$"sd" <- 0
  res.tab$"продажи макс" <- 0
  res.tab$"день макс" <- 0
  res.tab$"продажи мин" <- 0
  res.tab$"день мин" <- 0
  res.tab$"списание макс" <- 0
  res.tab$"день" <- 0
  
  #указываю название строчек
  for (j in (1:11)) {
    if (j <= 10) {	
      row.names(res.tab)[i] <- paste0('Магазин', as.character(i))
    }
    if (j == 11) { 
      row.names(res.tab)[j] <- 'Итого'
      row.names(res.tab)[j+1] <- 'Среднее'
    }
  }
  
  # цена за контейнер стоит 5500 руб. 
  # выручка от продажи одного(розница) 8000
  res.tab[1,1] = sum(out1[i+1])*8000
  res.tab[2,1] = sum(out2[i+1])*8000
  res.tab[3,1] = sum(out3[i+1])*8000
  res.tab[4,1] = sum(out4[i+1])*8000
  res.tab[5,1] = sum(out5[i+1])*8000
  res.tab[6,1] = sum(out6[i+1])*8000
  res.tab[7,1] = sum(out7[i+1])*8000
  res.tab[8,1] = sum(out8[i+1])*8000
  res.tab[9,1] = sum(out9[i+1])*8000
  res.tab[10,1] = sum(out10[i+1])*8000
  res.tab[11,1] = sum(res.tab[1:10,1])
  res.tab[12,1] = mean(res.tab[1:10,1])
  
  # потери от списания 400
  
  # Total revenue. TR = Q_sale*Price
  tr1 = sum(out1[i+1])*8000
  tr2 = sum(out2[i+1])*8000
  tr3 = sum(out3[i+1])*8000
  tr4 = sum(out4[i+1])*8000
  tr5 = sum(out5[i+1])*8000
  tr6 = sum(out6[i+1])*8000
  tr7 = sum(out7[i+1])*8000
  tr8 = sum(out8[i+1])*8000
  tr9 = sum(out9[i+1])*8000
  tr10 = sum(out10[i+1])*8000
  
  # Total cost. TC = Q_supply * P_supply + Q_util * P_util
  tc1 = sum(in1[i+1])*5500 + (sum(in1[i+1])-sum(out1[i+1]))*400
  tc2 = sum(in2[i+1])*5500 + (sum(in2[i+1])-sum(out2[i+1]))*400
  tc3 = sum(in3[i+1])*5500 + (sum(in3[i+1])-sum(out3[i+1]))*400
  tc4 = sum(in4[i+1])*5500 + (sum(in4[i+1])-sum(out4[i+1]))*400
  tc5 = sum(in5[i+1])*5500 + (sum(in5[i+1])-sum(out5[i+1]))*400
  tc6 = sum(in6[i+1])*5500 + (sum(in6[i+1])-sum(out6[i+1]))*400
  tc7 = sum(in7[i+1])*5500 + (sum(in7[i+1])-sum(out7[i+1]))*400
  tc8 = sum(in8[i+1])*5500 + (sum(in8[i+1])-sum(out8[i+1]))*400
  tc9 = sum(in9[i+1])*5500 + (sum(in9[i+1])-sum(out9[i+1]))*400
  tc10 = sum(in10[i+1])*5500 + (sum(in10[i+1])-sum(out10[i+1]))*400
  
  # Profit. pr = tr - tc
  pr1 = tr1-tc1
  pr2 = tr2-tc2
  pr3 = tr3-tc3
  pr4 = tr4-tc4
  pr5 = tr5-tc5
  pr6 = tr6-tc6
  pr7 = tr7-tc7
  pr8 = tr8-tc8
  pr9 = tr9-tc9
  pr10 = tr10-tc10
  
  res.tab[1,2] <- pr1
  res.tab[2,2] <- pr2
  res.tab[3,2] <- pr3
  res.tab[4,2] <- pr4
  res.tab[5,2] <- pr5
  res.tab[6,2] <- pr6
  res.tab[7,2] <- pr7
  res.tab[8,2] <- pr8
  res.tab[9,2] <- pr9
  res.tab[10,2] <- pr10
  z <- pr1 + pr2+ pr3+ pr4+ pr5+ pr6+ pr7+ pr8+ pr9+ pr10
  res.tab[11,2] <- z
  res.tab[12,2] <- mean(pr1, pr2, pr3, pr4, pr5, pr6, pr7, pr8, pr9, pr10)
  
  real1 <- sum(in1[i+1])
  real2 <- sum(in2[i+1])
  real3 <- sum(in3[i+1])
  real4 <- sum(in4[i+1])
  real5 <- sum(in5[i+1])
  real6 <- sum(in6[i+1])
  real7 <- sum(in7[i+1])
  real8 <- sum(in8[i+1])
  real9 <- sum(in9[i+1])
  real10 <- sum(in10[i+1])
  res.tab[1,3] <- real1
  res.tab[2,3] <- real2
  res.tab[3,3] <- real3
  res.tab[4,3] <- real4
  res.tab[5,3] <- real5
  res.tab[6,3] <- real6
  res.tab[7,3] <- real7
  res.tab[8,3] <- real8
  res.tab[9,3] <- real9
  res.tab[10,3] <- real10
  zz <- c(real1, real2,real3,real4,real5,real6,real7,real8,real9,real10)
  res.tab[11,3] <- sum(zz)
  res.tab[12,3] <- mean(zz)
  
  res.tab[1,4] <- sum(in1[i+1]) - sum(out1[i+1]) 
  res.tab[2,4] <- sum(in2[i+1]) - sum(out2[i+1]) 
  res.tab[3,4] <- sum(in3[i+1]) - sum(out3[i+1]) 
  res.tab[4,4] <- sum(in4[i+1]) - sum(out4[i+1]) 
  res.tab[5,4] <- sum(in5[i+1]) - sum(out5[i+1]) 
  res.tab[6,4] <- sum(in6[i+1]) - sum(out6[i+1]) 
  res.tab[7,4] <- sum(in7[i+1]) - sum(out7[i+1]) 
  res.tab[8,4] <- sum(in8[i+1]) - sum(out8[i+1]) 
  res.tab[9,4] <- sum(in9[i+1]) - sum(out9[i+1]) 
  res.tab[10,4] <- sum(in10[i+1]) - sum(out10[i+1]) 
  zzz <- sum(res.tab[1:10,4])
  zzz1 <- mean(res.tab[1:10,4])
  res.tab[11,4] <- zzz
  res.tab[12,4] <- zzz1
  
  res.tab[1,5] <- sd(out1[1:7,i+1])
  res.tab[2,5] <- sd(out2[1:7,i+1])
  res.tab[3,5] <- sd(out3[1:7,i+1])
  res.tab[4,5] <- sd(out4[1:7,i+1])
  res.tab[5,5] <- sd(out5[1:7,i+1])
  res.tab[6,5] <- sd(out6[1:7,i+1])
  res.tab[7,5] <- sd(out7[1:7,i+1])
  res.tab[8,5] <- sd(out8[1:7,i+1])
  res.tab[9,5] <- sd(out9[1:7,i+1])
  res.tab[10,5] <- sd(out10[1:7,i+1])
  l <- sum(res.tab[1:10,5])
  l1 <- mean(res.tab[1:10,5])
  res.tab[11,5] <- l
  res.tab[12,5] <- l1
  
  res.tab[1,6] <- max(out1[i+1])
  res.tab[1,7] <- which.max(unlist(out1[i+1]))
  res.tab[2,6] <- max(out2[i+1])
  res.tab[2,7] <- which.max(unlist(out2[i+1]))
  res.tab[3,6] <- max(out3[i+1])
  res.tab[3,7] <- which.max(unlist(out3[i+1]))
  res.tab[4,6] <- max(out4[i+1])
  res.tab[4,7] <- which.max(unlist(out4[i+1]))
  res.tab[5,6] <- max(out5[i+1])
  res.tab[5,7] <- which.max(unlist(out5[i+1]))
  res.tab[6,6] <- max(out6[i+1])
  res.tab[6,7] <- which.max(unlist(out6[i+1]))
  res.tab[7,6] <- max(out7[i+1])
  res.tab[7,7] <- which.max(unlist(out7[i+1]))
  res.tab[8,6] <- max(out8[i+1])
  res.tab[8,7] <- which.max(unlist(out8[i+1]))
  res.tab[9,6] <- max(out9[i+1])
  res.tab[9,7] <- which.max(unlist(out9[i+1]))
  res.tab[10,6] <- max(out10[i+1])
  res.tab[10,7] <- which.max(unlist(out10[i+1]))
  
  res.tab[1,8] <- min(out1[i+1])
  res.tab[1,9] <- which.min(unlist(out1[i+1]))
  res.tab[2,8] <- min(out2[i+1])
  res.tab[2,9] <- which.min(unlist(out2[i+1]))
  res.tab[3,8] <- min(out3[i+1])
  res.tab[3,9] <- which.min(unlist(out3[i+1]))
  res.tab[4,8] <- min(out4[i+1])
  res.tab[4,9] <- which.min(unlist(out4[i+1]))
  res.tab[5,8] <- min(out5[i+1])
  res.tab[5,9] <- which.min(unlist(out5[i+1]))
  res.tab[6,8] <- min(out6[i+1])
  res.tab[6,9] <- which.min(unlist(out6[i+1]))
  res.tab[7,8] <- min(out7[i+1])
  res.tab[7,9] <- which.min(unlist(out7[i+1]))
  res.tab[8,8] <- min(out8[i+1])
  res.tab[8,9] <- which.min(unlist(out8[i+1]))
  res.tab[9,8] <- min(out9[i+1])
  res.tab[9,9] <- which.min(unlist(out9[i+1]))
  res.tab[10,8] <- min(out10[i+1])
  res.tab[10,9] <- which.min(unlist(out10[i+1]))
  
  l1 <- in1[1:7,2]-out1[1:7,i+1]
  res.tab[1,10] <- max(l1)
  res.tab[1,11] <- which.max(l1)
  l2 <- in2[1:7,2]-out2[1:7,i+1]
  res.tab[2,10] <- max(l2)
  res.tab[2,11] <- which.max(l2)
  l3 <- in3[1:7,2]-out3[1:7,i+1]
  res.tab[3,10] <- max(l3)
  res.tab[3,11] <- which.max(l3)
  l4 <- in4[1:7,2]-out4[1:7,i+1]
  res.tab[4,10] <- max(l4)
  res.tab[4,11] <- which.max(l4)
  l5 <- in5[1:7,2]-out5[1:7,i+1]
  res.tab[5,10] <- max(l5)
  res.tab[5,11] <- which.max(l5)
  l6 <- in6[1:7,2]-out6[1:7,i+1]
  res.tab[6,10] <- max(l6)
  res.tab[6,11] <- which.max(l6)
  l7 <- in7[1:7,2]-out7[1:7,i+1]
  res.tab[7,10] <- max(l7)
  res.tab[7,11] <- which.max(l7)
  l8 <- in8[1:7,2]-out8[1:7,i+1]
  res.tab[8,10] <- max(l8)
  res.tab[8,11] <- which.max(l8)
  l9 <- in9[1:7,2]-out9[1:7,i+1]
  res.tab[9,10] <- max(l9)
  res.tab[9,11] <- which.max(l9)
  l10 <- in10[1:7,2]-out10[1:7,i+1]
  res.tab[10,10] <- max(l10)
  res.tab[10,11] <- which.max(l10)
  
  tabls <- c(tabls, res.tab)
} 


setwd("..")
setwd("result")
count <- length(tabls)/11
for (i in 1:count) {
  write.table(tabls[1:11], file=paste0("res.tab_", as.character(name_of_products[i]), ".csv"), col.names = TRUE, row.names = FALSE, sep = ";", dec = ",", fileEncoding = "cp1251")
  if (length(tabls) > 11) {
    tabls[-12:-(length(tabls))] <- NULL
  }
}


#===================ГРАФИКИ ЛАБ 6===================

# объём продаж 1,2 магазин 
x  <- c(out1[, 2])
y1 <- c(out2[, 2])

ym1 <- min(out1[, 2])
ym2 <- min(out2[, 2])

if (ym1>ym2) {
  ym1 <- ym2
}
ymax1 <- max(out1[, 2])
ymax2 <- max(out2[, 2])
if (ymax1<ymax2) {
  ymax1 <- ymax2
}
plot(x,type="l",col="red", xlab = "Дни", ylab = "штука", xlim = c(1,7), ylim= c(ym1, ymax1),  main = "Объём продаж")
lines(y1,col="green")


#выручка 3,4 магазин
v3 <- c(out3[, 2])
v4 <- c(out4[, 2])
new3 <- v3*8000
new4 <- v4*8000

ym1 <- min(new3)
ym2 <- min(new4)
if (ym1>ym2) {
  ym1 <- ym2
}
ymax1 <- max(new3)
ymax2 <- max(new4)
if (ymax1<ymax2) {
  ymax1 <- ymax2
}
plot(new3,type="l",col="red",xlim = c(1,7), ylim= c(ym1, ymax1), xlab = "Дни", ylab = "Выручка", main = "Выручка")
lines(new4,col="green")

# прибыль 5, 6 магазин
v5 <- c(out5[, 2])
v6 <- c(out6[, 2])
i5 <- c(in5[, 2])
i6 <- c(in6[, 2])
new5 <- v5*8000 - (i5*5000)
new6 <- v6*8000 - (i6*5000)
plot(new5,type="b",col="blue", xlab = "Дни", ylab = "прибыль")
lines(new6,col="yellow")

# списание 7, 8 магазин
new7 <- c(in7[, 2]) - c(out7[, 2])
new8 <- c(in8[, 2]) - c(out8[, 2])
plot(new7,type="h",col="black", xlab = "Дни", ylab = "списание")
lines(new8,type = "o", col="green")

# рентабельность 9, 10 магазин
new9 <- (c(out9[, 2])*8000 - (c(in9[, 2])*5000)) / (c(out9[, 2])*8000) * 100
new10 <- (c(out10[, 2])*8000 - (c(in10[, 2])*5000)) / (c(out10[, 2])*8000) * 100
plot(new9,type="s",col="pink", xlab = "Дни", ylab = "Рентабельность")
lines(new10,type="o",col="green")


#===================ГРАФИКИ ЛАБ 7 задание 1===================

# объём продаж 
x  <- c(out1[, 2])
y <- c(out1[, 3])
z <- c(out1[, 4])
plot(x,type="b",pch = 19, col="red",xlab = "Дни", ylab = "Объём продаж")
lines(y,pch = 18, type = "b", col="green")
lines(z,col="black", type="b",pch = 17)
legend("topright", legend = c(names(out1[2]), names(out1[3]), names(out1[4])), col=c("red", "green","black"), lty=1, cex=0.8, bg = "transparent")

#выручка 
x <- c(out1[, 2])*8000
y <- c(out1[, 3])*8000
z <- c(out1[, 4])*8000
plot(x, type="b",pch = 19,col="red", xlab = "Дни", ylab = "Выручка")
lines(y,pch = 18, type = "b", col="green")
lines(z,col="black", type="b",pch = 17)
legend("topright", legend = c(names(out1[2]), names(out1[3]), names(out1[4])), col=c("red", "green","black"), lty=1, cex=0.8, bg = "transparent")


# прибыль 
v1 <- c(out1[, 2])
v2 <- c(out1[, 3])
v3 <- c(out1[, 4])
i1 <- c(in1[, 2])
i2 <- c(in1[, 3])
i3 <- c(in1[, 4])
new1 <- v1*8000 - (i1*5000)
new2 <- v2*8000 - (i2*5000)
new3 <- v3*8000 - (i3*5000)
plot(new1,type="b",pch = 19,col="blue", xlab = "Дни", ylab = "прибыль")
lines(new2,pch = 18, type = "b", col="green")
lines(new3,col="black", type="b",pch = 17)
legend("topright", legend = c(names(out1[2]), names(out1[3]), names(out1[4])), col=c("blue", "green","black"), lty=1, cex=0.8, bg = "transparent")


# списание 
new7 <- c(in1[, 2]) - c(out1[, 2])
new8 <- c(in1[, 3]) - c(out1[, 3])
new9 <- c(in1[, 4]) - c(out1[, 4])
plot(new7,type="b",pch = 19,col="black", xlab = "Дни", ylab = "списание")
lines(new8,pch = 18, type = "b", col="green")
lines(new9,col="red", type="b",pch = 17)
legend("topright", legend = c(names(out1[2]), names(out1[3]), names(out1[4])), col=c("black", "green","red"), lty=1, cex=0.8, bg = "transparent")

# рентабельность
new4 <- (c(out1[, 2])*8000 - (c(in1[, 2])*5000)) / (c(out1[, 2])*8000) * 100
new5 <- (c(out1[, 3])*8000 - (c(in1[, 3])*5000)) / (c(out1[, 3])*8000) * 100
new6 <- (c(out1[, 4])*8000 - (c(in1[, 4])*5000)) / (c(out1[, 4])*8000) * 100
plot(new4,type="b", pch = 19,col="red", xlab = "Дни", ylab = "Рентабельность")
lines(new5,pch = 18, type = "b", col="green")
lines(new6,col="black", type="b",pch = 17)
legend("topright", legend = c(names(out1[2]), names(out1[3]), names(out1[4])), col=c("red", "green","black"), lty=1, cex=0.8, bg = "transparent")


#===================ГРАФИКИ ЛАБ 7 задание 2===================

# объём продаж первого товара по всем магазинам
rev <- rep(0,10)
tab <- data.frame('магазин'=rev, 'объём_продаж'=rev)
#вносим в таблицу магазины
for (j in (1:10)) {
 tab[j,1] <- paste0('Магазин', as.character(j))
}
#вносим в таблицу объём продаж
tab[1,2] <- sum(out1[, 2])
tab[2,2] <- sum(out2[, 2])
tab[3,2] <- sum(out3[, 2])
tab[4,2] <- sum(out4[, 2])
tab[5,2] <- sum(out5[, 2])
tab[6,2] <- sum(out6[, 2])
tab[7,2] <- sum(out7[, 2])
tab[8,2] <- sum(out8[, 2])
tab[9,2] <- sum(out9[, 2])
tab[10,2] <- sum(out10[, 2])
  
colorr <- c("black","red","yellow","blue","grey","pink","brown","purple","orange","green")
barplot(tab$"объём_продаж",names.arg = tab$"магазин", col = colorr )

#===================ГРАФИКИ ЛАБ 7 задание 3===================
new_tab <- data.frame('магазин'=rev, 'объём_продаж1'=rev, 'объём_продаж2'=rev)
#вносим в таблицу магазины
for (j in (1:10)) {
  new_tab[j,1] <- paste0('Магазин', as.character(j))
}
#первый товар
new_tab[1,2] <- sum(out1[, 2])
new_tab[2,2] <- sum(out2[, 2])
new_tab[3,2] <- sum(out3[, 2])
new_tab[4,2] <- sum(out4[, 2])
new_tab[5,2] <- sum(out5[, 2])
new_tab[6,2] <- sum(out6[, 2])
new_tab[7,2] <- sum(out7[, 2])
new_tab[8,2] <- sum(out8[, 2])
new_tab[9,2] <- sum(out9[, 2])
new_tab[10,2] <- sum(out10[, 2])

#второй товар
new_tab[1,3] <- sum(out1[, 3])
new_tab[2,3] <- sum(out2[, 3])
new_tab[3,3] <- sum(out3[, 3])
new_tab[4,3] <- sum(out4[, 3])
new_tab[5,3] <- sum(out5[, 3])
new_tab[6,3] <- sum(out6[, 3])
new_tab[7,3] <- sum(out7[, 3])
new_tab[8,3] <- sum(out8[, 3])
new_tab[9,3] <- sum(out9[, 3])
new_tab[10,3] <- sum(out10[, 3])


x  <- new_tab[,2]
y <- new_tab[,3]
plot(x, type="b",pch = 19, col="red",xlab = "Магазины", ylab = "Объём продаж")
lines(y,pch = 18, type = "b", col="green")
legend("topright", legend = c(names(out1[2]), names(out1[3])), col=c("red", "green"), lty=1, cex=0.8, bg = "transparent")




