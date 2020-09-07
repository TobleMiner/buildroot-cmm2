DOOM for the CMM2
=================

This repo contains DOOM for the CMM2.

Unfortunately both the SPI and USB interface are broken within Linux, thus in addition to the usual
microSD card a CF card is required, too.

# Demo
[![Video of DOOM on the CMM2](/assets/youtube.jpg)](https://www.youtube.com/watch?v=iAf6q5keE7U)

# Prerequisits  
* A CMM2 with 32MiB of SDRAM (tested on https://github.com/Manawyrm/CMM2-JLC)
* A Wii Nunchuk
* A USB A to A cable
* A [pata-gpio](https://github.com/Manawyrm/pata-gpio) adapter
* A linux machine (WSL works, too but is slow)
* The DOOM assets (DOOM.WAD)

# Building  
1. Clone this repository
2. Obtain a release of buildroot (tested with 2020.05.1) from https://buildroot.org/download.html
3. Extract the buildroot environment next to this repository
4. `cd` into the extracted buildroot
4. Setup the buildroot config by running `make BR2_EXTERNAL=../buildroot-cmm2/buildroot/ cmm2_defconfig`
5. Build the system image running `make all`

# Installation

## Bootloader
To support booting Linux u-boot needs to be flashed to the internal flash of the STM32H7 on the CMM2.  
This can be done via the DFU USB bootloader present in the STM. To activate the DFU bootrom, place the
`Boot select` jumper on the lefttmost two pins and press the reset button. Now use the USB A to A cable
to connect the USB A port on the CMM2 to one of your computers USB A ports.
Next flash the bootloader with dfu-util:  
`dfu-util --dfuse-address 0x08000000 -a 0 -D output/images/u-boot.bin`  
Remember to move the jumper back to two rightmost two pins, else the board will not boot.

## Linux
Once the build finished the file `output/images/sdcard.img` contains the system image. `dd` this image
to both the microSD and CF card.

## DOOM assets
Additionally you will need to obtain the `DOOM.WAD` file containing all game assets. Copy it to the root of the
second partition on the CF card.

# Running
Plug both the microSD card and CF card into the CMM2. Connect VGA and the Nunchuk. Power on the CMM2. After
about a minute the system should start loading doom. Loading all assets might take a few additional minutes.

# How to play
The Nunchuk emulates a keyboard.
The Nunchuk to keyboard mappings and the keys functions in DOOM are as follows:

| Nunchuk  | Keyboard   | DOOM     |
|----------|------------|----------|
| Joystick | Arrow keys | Movement |
| C        | ctrl       | Fire     |
| Z        | space      | Interact |
| C+Z      | enter      | Confirm  |

Currently there is now way to swap weapons.
