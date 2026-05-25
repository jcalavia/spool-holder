OPENSCAD ?= openscad

VARIANTS = axle_200g axle_1kg
STLS     = $(addsuffix .stl,$(VARIANTS))
SCAD     = axle.scad

axle_200g.stl: width := 48
axle_1kg.stl:  width := 76

.PHONY: all clean

all: $(STLS)

$(STLS): $(SCAD)
	$(OPENSCAD) -D 'width=$(width)' -o $@ $<

clean:
	rm -f $(STLS)
