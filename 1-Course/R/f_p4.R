install.packages("expm") #пакет для более удобного возведения матрицы в степень
library(expm)

#матрица вероятностей без учета вер-ти задержаться
P <- matrix(c(0, 0, 0.15, 0, 0, 0.77, rep(0, 8), 0.42, 0, 0.51, 
              rep(0, 12), 0.52, 0, 0.42, rep(0, 11), 0.11, 0, 0, 
              0.34, rep(0, 9), 0.18, 0.18, 0, 0.25, 0, 0, 0, 0.31,
              rep(0, 10), 0.54, 0, 0, 0, 0.32, rep(0, 5), 0.65, 0.14,
              rep(0, 5), 0.11, rep(0, 8), 0.06, rep(0, 3), 0.16, 0, 0, 
              0.26, 0, 0.29, 0.2, rep(0, 5), 0.07, 0, 0.19, 0.14, 0, 
              0.11, 0, 0.23, 0, 0.24, rep(0, 7), 0.87, rep(0, 13), 0.23,
              0.45, 0, 0, 0.25, rep(0, 12), 0.42, rep(0, 10), 0.17, 0.35,
              0, 0, 0, 0, 0.16, rep(0, 7), 0.02, 0.55, 0, 0, 0, 0.36, 0), 
            nrow = 14, ncol = 14, byrow = TRUE)

#заполнение диагонали матрицы 

for (i in 1:ncol(P))
  P[i,i] <- 1 - sum(P[i,])
P 


#3) вероятность первого перехода за 6 
#шагов из состояния 2 в состояние 12

first_k <- function(p, k) #нахожд. матрицы вер-тей первых переходов
{
  if (k <= 1) 
    return(p)
  else 
  {
    temp_p <- p 
    pm1 <- first_k(p, k-1) 
    for (i in 1:ncol(p))
      for (j in 1:ncol(p))
      {
        temp_p[i,j] <- 0
        for (m in 1:ncol(p))
          if (m!=j) #пропуск перехода в состояние на первых шагах
            temp_p[i,j] <- temp_p[i,j] + p[i,m] * pm1[m,j]
      }
    return(temp_p)
  }
}
first_k6 <- first_k(P, 6) #за 6 шагов
print(first_k6)
first_k6[2, 12] #вер-ть из 2 в 12


#4) вероятность перехода из состояния 6 
#в состояние 8 не позднее чем за 10 шагов

f_p4 <- function(p, k) #нахожд. матрицы вер-тей первых переходов
{
  temp_p <- p
  rez <- p
  summ <- p
  for (t in 1:k) #не поздее чем за 10 шагов
  {
    for (i in 1:ncol(p))
    {
      for (j in 1:ncol(p))
      {
        rez[i,j] <- 0
        for (m in 1:ncol(p))
          if (m!=j) #пропуск перехода в состояние на первых шагах
            rez[i,j] <- rez[i,j] + p[i,m] * temp_p[m][j]
      }
    }
    for (r in 1:ncol(rez))
    {
      for (d in 1:ncol(rez))
        summ[r,d] <- summ[r,d] + rez[r,d]
    }
    print(summ)
    temp_p <- rez
  }
  return(summ) 
}


f_p4(P,10)  
f_p4[6, 8]


#5) среднее количество шагов для 
#перехода из состояния 10 в состояние 5


f_p5 <- function(p) #нахожд. матрицы вер-тей первых переходов
{
  temp_p <- p
  rez <- p
  mult <- p
  for (t in 1:1000)
  {
    for (i in 1:ncol(p))
    {
      for (j in 1:ncol(p))
      {
        rez[i,j] <- 0
        for (m in 1:ncol(p))
          if (m!=j) #пропуск перехода в состояние на первых шагах
            rez[i,j] <- rez[i,j] + p[i,m] * temp_p[m][j]
      }
    }
    for (r in 1:ncol(rez))
    {
      for (d in 1:ncol(rez))
        mult[r,d] <- mult[r,d] + (t+1)*rez[r,d]
    }
    temp_p <- rez
  }
  return(mult) 
}

f_p5(P)  
f_p5[10, 5]













#7) вероятность возвращения в состояние 10 
#не позднее чем за 7 шагов
f_p7 <- function(p,K)
{
  f_p77 <- function(p, K){
    d <- c(dim(p), K)
    pk <- array(dim = d)
    for (i in 1:K)
      pk[,,i] <- p %^% i
    
    new <- pk
    for (k in 2:K) 
    {
      for (m in 1:(k-1))
        new[,,k]=new[,,k]-new[,,m]*pk[,,k-m]      
    }
    return(new[,,K])
  }
  summ <- p[10,10]
  for (r in 2:7)
    summ = summ + f_p77(P,r)[10,10]
  return(summ) 
}
f_p7(P, 7)

#неэффективно
p7 <- P[10,10]
print(p7)
for (t in 2:7) #не поздее чем за 7 шагов
  p7 <- p7 + first_return(P, t)[10,10]
p7 


#8) среднее время возвращения в состояние 14
f_p8 <- function(p,K)
{
  mult <- p[14,14]
  d <- c(dim(p), K)
  pk <- array(dim = d)
  for (i in 1:K)
    pk[,,i] <- p %^% i
  
  new <- pk
  for (k in 2:K) 
  {
    for (m in 1:(k-1))
      new[,,k]=new[,,k]-new[,,m]*pk[,,k-m]      
  }
  
  for (r in 2:500)
  {
    mult = mult + r * new[14,14,K]
  }
  return(mult) 
}
f_p8(P, 500)


#неэффективно
p8 <- P[14,14]
for (t in 2:1000) #(по ф-ле до беск.)
  p8 <- p8 + t * first_return(P, t)[14,14]
p8 
