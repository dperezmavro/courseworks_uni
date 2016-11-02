#!/usr/bin/python
from InstanceClass import * 

print "Starting analyzer..."
examples = dict() #stores the keys for each example to see how many of each class
instances = list() # stores each instance

with open('../data') as fp :
	for line in iter(fp.readline,''):
		pc = line.strip('\n').split(",")
		if len(pc) > 2 : instances.append(InstanceClass(pc))
		patb = pc[-1]
		if len(patb) > 0 : 
			patc = int(patb)
			if patc in examples :
				examples[patc] += 1
			else :
				examples[patc] = 1 

#sort dictionary according to key values 
sorted(examples , key=lambda key:examples[key])

for i in examples.keys():
	print "class",i,"has", str(examples[i]),"number of examples"
