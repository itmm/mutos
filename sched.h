
	#pragma once
	
	#include "act.h"
	#include <stdbool.h>

	
	struct Schedule {
		struct List _private_1129700641_priv;
		struct Action *_private_388766463_priv;
		#if CONFIG_WITH_MAGIC
			unsigned _private_71151907_priv;
		#endif
	};

	
	static inline bool isSchedule(
		const struct Schedule *s
	) {
		if (! s) { return false; }
		#if CONFIG_WITH_MAGIC
			if (s->_private_71151907_priv != 622131201) {
				return false;
			}
		#endif
		return true;
	}

	#if CONFIG_WITH_MAGIC
		#define sched_SCHEDULE(LST) { \
			._private_1129700641_priv = LST, \
			._private_388766463_priv = NULL, \
			._private_71151907_priv = 622131201 \
		}
	#else
		#define sched_SCHEDULE(LST) { \
			._private_1129700641_priv = LST, \
			._private_388766463_priv = NULL \
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
				lst_pullFirst(&s->_private_1129700641_priv);
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
			lst_pushLast(&s->_private_1129700641_priv, (void *) a);
			return true;
		}
	#else
		;
	#endif


