buildroot external tree
=======================

This directory contains a buildroot external tree for the CMM2.
Clone this repo next to your buildroot tree.

Use this tree by specifying it in the buildroot build command:

`make BR2_EXTERNAL=../buildroot-cmm2/buildroot/ menuconfig`
