#script to find three letter words which have the same two last letters 
fp = open('C:/Users/dennis/Desktop/test2.txt', 'r')
words = [line.rstrip() for line in fp.readlines() if len(line) > 2 and line[1] == line[2]]

print str(len(words))+ " results"
for w in words :
	print w
