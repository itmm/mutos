.PHONY: clean test

CFLAGS += -Wall -std=c11
CFLAGS += -DCONFIG_WITH_MAGIC

Xs := $(wildcard *.x)
SOURCEs := $(shell hx-files.sh $(Xs))
GENs := $(SOURCEs)
GENs += $(Xs:.x=.html)
GENs += hx.run
OBJs := $(filter %.o, $(SOURCEs:.c=.o))

test: mutos
	./mutos

mutos: $(OBJs)
	$(CC) $(CFLAGS) $^ -o $@

hx.run: $(Xs)
	touch hx.run
	hx

$(SOURCEs): hx.run

clean:
	rm -f $(GENs) $(OBJs)
