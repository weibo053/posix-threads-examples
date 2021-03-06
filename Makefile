# makefie
CFLAGS=-g -pthread
LDLIBS=-lm


binaries= fork_ex thread_ex summation mandelbrot charfrequency\
	threadparam
images= colour-mandelbrot.png
run= count

all: $(binaries) $(images) $(run)

mandelbrot.png: PATH:=.:$(PATH)
mandelbrot.png: mandelbrot 
	mandelbrot | convert txt:- mandelbrot.png

# These two need ImageMagick installed
# to install
# sudo apt -q -y install imagemagick
colourmap.png: 
	convert xc:black xc:red xc:yellow xc:green1 \
		xc:cyan xc:blue xc:black +append \
		-filter Cubic -resize 256x1\! colourmap.png 
colour-mandelbrot.png: mandelbrot.png colourmap.png
	convert mandelbrot.png \( colourmap.png \) -clut colour-mandelbrot.png

count: PATH:=.:$(PATH)
count: charfrequency
	charfrequency the-sign-of-four.txt

.PHONY: clean
clean:
	rm -f $(binaries)
	rm -f $(images)
