
	#pragma once
	
	#include "act.h"
	#include <stdbool.h>

	
	struct Schedule {
		struct List _private_297228220_list;
		struct Action *_private_1647241251_current;
		#if CONFIG_WITH_MAGIC
			unsigned _private_230416164_magic;
		#endif
	};

	
	static inline bool isSchedule(
		const struct Schedule *s
	) {
		if (! s) { return false; }
		#if CONFIG_WITH_MAGIC
			if (s->_private_230416164_magic != 74078299) {
				return false;
			}
		#endif
		return true;
	}

	#if CONFIG_WITH_MAGIC
		#define sched_SCHEDULE(LST) { \
			._private_297228220_list = LST, \
			._private_1647241251_current = NULL, \
			._private_230416164_magic = 74078299 \
		}
	#else
		#define sched_SCHEDULE(LST) { \
			._private_297228220_list = LST, \
			._private_1647241251_current = NULL \
		}
	#endif

	#define sched_EMPTY_SCHEDULE \
		sched_SCHEDULE(lst_EMPTY_LIST)

	bool sched_runNextAction(
		struct Schedule *s
	)
	#if sched_IMPL
		{
			if (! isSchedule(s)) { return false; }
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
		struct Schedule *s, struct Action *a
	)
	#if sched_IMPL
		{
			if (! isSchedule(s)) { return false; }
			if (! isAction(a)) { return false; }
			lst_pushLast(&s->_private_297228220_list, (void *) a);
			return true;
		}
	#else
		;
	#endif


