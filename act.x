# Actions

```
D{file: act.c}
	#define act_IMPL 1
	#include "act.h"
x{file: act.c}
```

```
D{file: act.h}
	#pragma once
	e{includes}
	e{structs}
x{file: act.h}
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

	e{functions}
x{structs}
```

```
d{functions}
	static inline bool isAction(
		const struct Action *a
	) {
		if (! a) { return false; }
		#if CONFIG_WITH_MAGIC
			if (a->p{magic} !=
				m{action}
			) {
				return false;
			}
		#endif
		return true;
	}
x{functions}
```

```
a{functions}
	static inline
	struct Action *initAction(
		struct Action *a,
		act_Callback cb,
		void *ctx
	) {
		if (! a) { return NULL; }
		if (! cb) { return NULL; }
		a->p{callback} = cb;
		a->p{context} = ctx;
		#if CONFIG_WITH_MAGIC
			a->p{magic} = m{action};
		#endif
		return a;
	}
x{functions}
```

```
a{functions}
	bool invokeAction(
		struct Schedule *s,
		struct Action *a
	)
	#if act_IMPL
		{
			if (! s) { return false; }
			if (! isAction(a)) { return false; }
			act_Callback cb = a->p{callback};
			if (! cb) { return false; }
			cb(s, a->p{context});
			return true;
		}
	#else
		;
	#endif
x{functions}
```

