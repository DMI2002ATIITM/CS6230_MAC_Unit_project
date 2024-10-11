# This file is public domain, it can be freely copied without restrictions.
# SPDX-License-Identifier: CC0-1.0

import os
import random
from pathlib import Path

import cocotb
from cocotb.clock import Clock
from cocotb.triggers import RisingEdge
#from model_counter import *

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

@cocotb.test()
async def test_counter(dut):
    """Test to check counter"""
#
#    dut.EN_increment.value = 0
#    dut.EN_decrement.value = 0
#
    clock = Clock(dut.CLK, 10, units="us")  # Create a 10us period clock on port clk
    # Start the clock. Start it low to avoid issues on the first RisingEdge
    cocotb.start_soon(clock.start(start_high=False))
    dut.RST_N.value = 0
    await RisingEdge(dut.CLK)
    dut.RST_N.value = 1
    await RisingEdge(dut.CLK)
    dut.get_A_a.value = -2
    dut.get_B_b.value = 5
    await RisingEdge(dut.CLK)
    await RisingEdge(dut.CLK)
    dut.EN_get_A.value = 1
    dut.EN_get_B.value = 1
    await RisingEdge(dut.CLK)
    dut.EN_get_A.value = 0
    dut.EN_get_B.value = 0
    await RisingEdge(dut.CLK)
    await RisingEdge(dut.CLK)
    await RisingEdge(dut.CLK)
    await RisingEdge(dut.CLK)
    await RisingEdge(dut.CLK)
    await RisingEdge(dut.CLK)
    await RisingEdge(dut.CLK)
    await RisingEdge(dut.CLK)
    await RisingEdge(dut.CLK)
    dut.EN_output_Mul.value = 1
    await RisingEdge(dut.CLK)
    await RisingEdge(dut.CLK)
    await RisingEdge(dut.CLK)
    await RisingEdge(dut.CLK)
    await RisingEdge(dut.CLK)
    

