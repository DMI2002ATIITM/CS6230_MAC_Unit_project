import cocotb
from cocotb_coverage.coverage import *

MAC_INT_coverage = coverage_section(
    CoverPoint('top.A', vname='A', bins = list(range(-128,128))),
    CoverPoint('top.B', vname='B', bins = list(range(-128,128))),
    CoverPoint('top.C', vname='C', bins = [0,1,-1,0xFFFFFFFF,0x7FFFFFFFF,0xAAAAAAAA,0x55555555]),
    CoverCross('top.cross_cover', items = ['top.A', 'top.B', 'top.C'])
)

@MAC_INT_coverage
def MAC_int32_RM(A,B,C):
	return A*B+C
