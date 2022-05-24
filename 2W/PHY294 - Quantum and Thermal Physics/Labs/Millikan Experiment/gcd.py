def float_gcd(a, b, rtol = 1e-05, atol = 1e-08):
    t = min(abs(a), abs(b))
    while abs(b) > rtol * t + atol:
        a, b = b, a % b
    return a

Q_vals = [4.26999E-20,	5.66444E-20, 1.31127E-19, 6.64984E-20, 1.8265E-19, 5.99134E-20, 1.27378E-19, 4.77906E-19, 3.44846E-19, 6.37416E-20, 7.09972E-20, 6.04456E-20, 5.54877E-20, 7.11282E-20, 1.0537E-19, 6.04189E-20, 5.84529E-20, 5.19147E-20, 6.41099E-20, 1.247E-19, 1.87109E-19, 1.89447E-19]

gcd = Q_vals[0]
for i in Q_vals[1:]:
    gcd = float_gcd(gcd, i)
print(gcd)
