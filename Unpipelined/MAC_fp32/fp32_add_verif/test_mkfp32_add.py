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
# out_AaddB                      O    32 reg
# RDY_out_AaddB                  O     1 reg
# CLK                            I     1 clock
# RST_N                          I     1 reset
# get_A_a                        I    16
# get_B_b                        I    32
# EN_get_A                       I     1
# EN_get_B                       I     1

async def reset(dut):
    dut.RST_N.value = 1
    await RisingEdge(dut.CLK)
    dut.RST_N.value = 0
    await RisingEdge(dut.CLK)
    dut.RST_N.value = 1
    await RisingEdge(dut.CLK)


async def give_input(dut,A,B):
    dut.get_A_a.value = A
    dut.get_B_b.value = B
    await RisingEdge(dut.CLK)
    dut.EN_get_A.value = 1
    dut.EN_get_B.value = 1
    await RisingEdge(dut.CLK)
    dut.EN_get_A.value = 0
    dut.EN_get_B.value = 0
    

async def get_output(dut):
    await RisingEdge(dut.RDY_out_AaddB)
    return dut.out_AaddB.value
	

@cocotb.test()
async def test_add(dut):
    clock = Clock(dut.CLK, 10, units="us")  
    cocotb.start_soon(clock.start(start_high=False))
    await reset(dut)
    
#    await give_input(dut,int("0100111111101000",2),int("01001010011111011111001110110111",2))
#    print(await get_output(dut))
#    await give_input(dut,int("0100111111010001",2),int("0101010010001001",2))
#    print(await get_output(dut))
    #print(await get_output(dut))
    #await give_input(dut,-1,50,-1,0)
    #print(await get_output(dut))
    
    LAB = []
    LC = []
    LABC = []
    
    file_ab = open("negAB_output.txt","r")
    LAB = file_ab.readlines()
    file_ab.close() 
    
    file_c = open("negC_binary.txt","r")
    LC = file_c.readlines()
    file_c.close() 
    
    file_abc = open("NN_MAC_binary.txt","r")
    LABC = file_abc.readlines()
    file_abc.close() 
    
    
    for i in range(len(LAB)):
    	await give_input(dut,int(LAB[i],2),int(LC[i],2))
    	rtl_output = await get_output(dut)
    	print(str(rtl_output),LABC[i].strip("\n"),f"TESTCASE {i+1}")
    	assert str(rtl_output) == LABC[i].strip("\n")
    	
    
    #for i in A:
    #    for j in B:
    #        await give_input(dut,i,j)
    #        await ClockCycles(dut.CLK, 10)
    #        rtl_result = await get_output(dut)
    #        await ClockCycles(dut.CLK, 1)
    #        print()
    #        print(str(i) + " " + str(j) + " " + str(i*j) + " == " +   str(rtl_result))
    #        assert i*j == rtl_result
    

