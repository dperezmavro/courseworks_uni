palph = 'girumbnwxachqlsykfjopdetvz' *2
txt = 'ciphertext_here'.lower().replace(' ','')

for i in range(0,26):
	cur_all = palph[i:i+26]
	txt2 = txt
	for j,l in enumerate(palph[0:26]) :
		txt2 = txt2.replace(cur_all[j],l.upper())	
	print i,txt2