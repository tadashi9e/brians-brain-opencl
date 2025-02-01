CXX_FLAGS=-Wall -D__CL_ENABLE_EXCEPTIONS -DCL_HPP_TARGET_OPENCL_VERSION=220

all: brians_brain

brians_brain: brians_brain.cpp
	g++ $(CXX_FLAGS) brians_brain.cpp -o brians_brain -g -lglut -lGLEW -lGLU -lGL `pkg-config --libs --cflags OpenCL`

clean:
	rm -rf brians_brain
