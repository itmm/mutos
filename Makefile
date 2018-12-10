.PHONY: clean test

CFLAGS += -Wall -std=c11

Xs := $(wildcard *.x)
SOURCEs := $(shell grep 'd{file: ' $(Xs) /dev/null | cut '-d{' -f2 | cut '-d}' -f1 | cut '-d ' -f2 |sort -u)
SOURCEs += $(shell grep 'D{file: ' $(Xs) </dev/null | cut '-d{' -f2 | cut '-d}' -f1 | cut '-d ' -f2 |sort -u)
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
