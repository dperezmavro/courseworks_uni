#search for pattern abcded'ess'
fp = open('C:\Users\dennis\Desktop\q4\letters.txt', 'r')
words = [line.rstrip() for line in fp.readlines() if line[3] == line[5] #check letter _gap_letter
												and len(set(line[0:5])) == 5 #check first five unique
												and line[6] not in set(line[0:6])] #check not e contained

print str(len(words))+ " results"
for w in words :
	print w