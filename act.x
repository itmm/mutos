# Actions

```
@Def(file: act.c)
	#define act_IMPL 1
	#include "act.h"
@end(file: act.c)
```

```
@Def(file: act.h)
	#pragma once
	@put(includes)
	@put(structs)
@end(file: act.h)
```

# Action

```
@def(includes)
	#include "lst.h"
@end(includes)
```

```
@def(structs)
	struct Schedule;
	struct Action;

	typedef void (* act_Callback)(
		struct Schedule *schedule,
		struct Action *action
	);

	typedef void (* act_Free)(
		struct Action *action
	);

	struct Action {
		struct Node p{node};
		act_Callback p{callback};
		act_Free p{free};
		#if CONFIG_WITH_MAGIC
			unsigned p{magic};
		#endif
	};

	@put(functions)
@end(structs)
```

```
@def(functions)
	#if CONFIG_WITH_MAGIC
		#define act_ACTION(CB, FREE) { \
			.p{node} = lst_EMPTY_NODE, \
			.p{callback} = (CB), \
			.p{free} = (FREE), \
			.p{magic} = m{action} \
		}
	#else
		#define act_ACTION(CB, FREE) { \
			.p{node} = lst_EMPTY_NODE, \
			.p{callback} = (CB), \
			.p{free} = (FREE) \
		}
	#endif
@end(functions)
```

```
@add(functions)
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
@end(functions)
```

```
@add(functions)
	struct Action *initAction(
		struct Action *a,
		act_Callback cb,
		act_Free free
	)
	#if act_IMPL
		{
			if (! a) { return NULL; }
			if (! cb) { return NULL; }
			a->p{callback} = cb;
			a->p{free} = free;
			#if CONFIG_WITH_MAGIC
				a->p{magic} = m{action};
			#endif
			return a;
		}
	#else
		;
	#endif
@end(functions)
```

```
@add(functions)
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
			cb(s, a);
			return true;
		}
	#else
		;
	#endif
@end(functions)
```

```
@add(functions)
	void freeAction(struct Action *a)
	#if act_IMPL
		{
			if (isAction(a)) {
				act_Free f = a->p{free};
				if (f) { f(a); }
			}
		}
	#else
		;
	#endif
@end(functions)
```

