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
# RDY_get_C                      O     1 const
# RDY_get_S1_or_S2               O     1
# output_MAC                     O    16 reg
# RDY_output_MAC                 O     1 reg
# CLK                            I     1 clock
# RST_N                          I     1 reset
# get_A_a                        I    16 reg
# get_B_b                        I    16 reg
# get_C_c                        I    32 unused
# get_S1_or_S2_s1_or_s2          I     1 reg
# EN_get_A                       I     1
# EN_get_B                       I     1
# EN_get_C                       I     1 unused
# EN_get_S1_or_S2                I     1

async def reset(dut):
    dut.RST_N.value = 1
    await RisingEdge(dut.CLK)
    dut.RST_N.value = 0
    await RisingEdge(dut.CLK)
    dut.RST_N.value = 1
    await RisingEdge(dut.CLK)


async def give_input(dut,A,B,C):
    dut.get_A_a.value = A
    dut.get_B_b.value = B
    dut.get_C_c.value = C
    await RisingEdge(dut.CLK)
    dut.EN_get_A.value = 1
    dut.EN_get_B.value = 1
    dut.EN_get_C.value = 1
    await RisingEdge(dut.CLK)
    dut.EN_get_A.value = 0
    dut.EN_get_B.value = 0
    dut.EN_get_C.value = 0
    

async def get_output(dut):
    await RisingEdge(dut.RDY_output_MAC)
    return dut.output_MAC.value
	

@cocotb.test()
async def test_mul(dut):
    clock = Clock(dut.CLK, 10, units="us")  
    cocotb.start_soon(clock.start(start_high=False))
    await reset(dut)
    
#    await give_input(dut,int("0100000100101100",2),int("0101010011100101",2))
#    print(await get_output(dut))
#    await give_input(dut,int("0100111111010001",2),int("0101010010001001",2))
#    print(await get_output(dut))
    #print(await get_output(dut))
    #await give_input(dut,-1,50,-1,0)
    #print(await get_output(dut))
    
    LA = []
    LB = []
    LAB = []
    
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
    	await give_input(dut,int(LA[i],2),int(LB[i],2),int(LC[i],2))
    	rtl_output = await get_output(dut)
    	print(str(rtl_output),LAB[i].strip("\n"),f"TESTCASE {i+1}")
    	assert str(rtl_output) == LAB[i].strip("\n")
    	
    
    #for i in A:
    #    for j in B:
    #        await give_input(dut,i,j)
    #        await ClockCycles(dut.CLK, 10)
    #        rtl_result = await get_output(dut)
    #        await ClockCycles(dut.CLK, 1)
    #        print()
    #        print(str(i) + " " + str(j) + " " + str(i*j) + " == " +   str(rtl_result))
    #        assert i*j == rtl_result
    

