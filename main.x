# Main

```
d{file: main.c}
	#include "sched.h"
	#include <assert.h>
	#include <stdio.h>

	static void writeCtx(struct Schedule *s, void *ctx) {
		puts(ctx);
	}

	int main() {
		struct Schedule sched = sched_EMPTY_SCHEDULE;
		assert(sched_push(&sched, writeCtx, "first"));
		assert(sched_push(&sched, writeCtx, "second"));
		while (sched_runNextAction(&sched)) {}
	}
x{file: main.c}
```
