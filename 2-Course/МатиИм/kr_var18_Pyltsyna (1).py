import numpy as np

#P = [[0,0.48,0,0,0.13,0.11,0,0,0,0,0,0,0,0,0,0],
#     [0,0,0,0,0.55,0,0.23,0,0,0,0,0,0,0,0,0],
#     [0,0.17,0,0,0.46,0,0.31,0,0,0,0,0,0,0,0,0],
#     [0,0,0,0,0,0.39,0.4,0,0,0,0,0,0,0,0,0],
#     [0.41,0,0.19,0,0,0.13,0,0.08,0,0.11,0,0,0,0,0,0],
#     [0,0.03,0,0.15,0.35,0,0,0,0.26,0,0.16,0,0,0,0,0],
#     [0.51,0,0,0,0,0.42,0,0,0,0,0,0,0,0,0,0],
#     [0,0,0,0,0,0,0.01,0,0.22,0,0,0.21,0.2,0,0,0.33],
#     [0,0,0,0,0,0,0.13,0.25,0,0.3,0,0,0,0,0,0],
#     [0,0,0,0,0.16,0.07,0.04,0,0.17,0,0.09,0.17,0.06,0.11,0.01,0],
#     [0,0,0,0,0,0,0.24,0,0,0,0,0.16,0,0.17,0.01,0.15],
#     [0,0,0,0,0,0,0,0,0,0,0,0,0.88,0,0,0],
#     [0,0,0,0,0,0,0,0.32,0,0.6,0,0.01,0,0,0,0],
#     [0,0,0,0,0,0,0,0,0.1,0.18,0.23,0,0.18,0,0,0],
#     [0,0,0,0,0,0,0,0,0,0,0.53,0,0,0.39,0,0],
#     [0,0,0,0,0,0,0,0,0,0.33,0,0,0,0,0.2,0]]
#
##заполнение диагонали
#for i in range(len(P)):
#    s = 0
#    for j in range(len(P)):
#        s += P[i][j]
#    P[i][i] = round(1 - s, 2)
#
#print('P = ', P) #матрица вероятностей 
#
#
##1) вероятность того, что за 5 шагов система перейдет из состояния 13 в состояние 7;
#
#pk = np.linalg.matrix_power(P, 5) #возведение матрицы в 5 степень
#print('1)вероятность того, что за 5 шагов система перейдет из состояния 13 в состояние 7 = ', pk[12][6])
#
##2) вероятности состояний системы спустя 6 шагов, если в начальный момент вероятность состояний были 
##следующими A=(0,05;0,05;0;0,09;0,11;0,1;0,14;0,06;0,08;0,03;0,07;0,01;0,09;0,07;0,01;0,04);
#
#A0 = np.matrix('0.05 0.05 0 0.09 0.11 0.1 0.14 0.06 0.08 0.03 0.07 0.01 0.09 0.07 0.01 0.04')
#A = np.linalg.matrix_power(P, 6) #возведение матрицы в 6 степень
#A = A0.dot(A) #перемножение матрицы на вектор
#print('2) вероятности состояний системы спустя 6 шагов = ', A)
#
##3) вероятность первого перехода за 9 шагов из состояния 11 в состояние 8;
#
#def mult_for_first(p1, p2): #функция перемножение матриц для первого перехода
#    res = [[0 for j in range(len(p2[0]))] for i in range(len(p1))] #пустая матрица
#    for i in range(len(p1)):
#        for j in range(len(p2[0])):
#            for k in range(len(p2)):
#                if i != j: #пропуск перехода в это же состояние 
#                        res[i][j] += p1[i][k] * p2[k][j]
#    return res
#
#def first_p(p, k): #функция нахождения вероятностей первого перехода за k шагов
#    res = [[p[i][j] for j in range(len(p))] for i in range(len(p))]
#    for i in range(k - 1):
#        res = mult_for_first(p, res)
#    return res
#
#first=first_p(P, 9)
#print("3) вероятность первого перехода за 9 шагов из состояния 11 в состояние 8 = ", first[10][7])
#
##4) вероятность перехода из состояния 11 в состояние 6 не позднее чем за 8 шагов;
#temp_p = [[P[i][j] for j in range(len(P))] for i in range(len(P))]
#p4 = temp_p[10][5]
#for i in range(8):
#    temp_p = mult_for_first(P,temp_p)
#    p4 += temp_p[10][5]
#
#print("4) вероятность перехода из состояния 11 в состояние 6 не позднее чем за 8 шагов = ", p4)
#
##5) среднее количество шагов для перехода из состояния 15 в состояние 13;
#temp_p = [[P[i][j] for j in range(len(P))] for i in range(len(P))]
#p5 = temp_p[14][12]
#for i in range(2, 1000): #бесконечность в формуле заменяем большим числом
#    temp_p = mult_for_first(P,temp_p)
#    p5 += temp_p[14][12]
#
#print("5) среднее количество шагов для перехода из состояния 15 в состояние 13 ", p5)
#
##6) вероятность первого возвращения в состояние 16 за 7 шагов;
#
#def fjj_k(p, k, el): #функция нахождения вероятности первого возвращения в состояние(el - номер состояния) за k шагов
#    f = [0, p[el - 1][el - 1]] 
#    if k == 1: 
#        return f[-1] 
#    else:
#        for i in range(2, k + 1):
#            mp = np.linalg.matrix_power(p, i) 
#            pk = mp[el - 1][el - 1] 
#            summa = 0 
#            for m in range(1, i):
#                fjj = np.linalg.matrix_power(p, i - m)[el - 1][el - 1] 
#                summa += fjj * f[m] 
#                f.append(pk - summa) 
#    return f[-1]
#
#def first_return(a, step, probability_of_return=0):  # Функция, находящая первое возвращение в состояние
#    # probability_of_return = 0: вероятность первого возвращения в состояние, по умолчанию 0;
#    # 1: среднее время возвращения;
#    # 2: вероятность возвращения в состояние не позднее, чем за step шагов
#    f = [[[a[i][j] for j in range(len(a))] for i in range(len(a))]]
#    a_step = [[[a[i][j] for j in range(len(a))] for i in range(len(a))]]
#    for k in range(1, step):
#        a_step.append(mult_for_first(a, a_step[-1]))
#        f.append([[a_step[k][i][j] for j in range(len(a))] for i in range(len(a))])
#        for m in range(k):
#            for i in range(len(a)):
#                for j in range(len(a)):
#                    f[k][i][j] -= f[m][i][j] * a_step[k - m - 1][i][j]
#    if probability_of_return == 0:
#        result = [f[-1][i][i] for i in range(len(a))]
#    elif probability_of_return == 1:
#        result = [0 for i in range(len(a))]
#        for k in f:
#            for i in range(len(a)):
#                result[i] += k[i][i]
#    elif probability_of_return == 2:
#        result = [0 for i in range(len(a))]
#        for j in range(len(f)):
#            for i in range(len(a)):
#                result[i] += (j + 1) * f[j][i][i]
#    else:
#        result = "Неверно введен параметр probability_of_return"
#    return result
#
#print("6) вероятность первого возвращения в состояние 16 за 7 шагов = ", first_return(P, 7)[15])
#    
##7) вероятность возвращения в состояние 8 не позднее чем за 9 шагов;
##p7 = 0
##for i in range(1, 10):
##    p7 += fjj_k(P, i, 8)
#
#print("7) вероятность возвращения в состояние 8 не позднее чем за 9 шагов = ", first_return(P, 9, 1)[7])
#
##8) среднее время возвращения в состояние 9;
##p8 = 0
##for i in range(1, 300):
##    p8 += t * fjj_k(P, i, 9)
#    
#print("8) среднее время возвращения в состояние 9 = ", first_return(P, 1000, 2)[8])
#
##9) установившиеся вероятности.
##def ust_p(p): 
##    Pt = p.transpose() #транспортируем
##    for i in range(0, len(p)): #вычитаем единичную матрицу 
##        Pt[i][i] = p[i][i] - 1 
##    Pt[len(p) - 1] = 1 #последнюю строчку заполняем единицами
##    B = np.zeros((len(Pt), 1)) 
##    B[len(p) - 1] = 1 #последнюю строчку матрицы делаем из 1
##    X = np.linalg.matrix_power(Pt, -1).dot(B) 
##    return X
#    
#def find_constant(p):  # Функция, находящая установившиеся вероятности
#    matrix = [[p[j][i] for j in range(len(p[0]))] for i in range(len(p))]
#    for i in range(len(p)):
#        matrix[i][i] -= 1
#        matrix[-1][i] = 1
#    b = [[0] for i in range(len(p))]
#    b[-1][0] = 1
#    matrix = np.linalg.inv(np.array(matrix)).tolist()
#    matrix = np.dot(matrix, b)
#    return [matrix[i][0] for i in range(len(matrix))]
#
#print("9) установившиеся вероятности: ", find_constant(P))
    
