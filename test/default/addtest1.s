        # Basic addition tests
	.text
main:   
        addiu   $2, $zero, 1024
        addiu   $v0, $zero, 0xa
        syscall