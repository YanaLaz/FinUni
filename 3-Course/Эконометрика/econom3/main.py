import numpy as np
import matplotlib.pyplot as plt

# x = кв м
x = np.array([87, 65, 110, 62, 159, 201, 378, 72, 77, 183, 109, 161, 251, 69, 65, 95, 145, 190, 95, 250, 48, 48, 47, 53, 95, 50, 69, 208, 48, 111,])
# y = цена в миллионах руб
y = np.array([35, 24, 35, 40, 136, 124, 217, 20, 13, 151, 35, 159, 325, 25, 12, 18, 85, 115, 33, 128, 24, 29, 19, 19, 35, 41, 60, 271, 48, 96])

# Находим ср значения
xsr = np.mean(x)
ysr = np.mean(y)

sumx = sum(x-xsr) # Xi-Xsr
sumy = sum(y-ysr) # Yi-Ysr
summ = sum((x-xsr)*(y-ysr)) # (Xi-Xsr)*(Yi-Ysr)
sumx2 = sum((x-xsr)**2)  # (Xi-Xsr)^2

b2 = summ / sumx2
b1 = ysr - b2 * xsr
# Получаем уравнение прямой
# y = b1 + x*b2
# находим точки прямой

a1 = b1 + 0*b2
a2 = b1 + 500*b2

plt.plot(x,y,'ro')
plt.plot([0,500],[a1,a2])
plt.show()