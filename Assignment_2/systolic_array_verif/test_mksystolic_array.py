import os
import random
from pathlib import Path

import cocotb
from cocotb.clock import Clock
from cocotb.triggers import RisingEdge, ClockCycles
import logging as _log

from FLOAT_RM import *
from INT_RM import *
from SYSARRAY_RM import *

class finish_test:
    def __init__(self):
        self.out1 = []
        self.out2 = []
        self.out3 = []
        self.out4 = []
        self.rtl_output = []
        self.all_verified = 0

# Ports:
# Name                         I/O  size props
# RDY_get_A1                     O     1
# RDY_get_A2                     O     1
# RDY_get_A3                     O     1
# RDY_get_A4                     O     1
# RDY_get_B1                     O     1
# RDY_get_B2                     O     1
# RDY_get_B3                     O     1
# RDY_get_B4                     O     1
# RDY_get_C1                     O     1
# RDY_get_C2                     O     1
# RDY_get_C3                     O     1
# RDY_get_C4                     O     1
# RDY_get_S1                     O     1
# RDY_get_S2                     O     1
# RDY_get_S3                     O     1
# RDY_get_S4                     O     1
# output1_MAC                    O    32
# RDY_output1_MAC                O     1
# output2_MAC                    O    32
# RDY_output2_MAC                O     1
# output3_MAC                    O    32
# RDY_output3_MAC                O     1
# output4_MAC                    O    32
# RDY_output4_MAC                O     1
# CLK                            I     1 clock
# RST_N                          I     1 reset
# get_A1_a                       I    16
# get_A2_a                       I    16
# get_A3_a                       I    16
# get_A4_a                       I    16
# get_B1_b                       I    16
# get_B2_b                       I    16
# get_B3_b                       I    16
# get_B4_b                       I    16
# get_C1_c                       I    32
# get_C2_c                       I    32
# get_C3_c                       I    32
# get_C4_c                       I    32
# get_S1_s                       I     1
# get_S2_s                       I     1
# get_S3_s                       I     1
# get_S4_s                       I     1
# EN_get_A1                      I     1
# EN_get_A2                      I     1
# EN_get_A3                      I     1
# EN_get_A4                      I     1
# EN_get_B1                      I     1
# EN_get_B2                      I     1
# EN_get_B3                      I     1
# EN_get_B4                      I     1
# EN_get_C1                      I     1
# EN_get_C2                      I     1
# EN_get_C3                      I     1
# EN_get_C4                      I     1
# EN_get_S1                      I     1
# EN_get_S2                      I     1
# EN_get_S3                      I     1
# EN_get_S4                      I     1
# EN_output1_MAC                 I     1
# EN_output2_MAC                 I     1
# EN_output3_MAC                 I     1
# EN_output4_MAC                 I     1

async def reset(dut):
    dut.RST_N.value = 1
    await RisingEdge(dut.CLK)
    dut.RST_N.value = 0
    await RisingEdge(dut.CLK)
    dut.RST_N.value = 1
    await RisingEdge(dut.CLK)

async def give_input(dut,A,B,C,S):
    dut.get_A1_a.value = A
    dut.get_B1_b.value = B
    dut.get_C1_c.value = C
    dut.get_S1_s.value = S
    await RisingEdge(dut.CLK)
    dut.EN_get_A1.value = 1
    dut.EN_get_B1.value = 1
    dut.EN_get_C1.value = 1
    dut.EN_get_S1.value = 1
    await RisingEdge(dut.CLK)
    dut.EN_get_A1.value = 0
    dut.EN_get_B1.value = 0
    dut.EN_get_C1.value = 0
    dut.EN_get_S1.value = 0    
    
async def give_inputsansB(dut,A,C,S):
    dut.get_A1_a.value = A
    #dut.get_B1_b.value = B
    dut.get_C1_c.value = C
    dut.get_S1_s.value = S
    await RisingEdge(dut.CLK)
    dut.EN_get_A1.value = 1
    #dut.EN_get_B1.value = 1
    dut.EN_get_C1.value = 1
    dut.EN_get_S1.value = 1
    await RisingEdge(dut.CLK)
    dut.EN_get_A1.value = 0
    #dut.EN_get_B1.value = 0
    dut.EN_get_C1.value = 0
    dut.EN_get_S1.value = 0   
    
async def get_output1(dut,test,S):
    while True:
        await RisingEdge(dut.RDY_output1_MAC)
        dut.EN_output1_MAC.value = 1
        await RisingEdge(dut.CLK)
        output = dut.output1_MAC.value
        dut.EN_output1_MAC.value = 0
        if(S == 0):
            test.out1.append(handle_int(output))
        else:
            test.out1.append(str(output))
    
