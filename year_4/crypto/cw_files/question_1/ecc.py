from math import sqrt

field = 17

def E(x):
	return ((x ** 3) + (4*x) + 3) % field

y_s = [ (i**2) % field for i in range(0,17)] 
x_s = [ E(x) for x in range(0,17)]
results = []

for i_x,x in enumerate(x_s):
	for i_y,y in enumerate(y_s):
		if x == y :
			results.append((i_x,i_y))
			if i_y == 0 : 
				results.append((i_x,-i_y))

print results