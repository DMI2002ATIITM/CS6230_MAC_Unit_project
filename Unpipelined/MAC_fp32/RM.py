def round_bfloat16(A):
    # input and output are str
    round_bit = A[7]
    if(round_bit == "0"):
        return A[:7]
    elif(round_bit == "1"):
        temp = A[8:]
        if(int(temp,2) == 0):
            return A[:6]+"0"
        else:
            return bin(int(A[:7],2)+1)[2:]
            

def bfloat16_mul(A,B):
    A_sign = int(A[0],2)
    A_exp =  int(A[1:9],2)
    A_frac =  int("1"+A[9:],2)

    B_sign = int(B[0],2)
    B_exp =  int(B[1:9],2)
    B_frac =  int("1"+B[9:],2)

    bias = int("1111111",2)
    # bias = int("10000001",2)
    
    AB_sign = bin(A_sign ^ B_sign)[2:]

    AB_exp = bin(A_exp + B_exp - bias)[2:][-8:]
    # AB_exp = bin(A_exp + B_exp + bias)[2:][-8:]

    # Multiplication of mantissa
    temp_A = bin(A_frac)[2:]
    for i in range(len(temp_A)):
        if(temp_A[-1] == "1"):
            break
        temp_A = temp_A[:-1]

    temp_B = bin(B_frac)[2:]
    for i in range(len(temp_B)):
        if(temp_B[-1] == "1"):
            break
        temp_B = temp_B[:-1]

    nob_A = len(temp_A)
    nob_B = len(temp_B)

    temp_AB = int(temp_A,2) * int(temp_B,2)
    nob_AB = len(bin(temp_AB)[2:])

    exp_adj = nob_AB - (nob_A + nob_B - 1) 
    AB_exp = bin(int(AB_exp,2) + exp_adj)[2:]

    AB_frac = round_bfloat16(bin(A_frac * B_frac)[3:])

    return AB_sign + AB_exp + AB_frac


def decode_bfloat_16(A):
    A_sign = A[0]
    A_exp =  int(A[1:9],2) - 127
    A_frac =  A[9:]

    L = list(range(1,24))
    for i in range(len(L)):
        L[i] = 1/2**L[i]

    ans = 0
    for i in range(len(A_frac)):
        if(A_frac[i] == "1"):
            ans += L[i]

    ans += 1
    ans = ans * 2**A_exp

    if(A_sign == "1"):
        ans = ans * -1

    return ans


def fp32_add(A,B):
    A_sign = int(A[0],2)
    A_exp =  int(A[1:9],2)
    A_frac =  "1"+A[9:]

    B_sign = int(B[0],2)
    B_exp =  int(B[1:9],2)
    B_frac =  "1"+B[9:]

    if(A_exp >= B_exp):
        f = 1
        C_sign = A_sign
    else:
        f = 0
        C_sign = B_sign

    exp_diff = abs(A_exp - B_exp)
    # if()


file_a = open("A_binary.txt","r")
file_b = open("B_binary.txt","r")

A_inps = file_a.readlines()
B_inps = file_b.readlines()

file_a.close()
file_b.close()

outfile = open("check_AB_output.txt","w")
# outfile = open("check_AB_output_1.txt","w")
for i in range(len(A_inps)):
    strp_A = A_inps[i].strip("\n")
    strp_B = B_inps[i].strip("\n")
    AB = bfloat16_mul(strp_A,strp_B)
    dec_A = decode_bfloat_16(A_inps[i])
    dec_B = decode_bfloat_16(B_inps[i])
    dec_AB = decode_bfloat_16(AB)
    outfile.write(f"TEST_NO: {i+1} (BINARY) A -> {strp_A} | B ->  {strp_B} | AxB -> {AB} | (DECIMAL) A -> {dec_A} | B -> {dec_B} | AxB -> {dec_AB} | Correct answer -> {dec_A*dec_B} | Error -> {(dec_A*dec_B) - dec_AB} \n")
outfile.close()