async def get_output2(dut,test,S):
    while True:
        await RisingEdge(dut.RDY_output2_MAC)
        dut.EN_output2_MAC.value = 1
        await RisingEdge(dut.CLK)
        output = dut.output2_MAC.value
        dut.EN_output2_MAC.value = 0
        if(S == 0):
            test.out2.append(handle_int(output))
        else:
            test.out2.append(str(output))

async def get_output3(dut,test,S):
    while True:
        await RisingEdge(dut.RDY_output3_MAC)
        dut.EN_output3_MAC.value = 1
        await RisingEdge(dut.CLK)
        output = dut.output3_MAC.value
        dut.EN_output3_MAC.value = 0
        if(S == 0):
            test.out3.append(handle_int(output))
        else:
            test.out3.append(str(output))
        
async def get_output4(dut,test,S):
    while True:
        await RisingEdge(dut.RDY_output4_MAC)
        dut.EN_output4_MAC.value = 1
        await RisingEdge(dut.CLK)
        output = dut.output4_MAC.value
        dut.EN_output4_MAC.value = 0
        if(S == 0):
            test.out4.append(handle_int(output))
        else:
            test.out4.append(str(output))           
    
def handle_int(rtl_answer):
    str_ans = str(rtl_answer)
    if(str_ans[0] == "1"):
        rtl_answer = ((int(str_ans,2) ^ 0xFFFFFFFF) + 1) * -1
    else:
        rtl_answer = int(str(rtl_answer),2)
    return rtl_answer    
    
def transpose(A,B,C,D):
    temp = [A,B,C,D]
    Out = [[0,0,0,0],[0,0,0,0],[0,0,0,0],[0,0,0,0]]
    for i in range(len(temp)):
        for j in range(len(temp[0])):
            Out[i][j] = temp [j][i]
    
    return Out
    
def printm(A):
    for i in A:
        print(str(i[0]).rjust(8),str(i[1]).rjust(8),str(i[2]).rjust(8),str(i[3]).rjust(8))    
    
def create_random_float16():
    S,E = random.randint(0,1),random.randint(0,0xFF)
    if(E == 0xFF):
        M = 0
    else:
        M = random.randint(0,0x7F)
    return bfmk(S,E,M)

def create_random_float32():
    S,E = random.randint(0,1),random.randint(0,0xFF)
    if(E == 0xFF):
        M = 0
    else:
        M = random.randint(0,0x7FFFFF)
    return fpmk(S,E,M)
        
async def input_MATB(dut,B):    
    await give_inputB(dut,B[3][0],B[3][1],B[3][2],B[3][3])
    await give_inputB(dut,B[2][0],B[2][1],B[2][2],B[2][3])
    await give_inputB(dut,B[1][0],B[1][1],B[1][2],B[1][3])
    await give_inputB(dut,B[0][0],B[0][1],B[0][2],B[0][3])
    
async def give_inputB(dut,B1,B2,B3,B4):
    if(type(B1) == str):
        B1 = int(B1,2)
    if(type(B2) == str):
        B2 = int(B2,2)
    if(type(B3) == str):
        B3 = int(B3,2)
    if(type(B4) == str):
        B4 = int(B4,2)        
    dut.get_B1_b.value, dut.get_B2_b.value, dut.get_B3_b.value, dut.get_B4_b.value = B1, B2, B3, B4
    await RisingEdge(dut.CLK)
    dut.EN_get_B1.value, dut.EN_get_B2.value, dut.EN_get_B3.value, dut.EN_get_B4.value = 1, 1, 1, 1
    await RisingEdge(dut.CLK)
    dut.EN_get_B1.value, dut.EN_get_B2.value, dut.EN_get_B3.value, dut.EN_get_B4.value = 0, 0, 0, 0
    
async def input_MATA_S(dut,A,S):    
    await give_inputAs_Cz_S(dut,A[0][0],A[0][1],A[0][2],A[0][3],S)    
    await give_inputAs_Cz_S(dut,A[1][0],A[1][1],A[1][2],A[1][3],S)
    await give_inputAs_Cz_S(dut,A[2][0],A[2][1],A[2][2],A[2][3],S)
    await give_inputAs_Cz_S(dut,A[3][0],A[3][1],A[3][2],A[3][3],S)
    
