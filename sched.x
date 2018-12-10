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

# Action

```
d{includes}
	#include "lst.h"
x{includes}
```

```
d{structs}
	struct Schedule;

	typedef void (* act_Callback)(
		struct Schedule *schedule,
		void *context
	);

	struct Action {
		struct lst_Node p{node};
		act_Callback p{callback};
		void *p{context};
		#if CONFIG_WITH_MAGIC
			unsigned p{magic};
		#endif
	};
x{structs}
```

```
a{structs}
	struct Schedule {
		struct lst_List p{list};
		#if CONFIG_WITH_MAGIC
			unsigned p{magic};
		#endif
	};

	e{schedule functions}
x{structs}
```

```
d{schedule functions}
	#if CONFIG_WITH_MAGIC
		#define sched_SCHEDULE(LST) { \
			.p{list} = LST, \
			.p{magic) = m{schedule} \
		}
	#else
		#define sched_SCHEDULE(LST) { \
			.p{list} = LST \
		}
	#endif
x{schedule functions}
```

```
a{schedule functions}
	#define sched_EMPTY_SCHEDULE \
		sched_SCHEDULE(lst_EMPTY_LIST)
x{schedule functions}
```

```
a{schedule functions}
	bool sched_runNextAction(
		struct Schedule *s
	)
	#if sched_IMPL
		{
			if (! s) { return false; }
			struct Action *a = (void *)
				lst_pullFirst(&s->p{list});
			if (! a) { return false; }
			act_Callback cb = a->p{callback};
			if (cb) {
				cb(s, a->p{context});
				return true;
			}
			free(a);
			return cb;
		}
	#else
		;
	#endif
x{schedule functions}
```

```
a{schedule functions}
	bool sched_push(
		struct Schedule *s,
		act_Callback cb,
		void *ctx
	) 
	#if sched_IMPL
		{
			if (! s || ! cb) { return false; }
			struct Action *a = malloc(
				sizeof(struct Action)
			);
			if (! a) { return false; }
			a->p{callback} = cb;
			a->p{context} = ctx;
			lst_pushLast(&s->p{list}, &a->p{node});
			return true;
		}
	#else
		;
	#endif
x{schedule functions}
```
