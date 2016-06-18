

#include "generic_cortex_m0.h"
#include "aes.h"

/*----------------------------------------------------------------------------
  Define clocks
 *----------------------------------------------------------------------------*/
#define __HSI             ( 8000000UL)
#define __XTAL            ( 5000000UL)    /* Oscillator frequency             */

#define __SYSTEM_CLOCK    (5*__XTAL)


/*----------------------------------------------------------------------------
  System Core Clock Variable
 *----------------------------------------------------------------------------*/
uint32_t SystemCoreClock = __SYSTEM_CLOCK;/* System Core Clock Frequency      */


/**
 * Update SystemCoreClock variable
 *
 * @param  none
 * @return none
 *
 * @brief  Updates the SystemCoreClock with current core Clock
 *         retrieved from cpu registers.
 */
void SystemCoreClockUpdate (void)
{

  SystemCoreClock = __SYSTEM_CLOCK;

}

/**
 * Initialize the system
 *
 * @param  none
 * @return none
 *
 * @brief  Setup the microcontroller system.
 *         Initialize the System.
 */
void SystemInit (void)
{

  SystemCoreClock = __SYSTEM_CLOCK;

}

//enable read/write/execute in a memory area
void MpuSetRegion(unsigned int region, uint32_t base, uint32_t size_power_of_2){
	MPU->RBAR = base | 0x10 | region;
	MPU->RASR = (0x3<<24) | ((size_power_of_2-1)<<1) | 1;
}
#define USER_ROM_BASE							0x01000000
#define USER_ROM_SIZE_POWER_OF_2	16
#define USER_RAM_BASE							0x21000000
#define USER_RAM_SIZE_POWER_OF_2	16
void ConfigMpu(void){
	MpuSetRegion(0,USER_ROM_BASE,USER_ROM_SIZE_POWER_OF_2);
	MpuSetRegion(1,USER_RAM_BASE,USER_RAM_SIZE_POWER_OF_2);
	MPU->CTRL = 0x05;// enable MPU with background region enabled for privileged mode (supervisor code)
}

const uint8_t aes_key[]  = {0x2b, 0x7e, 0x15, 0x16, 0x28, 0xae, 0xd2, 0xa6, 0xab, 0xf7, 0x15, 0x88, 0x09, 0xcf, 0x4f, 0x3c};
const uint8_t aes_key2[] = {0x16, 0x28, 0x2b, 0x7e, 0xa6, 0x09, 0xcf, 0x4f, 0x3c, 0xab, 0xf7, 0xff, 0x88, 0x15, 0xae, 0xd2};
const byte iv[]          =  {0x00, 0x00, 0x00, 0x00, 0x00, 0x00, 0x00, 0x00, 0x00, 0x00, 0x00, 0x00, 0x00, 0x00, 0x00, 0x00};

//ensure a pointer points to user mode memory
#define sanitize_user_pointer(p) do {p=(void*) ((uint32_t)p | 0x01000000);} while(0)

void SAPI_AesEncryptDirect(unsigned int dummy, uint8_t *out, const uint8_t *in){
	Aes aesContext;
	sanitize_user_pointer(out);
	sanitize_user_pointer(in);
	AesSetKey(&aesContext, aes_key, sizeof(aes_key), iv, AES_ENCRYPTION);
	AesCbcEncrypt(&aesContext, out, in, 16);
}

void SAPI_AesDecryptDirect(unsigned int dummy, uint8_t *out, const uint8_t *in){
	Aes aesContext;
	sanitize_user_pointer(out);
	sanitize_user_pointer(in);
	AesSetKey(&aesContext, aes_key, sizeof(aes_key), iv, AES_DECRYPTION);
	AesCbcDecrypt(&aesContext, out, in, 16);
}

void SAPI_AesDecryptDirectKey2(unsigned int dummy, uint8_t *out, const uint8_t *in){
	Aes aesContext;
	sanitize_user_pointer(out);
	sanitize_user_pointer(in);
	AesSetKey(&aesContext, aes_key2, sizeof(aes_key), iv, AES_DECRYPTION);
	AesCbcDecrypt(&aesContext, out, in, 16);
}

//never reach when executing the usermode project.
int main(void){
	while(1);
	return 0;
}
