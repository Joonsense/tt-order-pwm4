# 4 channel PWM controller

![gds](https://github.com/Joonsense/tt-order-pwm4/actions/workflows/gds.yaml/badge.svg) ![test](https://github.com/Joonsense/tt-order-pwm4/actions/workflows/test.yaml/badge.svg) ![docs](https://github.com/Joonsense/tt-order-pwm4/actions/workflows/docs.yaml/badge.svg)

Tiny Tapeout project `tt_um_joonsense_pwm4`, designed with the [chip-lab order flow](https://joonsense.github.io/chip-order/): a written spec and a cycle-level Python model went in, this repository came out.

## Spec

Four independent 8 bit PWM outputs sharing one free running 8 bit counter.

- A counter increments every clock and wraps 255 -> 0. Reset clears it and all duty registers.
- Write a duty value: put the value on `ui_in`, the channel number on `uio_in[2:1]`, and pulse `uio_in[0]` (WE) high for one clock.
  The new duty takes effect from the next clock.
- `uo_out[ch]` is high while `counter < duty[ch]`, so duty 0 is always low and duty 255 is high 255 of 256 clocks.
- `uo_out[7:4]` are 0. All `uio` pins are inputs (`uio_oe` = 0).

## Pins

| Pin | Signal |
|---|---|
| `ui[0]` | DUTY0 |
| `ui[1]` | DUTY1 |
| `ui[2]` | DUTY2 |
| `ui[3]` | DUTY3 |
| `ui[4]` | DUTY4 |
| `ui[5]` | DUTY5 |
| `ui[6]` | DUTY6 |
| `ui[7]` | DUTY7 |
| `uo[0]` | PWM0 |
| `uo[1]` | PWM1 |
| `uo[2]` | PWM2 |
| `uo[3]` | PWM3 |
| `uio[0]` | WE |
| `uio[1]` | CH0 |
| `uio[2]` | CH1 |

## Verification

| Check | Result |
|---|---|
| RTL vs model (`test/model.py`) | 8,997 cycles bit exact, 3 seeds, mid run reset |
| Yosys netlist vs model | 8,997 cycles bit exact |
| Mutation test | 5/5 injected faults caught |
| sky130 pre-layout | 1,718 um2, 217 cells, predicted 1x1 |

Placement, routing, DRC, LVS and the gate level test run in this repository's GitHub Actions (badges above).

## Test it

```bash
cd test
pip install -r requirements.txt
make            # RTL against the Python model
```

Not fabricated yet. Tiny Tapeout tiles are bought per shuttle at app.tinytapeout.com.
