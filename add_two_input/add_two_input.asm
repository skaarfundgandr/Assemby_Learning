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
    movl %edi, %eax # Move first arg to accumulator
    addl %esi, %eax # Add second arg to value in accumulator
    ret # Return
    .cfi_endproc

.globl main
.type main, @function
main:
    .cfi_startproc
    pushq %rbp # Initialize base pointer
    movq %rsp, %rbp # Move current stack to base pointer (ensures they are equal)
    subq $16, %rsp # Align stack by 16 bytes
    leaq output(%rip), %rdi # Load output string to first argument
    call puts@PLT # Print out output string
    # Variable allocation
    leaq -12(%rbp), %rdx
    leaq -16(%rbp), %rsi

    leaq input(%rip), %rdi # Load input format to first arg
    movl $0, %eax # Zero the accumulator (prepares for function call)
    call __isoc23_scanf@PLT # Call scanf
    movl -12(%rbp), %edi # Move first variable to first arg
    movl -16(%rbp), %esi # Move second variable to second arg
    call add_two # Call local function add_two
    movl %eax, %esi # Move result to second arg
    leaq fmt(%rip), %rdi # Load fmt string to first arg
    movl $0, %eax # Zero the accumulator
    call printf@PLT # Call printf
    # Exit
    movq $60, %rax # Move 60 to accumulator (syscall exit in linux)
    movq $0, %rdi # Pass 0 as the exit code
    syscall # Proceed with syscall
    leave # Clean up stack frame and base pointer
    ret # Return
    .cfi_endproc
