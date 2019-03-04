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
		struct Node @priv(node);
		act_Callback @priv(callback);
		act_Free @priv(free);
		#if CONFIG_WITH_MAGIC
			unsigned @priv(magic);
		#endif
	};

	@put(functions)
@end(structs)
```

```
@def(functions)
	#if CONFIG_WITH_MAGIC
		#define act_ACTION(CB, FREE) { \
			.@priv(node) = lst_EMPTY_NODE, \
			.@priv(callback) = (CB), \
			.@priv(free) = (FREE), \
			.@priv(magic) = @magic(action) \
		}
	#else
		#define act_ACTION(CB, FREE) { \
			.@priv(node) = lst_EMPTY_NODE, \
			.@priv(callback) = (CB), \
			.@priv(free) = (FREE) \
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
			if (a->@priv(magic) !=
				@magic(action)
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
			a->@priv(callback) = cb;
			a->@priv(free) = free;
			#if CONFIG_WITH_MAGIC
				a->@priv(magic) = @magic(action);
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
			act_Callback cb = a->@priv(callback);
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
				act_Free f = a->@priv(free);
				if (f) { f(a); }
			}
		}
	#else
		;
	#endif
@end(functions)
```

