import sys
import math

def bytesplit(binary_num_str):
	'''
		split binary-number into bytes
		0100101010100011110 => 010 01010101 00011110
	'''
	byte_bit_num=8;
	separator=' ';

	i=len(binary_num_str);
	result_str="";
	while(i>=8):
		result_str = binary_num_str[i-8:i] + separator + result_str;
		i=i-8;
	if(i>0):
		result_str = binary_num_str[:i] + separator + result_str;
	#return result_str;
	print(result_str);


def tofloat(uint32_str):
	'''
		convert 32bit unsigned integer to float
		IEEE 754-2008
	'''
	max_limit=int( math.pow(2,32)-1 );
	uint32=int(uint32_str);
	#print(max_limit, uint32);
	if(uint32>max_limit):
		exit(1);
	sign_bit = (uint32&0x80000000)>>31;
	exponent_bit = (uint32&0x7f800000)>>23;
	fraction_bit = (uint32&0x7fffff);
	#print(sign_bit, exponent_bit, fraction_bit);
	if(exponent_bit==0):
		if(fraction_bit==0):
			print('0');
		else:
			print('DeN');
	elif(exponent_bit==0xff):
		if(fraction_bit==0):
			print('Inf');
		else:
			print('NaN');
	else:
		float_number = (1 + fraction_bit*math.pow(2,-23)) * math.pow(2,exponent_bit-127);
		print(float_number);
	
if __name__ == '__main__':
	string=sys.argv[1];
	tofloat(string);
