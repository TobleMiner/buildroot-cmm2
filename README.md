DOOM for the CMM2
=================

This repo contains Doom for the CMM2.

Unfortunately the SPI interface is broken within Linux, thus in addition to the usual microSD card a CF card is
required, too.

# Demo
[![Video of DOOM on the CMM2](/assets/youtube.jpg)](https://www.youtube.com/watch?v=iAf6q5keE7U)

# Prerequisits  
* A CMM2 with 32MiB of SDRAM
* A Wii Nunchuk
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
Once the build finished the file `output/images/sdcard.img` contains the system image. `dd` those images
to both the microSD and CF card.
Additionally you will need to obtain the `DOOM.WAD` file containing all game assets. Copy it to the root of the
second partition on the CF card.

# Running
Plug both the microSD card and CF card into the CMM2. Connect VGA and the Nunchuk. Power on the CMM2. After
about a minute the system should start loading doom. Be patient, loading the DOOM assets takes some time.
