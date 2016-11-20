#!/bin/bash

set -e

GMP=gmp-6.1.1
MPFR=mpfr-3.1.5
MPC=mpc-1.0.3
GCC=gcc-6.2.0
NEWLIB=newlib-2.4.0.20161025
BINUTILS=binutils-2.27
GDB=gdb-7.12

# gmp
wget -N https://ftp.gnu.org/gnu/gmp/${GMP}.tar.xz
tar xf ${GMP}.tar.xz

# mpfr
wget -N https://ftp.gnu.org/gnu/mpfr/${MPFR}.tar.xz
tar xf ${MPFR}.tar.xz

# mpc
wget -N https://ftp.gnu.org/gnu/mpc/${MPC}.tar.gz
tar xf ${MPC}.tar.gz

# gcc

wget -N https://ftp.gnu.org/gnu/gcc/${GCC}/${GCC}.tar.bz2
tar xf ${GCC}.tar.bz2

# newlib
wget -N ftp://sourceware.org/pub/newlib/${NEWLIB}.tar.gz
tar xf ${NEWLIB}.tar.gz

# binutils
wget -N https://ftp.gnu.org/gnu/binutils/${BINUTILS}.tar.bz2
tar xf ${BINUTILS}.tar.bz2

# gdb
wget -N https://ftp.gnu.org/gnu/gdb/${GDB}.tar.xz
tar xf ${GDB}.tar.xz

cd ${GCC}
ln -s ../${BINUTILS}/bfd
ln -s ../${BINUTILS}/binutils
ln -s ../${BINUTILS}/gas
ln -s ../${BINUTILS}/gold
ln -s ../${BINUTILS}/gprof
ln -s ../${BINUTILS}/opcodes
ln -s ../${BINUTILS}/ld

ln -s ../${NEWLIB}/newlib
ln -s ../${NEWLIB}/libgloss

ln -s ../${GDB} gdb
ln -s ../${MPC} mpc
ln -s ../${MPFR} mpfr
ln -s ../${GMP} gmp

cd ..
mkdir -p build
cd build
../${GCC}/configure  --prefix=/opt/lm32 --enable-languages=c --target=lm32-elf
make -j32
