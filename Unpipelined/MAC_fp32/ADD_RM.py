           
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
        print("1")

        A_sign, B_sign = B_sign, A_sign
        A_exp, B_exp = B_exp, A_exp
        A_frac, B_frac = B_frac, A_frac


    for i in range(abs(exp_diff)):
        # print("2")
        B_frac = "0" + B_frac

    Blen_bef_add = len(B_frac)
    C_exp = A_exp

    print(A_sign,B_sign)
    if(A_sign == B_sign):
        print("3")
        # addition ...
        A_frac = A_frac.ljust(Blen_bef_add,"0")
        # print(Blen_bef_add)
        print(A_frac)
        # print(B_frac)
        sum_val = bin(int(A_frac,2) + int(B_frac,2))[2:]
        print(sum_val)
        # carry detection
        if(len(sum_val) > Blen_bef_add):
            print("4")
            # Adjust exponent
            exp_add_diff = len(sum_val) - Blen_bef_add
            A_exp += exp_add_diff
        rounded_sum = round_fp32(sum_val[1:])
        return A_sign + bin(A_exp)[2:].rjust(8,"0") + rounded_sum
    else:
        print("5")
        # subtraction ...
        return None
A = "0100010010110111"
B = "01000111011111011111001110110111"
Add = fp32_add(A,B)
print(Add)

# 0 10001111 00000011101010111011100
# 0 10001111 00000011101010111011100
