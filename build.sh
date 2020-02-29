#!/bin/bash

git clone --depth=1 https://github.com/crazyuploader/Xiaomeme.git -b TEST Meme && cd Meme

PWD="$(pwd)"
NAME="$(basename "${PWD}")"
TIME="$(date +%d%m%y%H%M)"
export KERNEL_VERSION=$(make kernelversion)
export BRANCH="$(git rev-parse --abbrev-ref HEAD)"
export ZIPNAME="${BRANCH}_${NAME}-${KERNEL_VERSION}.zip"
export KBUILD_BUILD_USER=Jungle
export KBUILD_BUILD_HOST=AMD
export KBUILD_COMPILER_STRING="Clang Version 10.0.4"
export ARCH=arm64 && export SUBARCH=arm64

curl -s -X POST https://api.telegram.org/bot${BOT_API_TOKEN}/sendMessage -d text="CI Build -- ${NAME} at Version: ${KERNEL_VERSION}" -d chat_id=${KERNEL_CHAT_ID} -d parse_mode=HTML
START=$(date +"%s")
echo ""
echo "Compiling ${NAME} at version: ${KERNEL_VERSION}"
echo ""
make O=out ARCH=arm64 whyred-perf_defconfig
make -j$(nproc --all) O=out ARCH=arm64 CC="${KERNEL}/clang-r377782b/bin/clang" CLANG_TRIPLE="aarch64-linux-gnu-" CROSS_COMPILE="${KERNEL}/gcc/bin/aarch64-linux-android-" CROSS_COMPILE_ARM32="${KERNEL}/gcc32/bin/arm-linux-androideabi-"
END=$(date +"%s")
DIFF=$((END - START))

if [ -f $(pwd)/out/arch/arm64/boot/Image.gz-dtb ]
	then
  	cp $(pwd)/out/arch/arm64/boot/Image.gz-dtb ${KERNEL}/anykernel
  	cd ${KERNEL}/anykernel
  	zip -r9 ${ZIPNAME} *
  	echo "Build Finished in $((DIFF / 60)) minute(s) and $((DIFF % 60)) second(s)."
	curl -F chat_id="${KERNEL_CHAT_ID}" -F document=@"$(pwd)/${ZIPNAME}" https://api.telegram.org/bot${BOT_API_TOKEN}/sendDocument
	curl -s -X POST https://api.telegram.org/bot${BOT_API_TOKEN}/sendMessage -d text="$(md5sum ${ZIPNAME})" -d chat_id=${KERNEL_CHAT_ID} -d parse_mode=HTML
else
  	curl -s -X POST https://api.telegram.org/bot${BOT_API_TOKEN}/sendMessage -d text="${NAME} Build finished with errors..." -d chat_id=${KERNEL_CHAT_ID} -d parse_mode=HTML
    echo "Built with errors! Time Taken: $((DIFF / 60)) minute(s) and $((DIFF % 60)) second(s)."
    exit 1
fi
