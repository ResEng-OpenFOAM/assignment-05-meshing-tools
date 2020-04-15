#!/bin/bash
# Run this as root please

set -ev

# Install dependencies
apt-get update
apt-get install liblapack-dev gfortran clang-7 llvm-7* libjpeg-dev libhdf5* pkg-config -y 

# Fix some library linking conflicts
ln -s /usr/lib/s390x-linux-gnu/libhdf5_serial.so /usr/lib/s390x-linux-gnu/libhdf5.so
ln -s /usr/lib/s390x-linux-gnu/libmpich.so /usr/lib/s390x-linux-gnu/libmpich.so.12

# Use LLVM-7
export LLVM_CONFIG=/usr/bin/llvm-config-7

# Install PoresPy
python3 -m pip install setuptools --upgrade
python3 -m pip install porespy
