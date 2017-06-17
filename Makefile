
# BRANCH name is taken from https://chromium.googlesource.com/chromiumos/manifest/+refs
# The information of release is taken from https://chromereleases.googleblog.com/search/label/Stable%20updates
TARGET = chromiumos
BRANCH = release-R55-8872.B

BOARD_ARM = arm-generic
BOARD_X86 = x86-generic
BOARD_X64 = amd64-generic

NPROC = 4

export PATH := ${PWD}/depot_tools:${PATH}


all: setup images

setup: depot_tools ${TARGET}
	cd depot_tools; git pull origin --rebase
	cd ${TARGET}; repo sync -j${NPROC}

depot_tools:
	git clone https://chromium.googlesource.com/chromium/tools/depot_tools.git

${TARGET}:
	mkdir ${TARGET}
	cd ${TARGET}; repo init -u https://chromium.googlesource.com/chromiumos/manifest.git --repo-url https://chromium.googlesource.com/external/repo.git -b ${BRANCH}

# build packages without debug symbol and with NDEBUG macro
# build images with "test0000" default password
# images are placed under ${TARGET}/src/build/images/

images: arm x86 x64

arm:
	cd ${TARGET}; cros_sdk -- ./build_packages --board=${BOARD_ARM} --nowithdebug
	cd ${TARGET}; cros_sdk -- ./build_image --board=${BOARD_ARM} --noenable_rootfs_verification dev

x86:
	cd ${TARGET}; cros_sdk -- ./build_packages --board=${BOARD_X86} --nowithdebug
	cd ${TARGET}; cros_sdk -- ./build_image --board=${BOARD_X86} --noenable_rootfs_verification dev

x64:
	cd ${TARGET}; cros_sdk -- ./build_packages --board=${BOARD_X64} --nowithdebug
	cd ${TARGET}; cros_sdk -- ./build_image --board=${BOARD_X64} --noenable_rootfs_verification dev

kvm: armk x86k x64k
armk:
	cd ${TARGET}; cros_sdk -- ./image_to_vm.sh --board=${BOARD_ARM}

x86k:
	cd ${TARGET}; cros_sdk -- ./image_to_vm.sh --board=${BOARD_X86}

x64k:
	cd ${TARGET}; cros_sdk -- ./image_to_vm.sh --board=${BOARD_X64}



clean: FORCE
	cd ${TARGET}; cros_sdk --delete

distclean: clean FORCE
	cd ${TARGET}; cros_sdk --delete
	rm -rf depot_tools
	rm -rf ${TARGET}

FORCE:
