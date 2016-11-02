file = open('secret.hex','r').readline()

key = [ord(file[0]) ^ ord('H'), ord(file[1]) ^ ord('g')]
print "Key is :", key, hex(key[0]), hex(key[1]) #decimal, then hex

string = [chr(ord(byte)^key[i%2]) for i, byte in enumerate(file)]
print "".join(string)