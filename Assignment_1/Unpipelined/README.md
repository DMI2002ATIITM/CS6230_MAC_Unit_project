# MAC_unpipelined

This folder contains the bsv design of unpipelined MAC unit and its verification environment.


## Folder structure:

* The below diagram illustrates the folder structure in this folder.
* The boxes which are colored are the files/folders which are intended for submition.
* Blue boxes are folders and green boxes are files
* The black(colorless) boxes are the folders which contains the files created when this project was in developement(Not indented for submition/obselete). [MAC_fp32/ and MAC_int32/ are not intended for submition]

![NEWFOLDERSTRUCTURE drawio](https://github.com/user-attachments/assets/972b6ad6-2f9f-4d1f-aed2-8e4fde61c16d)


### Description of contents:
#### Folders:
1. Unpipelined/--------------------> Contains all things related to unpipelined MAC unit 
2. MAC_unpipelined/----------------> Contains all things which are intended for submition
3. MAC_unpipelined_verif/----------> Contains Reference models, Makefile and testbench
4. verilog/------------------------> Contains generated verilog files
5. Values/-------------------------> Contains the text files used in final verification
6. Python_scripts/-----------------> Contains the python codes written to help verification of MAC unit

#### Files:
MAC_unpipelined/:
1. MAC_unpipelined.bsv-------------> Contains the Top module which instantiates MAC_int32 and MAC_fp32 within it
2. MAC_int32.bsv-------------------> Contains Int MAC unit which has both 8 bit multiplier and 32 bit adder implemented as a single module 
3. MAC_fp32.bsv--------------------> Contains Float MAC unit which instantiates bf16_mul and fp32_add within it
4. bf16_mul.bsv--------------------> Contains code which can do bf16 multiplication
5. fp32_add.bsv--------------------> Contains code which can do fp32 addition
6. Makefile------------------------> Makefile which is used to generate verilog codes from bsv codes
7. MAC_UNPIPELINED_TEST_RESULT-----> Log file which contains the simulation result of the final run
8. coverage_MAC_unpipelined.yml----> Contains coverage reports
9. Manual_float_add_workout.txt----> Contains the rough work done manually in order to understand floating point operations and rounding

MAC_unpipelined_verif/:
1. FLOAT_RM.py---------------------> Contains reference model which does float MAC, contains relevant coverage bins
2. INT_RM.py-----------------------> Contains reference model which does int MAC, contains relevant coverage bins
3. Makefile.verif------------------> Makefile which is used to simulate
4. test_mkMAC_unpipelined.py-------> Testbench which drives input to RTL and reference model, checks the RTL output with output of  reference model, given testcases, expanded testcases and random testcases.

verilog/:
1. Contains generated verilog files

Values/:
1. Contains given testcases and expanded testcases (expanded by flipping sign bits)

Python_scripts/:
1. Webscraping_for_testcases_augumentation.py----> Contains python code which webscraps the online calculator: https://numeral-systems.com/ieee-754-add/ to extract expected answers for negative inputs. From this extracted testcases, understood the procedure to implement the reference model. From the understanding acquired by creating reference model, bsv code is written.
2. Gen_neg_C.py----------------------------------> Contains python code which reads a textfile, flips all sign bits and write to output textfile.(Same code is used to flip input A and input B)
3. decode_fp32.py--------------------------------> Contains python code which can convert a floating point number from its IEEE754 representation to decimal representation.
4. Gen_padded_AB.py------------------------------> Contains python code which reads a textfile, pad zeroes to the right and write to output textfile. This is used to pad the output of float multiplication to convert bfloat16 to fp32 datatype.



