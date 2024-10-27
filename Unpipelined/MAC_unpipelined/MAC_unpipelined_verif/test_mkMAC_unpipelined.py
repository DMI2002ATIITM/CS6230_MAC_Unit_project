import os
import random
from pathlib import Path

import cocotb
from cocotb.clock import Clock
from cocotb.triggers import RisingEdge, ClockCycles
import logging as _log

from FLOAT_RM import *
from INT_RM import *

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
async def test_MAC_unpipelined(dut):
    clock = Clock(dut.CLK, 10, units="us")  
    cocotb.start_soon(clock.start(start_high=False))
    await reset(dut)
        
    LA = []
    LB = []
    LAB = []
    
    # Test float
    print("TESTING FLOAT INPUTS")
    
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
    
    # Inserting special cases
    
    # Float addition results in zero
    LA = LA[:49] + ["0011111110000000"] + LA[49:]
    LB = LB[:49] + ["0100000100101100"] + LB[49:]
    LC = LC[:49] + ["11000001001011000000000000000000"] + LC[49:]
    LAB = LAB[:49] + ["0"*32] + LAB[49:]
    
    # Input A is zero
    LA = LA[:100] + ["0"*16] + LA[100:]
    LB = LB[:100] + ["0100000100101100"] + LB[100:]
    LC = LC[:100] + ["10"*16] + LC[100:]
    LAB = LAB[:100] + ["10"*16] + LAB[100:]
    
    # Input B is zero
    LA = LA[:1000] + ["0100000100101100"] + LA[1000:]
    LB = LB[:1000] + ["0"*16] + LB[1000:]
    LC = LC[:1000] + ["10"*16] + LC[1000:]
    LAB = LAB[:1000] + ["10"*16] + LAB[1000:]
    
    # Input C is zero
    LA = LA[:1200] + ["0100000100101100"] + LA[1200:]
    LB = LB[:1200] + ["0011111110000000"] + LB[1200:]
    LC = LC[:1200] + ["0"*32] + LC[1200:]
    LAB = LAB[:1200] + ["01000001001011000000000000000000"] + LAB[1200:]
    
    # Input A is -ve zero
    LA = LA[:2000] + ["1"+"0"*15] + LA[2000:]
    LB = LB[:2000] + ["0100000100101100"] + LB[2000:]
    LC = LC[:2000] + ["10"*16] + LC[2000:]
    LAB = LAB[:2000] + ["10"*16] + LAB[2000:]
    
    # Input B is -ve zero
    LA = LA[:3000] + ["0100000100101100"] + LA[3000:]
    LB = LB[:3000] + ["1"+"0"*15] + LB[3000:]
    LC = LC[:3000] + ["10"*16] + LC[3000:]
    LAB = LAB[:3000] + ["10"*16] + LAB[3000:]
    
    # Input C is -ve zero
    LA = LA[:5200] + ["0100000100101100"] + LA[5200:]
    LB = LB[:5200] + ["0011111110000000"] + LB[5200:]
    LC = LC[:5200] + ["1"+"0"*31] + LC[5200:]
    LAB = LAB[:5200] + ["01000001001011000000000000000000"] + LAB[5200:]
    
    # All inputs are zero
    LA = LA[:7200] + ["0"*16] + LA[7200:]
    LB = LB[:7200] + ["0"*16] + LB[7200:]
    LC = LC[:7200] + ["0"*32] + LC[7200:]
    LAB = LAB[:7200] + ["0"*32] + LAB[7200:]
    
    count = 0
    for i in range(len(LA)):
    	await give_input(dut,int(LA[i],2),int(LB[i],2),int(LC[i],2),1)
    	rtl_output = await get_output_float(dut)
    	assert str(rtl_output) == LAB[i].strip("\n") # assertion between RTL and expected value
    	RM_output = MAC_fp32_RM(LA[i].strip("\n"),LB[i].strip("\n"),LC[i].strip("\n"))
    	print("RTL:",str(rtl_output),"EXPECTED:",LAB[i].strip("\n"),"RM:",RM_output,f"TESTCASE {i+1}")
    	assert str(rtl_output) == RM_output # assertion between RTL and reference model value
    	count += 1
    	
    # Int MAC test	
    print("TESTING INTEGER INPUTS")
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
         
    # Inserting special cases
    
    # Int addition results in zero
    LA = LA[:49] + [25] + LA[49:]
    LB = LB[:49] + [1] + LB[49:]
    LC = LC[:49] + [-25] + LC[49:]
    LO = LO[:49] + [0] + LO[49:]
    
    # Input A is zero
    LA = LA[:100] + [0] + LA[100:]
    LB = LB[:100] + [7] + LB[100:]
    LC = LC[:100] + [555] + LC[100:]
    LO = LO[:100] + [555] + LO[100:]
    
    # Input B is zero
    LA = LA[:500] + [15] + LA[500:]
    LB = LB[:500] + [0] + LB[500:]
    LC = LC[:500] + [100] + LC[500:]
    LO = LO[:500] + [100] + LO[500:]
    
    # Input C is zero
    LA = LA[:700] + [100] + LA[700:]
    LB = LB[:700] + [-2] + LB[700:]
    LC = LC[:700] + [0] + LC[700:]
    LO = LO[:700] + [-200] + LO[700:]
    
    # All inputs are zero
    LA = LA[:900] + [0] + LA[900:]
    LB = LB[:900] + [0] + LB[900:]
    LC = LC[:900] + [0] + LC[900:]
    LO = LO[:900] + [0] + LO[900:]
    
        
    for i in range(len(LA)):
        await give_input(dut,LA[i],LB[i],LC[i],0)
        rtl_output = await get_output_int(dut)
        RM_int = MAC_int32_RM(LA[i],LB[i],LC[i])
        print(f"Inp A: {LA[i]} Inp B: {LB[i]} Inp C: {LC[i]} EXPECTED: {LO[i]} RTL: {rtl_output} RM: {RM_int} TESTCASE {i+1+count}")
        assert rtl_output == LO[i]   # assertion between RTL and expected value
        assert rtl_output == RM_int  # assertion between RTL and reference model value

