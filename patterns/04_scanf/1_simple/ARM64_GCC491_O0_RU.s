.LC0:
	.string	"Enter X:"
.LC1:
	.string	"%d"
.LC2:
	.string	"You entered %d...\n"
scanf_main:
; вычесть 32 из SP, затем сохранить FP и LR в стековом фрейме:
	stp	x29, x30, [sp, -32]!
; установить стековый фрейм (FP=SP)
	add	x29, sp, 0
; загрузить указатель на строку "Enter X:"
	adrp	x0, .LC0
	add	x0, x0, :lo12:.LC0
; X0=указатель на строку "Enter X:"
; вывести её:
	bl	puts
; загрузить указатель на строку "\%d":
	adrp	x0, .LC1
	add	x0, x0, :lo12:.LC1
; найти место в стековом фрейме для переменной "x" (X1=FP+28):
	add	x1, x29, 28
; X1=адрес переменной "x"
; передать адрес в scanf() и вызвать её:
	bl	__isoc99_scanf
; загрузить 32-битное значение из переменной в стековом фрейме:
	ldr	w1, [x29,28]
; W1=x
; загрузить указатель на строку "You entered \%d...\textbackslash{}n"
; printf() возьмет текстовую строку из X0 и переменную "x" из X1 (или W1)
	adrp	x0, .LC2
	add	x0, x0, :lo12:.LC2
	bl	printf
; возврат 0
	mov	w0, 0
; восстановить FP и LR, затем прибавить 32 к SP:
	ldp	x29, x30, [sp], 32
	ret
