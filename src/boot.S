/* boot.S - assembly startup code */
 
// To keep this in the first portion of the binary.
.section ".text.boot"
 
// Make Start global.
.globl Start
 
// Entry point for the kernel.
// r15 -> should begin execution at 0x8000.
// r0 -> 0x00000000
// r1 -> 0x00000C42
// r2 -> 0x00000100 - start of ATAGS
// preserve these registers as argument for kernel_main
Start:
	// Setup the stack.
	mov	sp, #0x8000
 
	// Clear out bss.
	ldr	r4, =_bss_start
	ldr	r9, =_bss_end
	mov	r5, #0
	mov	r6, #0
	mov	r7, #0
	mov	r8, #0
1:
	// store multiple at r4.
	stmia	r4!, {r5-r8}
 
	// If we're still below bss_end, loop.
	cmp	r4, r9
	blo	1b
 
	// Call kernel_main
	ldr	r3, =kernel_main
	blx	r3
 
	// halt
halt:
	wfe
	b	halt
