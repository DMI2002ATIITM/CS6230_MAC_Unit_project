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
# output_Mul                     O    16 reg
# RDY_output_Mul                 O     1 const
# CLK                            I     1 clock
# RST_N                          I     1 reset
# get_A_a                        I     8
# get_B_b                        I     8
# EN_get_A                       I     1
# EN_get_B                       I     1
# EN_output_Mul                  I     1

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
    await RisingEdge(dut.completed)
    dut.EN_output_Mul.value = 1
    await RisingEdge(dut.CLK)
    await RisingEdge(dut.CLK)
    rtl_answer =  dut.output_Mul.value
    dut.EN_output_Mul.value = 0
    #print(bin(int(str(rtl_answer),2)^ 0xFFFF + 1))
    #print(int(str(rtl_answer),2) ^ 0xFFFF + 1)
    str_ans = str(rtl_answer)
    if(str_ans[0] == "1"):
       # rtl_answer = int(str_ans,2) ^ 0xFFFF) + 1) * -1
        rtl_answer = int(bin((int(str_ans,2) ^ 0xFFFF) + 1)[2:],2) * -1
    else:
        rtl_answer = int(str(rtl_answer),2)
    return rtl_answer

	

@cocotb.test()
async def test_mul(dut):
    clock = Clock(dut.CLK, 10, units="us")  
    cocotb.start_soon(clock.start(start_high=False))
    await reset(dut)
    
    # Disable dump.vcd when verifying all combinations from -128 to 127
    A = list(range(0,128))
    B = list(range(0,128))
    
    for i in A:
        for j in B:
            await give_input(dut,i,j)
            await ClockCycles(dut.CLK, 10)
            rtl_result = await get_output(dut)
            await ClockCycles(dut.CLK, 1)
            print()
            print(str(i) + " " + str(j) + " " + str(i*j) + " == " +   str(rtl_result))
            assert i*j == rtl_result
    

