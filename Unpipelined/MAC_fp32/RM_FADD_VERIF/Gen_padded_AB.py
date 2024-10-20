file = open("AB_output.txt","r")
AB = file.readlines()
file.close()

file = open("Padded_AB_output.txt","w")
for i in AB:
    file.write(i.strip("\n")+("0"*16)+"\n")
file.close()

file = open("negAB_output.txt","r")
AB = file.readlines()
file.close()

file = open("Padded_negAB_output.txt","w")
for i in AB:
    file.write(i.strip("\n")+("0"*16)+"\n")
file.close()