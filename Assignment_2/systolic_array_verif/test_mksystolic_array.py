import os
import random
from pathlib import Path

import cocotb
from cocotb.clock import Clock
from cocotb.triggers import RisingEdge, ClockCycles
import logging as _log

from FLOAT_RM import *
from INT_RM import *

class finish_test:
    def __init__(self):
        self.out1 = []
        self.out2 = []
        self.out3 = []
        self.out4 = []

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
    
async def give_inputB1(dut,B):
    dut.get_B1_b.value = B
    await RisingEdge(dut.CLK)
    dut.EN_get_B1.value = 1
    await RisingEdge(dut.CLK)
    dut.EN_get_B1.value = 0
    
async def give_inputB2(dut,B):
    dut.get_B2_b.value = B
    await RisingEdge(dut.CLK)
    dut.EN_get_B2.value = 1
    await RisingEdge(dut.CLK)
    dut.EN_get_B2.value = 0
    
async def give_inputB3(dut,B):
    dut.get_B3_b.value = B
    await RisingEdge(dut.CLK)
    dut.EN_get_B3.value = 1
    await RisingEdge(dut.CLK)
    dut.EN_get_B3.value = 0  
    
async def give_inputB4(dut,B):
    dut.get_B4_b.value = B
    await RisingEdge(dut.CLK)
    dut.EN_get_B4.value = 1
    await RisingEdge(dut.CLK)
    dut.EN_get_B4.value = 0          

async def give_inputAs_Cz_S(dut,A1,A2,A3,A4,S):
    while True:
    	if(dut.RDY_get_A1.value == 1 and dut.RDY_get_A2.value == 1 and dut.RDY_get_A3.value == 1 and dut.RDY_get_A4.value == 1 and dut.RDY_get_C1.value == 1 and dut.RDY_get_C2.value == 1 and dut.RDY_get_C3.value == 1 and dut.RDY_get_C4.value == 1 and dut.RDY_get_S1.value == 1 and dut.RDY_get_S2.value == 1 and dut.RDY_get_S3.value == 1 and dut.RDY_get_S4.value == 1):
    	    #dut._log.info("CHECK")
    	    #await RisingEdge(dut.CLK)
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

async def get_output1_float(dut,test):
    while True:
        await RisingEdge(dut.RDY_output1_MAC)
        dut.EN_output1_MAC.value = 1
        await RisingEdge(dut.CLK)
        output = dut.output1_MAC.value
        dut.EN_output1_MAC.value = 0
        test.out1.append(handle_int(output))
        #return output
    
async def get_output2_float(dut,test):
    while True:
        await RisingEdge(dut.RDY_output2_MAC)
        dut.EN_output2_MAC.value = 1
        await RisingEdge(dut.CLK)
        output = dut.output2_MAC.value
        dut.EN_output2_MAC.value = 0
        test.out2.append(handle_int(output))
        #return output    

async def get_output3_float(dut,test):
    while True:
        await RisingEdge(dut.RDY_output3_MAC)
        dut.EN_output3_MAC.value = 1
        await RisingEdge(dut.CLK)
        output = dut.output3_MAC.value
        dut.EN_output3_MAC.value = 0
        test.out3.append(handle_int(output))
        #return output    
        
async def get_output4_float(dut,test):
    while True:
        await RisingEdge(dut.RDY_output4_MAC)
        dut.EN_output4_MAC.value = 1
        await RisingEdge(dut.CLK)
        output = dut.output4_MAC.value
        dut.EN_output4_MAC.value = 0
        test.out4.append(handle_int(output))
        #return output            

    
async def get_output_int(dut):
    await RisingEdge(dut.RDY_output_MAC)
    dut.EN_output_MAC.value = 1
    await RisingEdge(dut.CLK)
    rtl_answer =  dut.output_MAC.value
    dut.EN_output_MAC.value = 0
    str_ans = str(rtl_answer)
    if(str_ans[0] == "1"):
        rtl_answer = ((int(str_ans,2) ^ 0xFFFFFFFF) + 1) * -1
    else:
        rtl_answer = int(str(rtl_answer),2)
    return rtl_answer
    
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
    
async def get_output_matrix(dut,test):
    while True:
        if(len(test.out1) == 4 and len(test.out2) == 4 and len(test.out3) == 4 and len(test.out4) == 4):
            print()
            print("OUTPUT MATRIX: ")
            printm(transpose(test.out1,test.out2,test.out3,test.out4))
            print()
            test.out1 = []
            test.out2 = []
            test.out3 = []
            test.out4 = []
            break
        await RisingEdge(dut.CLK)

    
