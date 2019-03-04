# Scheduling of Actions

```
@Def(file: sched.c)
	#define sched_IMPL 1
	#include "sched.h"
@end(file: sched.c)
```

```
@Def(file: sched.h)
	#pragma once
	@put(includes)
	@put(structs)
@end(file: sched.h)
```

```
@def(includes)
	#include "act.h"
	#include <stdbool.h>
@end(includes)
```

```
@def(structs)
	struct Schedule {
		struct List @priv(list);
		struct Action *@priv(current);
		#if CONFIG_WITH_MAGIC
			unsigned @priv(magic);
		#endif
	};

	@put(functions)
@end(structs)
```

```
@def(functions)
	static inline bool isSchedule(
		const struct Schedule *s
	) {
		if (! s) { return false; }
		#if CONFIG_WITH_MAGIC
			if (s->@priv(magic) != @magic(schedule)) {
				return false;
			}
		#endif
		return true;
	}
@end(functions)
```

```
@add(functions)
	#if CONFIG_WITH_MAGIC
		#define sched_SCHEDULE(LST) { \
			.@priv(list) = LST, \
			.@priv(current) = NULL, \
			.@priv(magic) = @magic(schedule) \
		}
	#else
		#define sched_SCHEDULE(LST) { \
			.@priv(list) = LST, \
			.@priv(current) = NULL \
		}
	#endif
@end(functions)
```

```
@add(functions)
	#define sched_EMPTY_SCHEDULE \
		sched_SCHEDULE(lst_EMPTY_LIST)
@end(functions)
```

```
@add(functions)
	bool sched_runNextAction(
		struct Schedule *s
	)
	#if sched_IMPL
		{
			if (! isSchedule(s)) { return false; }
			struct Action *a = (void *)
				lst_pullFirst(&s->@priv(list));
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
@end(functions)
```

```
@add(functions)
	bool sched_push(
		struct Schedule *s, struct Action *a
	)
	#if sched_IMPL
		{
			if (! isSchedule(s)) { return false; }
			if (! isAction(a)) { return false; }
			lst_pushLast(&s->@priv(list), (void *) a);
			return true;
		}
	#else
		;
	#endif
@end(functions)
```

