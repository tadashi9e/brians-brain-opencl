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
