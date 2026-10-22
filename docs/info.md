<!---
This file is used to generate your project datasheet.
-->

## How it works

Four independent 8 bit PWM outputs sharing one free running 8 bit counter.

- A counter increments every clock and wraps 255 -> 0. Reset clears it and all duty registers.
- Write a duty value: put the value on `ui_in`, the channel number on `uio_in[2:1]`, and pulse `uio_in[0]` (WE) high for one clock.
  The new duty takes effect from the next clock.
- `uo_out[ch]` is high while `counter < duty[ch]`, so duty 0 is always low and duty 255 is high 255 of 256 clocks.
- `uo_out[7:4]` are 0. All `uio` pins are inputs (`uio_oe` = 0).

## How to test

The cocotb test in `test/` drives random inputs every clock and compares all outputs with the cycle-level Python reference model `test/model.py`. Run it with `cd test && make` (RTL) or `make GATES=yes` (gate level).

## Verification (chip-lab)

- RTL and Yosys netlist simulation: 8997 cycles bit exact against the model
- Mutation test: 5/5 injected faults caught
- sky130 pre-layout area 1,718 um2, predicted 1x1 tile
- Pre-layout setup slack at ss 100C 1.60V, 50 MHz: +11.40 ns

## External hardware

None.
