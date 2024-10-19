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
    print(AB_exp)

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
    print(nob_A,nob_B)

    temp_AB = int(temp_A,2) * int(temp_B,2)
    nob_AB = len(bin(temp_AB)[2:])

    exp_adj = nob_AB - (nob_A + nob_B - 1) 
    print(exp_adj)
    AB_exp = bin(int(AB_exp,2) + exp_adj)[2:]

    print(f"before rounding {bin(A_frac * B_frac)[2:]}")
    AB_frac = round_bfloat16(bin(A_frac * B_frac)[3:])
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

A = "0011111110011100"
B = "0100010010010110"
AB = bfloat16_mul(A,B)
print(AB)


# Test 1
# 0 10101101 0011001|1|10111           <- manual calculation
# 0 10101101 0011010           <- manual calculation (rounded)
# 0 10101101 00110100000000000000000 <- Website result
# 0 10101101 0011010            <- RM output


# Test 30
# 0 01111111 1001100   <- RM output
# 0 01111111 100101111  <- manual calculation
# 0 01111111 10010111111111111111111 <- website result


# Test 79
# 0 10001001 0110111 <- RM output
# 0 10001001 0110111 0000000000100000 <- Website result


