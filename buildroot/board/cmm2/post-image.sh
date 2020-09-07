#!/bin/sh

set -e

BOARD_DIR="$(dirname $0)"

GENIMAGE_TMP="${BUILD_DIR}/genimage.tmp"

MKIMAGE="$HOST_DIR"/bin/mkimage

LOADADDR=0xd0000000

# Create fit image
# Load address and entry point are the same
$MKIMAGE -f auto -A arm -O linux -T kernel -C none -a $LOADADDR -e $LOADADDR \
	 -n linux -d $BINARIES_DIR/zImage -b $BINARIES_DIR/stm32h743ii-cmm2.dtb \
	 $BINARIES_DIR/Image.fit

for devtype in sdcard; do
	# Build boot scripts
	$MKIMAGE -C none -A arm64 -T script -d $BOARD_DIR/boot-${devtype}.txt\
		 $BINARIES_DIR/boot-${devtype}.scr

	# Generate images
	trap 'rm -rf "${ROOTPATH_TMP}"' EXIT
	ROOTPATH_TMP="$(mktemp -d)"

	rm -rf "${GENIMAGE_TMP}"

	genimage \
		--rootpath "${ROOTPATH_TMP}"   \
		--tmppath "${GENIMAGE_TMP}"    \
		--inputpath "${BINARIES_DIR}"  \
		--outputpath "${BINARIES_DIR}" \
		--config "${BOARD_DIR}/genimage-${devtype}.cfg"

	rm -rf "${ROOTPATH_TMP}"
done
