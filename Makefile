.PHONY: compile clean

ERLC_FLAGS ?= -Wall -I include +debug_info

SRC	:= $(wildcard src/*.erl)
BEAMS := $(SRC:src/%.erl=ebin/%.beam)
APP_SRC := $(wildcard src/*.app.src)
APP := $(APP_SRC:src/%.app.src=ebin/%.app)
EBIN := $(CURDIR)/ebin

all: compile

compile: $(EBIN) $(BEAMS) $(APP)

clean:
	@rm -f ebin/*.app
	@rm -f $(BEAMS)

$(EBIN):
	-mkdir $@

ebin/%.beam : src/%.erl
	erlc $(ERLC_FLAGS) -o $(dir $@) $<

ebin/%.app : src/%.app.src
	cat $< > $@
