from __future__ import division

text = 'input_ciphertext_here'

def ioc(freqs) :
	enumerator  = 0
	denominator = 0
	for letter in freqs:
		enumerator += freqs[letter]*(freqs[letter] -1 )
		denominator += freqs[letter]
		
	return enumerator/(denominator*(denominator-1))

def build_dict(t, length):
	fr = dict()
	for i,l in enumerate(t) :
		index = i * length 
		if index >= len(t) : #check out of bounds
			return fr 
			
		letter = t[index]
		if letter == ' ' :
			pass
		elif letter in fr :
			fr[letter] += 1
		else:
			fr[letter] = 1	
	return fr

fp = open ('res.txt','w')
fp.write('"Key length", IoC \n')
highest = 0
highest_index = [] 
for i in range(1,20):
	fp.write("KEY length {:2d}\n".format(i))
	for j in range(0,i):
		t = text[j:] #shift text one position to the right 
		list = build_dict(t,i)
		index_oc = ioc(list)
		if index_oc > highest :
			highest = index_oc
			highest_index = [i,j]
		fp.write("{:2d} : {}\n".format(j,index_oc/0.0385))

fp.write("Highest value {}, index : {}".format(highest, highest_index))
fp.close()