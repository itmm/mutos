# Scheduling of Actions

```
D{file: sched.c}
	#define sched_IMPL 1
	#include "sched.h"
x{file: sched.c}
```

```
D{file: sched.h}
	#pragma once
	e{includes}
	e{structs}
x{file: sched.h}
```

```
d{includes}
	#include "act.h"
	#include <stdbool.h>
x{includes}
```

```
d{structs}
	struct Schedule {
		struct List p{list};
		struct Action *p{current};
		#if CONFIG_WITH_MAGIC
			unsigned p{magic};
		#endif
	};

	e{functions}
x{structs}
```

```
d{functions}
	static inline bool isSchedule(
		const struct Schedule *s
	) {
		if (! s) { return false; }
		#if CONFIG_WITH_MAGIC
			if (s->p{magic} != m{schedule}) {
				return false;
			}
		#endif
		return true;
	}
x{functions}
```

```
a{functions}
	#if CONFIG_WITH_MAGIC
		#define sched_SCHEDULE(LST) { \
			.p{list} = LST, \
			.p{current} = NULL, \
			.p{magic} = m{schedule} \
		}
	#else
		#define sched_SCHEDULE(LST) { \
			.p{list} = LST, \
			.p{current} = NULL \
		}
	#endif
x{functions}
```

```
a{functions}
	#define sched_EMPTY_SCHEDULE \
		sched_SCHEDULE(lst_EMPTY_LIST)
x{functions}
```

```
a{functions}
	bool sched_runNextAction(
		struct Schedule *s
	)
	#if sched_IMPL
		{
			if (! isSchedule(s)) { return false; }
			struct Action *a = (void *)
				lst_pullFirst(&s->p{list});
			bool done = false;
			if (isAction(a)) {
				if (invokeAction(s, a)) { 
					done = true;
				}
			}
			freeAction(a);
			return done;
		}
	#else
		;
	#endif
x{functions}
```

```
a{functions}
	bool sched_push(
		struct Schedule *s, struct Action *a
	)
	#if sched_IMPL
		{
			if (! isSchedule(s)) { return false; }
			if (! isAction(a)) { return false; }
			lst_pushLast(&s->p{list}, (void *) a);
			return true;
		}
	#else
		;
	#endif
x{functions}
```