@cocotb.test()
async def test_systolic_array(dut):

    test = finish_test()

    # Choose type of test
    test_float = 0
    test_int = 0
    test_random = 0
    test_indiv = 1

    clock = Clock(dut.CLK, 10, units="us")  
    cocotb.start_soon(clock.start(start_high=False))
    await reset(dut)
    
    cocotb.start_soon(get_output1_float(dut,test))
    cocotb.start_soon(get_output2_float(dut,test))
    cocotb.start_soon(get_output3_float(dut,test))
    cocotb.start_soon(get_output4_float(dut,test))
    
    
    await give_inputB1(dut,4)
    await give_inputB1(dut,3)
    await give_inputB1(dut,2)
    await give_inputB1(dut,1)
    
    await give_inputB2(dut,8)
    await give_inputB2(dut,7)
    await give_inputB2(dut,6)
    await give_inputB2(dut,5)
    
    await give_inputB3(dut,12)
    await give_inputB3(dut,11)
    await give_inputB3(dut,10)
    await give_inputB3(dut,9)
    
    await give_inputB4(dut,16)
    await give_inputB4(dut,15)
    await give_inputB4(dut,14)
    await give_inputB4(dut,13)
    
    #await give_inputAs_Cz_S(dut,2,0,0,0,0)    
    #await give_inputAs_Cz_S(dut,0,7,0,0,0)
    #await give_inputAs_Cz_S(dut,-16,4,-9,0,0)
    #await give_inputAs_Cz_S(dut,0,7,13,0,0)
    #await give_inputAs_Cz_S(dut,0,0,8,0,0)
    #await give_inputAs_Cz_S(dut,0,0,0,0,0)
    
    # Given example
    await give_inputAs_Cz_S(dut,2,7,-9,0,0)    
    await give_inputAs_Cz_S(dut,0,4,13,0,0)
    await give_inputAs_Cz_S(dut,-16,7,8,0,0)
    await give_inputAs_Cz_S(dut,0,0,0,0,0)
    await give_inputAs_Cz_S(dut,0,0,0,0,0)
    
    # Identity matrix
    await give_inputAs_Cz_S(dut,1,0,0,0,0)    
    await give_inputAs_Cz_S(dut,0,1,0,0,0)
    await give_inputAs_Cz_S(dut,0,0,1,0,0)
    await give_inputAs_Cz_S(dut,0,0,0,1,0)
    await give_inputAs_Cz_S(dut,0,0,0,0,0)

    await get_output_matrix(dut,test)

    #print()
    #print(test.out1)
    #print(test.out2)
    #print(test.out3)
    #print(test.out4)
    
    #print()
    #printm(transpose(test.out1,test.out2,test.out3,test.out4))
    
    #print()
    
    if(test_indiv == 0):
        #await give_input(dut,int("1110111011110010",2),int("0101000001111100",2),int("11111110011101010000111001110111",2),1)
        #await give_input(dut,1,2,3,0)
        await give_inputsansB(dut,2,5,0)
        rtl_output = await get_output_float(dut)
        print("RTL:",str(rtl_output))

    await RisingEdge(dut.CLK)
    await RisingEdge(dut.CLK)
    await RisingEdge(dut.CLK)
    await RisingEdge(dut.CLK)
    await RisingEdge(dut.CLK)   
    
    if(test_indiv == 0):
        #await give_input(dut,int("1110111011110010",2),int("0101000001111100",2),int("11111110011101010000111001110111",2),1)
        #await give_input(dut,3,1,3,0)
        await give_inputsansB(dut,3,3,0)
        rtl_output = await get_output_float(dut)
        print("RTL:",str(rtl_output))
        
        
    await RisingEdge(dut.CLK)
    await RisingEdge(dut.CLK)
    await RisingEdge(dut.CLK)
    await RisingEdge(dut.CLK)
    await RisingEdge(dut.CLK)   
    
    if(test_indiv == 0):
        #await give_input(dut,int("1110111011110010",2),int("0101000001111100",2),int("11111110011101010000111001110111",2),1)
        #await give_input(dut,3,4,3,0)
        await give_inputsansB(dut,3,7,0)
        rtl_output = await get_output_float(dut)
        print("RTL:",str(rtl_output))
    
    #if(test_indiv == 1):
        #await give_input(dut,int("1110111011110010",2),int("0101000001111100",2),int("11111110011101010000111001110111",2),1)
        
    #    await give_inputsansB(dut,3,7,0)
    #    rtl_output = await get_output_float(dut)
    #    print("RTL:",str(rtl_output))

    #await RisingEdge(dut.CLK)
    #await RisingEdge(dut.CLK)
    #await RisingEdge(dut.CLK)
    #await RisingEdge(dut.CLK)
    #await RisingEdge(dut.CLK)    
    
          
#coverage_db.export_to_yaml(filename="coverage_MAC_pipelined.yml")
    
    
    

