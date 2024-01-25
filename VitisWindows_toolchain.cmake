#
#  Copyright 2013-16 ARM Limited and Contributors.
#  All rights reserved.
#
#  Redistribution and use in source and binary forms, with or without
#  modification, are permitted provided that the following conditions are met:
#    * Redistributions of source code must retain the above copyright
#      notice, this list of conditions and the following disclaimer.
#    * Redistributions in binary form must reproduce the above copyright
#      notice, this list of conditions and the following disclaimer in the
#      documentation and/or other materials provided with the distribution.
#    * Neither the name of ARM Limited nor the
#      names of its contributors may be used to endorse or promote products
#      derived from this software without specific prior written permission.
#
#  THIS SOFTWARE IS PROVIDED BY ARM LIMITED AND CONTRIBUTORS "AS IS" AND
#  ANY EXPRESS OR IMPLIED WARRANTIES, INCLUDING, BUT NOT LIMITED TO, THE IMPLIED
#  WARRANTIES OF MERCHANTABILITY AND FITNESS FOR A PARTICULAR PURPOSE ARE
#  DISCLAIMED. IN NO EVENT SHALL ARM LIMITED AND CONTRIBUTORS BE LIABLE FOR ANY
#  DIRECT, INDIRECT, INCIDENTAL, SPECIAL, EXEMPLARY, OR CONSEQUENTIAL DAMAGES
#  (INCLUDING, BUT NOT LIMITED TO, PROCUREMENT OF SUBSTITUTE GOODS OR SERVICES;
#  LOSS OF USE, DATA, OR PROFITS; OR BUSINESS INTERRUPTION) HOWEVER CAUSED AND
#  ON ANY THEORY OF LIABILITY, WHETHER IN CONTRACT, STRICT LIABILITY, OR TORT
#  (INCLUDING NEGLIGENCE OR OTHERWISE) ARISING IN ANY WAY OUT OF THE USE OF THIS
#  SOFTWARE, EVEN IF ADVISED OF THE POSSIBILITY OF SUCH DAMAGE.
#

#  Usage:
#   $ mkdir build && cd build
#   $ cmake -DCMAKE_TOOLCHAIN_FILE=path/of/GNUlinux_config.cmake ..
#   $ make
#
#  Option:
#   - Choose target architecture
#     Target architecture can be specified by setting NE10_LINUX_TARGET_ARCH to
#     armv7 or aarch64 (Not done yet). Defaut is armv7.

set(GNULINUX_PLATFORM ON)
set(CMAKE_SYSTEM_NAME "Generic")
set(CMAKE_SYSTEM_PROCESSOR "arm")
set(ZYNQ_BAREMETAL_TARGET ON)

if(NOT DEFINED ENV{NE10_LINUX_TARGET_ARCH})
   set(NE10_LINUX_TARGET_ARCH "armv7")
else()
   set(NE10_LINUX_TARGET_ARCH $ENV{NE10_LINUX_TARGET_ARCH})
endif()

set(ARM_ZYNQ_NONE_EABI_AARCH32_TOOLCHAIN "C:/Xilinx/Vitis/2022.2/gnu/aarch32/nt/gcc-arm-none-eabi")
set(ZYNQ_TARGET_TRIPLET "aarch32-xilinx-eabi")

set(TOOLCHAIN_SYSROOT  "${ARM_ZYNQ_NONE_EABI_AARCH32_TOOLCHAIN}/${ZYNQ_TARGET_TRIPLET}")
set(TOOLCHAIN_BIN_PATH "${ARM_ZYNQ_NONE_EABI_AARCH32_TOOLCHAIN}/bin")
set(TOOLCHAIN_INC_PATH "${ARM_ZYNQ_NONE_EABI_AARCH32_TOOLCHAIN}/${ZYNQ_TARGET_TRIPLET}/usr/include")
set(TOOLCHAIN_LIB_PATH "${ARM_ZYNQ_NONE_EABI_AARCH32_TOOLCHAIN}/${ZYNQ_TARGET_TRIPLET}/usr/lib")
set(AARCH32_ZYNQ_TARGET_TRIPLET "arm-none-eabi")

set(CMAKE_OBJCOPY  ${TOOLCHAIN_BIN_PATH}/${AARCH32_ZYNQ_TARGET_TRIPLET}-objcopy.exe)
set(CMAKE_OBJDUMP  ${TOOLCHAIN_BIN_PATH}/${AARCH32_ZYNQ_TARGET_TRIPLET}-objdump.exe)
set(CMAKE_SIZE  ${TOOLCHAIN_BIN_PATH}/${AARCH32_ZYNQ_TARGET_TRIPLET}-size.exe)
set(CMAKE_DEBUGGER ${TOOLCHAIN_BIN_PATH}/${AARCH32_ZYNQ_TARGET_TRIPLET}-gdb.exe)
set(CMAKE_CPPFILT  ${TOOLCHAIN_BIN_PATH}/${AARCH32_ZYNQ_TARGET_TRIPLET}-c++filt.exe)

set(CMAKE_TRY_COMPILE_TARGET_TYPE STATIC_LIBRARY)

set(CMAKE_C_COMPILER  ${TOOLCHAIN_BIN_PATH}/${AARCH32_ZYNQ_TARGET_TRIPLET}-gcc.exe )
set(CMAKE_CXX_COMPILER ${TOOLCHAIN_BIN_PATH}/${AARCH32_ZYNQ_TARGET_TRIPLET}-g++.exe )
set(CMAKE_SIZE_UTIL  ${TOOLCHAIN_BIN_PATH}/${AARCH32_ZYNQ_TARGET_TRIPLET}-size.exe )
set(CMAKE_OBJCOPY  ${TOOLCHAIN_BIN_PATH}/${AARCH32_ZYNQ_TARGET_TRIPLET}-objcopy.exe )
set(CMAKE_AR   ${TOOLCHAIN_BIN_PATH}/arm-none-eabi-ar.exe )
set(CMAKE_RANLIB   ${TOOLCHAIN_BIN_PATH}/arm-none-eabi-ranlib.exe )

set(CMAKE_SHARED_LINKER_FLAGS "--specs=nosys.specs")

mark_as_advanced(CMAKE_AR)
mark_as_advanced(CMAKE_RANLIB)

# Don't look for programs in the sysroot (these are ARM programs, they won't run
# on the build machine).
set(CMAKE_FIND_ROOT_PATH_MODE_PROGRAM NEVER)

# Only look for libraries, headers and packages in the sysroot, don't look on
# the build machine.
set(CMAKE_FIND_ROOT_PATH_MODE_LIBRARY ONLY)
set(CMAKE_FIND_ROOT_PATH_MODE_INCLUDE ONLY)
set(CMAKE_FIND_ROOT_PATH_MODE_PACKAGE ONLY)