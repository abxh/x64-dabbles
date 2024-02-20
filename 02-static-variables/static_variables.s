// reference(s) for extra comments:
// https://docs.oracle.com/cd/E19253-01/817-5477/eoiyg/index.html
// https://stackoverflow.com/questions/4423211/when-are-gas-elf-the-directives-type-thumb-size-and-section-needed

// file name
.file	"static_variables.c"

// at&t syntax ( ), intel syntax (x):
.intel_syntax noprefix		 

// ------------------
.text
	// local to the obj file to be generated i.e. static
	.local	a       
	// allocate_data <name>, <size>, [alignment]
	.comm	a,8,8	
// ------------------
// .text?
	.local	b
	.comm	b,8,8
// ------------------
.data
	// let next data to be generated to be 8 byte aligned
	.align 8

	// elf gcc assembler specific directives:
	.type	c, @object
	.size	c, 8

	// quad (64-bit) with value 42
	c:
		.quad	42

// ------------------
// .text?
	.local	d
	.comm	d,8,8
// ------------------
// read-only data
.section	.rodata 
		.align 8
		.type	e, @object
		.size	e, 8
	e:
		// fill number with zeroes
		.zero	8 

		.align 8
		.type	f, @object
		.size	f, 8
	f:
		.quad	43 
	.ident	"GCC: (GNU) 13.2.0"
	.section	.note.GNU-stack,"",@progbits
