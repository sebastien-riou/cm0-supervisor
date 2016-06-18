

Stack_Size      EQU     0x00000400

__initial_sp		EQU			0x2001FFFC

Heap_Size       EQU     0x00000C00

Boot_Base_Address		EQU     0x01000000



                PRESERVE8
                THUMB


; Vector Table Mapped to Address 0 at Reset

                AREA    RESET, DATA, READONLY
                EXPORT  __Vectors
                EXPORT  __Vectors_End
                EXPORT  __Vectors_Size

__Vectors       DCD     __initial_sp              ; Top of Stack
                DCD     Reset_Handler             ; Reset Handler
                DCD     NMI_Handler               ; NMI Handler
                DCD     HardFault_Handler         ; Hard Fault Handler
                DCD     0                         ; Reserved
                DCD     0                         ; Reserved
                DCD     0                         ; Reserved
                DCD     0                         ; Reserved
                DCD     0                         ; Reserved
                DCD     0                         ; Reserved
                DCD     0                         ; Reserved
                DCD     SVC_Handler               ; SVCall Handler
                DCD     0                         ; Reserved
                DCD     0                         ; Reserved
                DCD     PendSV_Handler            ; PendSV Handler
                DCD     SysTick_Handler           ; SysTick Handler

                ; External Interrupts
                DCD     WDT_IRQHandler            ;  0:  Watchdog Timer
                DCD     RTC_IRQHandler            ;  1:  Real Time Clock
                DCD     TIM0_IRQHandler           ;  2:  Timer0 / Timer1
                DCD     TIM2_IRQHandler           ;  3:  Timer2 / Timer3
                DCD     MCIA_IRQHandler           ;  4:  MCIa
                DCD     MCIB_IRQHandler           ;  5:  MCIb
                DCD     UART0_IRQHandler          ;  6:  UART0 - DUT FPGA
                DCD     UART1_IRQHandler          ;  7:  UART1 - DUT FPGA
                DCD     UART2_IRQHandler          ;  8:  UART2 - DUT FPGA
                DCD     UART4_IRQHandler          ;  9:  UART4 - not connected
                DCD     AACI_IRQHandler           ; 10: AACI / AC97
                DCD     CLCD_IRQHandler           ; 11: CLCD Combined Interrupt
                DCD     ENET_IRQHandler           ; 12: Ethernet
                DCD     USBDC_IRQHandler          ; 13: USB Device
                DCD     USBHC_IRQHandler          ; 14: USB Host Controller
                DCD     CHLCD_IRQHandler          ; 15: Character LCD
                DCD     FLEXRAY_IRQHandler        ; 16: Flexray
                DCD     CAN_IRQHandler            ; 17: CAN
                DCD     LIN_IRQHandler            ; 18: LIN
                DCD     I2C_IRQHandler            ; 19: I2C ADC/DAC
                DCD     0                         ; 20: Reserved
                DCD     0                         ; 21: Reserved
                DCD     0                         ; 22: Reserved
                DCD     0                         ; 23: Reserved
                DCD     0                         ; 24: Reserved
                DCD     0                         ; 25: Reserved
                DCD     0                         ; 26: Reserved
                DCD     0                         ; 27: Reserved
                DCD     CPU_CLCD_IRQHandler       ; 28: Reserved - CPU FPGA CLCD
                DCD     0                         ; 29: Reserved - CPU FPGA
                DCD     UART3_IRQHandler          ; 30: UART3    - CPU FPGA
                DCD     SPI_IRQHandler            ; 31: SPI Touchscreen - CPU FPGA
__Vectors_End

__Vectors_Size  EQU     __Vectors_End - __Vectors

                AREA    |.text|, CODE, READONLY


; Reset Handler

