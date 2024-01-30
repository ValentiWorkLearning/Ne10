# README

## What’s Ne10?
Ne10 is a library of common, useful functions that have been heavily optimised for ARM-based CPUs equipped with [NEON](https://www.arm.com/products/processors/technologies/neon.php) SIMD capabilities. It provides consistent, well-tested behaviour, allowing for painless integration into a wide variety of applications. The library currently focuses primarily around math, signal processing, image processing, and physics functions.

## Building [![CircleCI](https://circleci.com/gh/projectNe10/Ne10.svg?style=svg)](https://circleci.com/gh/projectNe10/Ne10)
Out of the box, Ne10 supports the Linux, Android, and iOS platforms. For instructions on building Ne10 for these platforms, please consult the build instructions in [`building.md`](https://github.com/projectNe10/Ne10/tree/master/doc/building.md#building-ne10). It is possible to use the library on other platforms (or, indeed, “without a platform”), however you may have to fiddle with some of the build configuration files.

Once Ne10 has been built, it can be linked against just like any other C library. To link C code against Ne10, for instance, the compiler must first be aware of Ne10's library and header files — those within `build/modules/` and `inc/`. To do this, these files can be copied to the standard directories used by compilation tools by running `make install`, or by installing Ne10 from a package manager. Following this, you can simply include `Ne10.h` in your C code, and ask the compiler to link against the `NE10` library (e.g. with `-lNE10`).

## Documentation
Ne10’s official documentation is generated from [doxygen](https://www.stack.nl/~dimitri/doxygen/) annotations in the source code. As such, these documents can be generated locally from the codebase by running `doxygen` within the `doc` directory (producing results in `doc/html`), or viewed remotely as [hosted copies available over the Internet](http://projectne10.github.io/Ne10/doc/modules.html).

We also have a handful of carefully prepared sample code snippets in the [`samples/`](https://github.com/projectNe10/Ne10/tree/master/samples) directory that outline how Ne10 can be used to accomplish a number of common tasks. These include example programs to perform the [FFT](https://github.com/projectNe10/Ne10/tree/master/samples/NE10_sample_complex_fft.c), [FIR](https://github.com/projectNe10/Ne10/tree/master/samples/NE10_sample_fir.c), and [matrix multiply](https://github.com/projectNe10/Ne10/tree/master/samples/NE10_sample_matrix_multiply.c) operations.

## Contributing
Ne10 welcomes and encourages external contributions of any and all forms. If you’ve found a bug or have a suggestion, please don’t hesitate to detail these in the [official issue tracker](https://github.com/projectNe10/Ne10/issues). For those looking to get their hands dirty and contribute code (the best kind of contribution!), please see [`CONTRIBUTING.md`](https://github.com/projectNe10/Ne10/tree/master/CONTRIBUTING.md#contributing-to-project-ne10) for more details.

## Quick Links

- [Official website](http://projectne10.org/)
- [Source repository](https://github.com/projectNe10/Ne10)
- [Issue tracker](https://github.com/projectNe10/Ne10/issues)
- [Doxygen documentation](http://projectne10.github.io/Ne10/doc/modules.html)
- [Coding style guidelines](https://github.com/projectNe10/Ne10/wiki/Ne10-Coding-Style)

## Call for Use Cases

Find Project Ne10 useful? You can help us justify spending more engineering resources on the project! Please email us, outlining how you are using the project in your applications.

Want us to help cross-promote your product using Ne10 at developer events? We’re also looking for Ne10 use cases to show at conferences and meetups.


## Building for ZYNQ on Windows:
```shell
mkdir build && cd build
cmake -G"Unix Makefiles" -DCMAKE_TOOLCHAIN_FILE="full_file_path/VitisWindows_toolchain.cmake" -DBUILD_DEBUG=0 ..
cmake --build .
```
## Some advice for Zynq uses
Taken from: https://github.com/rubennc91/Ne10_zynq_lib

If you want to make an FFT less than 256 points, maybe you can run the program perfectly, depends on the platform you are implementing.
But if you have a problem, you may not have enought "heap" memory.
To avoid this problem it is necessart to change the properties of the linker script. On the  project, right-click and select "Generate linker script". 
In this part, you can change the reserved memory for the program. Change the "Heap Size", default is 1KB, then change the size in bits that you need (4096000 = 4MB). 
Arround 4MB is anought to make an FFT of 8192 points. 

With all this, you can run the sample program. 

The sample program has some definitions to test all possibilities that the library has. 

```
#define NFFT 128
```
This define is used to select the number of points for the FFT function.

The following defines are used to select between different FFT configurations. 
* ```C2C:``` is used to select between differents input types, it is possible real (0) or complex (1). The output is always complex. 
* ```NEON```: You can select between using the NEON module (1) or not using it (0).
* ```FFT```: If you need to perform the inverse FFT (Complex inputs, and real outputs), you can modify it with this define. 
	
Obiously if you select ```C2C=1``` the inputs are complex and the output complex too, therefore the iFFT is implemented, but the input is complex and the output too. 
```
#define C2C 	1	// COMPLEX INPUT AND COMPLEX OUTPUT
#define NEON	0	// USING NEON BLOCK
#define FFT	0	// FFT = 0; iFFT = 1;
```
The final definition is as follows:
*```SHOW_RESULTS``` it is used to display the input and output of the FFT test running. 
*```TEST_SAMPLES``` it is used to select the number of repetitions that the FFT algorithm must execute to obtain the time. 
```
#define SHOW_RESULTS 	0
#define TEST_SAMPLES	1000
```

## Tips when building
https://support.xilinx.com/s/question/0D52E00006hpJQcSAM/undefined-reference-to-pow-despite-linking-to-libm?language=en_US


## Vitis IDE:
- Navigate to Application Properties->ARM v7 gcc linker->Inferred Options->Software Platform Inferred Flags
- Add the following targets:
```
-Wl,--start-group,-lxil,-lgcc,-lc,-lm,-lNE10,--end-group
```
- Add path to the built artifacts(build/modules) to the linker libary search paths in Vitis