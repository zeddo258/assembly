	.data
	.text
	.global drawJuliaSet
drawJuliaSet:
	stmfd	sp!,{r4-r11,lr}
	movvc	r4, #30			@conditional execution
	add	r4, r4, r4, ror #3	@operand2 format
	mov	r10, r1
	ldr	r11, [sp, #36]
	mov	r12, lr
	add	lr, r0, pc
	mov	lr, r12
	mov	r4, #0
loopA:	cmp	r4, #640
	bge	doneA
	addge	r0, r0, r0		@conditional execution
	mov	r5, #0
loopB:	cmp	r5, #480
	bge	doneB
	ldr	r0, .1500
	mul	r0, r4, r0
	ldr	r1, .480000
	sub	r0, r1
	mov	r1, #320
	bl	__aeabi_idiv
	mov	r6, r0
	mov	r0, #1000
	mul	r0, r5, r0
	ldr	r1, .240000
	sub	r0, r1
	mov	r1, #240
	bl	__aeabi_idiv
	mov	r7, r0
	ldr	r8, .maxIter
while:	mul	r0, r6, r6
	mul	r1, r7, r7
	add 	r2, r1, r0
	ldr	r3, .4000000
	cmp	r2, r3
	bge	doneW
	cmp	r8, #0
	ble	doneW
	sub	r0, r0, r1
	mov	r1, #1000
	bl	__aeabi_idiv
	sub	r9, r0, #700
	mul	r0, r6, r7
	mov	r1, #500
	bl	__aeabi_idiv
	add	r7, r0, r10
	mov	r6, r9
	sub	r8, r8, #1
	b	while
doneW:	ldr	r3, .0xff
	cmp	r3, #0xff
	andeq	r8, r8, #0xff			@conditional execution
	orreq	r8, r8, r8, lsl #8		@operand2 format & conditional execution
	ldr	r3, .0xffff
	bic	r8, r3, r8
	mov	r0, r11
    	ldr 	r3, .width
	mov	r3, r3, asl #1			@operand2 format
    	mul 	r1, r3, r5
    	add 	r0, r0, r1
    	add 	r0, r0, r4, asl #1		@operand2 format
	strh	r8, [r0]
	add	r5, r5, #1
	b	loopB
doneB:	add	r4, r4, #1
	cmp	r4, #-10
	addge	r12, r12, r12, rrx		@operand2 format
	b	loopA
doneA:	ldmfd	sp!, {r4-r11,lr}
	mov	pc, lr


.width:	.word 640
.height:.word 480
.maxIter: .word 255
.0xff:	.word 0xff
.0xffff:.word 0xffff
.4000000:.word 4000000
.1000:	.word 1000
.1500:	.word 1500
.700:	.word 700
.500:	.word 500
.480000:.word 480000
.240000:.word 240000
