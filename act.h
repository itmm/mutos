
	#pragma once
	
	#include "lst.h"

	
	struct Schedule;

	typedef void (* act_Callback)(
		struct Schedule *schedule,
		void *context
	);

	struct Action {
		struct lst_Node _private_1735900598_node;
		act_Callback _private_482912951_callback;
		void *_private_1650282958_context;
		#if CONFIG_WITH_MAGIC
			unsigned _private_1001839987_magic;
		#endif
	};

	
	static inline bool isAction(
		const struct Action *a
	) {
		if (! a) { return false; }
		#if CONFIG_WITH_MAGIC
			if (a->_private_1001839987_magic !=
				1547135001
			) {
				return false;
			}
		#endif
		return true;
	}

	static inline
	struct Action *initAction(
		struct Action *a,
		act_Callback cb,
		void *ctx
	) {
		if (! a) { return NULL; }
		if (! cb) { return NULL; }
		a->_private_482912951_callback = cb;
		a->_private_1650282958_context = ctx;
		#if CONFIG_WITH_MAGIC
			a->_private_1001839987_magic = 1547135001;
		#endif
		return a;
	}

	bool invokeAction(
		struct Schedule *s,
		struct Action *a
	)
	#if act_IMPL
		{
			if (! s) { return false; }
			if (! isAction(a)) { return false; }
			act_Callback cb = a->_private_482912951_callback;
			if (! cb) { return false; }
			cb(s, a->_private_1650282958_context);
			return true;
		}
	#else
		;
	#endif


