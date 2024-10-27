# CS6230_MAC_Unit_project

## Folder structure:

![File_structure_MAC_project drawio (1)](https://github.com/user-attachments/assets/6b3b41e6-083e-4bc2-9945-8aeac27e878a)



* The above diagram illustrates the folder structure in this repository.
* The boxes which are colored are the files/folders which are intended for submition.
* Blue boxes are folders and green boxes are files

### Description of contents:
#### Folders:
1. Unpipelined/-------------> Contains all things related to unpipelined MAC unit 
2. MAC_unpipelined/---------> Contains all things which are intended for submition
3. MAC_unpipelined_verif/---> Contains Reference models, Makefile and testbench
4. verilog/-----------------> Contains generated verilog files
5. Values/------------------> Contains the text files used in final verification
6. Python_scripts/----------> Contains the python codes written to help verification of MAC unit

#### Files:
BSV files:
1. MAC_unpipelined.bsv------> Contains the Top module which instantiates MAC_int32 and MAC_fp32 within it
2. MAC_int32.bsv------------> Contains Int MAC unit which has both 8 bit multiplier and 32 bit adder implemented as a single module 
3. MAC_fp32.bsv-------------> Contains Float MAC unit which instantiates bf16_mul and fp32_add within it
4. bf16_mul.bsv-------------> Contains code which can do bf16 multiplication
5. fp32_add.bsv-------------> Contains code which can do fp32 addition


