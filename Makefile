CXXFLAGS=-g -Wall `pkg-config --cflags OpenCL opengl glut glew`
LDFLAGS=`pkg-config --libs OpenCL opengl glut glew`

all: brians_brain

brians_brain: brians_brain.cpp
	g++ $(CXXFLAGS) brians_brain.cpp -o brians_brain $(LDFLAGS)

clean:
	rm -rf brians_brain
