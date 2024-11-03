import os
import random
from pathlib import Path

import cocotb
from cocotb.clock import Clock
from cocotb.triggers import RisingEdge, ClockCycles
import logging as _log


# Ports:
# Name                         I/O  size props
# RDY_get_A                      O     1 const
# RDY_get_B                      O     1 const
# output_Add                     O     5
# RDY_output_Add                 O     1 const
# CLK                            I     1 clock
# RST_N                          I     1 reset
# get_A_a                        I     4 reg
# get_B_b                        I     4 reg
# EN_get_A                       I     1
# EN_get_B                       I     1
# EN_output_Add                  I     1 unused

def take_care_of_sign(num):
    num_str = bin(num)[2:][-16:].rjust(16,"0")
    
    if(num < 0):
        if(num_str[0] == "1"):
            rtl_answer = int(bin((int(num_str,2) ^ 0xFFFF) + 1)[2:],2) * -1
            return rtl_answer
        return num
    
    if(num_str[0] == "1"):
       # rtl_answer = int(str_ans,2) ^ 0xFFFF) + 1) * -1
        rtl_answer = int(bin((int(num_str,2) ^ 0xFFFF) + 1)[2:],2) * -1
    else:
        rtl_answer = int(num_str,2)
    return rtl_answer
    
   

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
    await RisingEdge(dut.CLK)
    rtl_answer = dut.output_Add.value
    await RisingEdge(dut.CLK)
    str_ans = str(rtl_answer)
    if(str_ans[0] == "1"):
       # rtl_answer = int(str_ans,2) ^ 0xFFFF) + 1) * -1
        rtl_answer = int(bin((int(str_ans,2) ^ 0xFFFF) + 1)[2:],2) * -1
    else:
        rtl_answer = int(str(rtl_answer),2)
    return rtl_answer
	

@cocotb.test()
async def test_add(dut):
    clock = Clock(dut.CLK, 10, units="us")  
    cocotb.start_soon(clock.start(start_high=False))
    await reset(dut)
    
    # Disable dump file while simulating the below inputs
    #A = [0xFFFF] + list(range(-128,128)) + [0x7FFF]
    #B = [0xFFFF] + list(range(-128,128)) + [0x7FFF]
    
    
    A = list(range(-128,128))
    B = list(range(-128,128))
    
    for i in A:
        for j in B:
            inp_a = take_care_of_sign(i)
            inp_b = take_care_of_sign(j)
            await give_input(dut,i,j)
            await ClockCycles(dut.CLK, 5)
            rtl_result = await get_output(dut)
    #        await ClockCycles(dut.CLK, 1)
            print(str(i) , str(j))
            print(str(inp_a) + " " + str(inp_b) + " " + str(inp_a+inp_b) + " == " +   str(rtl_result))
            assert take_care_of_sign(inp_a+inp_b) == rtl_result
    

