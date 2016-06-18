#include <stdio.h>
#include <stdlib.h>
#include <string.h>
#include <stdint.h>

char fputc_output_buf[1024];
unsigned int fputc_index=0;
	
int fputc(int ch, FILE *f) {
	fputc_output_buf[fputc_index % sizeof(fputc_output_buf)] = ch;
	fputc_index++;
  return ch;
}

__svc(0) void SAPI_AesEncryptDirect(uint32_t funcId, uint8_t *out, const uint8_t *in);
__svc(0) void SAPI_AesDecryptDirect(uint32_t funcId, uint8_t *out, const uint8_t *in);
__svc(0) void SAPI_AesDecryptDirectKey2(uint32_t funcId, uint8_t *out, const uint8_t *in);
#define AesEncryptDirect(out, in) SAPI_AesEncryptDirect(0x01, out, in)
#define AesDecryptDirect(out, in) SAPI_AesDecryptDirect(0x02, out, in)
#define AesDecryptDirectKey2(out, in) SAPI_AesDecryptDirectKey2(0x03, out, in)

void testAes(void){
	uint8_t plain[]    = {0x32, 0x43, 0xf6, 0xa8, 0x88, 0x5a, 0x30, 0x8d, 0x31, 0x31, 0x98, 0xa2, 0xe0, 0x37, 0x07, 0x34};
	uint8_t expected[] = {0x39, 0x25, 0x84, 0x1D, 0x02, 0xDC, 0x09, 0xFB, 0xDC, 0x11, 0x85, 0x97, 0x19, 0x6A, 0x0B, 0x32};
	uint8_t out[16];
	unsigned int i;
	AesEncryptDirect(out,plain);
	for(i=0;i<sizeof(expected);i++){
		if(out[i]!=expected[i]){
			while(1);//error
		}
	}
	AesDecryptDirect(out,out);
	for(i=0;i<sizeof(plain);i++){
		if(out[i]!=plain[i]){
			while(1);//error
		}
	}
	AesDecryptDirectKey2(out,plain);
}

//attack suggested by Odile Derouet
//try to read in supervisor memory by requesting encryption of it
//supervisor code has been fixed to avoid it: it enforce that all I/O pointers points in the user mode memory space
//memory map has been changed such that bit 24 in addresses is set to 1 for user mode memories.
void pointer_attack(void){
	uint8_t out[16];
	uint8_t *target = (uint8_t*)0;//what we would like to encrypt: something from supervisor memory space
	uint8_t *expected = (uint8_t*)((uint32_t)target | 0x01000000);//what will be actually encrypted if supervisor mode is correctly protected.
	AesEncryptDirect(out,target);
	AesDecryptDirect(out,out);
	if(0==memcmp(out,expected,sizeof(out))){
		printf("pointer attack failed, we just read usermode memory");
	} else {
		int i;
		printf("pointer attack may have succeeded, is this supervisor's secret data ?");
		for(i=0;i<sizeof(out);i++){
			printf("%02X ",out[i]);
		}
	}
}

volatile uint8_t temp;

void testReadAccess(uint8_t*address){
	temp = *address;
}

void testAccessLowBoundary(uint8_t*lastValid){
	testReadAccess(lastValid);//should be OK
	testReadAccess(lastValid+1);//should end up in hard fault handler
}
__svc(0) void svcProbe(uint32_t r0,uint32_t r1,uint32_t r2,uint32_t r3);

void silly_tests(void){
	//from here we test sandboxing, everyline is supposed to end up in hardfault handler
	svcProbe(0,0xFB,0,0x10000000);//try the switch to usermode SVC with target address 0xFA, which is a BX R3 instruction.
	svcProbe(4,0,0,0);//second unused funcId
	svcProbe(3,0,0,0);//first unused funcId
	svcProbe(0,0,0,0);//try the switch to usermode SVC with target address 0
	testReadAccess((uint8_t*)0x00000000);//first address of supervisor ROM
	testReadAccess((uint8_t*)0x0003FFFF);//last address of supervisor ROM
	testAccessLowBoundary((uint8_t*)0x2000FFFF);//last address of usermode RAM
}

int main(void){
	memset(fputc_output_buf,0,1024);
	printf("hello world\r\n");
	testAes();
	printf("testAes passed\r\n");
	pointer_attack();
	silly_tests();
	while(1);
	return 0;
}
