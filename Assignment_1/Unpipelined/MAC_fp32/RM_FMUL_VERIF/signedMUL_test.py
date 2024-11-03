def round_bfloat16(A):
    # input and output are str
    A += "0"
    adj_exp = 0
    round_bit = A[7]
    if(round_bit == "0"):
        return [A[:7],adj_exp]
    elif(round_bit == "1"):
        temp = A[8:]
        if(int(temp,2) == 0 and A[6] == "0"):
            return [A[:6]+"0",adj_exp]
        else:
            # print("here")
            # possibility of carry being generated is there
            carry_check = bin(int(A[:7],2)+1)[2:]
            if(len(carry_check) > 7):
                # print("here too")
                adj_exp = len(carry_check) - 7
                return [carry_check[1:8], adj_exp]
            else:
                return [bin(int(A[:7],2)+1)[2:].rjust(7,"0"), adj_exp]


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
    # print(AB_exp)

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
    # print(nob_A,nob_B)

    temp_AB = int(temp_A,2) * int(temp_B,2)
    nob_AB = len(bin(temp_AB)[2:])

    exp_adj = nob_AB - (nob_A + nob_B - 1) 
    # print(exp_adj)
    AB_exp = bin(int(AB_exp,2) + exp_adj)[2:]

    # print(f"before rounding {bin(A_frac * B_frac)[2:]}")
    round_ret = round_bfloat16(bin(A_frac * B_frac)[3:])
    if(round_ret[1] == 0):
        AB_frac = round_ret[0]
    else:
        # print("here 3")
        AB_exp = bin(int(AB_exp,2) + round_ret[1])[2:]
        AB_frac = round_ret[0]
    # AB_frac = bin(A_frac * B_frac)[3:]

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

# Multiply .......
LA = ["A_binary.txt","negA_binary.txt"]
LB = ["B_binary.txt","negB_binary.txt"]
count = 0
batch = ["PP","PN","NP","NN"]

for I in LA:
    for J in LB:
        print(f"Multiplying batch {batch[count]} ...")
        file_a = open(I,"r")
        file_b = open(J,"r")

        A_inps = file_a.readlines()
        B_inps = file_b.readlines()

        file_a.close()
        file_b.close()

        outfile = open(f"{batch[count]}_output.txt","w")
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


        # Checking computed results
        print("Checking results")
        if(count == 0 or count == 3):
            file_a = open("AB_output.txt","r")
        else:
            file_a = open("negAB_output.txt","r")
        file_b = open(f"{batch[count]}_output.txt","r")

        A_inps = file_a.readlines()
        B_inps = file_b.readlines()

        file_a.close()
        file_b.close()

        outfile = open(f"{batch[count]}_check_Results.txt","w")
        wrong = open(f"{batch[count]}_wrong_Results.txt","w")
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

        count += 1
