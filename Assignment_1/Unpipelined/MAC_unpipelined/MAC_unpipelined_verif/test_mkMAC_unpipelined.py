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
    
@cocotb.test()
async def test_MAC_unpipelined(dut):

    # Choose type of test
    test_float = 1
    test_int = 1
    test_random = 1
    test_indiv = 0

    clock = Clock(dut.CLK, 10, units="us")  
    cocotb.start_soon(clock.start(start_high=False))
    await reset(dut)
    
    if(test_indiv == 1):
        await give_input(dut,int("1110111011110010",2),int("0101000001111100",2),int("11111110011101010000111001110111",2),1)
        rtl_output = await get_output_float(dut)
        print("RTL:",str(rtl_output))
          
    LA = []
    LB = []
    LAB = []
    
    # Test float
    
    file_a = open("Values/combined_A_binary.txt","r")
    LA = file_a.readlines()
    file_a.close() 
    
    file_b = open("Values/combined_B_binary.txt","r")
    LB = file_b.readlines()
    file_b.close() 
    
    file_c = open("Values/combined_C_binary.txt","r")
    LC = file_c.readlines()
    file_c.close() 
    
    file_MAC = open("Values/combined_MAC_binary.txt","r")
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
    
    
    # Corner cases indentified while analysing coverage
    bfS = [0,1]*10
    bfE = [0,0b11111110,0x55,0xAA,0x1,0x2,0x4,0x8,0x10,0x20,0x40,0x80,0xFE,0xFD,0xFB,0xF7,0xEF,0xDF,0xBF,0x7F]
    bfM = [0,0b1111111,0x55,0x2A,0x1,0x2,0x4,0x8,0x10,0x20,0x40,0x7E,0x7D,0x7B,0x77,0x6F,0x5F,0x3F,0x4,0x7E]

    fpS = [0,1]*10
    fpE = [0,0b11111110,0x55,0xAA,0x1,0x2,0x4,0x8,0x10,0x20,0x40,0x80,0xFE,0xFD,0xFB,0xF7,0xEF,0xDF,0xBF,0x7F]
    fpM = [0,0x7FFFFF,0x555555,0x2AAAAA]*5


    Bin_A = []
    Bin_B = []
    Bin_C = []

    for i in range(20):
        temp_A = bfmk(bfS[i],bfE[i],bfM[i])
        temp_B = bfmk(bfS[i],bfE[i],bfM[i])
        temp_C = fpmk(fpS[i],fpE[i],fpM[i])
        RM_output = MAC_fp32_RM(temp_A,temp_B,temp_C)
        if(RM_output != "EXCEPTION"):
            Bin_A.append(temp_A)
            Bin_B.append(temp_B)
            Bin_C.append(temp_C) 
                  
    
    # The below commented lines will produce approx 66 lakhs testcases!
    #Perm_A = []
    #Perm_B = []
    #Perm_C = []
    #for i in Bin_A:
    #    for j in Bin_B:
    #        for k in Bin_C:
    #            Perm_A.append(i)
    #            Perm_B.append(j)
    #            Perm_C.append(k)
    
    testcase_counter = 0
    if(test_float == 1):
        print("TESTING FLOAT INPUTS")
        for i in range(len(LA)):
            testcase_counter += 1
            await give_input(dut,int(LA[i],2),int(LB[i],2),int(LC[i],2),1)
            rtl_output = await get_output_float(dut)
            assert str(rtl_output) == LAB[i].strip("\n") # assertion between RTL and expected value
            RM_output = MAC_fp32_RM(LA[i].strip("\n"),LB[i].strip("\n"),LC[i].strip("\n"))
            print("RTL:",str(rtl_output),"EXPECTED:",LAB[i].strip("\n"),"RM:",RM_output,f"TESTCASE {testcase_counter}")
            assert str(rtl_output) == RM_output # assertion between RTL and reference model value
            
        for i in range(len(Bin_A)):
            testcase_counter += 1
            await give_input(dut,int(Bin_A[i],2),int(Bin_B[i],2),int(Bin_C[i],2),1)
            rtl_output = await get_output_float(dut)
            RM_output = MAC_fp32_RM(Bin_A[i],Bin_B[i],Bin_C[i])
            print("RTL:",str(rtl_output),"RM:",RM_output,f"TESTCASE {testcase_counter}")
            assert str(rtl_output) == RM_output # assertion between RTL and reference model value
    
    # Int MAC test	
    
    LA = []
    LB = []
    LC = []
    LO = []
    
    A_File = open("Values/A_decimal.txt","r")
    A_List = A_File.readlines()
    A_File.close()
    
    B_File = open("Values/B_decimal.txt","r")
    B_List = B_File.readlines()
    B_File.close()
    
    C_File = open("Values/C_decimal.txt","r")
    C_List = C_File.readlines()
    C_File.close()
    
    O_File = open("Values/MAC_decimal.txt","r")
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
    
    CA = list(range(-128,128))
    CB = list(range(-128,128))
    CC = [0,1,-1,0xFFFFFFFF,0x7FFFFFFF,0xAAAAAAAA,0x55555555,4294967294, 4294967293, 4294967291, 4294967287, 4294967279, 4294967263, 4294967231, 4294967167, 4294967039, 4294966783, 4294966271, 4294965247, 4294963199, 4294959103, 4294950911, 4294934527, 4294901759, 4294836223, 4294705151, 4294443007, 4293918719, 4292870143, 4290772991, 4286578687, 4278190079, 4261412863, 4227858431, 4160749567, 4026531839, 3758096383, 3221225471, 2147483647, 1, 2, 4, 8, 16, 32, 64, 128, 256, 512, 1024, 2048, 4096, 8192, 16384, 32768, 65536, 131072, 262144, 524288, 1048576, 2097152, 4194304, 8388608, 16777216, 33554432, 67108864, 134217728, 268435456, 536870912, 1073741824, 2147483648]*3
    
    l = len(CC)
    for i in range(len(CA)-l):
        CC.append(CC[random.randint(0,l-1)])
    
    count_1 = 0
    if(test_int == 1):
        print("TESTING INTEGER INPUTS")
        for i in range(len(LA)):
            testcase_counter += 1
            await give_input(dut,LA[i],LB[i],LC[i],0)
            rtl_output = await get_output_int(dut)
            RM_int = MAC_int32_RM(LA[i],LB[i],LC[i])
            print(f"Inp A: {LA[i]} Inp B: {LB[i]} Inp C: {LC[i]} EXPECTED: {LO[i]} RTL: {rtl_output} RM: {RM_int} TESTCASE {testcase_counter}")
            assert rtl_output == LO[i]   # assertion between RTL and expected value
            assert rtl_output == RM_int  # assertion between RTL and reference model value
        
        
        for i in range(len(CA)):
            testcase_counter += 1
            await give_input(dut,CA[i],CB[i],CC[i],0)
            rtl_output = await get_output_int(dut)
            RM_int = MAC_int32_RM(CA[i],CB[i],CC[i])
            print(f"Inp A: {CA[i]} Inp B: {CB[i]} Inp C: {CC[i]} RTL: {rtl_output} RM: {RM_int} TESTCASE {testcase_counter}")
            assert rtl_output == RM_int  # assertion between RTL and reference model value
        
    # Random inputs testing	
    
    filerand = open("Values/random.txt","w")
    S = [random.randint(0,1) for _ in range(15000)]
    retry = 1
    #S = [0]*5000
    
    if(test_random == 1):
        print("TESTING RANDOM INPUTS")
        for i in range(len(S)):
            testcase_counter += 1
            if(S[i] == 1):
                while(retry == 1):
                    A = create_random_float16()
                    B = create_random_float16()
                    C = create_random_float32()
                    RM_output = MAC_fp32_RM(A,B,C)
                    if(RM_output != "EXCEPTION"):
                        break
                
                await give_input(dut,int(A,2),int(B,2),int(C,2),1)
                rtl_output = await get_output_float(dut)
                print("RTL:",str(rtl_output),"RM:",RM_output,f"TESTCASE {testcase_counter}")
                filerand.write("A: "+A+" B: "+B+" C: "+C+" RTL: "+str(rtl_output)+" RM: "+RM_output+"\n")
                assert str(rtl_output) == RM_output # assertion between RTL and reference model value
            
        
            elif(S[i] == 0):
                A = random.randint(-128,127)
                B = random.randint(-128,127)
                C = random.randint(-2147483648,2147483647)
                await give_input(dut,A,B,C,0)
                rtl_output = await get_output_int(dut)
                RM_int = MAC_int32_RM(A,B,C)
                print(f"Inp A: {A} Inp B: {B} Inp C: {C} RTL: {rtl_output} RM: {RM_int} TESTCASE {testcase_counter}")
                filerand.write("A: "+str(A)+" B: "+str(B)+" C: "+str(C)+" RTL: "+str(rtl_output)+" RM: "+str(RM_int)+"\n")
                assert rtl_output == RM_int # assertion between RTL and reference model value
    
    coverage_db.export_to_yaml(filename="coverage_MAC_unpipelined.yml")
    
    
    

