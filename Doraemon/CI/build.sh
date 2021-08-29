#!/bin/bash
#
# Doraemon Kernel Script 2021
# Licensed under the Apache License, Version 2.0 (the "License");
# you may not use this file except in compliance with the License.
# You may obtain a copy of the License at
#
#      http://www.apache.org/licenses/LICENSE-2.0
#
# Unless required by applicable law or agreed to in writing, software

# distributed under the License is distributed on an "AS IS" BASIS,
# WITHOUT WARRANTIES OR CONDITIONS OF ANY KIND, either express or implied.
# See the License for the specific language governing permissions and
# limitations under the License.

git clone -b amd64 --single-branch https://github.com/EternalX-project/aarch64-linux-gnu.git /tmp/ci/gcc
git clone -b 11.0.0 --single-branch https://github.com/Haseo97/Avalon-Clang-12.0.0.git /tmp/ci/clang
export CROSS_COMPILE=~/kernel/gcc/bin/aarch64-linux-gnu-
export SUBARCH=arm64
export ARCH=arm64

make O=out picasso-user_defconfig ARCH=arm64

PATH=/tmp/ci/clang/bin:/tmp/ci/gcc/bin:${PATH} \
make -j$(nproc --all) O=out \
                      ARCH=arm64 \
                      CC=clang \
                      CLANG_TRIPLE=aarch64-linux-gnu- \
                      CROSS_COMPILE=aarch64-linux-gnu-
