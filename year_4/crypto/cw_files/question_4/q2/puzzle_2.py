fp2 =  open('C:/Users/dennis/Desktop/q3/two_letter_words.txt','r')
twos = [line.rstrip() for line in fp2.readlines()]

common = set(word for word in twos for w in twos if word[1] == w[1])

print common