from FLOAT_RM import *
from INT_RM import *

def sysarray_rm(A,B,S):
    Output = []
    if(S == 0):
        for i in range(4):
            # Column 1 
            mac_1  = MAC_int32_RM(A[i][0],B[0][0],0)
            mac_2  = MAC_int32_RM(A[i][1],B[1][0],mac_1)
            mac_3  = MAC_int32_RM(A[i][2],B[2][0],mac_2)
            mac_4  = MAC_int32_RM(A[i][3],B[3][0],mac_3)
            
            # Column 2
            mac_5  = MAC_int32_RM(A[i][0],B[0][1],0)
            mac_6  = MAC_int32_RM(A[i][1],B[1][1],mac_5)
            mac_7  = MAC_int32_RM(A[i][2],B[2][1],mac_6)
            mac_8  = MAC_int32_RM(A[i][3],B[3][1],mac_7)
            
            # Column 3
            mac_9  = MAC_int32_RM(A[i][0],B[0][2],0)
            mac_10 = MAC_int32_RM(A[i][1],B[1][2],mac_9)
            mac_11 = MAC_int32_RM(A[i][2],B[2][2],mac_10)
            mac_12 = MAC_int32_RM(A[i][3],B[3][2],mac_11)
            
            # Column 4
            mac_13 = MAC_int32_RM(A[i][0],B[0][3],0)
            mac_14 = MAC_int32_RM(A[i][1],B[1][3],mac_13)
            mac_15 = MAC_int32_RM(A[i][2],B[2][3],mac_14)
            mac_16 = MAC_int32_RM(A[i][3],B[3][3],mac_15)
            
            Output.append([mac_4,mac_8,mac_12,mac_16])
        
    else:
        for i in range(4):
            # Column 1 
            mac_1  = MAC_fp32_RM(A[i][0],B[0][0],"0"*32)
            if (mac_1 == "EXCEPTION"):
                return "EXCEPTION"
            mac_2  = MAC_fp32_RM(A[i][1],B[1][0],mac_1)
            if (mac_2 == "EXCEPTION"):
                return "EXCEPTION"
            mac_3  = MAC_fp32_RM(A[i][2],B[2][0],mac_2)
            if (mac_3 == "EXCEPTION"):
                return "EXCEPTION"
            mac_4  = MAC_fp32_RM(A[i][3],B[3][0],mac_3)
            if (mac_4 == "EXCEPTION"):
                return "EXCEPTION"
            
            # Column 2
            mac_5  = MAC_fp32_RM(A[i][0],B[0][1],"0"*32)
            if (mac_5 == "EXCEPTION"):
                return "EXCEPTION"
            mac_6  = MAC_fp32_RM(A[i][1],B[1][1],mac_5)
            if (mac_6 == "EXCEPTION"):
                return "EXCEPTION"
            mac_7  = MAC_fp32_RM(A[i][2],B[2][1],mac_6)
            if (mac_7 == "EXCEPTION"):
                return "EXCEPTION"
            mac_8  = MAC_fp32_RM(A[i][3],B[3][1],mac_7)
            if (mac_8 == "EXCEPTION"):
                return "EXCEPTION"
            
            # Column 3
            mac_9  = MAC_fp32_RM(A[i][0],B[0][2],"0"*32)
            if (mac_9 == "EXCEPTION"):
                return "EXCEPTION"
            mac_10 = MAC_fp32_RM(A[i][1],B[1][2],mac_9)
            if (mac_10 == "EXCEPTION"):
                return "EXCEPTION"
            mac_11 = MAC_fp32_RM(A[i][2],B[2][2],mac_10)
            if (mac_11 == "EXCEPTION"):
                return "EXCEPTION"
            mac_12 = MAC_fp32_RM(A[i][3],B[3][2],mac_11)
            if (mac_12 == "EXCEPTION"):
                return "EXCEPTION"
            
            # Column 4
            mac_13 = MAC_fp32_RM(A[i][0],B[0][3],"0"*32)
            if (mac_13 == "EXCEPTION"):
                return "EXCEPTION"
            mac_14 = MAC_fp32_RM(A[i][1],B[1][3],mac_13)
            if (mac_14 == "EXCEPTION"):
                return "EXCEPTION"
            mac_15 = MAC_fp32_RM(A[i][2],B[2][3],mac_14)
            if (mac_15 == "EXCEPTION"):
                return "EXCEPTION"
            mac_16 = MAC_fp32_RM(A[i][3],B[3][3],mac_15)
            if (mac_16 == "EXCEPTION"):
                return "EXCEPTION"
            
            Output.append([mac_4,mac_8,mac_12,mac_16])
        
    return Output
    
    
    
