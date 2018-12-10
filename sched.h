
	#pragma once
	
	#include "act.h"

	
	struct Schedule {
		struct lst_List _private_297228220_list;
		#if CONFIG_WITH_MAGIC
			unsigned _private_230416164_magic;
		#endif
	};

	
	#if CONFIG_WITH_MAGIC
		#define sched_SCHEDULE(LST) { \
			._private_297228220_list = LST, \
			.1783542926 \
		}
	#else
		#define sched_SCHEDULE(LST) { \
			._private_297228220_list = LST \
		}
	#endif

	#define sched_EMPTY_SCHEDULE \
		sched_SCHEDULE(lst_EMPTY_LIST)

	bool sched_runNextAction(
		struct Schedule *s
	)
	#if sched_IMPL
		{
			if (! s) { return false; }
			struct Action *a = (void *)
				lst_pullFirst(&s->_private_297228220_list);
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

	bool sched_push(
		struct Schedule *s,
		act_Callback cb,
		void *ctx
	) 
	#if sched_IMPL
		{
			if (! s || ! cb) { return false; }
			struct Action *a = allocAction(cb, ctx);
			if (! a) { return false; }
			lst_pushLast(&s->_private_297228220_list, (void *) a);
			return true;
		}
	#else
		;
	#endif


