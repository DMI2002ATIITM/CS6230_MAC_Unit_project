def MAC_int32_RM(A,B,C):
	temp = A*B+C
	if(temp & 0x80000000):
		return (((temp & 0xFFFFFFFF) ^ 0xFFFFFFFF) + 1) *(-1)
	else:
		return (A*B+C) & 0xFFFFFFFF
