import cocotb
from cocotb_coverage.coverage import *

MAC_INT_coverage = coverage_section(
    CoverPoint('top.A', vname='A', bins = list(range(-128,128))),
    CoverPoint('top.B', vname='B', bins = list(range(-128,128))),
    CoverPoint('top.C', vname='C', bins = [0,1,-1,0xFFFFFFFF,0x7FFFFFFFF,0xAAAAAAAA,0x55555555,4294967294, 4294967293, 4294967291, 4294967287, 4294967279, 4294967263, 4294967231, 4294967167, 4294967039, 4294966783, 4294966271, 4294965247, 4294963199, 4294959103, 4294950911, 4294934527, 4294901759, 4294836223, 4294705151, 4294443007, 4293918719, 4292870143, 4290772991, 4286578687, 4278190079, 4261412863, 4227858431, 4160749567, 4026531839, 3758096383, 3221225471, 2147483647, 1, 2, 4, 8, 16, 32, 64, 128, 256, 512, 1024, 2048, 4096, 8192, 16384, 32768, 65536, 131072, 262144, 524288, 1048576, 2097152, 4194304, 8388608, 16777216, 33554432, 67108864, 134217728, 268435456, 536870912, 1073741824, 2147483648])
)

@MAC_INT_coverage
def MAC_int32_RM(A,B,C):
	temp = A*B+C
	if(temp & 0x80000000):
		return (((temp & 0xFFFFFFFF) ^ 0xFFFFFFFF) + 1) *(-1)
	else:
		return (A*B+C) & 0xFFFFFFFF