async def give_inputAs_Cz_S(dut,A1,A2,A3,A4,S):
    if(type(A1) == str):
        A1 = int(A1,2)
    if(type(A2) == str):
        A2 = int(A2,2)
    if(type(A3) == str):
        A3 = int(A3,2)
    if(type(A4) == str):
        A4 = int(A4,2)  
    while True:
    	if(dut.RDY_get_A1.value == 1 and dut.RDY_get_A2.value == 1 and dut.RDY_get_A3.value == 1 and dut.RDY_get_A4.value == 1 and dut.RDY_get_C1.value == 1 and dut.RDY_get_C2.value == 1 and dut.RDY_get_C3.value == 1 and dut.RDY_get_C4.value == 1 and dut.RDY_get_S1.value == 1 and dut.RDY_get_S2.value == 1 and dut.RDY_get_S3.value == 1 and dut.RDY_get_S4.value == 1):
    	    break
    	await RisingEdge(dut.CLK)
    dut.get_A1_a.value = A1
    dut.get_A2_a.value = A2
    dut.get_A3_a.value = A3
    dut.get_A4_a.value = A4
    dut.get_C1_c.value = 0
    dut.get_C2_c.value = 0
    dut.get_C3_c.value = 0
    dut.get_C4_c.value = 0
    dut.get_S1_s.value = S
    dut.get_S2_s.value = S
    dut.get_S3_s.value = S
    dut.get_S4_s.value = S
    await RisingEdge(dut.CLK)
    dut.EN_get_A1.value = 1
    dut.EN_get_A2.value = 1
    dut.EN_get_A3.value = 1
    dut.EN_get_A4.value = 1
    dut.EN_get_C1.value = 1
    dut.EN_get_C2.value = 1
    dut.EN_get_C3.value = 1
    dut.EN_get_C4.value = 1
    dut.EN_get_S1.value = 1
    dut.EN_get_S2.value = 1
    dut.EN_get_S3.value = 1
    dut.EN_get_S4.value = 1
    await RisingEdge(dut.CLK)
    dut.EN_get_A1.value = 0
    dut.EN_get_A2.value = 0
    dut.EN_get_A3.value = 0
    dut.EN_get_A4.value = 0
    dut.EN_get_C1.value = 0
    dut.EN_get_C2.value = 0
    dut.EN_get_C3.value = 0
    dut.EN_get_C4.value = 0
    dut.EN_get_S1.value = 0
    dut.EN_get_S2.value = 0
    dut.EN_get_S3.value = 0
    dut.EN_get_S4.value = 0
    await RisingEdge(dut.CLK)
    await RisingEdge(dut.CLK)

async def dynamic_assertion(dut,tot_testcases,test):
    checked = 0
    while True:
        file_AB = open("Mat_AB.txt","r")
        file_exp = open("Mat_exp.txt","r")
        L1 = file_AB.readlines() 
        L2 = file_exp.readlines()
        file_AB.close()
        file_exp.close()
        
        #print(len(L1),len(L2) )
        if((len(L1) == (checked + 1)) and (len(L2) == (checked + 1))):
            assert L1[checked] == L2[checked], f"Testcase {checked} failed"
            checked += 1
        await RisingEdge(dut.CLK)
        
        if(checked == tot_testcases):
            test.all_verified = 1
            break

async def get_output_matrix(dut,test,file_AB):
    testcase_odd = True
    while True:
        
        if(len(test.out1) == 4 and len(test.out2) == 4 and len(test.out3) == 4 and len(test.out4) == 4):
            if(testcase_odd):
                #print()
                #print("OUTPUT MATRIX: ")
                #printm(transpose(test.out1,test.out2,test.out3,test.out4))
                #print()
                temp = transpose(test.out1,test.out2,test.out3,test.out4)
                test.rtl_output.append(temp)
                file_AB = open("Mat_AB.txt","a+")
                file_AB.write(str(temp)+"\n")
                file_AB.close()
            test.out1 = []
            test.out2 = []
            test.out3 = []
            test.out4 = []
            testcase_odd = not testcase_odd
        await RisingEdge(dut.CLK)
             
