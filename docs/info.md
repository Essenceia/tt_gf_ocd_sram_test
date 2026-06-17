<!---

This file is used to generate your project datasheet. Please fill in the information below and delete any unused
sections.

You can also include images in this folder and reference them in the markdown. Each image must be less than
512 kb in size, and the combined size of all images must be less than 1 MB.
-->

Open Circuit Design 256x8 SRAM for gf180 test. 

## How it works

SRAM is entirely cleared on reset. 

Although this is technically an 256x8 SRAM only the top 128 entries are addressable. 
There are 6 bits of address, 8 bits of input data and 8 bits of output data. 
Toggle `wen` to write, else SRAM will be in read mode. 

Beware, incomming data/write enable/address are flopped once before the SRAM and outgoing data is also flopped once 
before reaching the `uo_out` pins. 

## How to test

See above. 

## External hardware

None
