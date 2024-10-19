def round_bfloat16(A):
    # input and output are str
    A += "0"
    round_bit = A[7]
    if(round_bit == "0"):
        return A[:7]
    elif(round_bit == "1"):
        temp = A[8:]
        if(int(temp,2) == 0 and A[6] == "0"):
            return A[:6]+"0"
        else:
            return bin(int(A[:7],2)+1)[2:].rjust(7,"0")
            

# def round_bfloat16(A):
#     # input and output are str
#     # print("A",A)
#     round_bit = A[7]
#     if(round_bit == "0"):
#         return A[:7]
#     return A[:7]
#     # elif(round_bit == "1"):
#     #     temp = A[8:]
#     #     # if(int(temp,2) == 0):
#     #     #     return A[:6]+"0"
#     #     # else:
#     #     #     print("here")
#     #     #     return bin(int(A[:7],2)+1)[2:].rjust(7,"0")
#     #     return A[:6]+"0"


def round_fp32(A):
    # input and output are str
    A += "0"
    round_bit = A[23]
    if(round_bit == "0"):
        return A[:23]
    elif(round_bit == "1"):
        temp = A[24:]
        if(int(temp,2) == 0 and A[22] == "0"):
            return A[:22]+"0"
        else:
            return bin(int(A[:23],2)+1)[2:].rjust(23,"0")            

def bfloat16_mul(A,B):
    A_sign = int(A[0],2)
    A_exp =  int(A[1:9],2)
    A_frac =  int("1"+A[9:],2)

    B_sign = int(B[0],2)
    B_exp =  int(B[1:9],2)
    B_frac =  int("1"+B[9:],2)

    # bias = int("1111111",2)
    bias = int("10000001",2)
    
    AB_sign = bin(A_sign ^ B_sign)[2:]

    # AB_exp = bin(A_exp + B_exp - bias)[2:][-8:]
    # AB_exp = bin(A_exp + B_exp + bias)[2:][-8:]

    AB_exp = bin((A_exp + B_exp + bias) & 0xFF)[2:][-8:]

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

    return AB_sign + AB_exp.rjust(8,"0") + AB_frac


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

def decode_fp32(A):
    A_sign = A[0]
    A_exp =  int(A[1:9],2) - 127
    A_frac =  A[9:]

    L = list(range(1,32))
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
    A_sign = A[0]
    A_exp =  int(A[1:9],2)
    A_frac =  "1"+A[9:].ljust(23,"0")

    B_sign = B[0]
    B_exp =  int(B[1:9],2)
    B_frac =  "1"+B[9:]

    exp_diff = A_exp - B_exp

    if(exp_diff < 0):
        # print("1")

        A_sign, B_sign = B_sign, A_sign
        A_exp, B_exp = B_exp, A_exp
        A_frac, B_frac = B_frac, A_frac


    for i in range(abs(exp_diff)):
        # print("2")
        B_frac = "0" + B_frac

    Blen_bef_add = len(B_frac)
    C_exp = A_exp

    # print(A_sign,B_sign)
    if(A_sign == B_sign):
        # print("3")
        # addition ...
        A_frac = A_frac.ljust(Blen_bef_add,"0")
        # print(Blen_bef_add)
        # print(A_frac)
        # print(B_frac)
        sum_val = bin(int(A_frac,2) + int(B_frac,2))[2:]
        # print(sum_val)
        # carry detection
        if(len(sum_val) > Blen_bef_add):
            # print("4")
            # Adjust exponent
            exp_add_diff = len(sum_val) - Blen_bef_add
            A_exp += exp_add_diff
        rounded_sum = round_fp32(sum_val[1:])
        return A_sign + bin(A_exp)[2:].rjust(8,"0") + rounded_sum
    else:
        # print("5")
        # subtraction ...
        return None


# Multiply .......
print("Multiplying .....")
file_a = open("A_binary.txt","r")
file_b = open("B_binary.txt","r")

A_inps = file_a.readlines()
B_inps = file_b.readlines()

file_a.close()
file_b.close()

outfile = open("AB_output.txt","w")
# outfile = open("check_AB_output_1.txt","w")
for i in range(len(A_inps)):
    strp_A = A_inps[i].strip("\n")
    strp_B = B_inps[i].strip("\n")
    AB = bfloat16_mul(strp_A,strp_B)
    dec_A = decode_bfloat_16(A_inps[i])
    dec_B = decode_bfloat_16(B_inps[i])
    dec_AB = decode_bfloat_16(AB)
    # outfile.write(f"TEST_NO: {i+1} (BINARY) A -> {strp_A} | B ->  {strp_B} | AxB -> {AB} | (DECIMAL) A -> {dec_A} | B -> {dec_B} | AxB -> {dec_AB} | Correct answer -> {dec_A*dec_B} | Error -> {(dec_A*dec_B) - dec_AB} \n")
    outfile.write(f"{AB}\n")
    print(f"  Multiplication done for TESTCASE {i+1}")
outfile.close()

# ....... And Accumulate
print("Adding .....")
file_a = open("AB_output.txt","r")
file_b = open("C_binary.txt","r")

A_inps = file_a.readlines()
B_inps = file_b.readlines()

file_a.close()
file_b.close()

outfile = open("MAC_output.txt","w")
for i in range(len(A_inps)):
    strp_A = A_inps[i].strip("\n")
    strp_B = B_inps[i].strip("\n")
    MAC = fp32_add(strp_A,strp_B)    
    outfile.write(f"{MAC}\n")
    print(f"  Addition done for TESTCASE {i+1}")
outfile.close()

# Checking computed results
print("Checking results")
file_a = open("MAC_output.txt","r")
file_b = open("MAC_binary.txt","r")

A_inps = file_a.readlines()
B_inps = file_b.readlines()

file_a.close()
file_b.close()

outfile = open("MAC_check_Results.txt","w")
wrong = open("MAC_wrong_Results.txt","w")
for i in range(len(A_inps)):
    strp_A = A_inps[i].strip("\n")
    strp_B = B_inps[i].strip("\n")
    # if(strp_A[:-2] == strp_B[:-2]):
    if(strp_A == strp_B):
        outfile.write(f"TESTCASE {i+1}: {strp_A} == {strp_B} <= PASS \n")
    else:
        outfile.write(f"TESTCASE {i+1}: {strp_A} != {strp_B} <= FAIL \n")
        wrong.write(f"TESTCASE {i+1}: {strp_A} != {strp_B} <= FAIL \n")
        print(f"   Wrong answer at testcase {i+1}")
outfile.close()
wrong.close()
