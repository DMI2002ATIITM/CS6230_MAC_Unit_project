
file = open("C_binary.txt","r")
C = file.readlines()
file.close()

file = open("negC_binary.txt","w")
for i in C:
    file.write("1"+i[1:])
file.close()
