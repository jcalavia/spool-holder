# Makefile for spool-holder
# Generates all STL variants for the filament spool holder.

OPENSCAD ?= openscad

ifeq ($(shell command -v $(OPENSCAD) 2>/dev/null),)
  OPENSCAD := $(firstword $(wildcard /Applications/OpenSCAD*.app/Contents/MacOS/OpenSCAD))
  ifeq ($(OPENSCAD),)
    $(error OpenSCAD not found. Set OPENSCAD=<path> or install with: brew install openscad)
  endif
endif

STL_DIR := stl

# Parametric variants from axle.scad (width via -D override)
STLS := \
	$(STL_DIR)/axle_1kg.stl \
	$(STL_DIR)/axle_200g.stl

# Standalone models
STLS += \
	$(STL_DIR)/axle_1kg_light.stl \
	$(STL_DIR)/axle_test.stl

# Parametric variants from clamp.scad / triangle.scad
STLS += \
	$(STL_DIR)/clamp_izquierda.stl \
	$(STL_DIR)/clamp_derecha.stl \
	$(STL_DIR)/triangle_8.2.stl \
	$(STL_DIR)/triangle_8.5.stl

.PHONY: all clean

all: $(STLS)

$(STL_DIR)/axle_1kg.stl: axle.scad
	@mkdir -p $(STL_DIR)
	$(OPENSCAD) -o "$@" -D 'width=76' "$<"

$(STL_DIR)/axle_200g.stl: axle.scad
	@mkdir -p $(STL_DIR)
	$(OPENSCAD) -o "$@" -D 'width=48' "$<"

$(STL_DIR)/axle_1kg_light.stl: axle_1kg_light.scad
	@mkdir -p $(STL_DIR)
	$(OPENSCAD) -o "$@" "$<"

$(STL_DIR)/axle_test.stl: axle_test.scad
	@mkdir -p $(STL_DIR)
	$(OPENSCAD) -o "$@" "$<"

$(STL_DIR)/clamp_izquierda.stl: clamp.scad
	@mkdir -p $(STL_DIR)
	$(OPENSCAD) -o "$@" -D 'lado_tuerca="izquierda"' "$<"

$(STL_DIR)/clamp_derecha.stl: clamp.scad
	@mkdir -p $(STL_DIR)
	$(OPENSCAD) -o "$@" -D 'lado_tuerca="derecha"' "$<"

$(STL_DIR)/triangle_8.2.stl: triangle.scad
	@mkdir -p $(STL_DIR)
	$(OPENSCAD) -o "$@" -D 'lado="fijo"' "$<"

$(STL_DIR)/triangle_8.5.stl: triangle.scad
	@mkdir -p $(STL_DIR)
	$(OPENSCAD) -o "$@" -D 'lado="libre"' "$<"

clean:
	rm -rf $(STL_DIR) dist/
