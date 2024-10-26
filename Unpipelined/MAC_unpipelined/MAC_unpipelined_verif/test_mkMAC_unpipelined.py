import os
import random
from pathlib import Path

import cocotb
from cocotb.clock import Clock
from cocotb.triggers import RisingEdge, ClockCycles
import logging as _log

# Ports:
# Name                         I/O  size props
# RDY_get_A                      O     1
# RDY_get_B                      O     1
# RDY_get_C                      O     1
# RDY_get_S1_or_S2               O     1
# output_MAC                     O    32 reg
# RDY_output_MAC                 O     1 reg
# CLK                            I     1 clock
# RST_N                          I     1 reset
# get_A_a                        I    16 reg
# get_B_b                        I    16 reg
# get_C_c                        I    32 reg
# get_S1_or_S2_s1_or_s2          I     1 reg
# EN_get_A                       I     1
# EN_get_B                       I     1
# EN_get_C                       I     1
# EN_get_S1_or_S2                I     1

async def reset(dut):
    dut.RST_N.value = 1
    await RisingEdge(dut.CLK)
    dut.RST_N.value = 0
    await RisingEdge(dut.CLK)
    dut.RST_N.value = 1
    await RisingEdge(dut.CLK)


async def give_input(dut,A,B,C,S):
    dut.get_A_a.value = A
    dut.get_B_b.value = B
    dut.get_C_c.value = C
    dut.get_S1_or_S2_s1_or_s2.value = S
    await RisingEdge(dut.CLK)
    dut.EN_get_A.value = 1
    dut.EN_get_B.value = 1
    dut.EN_get_C.value = 1
    dut.EN_get_S1_or_S2.value = 1
    await RisingEdge(dut.CLK)
    dut.EN_get_A.value = 0
    dut.EN_get_B.value = 0
    dut.EN_get_C.value = 0
    dut.EN_get_S1_or_S2.value = 0
    

async def get_output_float(dut):
    await RisingEdge(dut.RDY_output_MAC)
    return dut.output_MAC.value
    
async def get_output_int(dut):
    await RisingEdge(dut.RDY_output_MAC)
    rtl_answer =  dut.output_MAC.value
    str_ans = str(rtl_answer)
    if(str_ans[0] == "1"):
        rtl_answer = ((int(str_ans,2) ^ 0xFFFFFFFF) + 1) * -1
    else:
        rtl_answer = int(str(rtl_answer),2)
    return rtl_answer

	

@cocotb.test()
async def test_mul(dut):
    clock = Clock(dut.CLK, 10, units="us")  
    cocotb.start_soon(clock.start(start_high=False))
    await reset(dut)
        
    LA = []
    LB = []
    LAB = []
    
    # Test float
    
    file_a = open("combined_A_binary.txt","r")
    LA = file_a.readlines()
    file_a.close() 
    
    file_b = open("combined_B_binary.txt","r")
    LB = file_b.readlines()
    file_b.close() 
    
    file_c = open("combined_C_binary.txt","r")
    LC = file_c.readlines()
    file_c.close() 
    
    file_MAC = open("combined_MAC_binary.txt","r")
    LAB = file_MAC.readlines()
    file_MAC.close() 
    
    
    for i in range(len(LA)):
    	await give_input(dut,int(LA[i],2),int(LB[i],2),int(LC[i],2),1)
    	rtl_output = await get_output_float(dut)
    	print(str(rtl_output),LAB[i].strip("\n"),f"TESTCASE {i+1}")
    	assert str(rtl_output) == LAB[i].strip("\n")
    	
    # Int MAC test	
    LA = []
    LB = []
    LC = []
    LO = []
    
    A_File = open("A_decimal.txt","r")
    A_List = A_File.readlines()
    A_File.close()
    
    B_File = open("B_decimal.txt","r")
    B_List = B_File.readlines()
    B_File.close()
    
    C_File = open("C_decimal.txt","r")
    C_List = C_File.readlines()
    C_File.close()
    
    O_File = open("MAC_decimal.txt","r")
    O_List = O_File.readlines()
    O_File.close()
    
    for i in range(len(A_List)-1):
         LA.append(eval(A_List[i].strip().strip('\n')))
         
    for i in range(len(B_List)-1):
         LB.append(eval(B_List[i].strip().strip('\n')))
         
    for i in range(len(C_List)-1):
         LC.append(eval(C_List[i].strip().strip('\n')))
         
    for i in range(len(O_List)-1):
         LO.append(eval(O_List[i].strip().strip('\n')))    
    
    for i in range(len(LA)):
        await give_input(dut,LA[i],LB[i],LC[i],0)
        rtl_output = await get_output_int(dut)
        print(f"{LA[i]} {LB[i]} {LC[i]} {LO[i]} == {rtl_output}")
        assert rtl_output == LO[i]
    	
    