@cocotb.test()
async def test_systolic_array(dut):

    test = finish_test()
    
    file_A = open("Mat_A.txt","w")
    file_B = open("Mat_B.txt","w")
    file_AB = open("Mat_AB.txt","w")
    file_exp = open("Mat_exp.txt","w")
    file_debug = open("MAT_debug.txt","w")
    
    file_A.close()
    file_B.close()
    file_AB.close()
    file_exp.close()
    file_debug.close()

    file_A = open("Mat_A.txt","a+")
    file_B = open("Mat_B.txt","a+")
    file_AB = open("Mat_AB.txt","a+")
    

    clock = Clock(dut.CLK, 10, units="us")  
    cocotb.start_soon(clock.start(start_high=False))
    await reset(dut)
    
    if(cocotb.plusargs["TEST_TYPE"] not in ["TEST_RANDOM_INT","TEST_RANDOM_FLOAT"]):
        error = 1
        print()
        print("***********************************************************************************************")
        print("ERROR: Invalid test type given")
        print("The valid test types are:")
        print("                         * TEST_RANDOM_INT") 
        print("                         * TEST_RANDOM_FLOAT") 
        print("***********************************************************************************************")
        print()
        assert error == 0, "Invalid arguments given, check for syntax, spelling given in arguments"
    
    if(cocotb.plusargs["TEST_TYPE"] == "TEST_RANDOM_INT"):
        S = 0
    if(cocotb.plusargs["TEST_TYPE"] == "TEST_RANDOM_FLOAT"):
        S = 1
    
    tot_testcases = int(cocotb.plusargs["TESTCASES"])
       
    cocotb.start_soon(get_output1(dut,test,S))
    cocotb.start_soon(get_output2(dut,test,S))
    cocotb.start_soon(get_output3(dut,test,S))
    cocotb.start_soon(get_output4(dut,test,S))
    cocotb.start_soon(get_output_matrix(dut,test,file_AB))
    cocotb.start_soon(dynamic_assertion(dut,tot_testcases,test))
    
    A = []
    B = [] 
    P = [[0,0,0,0],[0,0,0,0],[0,0,0,0],[0,0,0,0]]
    rm_output = []
    
    
    
    
    
    if(cocotb.plusargs["TEST_TYPE"] == "TEST_RANDOM_INT"):	
        for i in range(tot_testcases):
            for j in range(4):
                A.append([random.randint(-128,127),random.randint(-128,127),random.randint(-128,127),random.randint(-128,127)])
                B.append([random.randint(-128,127),random.randint(-128,127),random.randint(-128,127),random.randint(-128,127)])
            
            await input_MATB(dut,B)
            await input_MATA_S(dut,A,0)
            file_A.write(str(A)+"\n")
            file_B.write(str(B)+"\n")
            temp_int = sysarray_rm(A,B,0)
            file_exp = open("Mat_exp.txt","a+")
            file_exp.write(str(temp_int)+"\n")
            file_exp.close()
            rm_output.append(temp_int)
            if(i != (tot_testcases-1)):
                await input_MATA_S(dut,P,0)
            else:   
                await give_inputAs_Cz_S(dut,0,0,0,0,0) 
                
            print("                                         TESTCASE:",i+1)
            
            A = []
            B = []
        
        while True:
            await RisingEdge(dut.CLK)
            if(test.all_verified == 1):
                break

        #print(rm_output)
        #print(test.rtl_output)

        file_A.close()
        file_B.close()
        file_AB.close()
        file_exp.close()
        assert rm_output == test.rtl_output, "Test failed"

    if(cocotb.plusargs["TEST_TYPE"] == "TEST_RANDOM_FLOAT"):	
        
        for i in range(tot_testcases):
            while True:
                for j in range(4):
                    A.append([create_random_float16(),create_random_float16(),create_random_float16(),create_random_float16()])
                    B.append([create_random_float16(),create_random_float16(),create_random_float16(),create_random_float16()])
                
                RM_output = sysarray_rm(A,B,1)
                #print(RM_output)
                if(RM_output != "EXCEPTION"):
                    break
                A = []
                B = []
            
        
            await input_MATB(dut,B)
            await input_MATA_S(dut,A,1)
            
            file_A.write(str(A)+"\n")
            file_B.write(str(B)+"\n")
            temp_float = sysarray_rm(A,B,1)
            file_exp = open("Mat_exp.txt","a+")
            file_exp.write(str(temp_float)+"\n")
            file_exp.close()
            rm_output.append(temp_float)
            if(i != (tot_testcases-1)):
                await input_MATA_S(dut,P,1)
            else:   
                await give_inputAs_Cz_S(dut,0,0,0,0,1) 
    
            print("                                         TESTCASE:",i+1)
            
            A = []
            B = []
            

        while True:
            await RisingEdge(dut.CLK)
            if(len(test.rtl_output) == tot_testcases):
                break

        #print(rm_output)
        #print(test.rtl_output)
        
        file_A.close()
        file_B.close()
        file_AB.close()
        file_exp.close()

        assert rm_output == test.rtl_output, "Test failed"

    
    
    

