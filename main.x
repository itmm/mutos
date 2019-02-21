# Main

```
@def(file: main.c)
	#include "sched.h"
	#include <assert.h>
	#include <stdio.h>

	struct WriteCtx {
		struct Action a;
		const char *str;
	};

	static void writeCtx(struct Schedule *s, struct Action *a) {
		struct WriteCtx *ctx = (void *) a;
		puts(ctx->str);
	}

	#define WRITE_CTX(S) { act_ACTION(writeCtx, NULL), (S) }

	int main() {
		struct Schedule sched = sched_EMPTY_SCHEDULE;
		assert(isSchedule(&sched));
		struct WriteCtx first = WRITE_CTX("first");
		struct WriteCtx second = WRITE_CTX("second");
		assert(sched_push(&sched, &first.a));
		assert(sched_push(&sched, &second.a));
		while (sched_runNextAction(&sched)) {}
	}
@end(file: main.c)
```
