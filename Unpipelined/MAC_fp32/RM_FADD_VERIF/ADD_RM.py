           
def round_fp32(A):
    # input and output are str
    # print(A, len(A))
    A = A.ljust(25,"0") 
    adj_exp = 0
    round_bit = A[23]
    if(round_bit == "0"):
        return [A[:23],adj_exp]
    elif(round_bit == "1"):
        temp = A[24:]
        # print(temp)
        if(int(temp,2) == 0 and A[22] == "0"):
            return [A[:22]+"0",adj_exp]
        else:
            # possibility of carry being generated is there
            carry_check = bin(int(A[:23],2)+1)[2:]
            if(len(carry_check) > 23):
                # print("here too")
                adj_exp = len(carry_check) - 23
                return [carry_check[1:24], adj_exp]
            else:
                return [bin(int(A[:23],2)+1)[2:].rjust(23,"0"), adj_exp]

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

        round_ret = round_fp32(sum_val[1:])
        if(round_ret[1] == 0):
            rounded_sum = round_ret[0]
        else:
            # print("here 3")
            A_exp = bin(int(A_exp,2) + round_ret[1])[2:]
            rounded_sum = round_ret[0]


        return A_sign + bin(A_exp)[2:].rjust(8,"0") + rounded_sum
    else:
        # print("5")
        # subtraction ...
        # print("3")
        # addition ...
        A_frac = A_frac.ljust(Blen_bef_add,"0")
        if(exp_diff == 0):
            if(A_frac < B_frac):
                A_sign = B_sign
                A_frac, B_frac = B_frac, A_frac
        # print(Blen_bef_add)
        # print(A_frac)
        # print(B_frac)
        diff_val = bin(int(A_frac,2) - int(B_frac,2))[2:]
        # print(diff_val)
        # carry detection
        # print(A_exp)
        
        if(len(diff_val) < Blen_bef_add):
            # print("4")
            # Adjust exponent
            exp_sub_diff = len(diff_val) - Blen_bef_add
            # print(len(diff_val),Blen_bef_add)
            A_exp -= abs(exp_sub_diff)
            # print(A_exp)

        round_ret = round_fp32(diff_val[1:])
        if(round_ret[1] == 0):
            rounded_sum = round_ret[0]
        else:
            # print("here 3")
            # print(A_exp,round_ret[1])
            A_exp = A_exp + round_ret[1]
            rounded_sum = round_ret[0]


        return A_sign + bin(A_exp)[2:].rjust(8,"0") + rounded_sum

# A = "0101000111110010"
# B = "11010001001101000011100101011001"
# Add = fp32_add(A,B)
# print(Add)

# 01010001100101111110001101010100
# 01010001100101111110001101010100




print("Adding .....")
file_a = open("negAB_output.txt","r")
file_b = open("C_binary.txt","r")

A_inps = file_a.readlines()
B_inps = file_b.readlines()

file_a.close()
file_b.close()

outfile = open("NP_MAC_output.txt","w")
for i in range(len(A_inps)):
    strp_A = A_inps[i].strip("\n")
    strp_B = B_inps[i].strip("\n")
    MAC = fp32_add(strp_A,strp_B)    
    outfile.write(f"{MAC}\n")
    print(f"  Addition done for TESTCASE {i+1}")
outfile.close()

# Checking computed results
print("Checking results")
file_a = open("NP_MAC_output.txt","r")
file_b = open("NP_MAC_binary.txt","r")

A_inps = file_a.readlines()
B_inps = file_b.readlines()

file_a.close()
file_b.close()

outfile = open("NP_MAC_check_Results.txt","w")
wrong = open("NP_MAC_wrong_Results.txt","w")
fail = 0
for i in range(len(A_inps)):
    strp_A = A_inps[i].strip("\n")
    strp_B = B_inps[i].strip("\n")
    # if(strp_A[:-2] == strp_B[:-2]):
    if(strp_A == strp_B):
        outfile.write(f"TESTCASE {i+1}: {strp_A} == {strp_B} <= PASS \n")
    else:
        fail = 1
        outfile.write(f"TESTCASE {i+1}: {strp_A} != {strp_B} <= FAIL \n")
        wrong.write(f"TESTCASE {i+1}: {strp_A} != {strp_B} <= FAIL \n")
        print(f"   Wrong answer at testcase {i+1}")
outfile.close()
wrong.close()

if(fail == 0):
    print("ALL TESTCASES PASSED !!!")