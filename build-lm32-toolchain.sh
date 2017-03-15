#!/bin/bash

set -e

GMP=gmp-6.1.2
MPFR=mpfr-3.1.5
MPC=mpc-1.0.3
GCC=gcc-6.3.0
NEWLIB=newlib-2.5.0.20170228
BINUTILS=binutils-2.28
GDB=gdb-7.12.1

GNU_MIRROR=https://ftp.gnu.org
#GNU_MIRROR=http://mirror.internode.on.net/pub

# gmp
wget -N $GNU_MIRROR/gnu/gmp/${GMP}.tar.xz
tar xf ${GMP}.tar.xz

# mpfr
wget -N $GNU_MIRROR/gnu/mpfr/${MPFR}.tar.xz
tar xf ${MPFR}.tar.xz

# mpc
wget -N $GNU_MIRROR/gnu/mpc/${MPC}.tar.gz
tar xf ${MPC}.tar.gz

# gcc

wget -N $GNU_MIRROR/gnu/gcc/${GCC}/${GCC}.tar.bz2
tar xf ${GCC}.tar.bz2

# newlib
wget -N ftp://sourceware.org/pub/newlib/${NEWLIB}.tar.gz
tar xf ${NEWLIB}.tar.gz

# binutils
wget -N $GNU_MIRROR/gnu/binutils/${BINUTILS}.tar.bz2
tar xf ${BINUTILS}.tar.bz2

# gdb
wget -N $GNU_MIRROR/gnu/gdb/${GDB}.tar.xz
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
