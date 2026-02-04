.section .rodata
output:
    .string "Enter two numbers:"
fmt:
    .string "Sum of two numbers is %d\n"
input:
    .string "%d%d"

.text
.globl add_two
.type add_two, @function
add_two:
    .cfi_startproc
    movl %edi, %eax
    addl %esi, %eax
    ret
    .cfi_endproc

.globl main
.type main, @function
main:
    .cfi_startproc
    pushq %rbp
    movq %rsp, %rbp
    subq $16, %rsp
    leaq output(%rip), %rax
    movq %rax, %rdi
    call puts@PLT
    leaq -12(%rbp), %rdx
    leaq -16(%rbp), %rax
    leaq input(%rip), %rcx
    movq %rax, %rsi
    movq %rcx, %rdi
    movl $0, %eax
    call __isoc23_scanf@PLT
    movl -12(%rbp), %esi
    movl -16(%rbp), %edi
    call add_two
    movl %eax, %esi
    leaq fmt(%rip), %rdi
    movl $0, %eax
    call printf@PLT
    movq $60, %rax
    movq $0, %rdi
    syscall
    leave
    ret
    .cfi_endproc