def find_constant(l):  # Функция возвращает устоявшиеся вероятности состояния системы (от 0 работающих устройств до 12)
    matrix = [[l[j][i] for j in range(len(l[0]))] for i in range(len(l))]
    for i in range(len(l)):
        matrix[i][i] = 0
        for j in range(len(l)):
            if j != i:
                matrix[i][i] -= l[i][j]
        matrix[-1][i] = 1
    b = [[0] for i in range(len(l))]
    b[-1][0] = 1
    matrix = np.linalg.inv(np.array(matrix)).tolist()
    matrix = np.dot(matrix, b)
    p = []
    for i in matrix:
        p.append(i[0])
    return p    
    
lu = 36 #интенсивность поступления
m = 6  #количество каналов обслуживания
mu = 8 #интенсивность обсулживания
n = 7 #максимальный размер очереди

#заполнение матрицы интенсивностей
L = [[0 for j in range(n + m + 1)] for i in range(n + m + 1)]
for i in range(0, n + m): #заполнение диагонали интенсив. поступлений
    L[i][i + 1] = lu    
for i in range(1, n + m + 1): #заполнение диагонали интенсив. обслуживаний
    if i < m:
        L[i][i - 1] = i * mu
    else:
        L[i][i - 1] = m * mu
        
print("Матрица интенсивностей: ", L)
#
##a)	Составьте граф марковского процесса, запишите систему уравнений Колмогорова и найдите установившиеся вероятности состояний.
#def ust_p(N, M, matrix):
#    l = np.zeros(len(L), len(L))
#    for i in range (0, len(L)): 
#        l[i][i] = -sum(L[i]) #диагональ заполняем суммой по строке
#    M = matrix.transpose() - l 
#    M[-1] = 1 #последнюю строку заполняем единицами
#    B = np.zeros((n + m + 1, 1))
#    B[-1] = 1 # последняя единица
#    return (np.linalg.matrix_power(M,-1).dot(B)) #обратную матрицу M умножаем на B
#    
#p_ust = find_constant(L) #ust_p(n, m, L) 
#print("a) установившиеся вероятности состояний: ", p_ust)
#
##b)	Найдите вероятность отказа в обслуживании.
#p_otkaz = p_ust[m + n]
#print("b) вероятность отказа в обслуживании = ", p_otkaz)
#
##c)	Найдите относительную и абсолютную интенсивность обслуживания.
#q = 1 - p_otkaz
#print("c) относительная интенсивность = ", q)
#
#A = q * lu
#print("c) абсолютная интенсивность = ",  A)
#
##d)	Найдите среднюю длину в очереди.
#L_o4 = 0
#for i in range(1, n + 1):
#    L_o4 += i * p_ust[m + i]
#print("d) средняя длина очереди = ",  L_o4)
#
##e)	Найдите среднее время в очереди.
#T_o4 = 0
#for i in range(n):
#    T_o4 += (i + 1) / (m * mu) * p_ust[m + i]
#print("e) среднее время в очереди = ",  T_o4)
#
##f)	Найдите среднее число занятых каналов.
#N_kanalov = 0
#for i in range(1, m + 1):
#    N_kanalov += i * p_ust[i]
#for i in range(m + 1, m + n + 1):
#    N_kanalov += m * p_ust[i]
#print("f) среднее число занятых каналов = ",  N_kanalov)
#
##g)	Найдите вероятность того, что поступающая заявка не будет ждать в очереди.
#no_wait = 0
#for i in range(0, m):
#    no_wait += p_ust[i]
#print("g) вероятность того, что поступающая заявка не будет ждать в очереди = ",  no_wait)
#
##h)	Найти среднее время простоя системы массового обслуживания.
#t_prost = 1 / lu
#print("h) среднее время простоя системы массового обслуживания = ", t_prost)
#
##i)	Найти среднее время, когда в системе нет очереди.
#def find_coef(l): #матрица коэф Колмагорова
#    k = [[0 for j in range(len(l))] for i in range(len(l))]
#    for i in range(0, m): #копируем матрицу L но размером от 0 до m и транспортируем
#        for j in range(len(l)):
#            k[j][i] = l[i][j]
#    for i in range(0, m): #заполняем диагональ минус суммами исходящих вероятностей
#        for j in range(len(l)):
#            if j != i:
#                k[i][i] -= l[i][j]
#    return k
#
#kk = find_coef(L)
#
#def RK_p(coef, l, t):
#    k = {x: [0, 0, 0, 0] for x in range(0,m+1)}
#    for x in range(0, m+1):
#        for i in range(0, m+1):
#            k[x][0] += coef[x][i] * l[i]
#        for i in range(0, m+1):
#            k[x][1] += (coef[x][i]) * (l[i] + k[x][0] * t / 2)
#        for i in range(0, m+1):
#            k[x][2] += (coef[x][i]) * (l[i] + k[x][1] * t / 2)
#        for i in range(0, m+1):
#            k[x][3] += (coef[x][i]) * (l[i] + k[x][2] * t)
#    return [(l[x] + t * (k[x][0] + 2 * k[x][1] + 2 * k[x][2] + k[x][3]) / 6) for x in range(0, m+1)]
#
#    
#def integr(vp, t, time_step):
#    f = 0
#    p = vp.copy()
#    for n in np.arange(time_step, t + time_step, time_step):
#        p = RK_p(kk, vp, time_step)
#        f += t * sum(p[i] * L[i][j] for j in range(m+1,m+n) for i in range(0,m))
#    return f * time_step
#
#p_ust2 = [0 for i in range(0,m+1)] #берем установившиеся вероятности от 0 состояния до m
#for i in range(len(p_ust2)):
#    p_ust2[i] = p_ust[i]
#norm = 1 / sum(p_ust2) #находим коэф нормировки, деля единицу на сумму вер. состояний
#for i in range(len(p_ust2)): #домножаем их на коэф нормировки
#    p_ust2[i] = p_ust2[i] * norm
#t_not_q = integr(p_ust2, 1000, 0.0005)
#print("h) среднее время, когда в системе нет очереди = ", t_not_q)