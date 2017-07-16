# chromeos-build
A tool to build Chrome OS easily

## Prerequisites
Prerequisites are described [here](https://www.chromium.org/chromium-os/developer-guide).

I'll list them for the ease.  **Bold** means new or different prerequisities from above public.  I noticed them through my experience.

- ubuntu **16.04 works**
- x86_64 64 bit system
- an account with sudo access
- **4~16** GB RAM for arm and x86.  **16~32** GB RAM for amd64.  (This means I could not compile it correctly with smaller number of RAM but could with larger number of RAM)
- git and curl
- configure git
- tweak sudoers for **400** minutes (My machine takes more than 180 min for compilation)

## Setup
Type following command to prepare depo_tools and sources.

```
$ make setup
```

## Usage
Type following command to create images for all architectures.  This takes a day or more for me.

```
$ make images
```

You can create images for architecures you need only by following command.

```
$ make arm | x86 | x64
```

## How to convert raw image to qcow2 image

```
$ qemu-img convert -f raw -O qcow2 chromiumos_qemu_image-R55-8872.76-amd64-generic.img chromiumos_qemu_image-R55-8872.76-amd64-generic.qcow2
```

## How to run Chromium OS on KVM

Create VM using GUI manager.  It is required to use **cirrius** VGA.

## Releases
You can download pre-compiled image through [release page](https://github.com/jam7/chromeos-build/releases)

## References
[a list of released chromebook](https://www.chromium.org/chromium-os/developer-information-for-chrome-os-devices)
[developer guide](https://www.chromium.org/chromium-os/developer-guide)
