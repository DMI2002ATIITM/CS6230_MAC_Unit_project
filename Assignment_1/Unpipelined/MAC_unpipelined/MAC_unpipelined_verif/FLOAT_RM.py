import cocotb
from cocotb_coverage.coverage import *



def bfmk(S,E,M):
    return bin(S)[2:].ljust(1,"0")+bin(E)[2:].ljust(8,"0")+bin(M)[2:].ljust(7,"0")
    
def fpmk(S,E,M):
    return bin(S)[2:].ljust(1,"0")+bin(E)[2:].ljust(8,"0")+bin(M)[2:].ljust(23,"0")
        
        

bfS = [0,1]*10
bfE = [0,0b11111110,0x55,0xAA,0x1,0x2,0x4,0x8,0x10,0x20,0x40,0x80,0xFE,0xFD,0xFB,0xF7,0xEF,0xDF,0xBF,0x7F]
bfM = [0,0b1111111,0x55,0x2A,0x1,0x2,0x4,0x8,0x10,0x20,0x40,0x7E,0x7D,0x7B,0x77,0x6F,0x5F,0x3F,0x4,0x7E]

fpS = [0,1]*10
fpE = [0,0b11111110,0x55,0xAA,0x1,0x2,0x4,0x8,0x10,0x20,0x40,0x80,0xFE,0xFD,0xFB,0xF7,0xEF,0xDF,0xBF,0x7F]
fpM = [0,0x7FFFFF,0x555555,0x2AAAAA]*5


Bin_A = []
Bin_B = []
Bin_C = []

for i in range(20):
    Bin_A.append(bfmk(bfS[i],bfE[i],bfM[i]))
    Bin_B.append(bfmk(bfS[i],bfE[i],bfM[i]))
    Bin_C.append(fpmk(fpS[i],fpE[i],fpM[i])) 
                             

MAC_FLOAT_coverage = coverage_section(
    CoverPoint('top.FLOAT.A', vname='A', bins = Bin_A),
    CoverPoint('top.FLOAT.B', vname='B', bins = Bin_B),
    CoverPoint('top.FLOAT.C', vname='C', bins = Bin_C)
)


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
            # possibility of carry being generated is there
            carry_check = bin(int(A[:7],2)+1)[2:]
            if(len(carry_check) > 7):
                adj_exp = len(carry_check) - 7
                return [carry_check[1:8], adj_exp]
            else:
                return [bin(int(A[:7],2)+1)[2:].rjust(7,"0"), adj_exp]


def round_fp32(A):
    # input and output are str
    A = A.ljust(25,"0") 
    adj_exp = 0
    round_bit = A[23]
    if(round_bit == "0"):
        return [A[:23],adj_exp]
    elif(round_bit == "1"):
        temp = A[24:]
        if(int(temp,2) == 0 and A[22] == "0"):
            return [A[:22]+"0",adj_exp]
        else:
            # possibility of carry being generated is there
            carry_check = bin(int(A[:23],2)+1)[2:]
            if(len(carry_check) > 23):
                adj_exp = len(carry_check) - 23
                return [carry_check[1:24], adj_exp]
            else:
                return [bin(int(A[:23],2)+1)[2:].rjust(23,"0"), adj_exp]

def bfloat16_mul(A,B):
    A_sign = int(A[0],2)
    A_exp =  int(A[1:9],2)
    A_frac =  int("1"+A[9:],2)

    B_sign = int(B[0],2)
    B_exp =  int(B[1:9],2)
    B_frac =  int("1"+B[9:],2)

    bias = int("10000001",2)
    
    AB_sign = bin(A_sign ^ B_sign)[2:]
    AB_exp = bin((A_exp + B_exp + bias) & 0xFF)[2:][-8:]
    
    if(int(AB_exp,2) > int("11111111",2)):
        return "EXCEPTION" 

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

    if(int(AB_exp,2) > int("11111111",2)):
        return "EXCEPTION" 
    
    
    round_ret = round_bfloat16(bin(A_frac * B_frac)[3:])
    if(round_ret[1] == 0):
        AB_frac = round_ret[0]
    else:
        AB_exp = bin(int(AB_exp,2) + round_ret[1])[2:]
        AB_frac = round_ret[0]
        if(int(AB_exp,2) > int("11111111",2)):
            return "EXCEPTION" 

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
        A_sign, B_sign = B_sign, A_sign
        A_exp, B_exp = B_exp, A_exp
        A_frac, B_frac = B_frac, A_frac

    for i in range(abs(exp_diff)):
        B_frac = "0" + B_frac
	
    Blen_bef_add = len(B_frac)
    C_exp = A_exp

    if(A_sign == B_sign):
        # addition ...
        A_frac = A_frac.ljust(Blen_bef_add,"0")
        sum_val = bin(int(A_frac,2) + int(B_frac,2))[2:]
        # carry detection
        if(len(sum_val) > Blen_bef_add):
            # Adjust exponent
            exp_add_diff = len(sum_val) - Blen_bef_add
            A_exp += exp_add_diff
            if(A_exp > int("11111111",2)):
                return "EXCEPTION" 
            
    	

        round_ret = round_fp32(sum_val[1:])
        if(round_ret[1] == 0):
            rounded_sum = round_ret[0]
        else:
            A_exp = bin(int(A_exp,2) + round_ret[1])[2:]
            rounded_sum = round_ret[0]
            if(A_exp > int("11111111",2)):
                return "EXCEPTION" 
            
            
        return A_sign + bin(A_exp)[2:].rjust(8,"0") + rounded_sum
    else:
        A_frac = A_frac.ljust(Blen_bef_add,"0")
        if(exp_diff == 0):
            if(A_frac < B_frac):
                A_sign = B_sign
                A_frac, B_frac = B_frac, A_frac
        diff_val = bin(int(A_frac,2) - int(B_frac,2))[2:]
        
        if(len(diff_val) < Blen_bef_add):
            # Adjust exponent
            exp_sub_diff = len(diff_val) - Blen_bef_add
            A_exp -= abs(exp_sub_diff)

        round_ret = round_fp32(diff_val[1:])
        if(round_ret[1] == 0):
            rounded_sum = round_ret[0]
        else:
            A_exp = A_exp + round_ret[1]
            rounded_sum = round_ret[0]
            if(A_exp > int("11111111",2)):
                return "EXCEPTION" 

        return A_sign + bin(A_exp)[2:].rjust(8,"0") + rounded_sum
        
@MAC_FLOAT_coverage
def MAC_fp32_RM(A,B,C):
# Float multiplication
        if(A[1:] == "0"*15 or B[1:] == "0"*15):
                AB = "0"*16
        else:
                AB = bfloat16_mul(A,B)   
                if(AB == "EXCEPTION"):
                    return "EXCEPTION" 
        
# Float addition                
        if(C[1:] == "0"*31):
                C = "0"*32 
        if(AB[1:].ljust(31,"0") == C[1:] and AB[0] != C[0]):
                return "0"*32                    
        if(AB == "0"*16):
                return C
        elif(C == "0"*32):
                return AB.ljust(32,"0")
        else:
                return fp32_add(AB,C)
                
#print(MAC_fp32_RM("0100000100101100","0101010011100101","01000001110010101100001010010000"))
	 

