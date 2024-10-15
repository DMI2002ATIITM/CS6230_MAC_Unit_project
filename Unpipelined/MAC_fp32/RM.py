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

    neg_bias = int("10000001",2)

    AB_sign = bin(A_sign ^ B_sign)[2:]
    AB_exp = bin(A_exp + B_exp + neg_bias)[2:][-8:]
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

A = "0100010110111100"
B = "0100100110011110"
C = "01001010011111011111001110110111"


ANS = bfloat16_mul(A,B)
print(decode_bfloat_16(A))
print(decode_bfloat_16(B))
print(decode_bfloat_16(ANS))