Reset_Handler   PROC
                EXPORT  Reset_Handler             [WEAK]
                IMPORT  SystemInit
                IMPORT  __main
								IMPORT  ConfigMpu
                LDR     R0, =SystemInit
                BLX     R0
                LDR     R0, =ConfigMpu
								BLX			R0
								LDR			R0, =Boot_Base_Address
								;set process stack pointer with the user code stack pointer
								LDR			R1, [R0, #0]
								MSR			PSP, R1
								;get user code's reset vector
								LDR			R1, [R0, #4]
								;select PSP
								MOVS		R0,#2
								MSR			CONTROL, R0
								;switch to user mode
								MOVS		R0,#0
								SVC			0
                ENDP


; Dummy Exception Handlers (infinite loops which can be modified)

NMI_Handler     PROC
                EXPORT  NMI_Handler               [WEAK]
                B       .
                ENDP
HardFault_Handler\
                PROC
                EXPORT  HardFault_Handler         [WEAK]
                B       .
                ENDP
EXC_RETURN_HANDLER_MSP  EQU	0xFFFFFFF1
EXC_RETURN_THREAD_MSP  EQU	0xFFFFFFF9
EXC_RETURN_THREAD_PSP  EQU	0xFFFFFFFD


;assume we always call while using PSP
SVC_Handler     PROC
                EXPORT  SVC_Handler               
								IMPORT	SAPI_AesEncryptDirect
								IMPORT	SAPI_AesDecryptDirect
								IMPORT	SAPI_AesDecryptDirectKey2
								
								PUSH	{R4-R7,LR}
								MOV		R4,R8
								MOV		R5,R9
								MOV		R6,R10
								MOV		R7,R11
								PUSH	{R4-R7}
								
								MOVS	R4, #0x03
								ANDS	R0, R4
								LSLS	R0, #2
								LDR		R4, =SVC_Handler_vectors
								LDR		R0, [R4, R0]
								BLX		R0

SVC_Handler_exit
								;restore caller context
								POP	{R4-R7}
								MOV		R8,R4
								MOV		R9,R5
								MOV		R10,R6
								MOV		R11,R7
								;jump to user mode
								POP	{R4-R7, PC}

								ALIGN		4
SVC_Handler_vectors
								DCD			switch_to_user_mode
								DCD			SAPI_AesEncryptDirect
								DCD			SAPI_AesDecryptDirect
								DCD			SAPI_AesDecryptDirectKey2
								DCD     HardFault_Handler
								DCD     HardFault_Handler
								DCD     HardFault_Handler
								DCD     HardFault_Handler
								DCD     HardFault_Handler
								


switch_to_user_mode
;switch to user mode and jump to address in r1
;assume it is called from privileged mode	
;caller must use the stack pointer desired for user mode             
								;replace return address in stack
								MRS			R2,PSP
								STR			R1,[R2,#0x18]
								;erase saved R0~R3,R12,LR and xPSR values
								MOVS		R0,#0
								STR			R0,[R2,#0x00]
								STR			R0,[R2,#0x04]
								STR			R0,[R2,#0x08]
								STR			R0,[R2,#0x0C]
								STR			R0,[R2,#0x10]
								STR			R0,[R2,#0x14]
								LDR			R0,=0x01000000
								STR			R0,[R2,#0x1C]
								
								;set user mode (effective only after return to thread mode)
								;( stack selection irrelevant as it is fixed by EXC_RETURN )
								MOVS		R1,#3
								MSR			CONTROL, R1

								;ready for jumping to user mode (done by SVC_Handler_exit final instruction)
								BX			LR
								
                ENDP
									
PendSV_Handler  PROC
                EXPORT  PendSV_Handler            [WEAK]
                B       .
                ENDP
SysTick_Handler PROC
                EXPORT  SysTick_Handler           [WEAK]
                B       .
                ENDP

Default_Handler PROC

                EXPORT  WDT_IRQHandler            [WEAK]
                EXPORT  RTC_IRQHandler            [WEAK]
                EXPORT  TIM0_IRQHandler           [WEAK]
                EXPORT  TIM2_IRQHandler           [WEAK]
                EXPORT  MCIA_IRQHandler           [WEAK]
                EXPORT  MCIB_IRQHandler           [WEAK]
                EXPORT  UART0_IRQHandler          [WEAK]
                EXPORT  UART1_IRQHandler          [WEAK]
                EXPORT  UART2_IRQHandler          [WEAK]
                EXPORT  UART3_IRQHandler          [WEAK]
                EXPORT  UART4_IRQHandler          [WEAK]
                EXPORT  AACI_IRQHandler           [WEAK]
                EXPORT  CLCD_IRQHandler           [WEAK]
                EXPORT  ENET_IRQHandler           [WEAK]
                EXPORT  USBDC_IRQHandler          [WEAK]
                EXPORT  USBHC_IRQHandler          [WEAK]
                EXPORT  CHLCD_IRQHandler          [WEAK]
                EXPORT  FLEXRAY_IRQHandler        [WEAK]
                EXPORT  CAN_IRQHandler            [WEAK]
                EXPORT  LIN_IRQHandler            [WEAK]
                EXPORT  I2C_IRQHandler            [WEAK]
                EXPORT  CPU_CLCD_IRQHandler       [WEAK]
                EXPORT  SPI_IRQHandler            [WEAK]

WDT_IRQHandler
RTC_IRQHandler
TIM0_IRQHandler
TIM2_IRQHandler
MCIA_IRQHandler
MCIB_IRQHandler
UART0_IRQHandler
UART1_IRQHandler
UART2_IRQHandler
UART3_IRQHandler
UART4_IRQHandler
AACI_IRQHandler
CLCD_IRQHandler
ENET_IRQHandler
USBDC_IRQHandler
USBHC_IRQHandler
CHLCD_IRQHandler
FLEXRAY_IRQHandler
CAN_IRQHandler
LIN_IRQHandler
I2C_IRQHandler
CPU_CLCD_IRQHandler
SPI_IRQHandler
                B       .

                ENDP


                ALIGN

                END
