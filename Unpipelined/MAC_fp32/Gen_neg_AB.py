file = open("A_binary.txt","r")
A = file.readlines()
file.close()

file = open("B_binary.txt","r")
B = file.readlines()
file.close()

file = open("AB_output.txt","r")
C = file.readlines()
file.close()

file = open("negA_binary.txt","w")
for i in A:
    file.write("1"+i[1:])
file.close()

file = open("negB_binary.txt","w")
for i in B:
    file.write("1"+i[1:])
file.close()

file = open("negAB_output.txt","w")
for i in C:
    file.write("1"+i[1:])
file.close()
