.section .data
fmt:
    .string "sum: %d\n"

.text
.globl add_two
.type add_two, @function
add_two:
    .cfi_startproc
    movq  %rdi, %rax
    addq %rsi, %rax
    ret
    .cfi_endproc

.globl main
.type main, @function
main:
    .cfi_startproc
    pushq %rbp
    movq %rsp, %rbp
    movq $23, %rdi
    movq $19, %rsi
    call add_two
    movq %rax, -4(%rbp)
    movl -4(%rbp), %esi
    leaq fmt(%rip), %rdi
    movl $0, %eax
    call printf@PLT
    movq $60, %rax
    movq $0, %rdi
    syscall
    leave
    ret
    .cfi_endproc
