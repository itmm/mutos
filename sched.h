
	#pragma once
	
	#include "lst.h"

	
	struct Schedule;

	typedef void (* act_Callback)(
		struct Schedule *schedule,
		void *context
	);

	struct Action {
		struct lst_Node _private_297147900_node;
		act_Callback _private_114034139_callback;
		void *_private_1629340707_context;
		#if CONFIG_WITH_MAGIC
			unsigned _private_230416164_magic;
		#endif
	};

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
			if (! a) { return false; }
			act_Callback cb = a->_private_114034139_callback;
			if (cb) {
				cb(s, a->_private_1629340707_context);
				return true;
			}
			free(a);
			return cb;
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
			struct Action *a = malloc(
				sizeof(struct Action)
			);
			if (! a) { return false; }
			a->_private_114034139_callback = cb;
			a->_private_1629340707_context = ctx;
			lst_pushLast(&s->_private_297228220_list, &a->_private_297147900_node);
			return true;
		}
	#else
		;
	#endif


