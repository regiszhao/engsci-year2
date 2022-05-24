from turtle import pos
import matplotlib.pyplot as plt
import numpy as np
from scipy.optimize import curve_fit
from scipy import stats
# np.seterr(divide='ignore', invalid='ignore')


# # FINDING CENTRAL MAX FOR SINGLE SLIT AND DOUBLE SLIT EXERCISES

# # f = open('singleslit0.04.txt', 'r')
# # f = open('doubleslit0.04_0.25.txt', 'r')
# # f = open('doubleslit0.04_0.50.txt', 'r')
# # f = open('doubleslit0.08_0.25.txt', 'r')
# f = open('singleslit0.16.txt', 'r')
# raw_data = f.readlines()

# # getting rid of text at the top of the file
# raw_data.pop(0)
# raw_data.pop(0)

# data = [] # initialize list of data points
# positions = []
# intensities = []
# for line in raw_data:
#     datapoint = line.split()
#     (x, y) = (float(datapoint[0]), float(datapoint[1]))
#     data.append((x, y))
#     positions.append(x)
#     intensities.append(y)
# f.close()

# max_intensity = max(intensities)
# max_intensity_index = intensities.index(max_intensity)
# pos_of_max_intensity = positions[max_intensity_index]
# print(max_intensity, pos_of_max_intensity)




# CURVE FITTING
f = open('singleslit0.16.txt', 'r')

raw_data = f.readlines()

# getting rid of text at the top of the file
raw_data.pop(0)
raw_data.pop(0)

data = [] # initialize list of data points
positions = []
intensities = []
for line in raw_data:
    datapoint = line.split()
    (x, y) = (float(datapoint[0]), float(datapoint[1]))
    data.append((x, y))
    positions.append(x)
    intensities.append(y)
f.close()

def theta(x):
    loc_max = -0.01844
    return np.sin(np.arctan(x-loc_max)/1.1)

def Phi(x):
    a = 0.00016
    return (np.pi * a * np.sin(theta(x)))/0.00000065

def func(phi, I0):
    return I0 * ((np.sin(phi)/phi)**2)

# creating phi array from positions array
phi_arr = []
intensities_filtered = []
for i in range(len(positions)):
    phi = Phi(positions[i])
    if abs(phi) > 0.0000000000000000000000000000000000001:
        phi_arr.append(phi)
        intensities_filtered.append(intensities[i])
# print(phi)
# phi_arr.append(0.0000000000000000000000000000000000001)
# intensities_filtered.append(3.53593)
print(phi_arr)
print(intensities_filtered)

# fit to curve:
popt, pcov = curve_fit(func, phi_arr, intensities_filtered)

print(popt)


# plotting recorded data
plt.errorbar(phi_arr, intensities_filtered, label='data')

# plotting fit
plt.plot(phi_arr, func(phi_arr, *popt), label='non-linear fit')
plt.title('Light intensity vs Phi')
plt.xlabel('Phi')
plt.ylabel('Light Intensity (volts)')
plt.legend()
plt.show()



slope, intercept, r_value, p_value, std_err = stats.linregress(phi_arr, intensities_filtered)
print(r_value**2, std_err)
