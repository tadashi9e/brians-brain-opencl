# Brian's Brain

Brian's Brain is a cellular automaton devised by Brian Silverman.

# Rules

- For a cell in the "ON" state, change its state to "DYING".
- For a cell in the "DYING" state, change its state to "OFF".
- For a cell in the "OFF" state, if it has exactly two neighbors in the "ON" state, change its state to "ON".

# Requirement

- OpenCL
- OpenGL
- FreeGLUT

# Files

- brians_brain.cpp
- brians_brain_kernel.cl
- Makefile

# Execution

```
brians_brain [-d device] [-w width] [-h height] [-i interval_millis] [-P]
 -d, --device    : Select compute device.
 -w, --width     : Field width.
 -h, --height    : Field height.
 -i, --interval  : Step interval in milli seconds.
 -P, --pause     : Pause at start. Will be released by 'p' key.
```
