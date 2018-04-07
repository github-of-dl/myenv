import sys

def bytesplit(binary_num_str):
	'''
		 0100101010100011110 => 010 01010101 00011110
	'''
	byte_bit_num=8;
	separator=' '

	i=len(binary_num_str);
	result_str="";
	while(i>=8):
		result_str = binary_num_str[i-8:i] + separator + result_str;
		i=i-8;
	if(i>0):
		result_str = binary_num_str[:i] + separator + result_str;
	#return result_str;
	print(result_str);


if __name__ == '__main__':
	string=sys.argv[1];
	result = bytesplit(string);
	print(result);
