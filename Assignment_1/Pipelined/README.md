# MAC_pipelined

This folder contains the bsv design of pipelined MAC unit and its verification environment.

## Folder structure:

* The below diagram illustrates the folder structure in this folder.
* The boxes which are colored are the files/folders which are intended for submition.
* Blue boxes are folders and green boxes are files

![Pipelined_foldstruct drawio](https://github.com/user-attachments/assets/f75aa52a-f904-4526-88e4-e34a2c8c219f)

### Description of contents:
#### Folders:
1. Pipelined/--------------------> Contains all things related to pipelined MAC unit 
2. MAC_pipelined_verif/----------> Contains Reference models, Makefile and testbench
3. Python_scripts/-----------------> Contains the python codes written to help verification of pipelined MAC unit
4. Values/-------------------------> Contains the text files used in final verification
5. verilog/------------------------> Contains generated verilog files

#### Files:
Pipelined/:
1. MAC_pipelined.bsv-------------------> Contains the Top module which instantiates MAC_int32_pipelined and MAC_fp32_pipelined within it
2. MAC_int32_pipelined.bsv-------------> Contains pipelined Int MAC unit which has both 8 bit multiplier and 32 bit adder implemented as a single module 
3. MAC_fp32_pipelined.bsv--------------> Contains pipelined Float MAC unit which instantiates bf16_mul_pipelined and fp32_add_pipelined within it
4. bf16_mul_pipelined.bsv--------------> Contains pipelined code which can do bf16 multiplication
5. fp32_add_pipelined.bsv--------------> Contains pipelined code which can do fp32 addition
6. Makefile------------------------------> Makefile which is used to generate verilog codes from bsv codes
7. MAC_PIPELINED_TEST_RESULT-----> Log file which contains the simulation result of the final run
8. MAC_types.bsv----------------------> Contains all the struct definitions

MAC_pipelined_verif/:
1. FLOAT_RM.py---------------------> Contains reference model which does float MAC, contains relevant coverage bins
2. INT_RM.py-----------------------> Contains reference model which does int MAC, contains relevant coverage bins
3. Makefile.verif------------------> Makefile which is used to simulate
4. test_mkMAC_pipelined.py-------> Testbench which drives input to pipelined RTL and reference model, checks the pipelined RTL output with output of reference model, given testcases, expanded testcases and random testcases.

verilog/:
1. Contains generated verilog files

Values/:
1. Contains given testcases and expanded testcases (expanded by flipping sign bits)

Python_scripts/:
1. Webscraping_for_testcases_augumentation.py----> Contains python code which webscraps the online calculator: https://numeral-systems.com/ieee-754-add/ to extract expected answers for negative inputs. From this extracted testcases, understood the procedure to implement the reference model. From the understanding acquired by creating reference model, bsv code is written.
2. Gen_neg_C.py----------------------------------> Contains python code which reads a textfile, flips all sign bits and write to output textfile.(Same code is used to flip input A and input B)
3. decode_fp32.py--------------------------------> Contains python code which can convert a floating point number from its IEEE754 representation to decimal representation.
4. Gen_padded_AB.py------------------------------> Contains python code which reads a textfile, pad zeroes to the right and write to output textfile. This is used to pad the output of float multiplication to convert bfloat16 to fp32 datatype.


# STEPS TO RUN PIPELINED MAC

1. Navigate to Assignment_1/Pipelined/ directory
```
cd Assignment_1/Pipelined/
```
2. activate pyenv
```
pyenv activate py38
```
3. compile and generate verilog from bsv
```
make generate_verilog
```
4. To simulate using cocotb, for int testcases run the following command
```
make simulate PLUSARGS="+TEST_INT=1"
```

5. To simulate using cocotb, for float testcases run the following command
```
make simulate PLUSARGS="+TEST_FLOAT=1"
```
 
6. To simulate using cocotb, for random testcases run the following command
```
make simulate PLUSARGS="+TEST_RANDOM=1"
```
 
7.  To simulate using cocotb, for individual testcase run the following command
```
make simulate PLUSARGS="+TEST_INDIV=1"
```
 
8. To simulate all testcases, run the following command
```
make simulate PLUSARGS="+TEST_INT=1 +TEST_FLOAT=1 +TEST_RANDOM=1 +TEST_INDIV=1"
```
 
## To clean all the builds
```
make clean_build
```
