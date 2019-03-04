
	#pragma once
	
	#include "lst.h"

	
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
		struct Node _private_255765309_priv;
		act_Callback _private_1916829317_priv;
		act_Free _private_685688864_priv;
		#if CONFIG_WITH_MAGIC
			unsigned _private_1769794728_priv;
		#endif
	};

	
	#if CONFIG_WITH_MAGIC
		#define act_ACTION(CB, FREE) { \
			._private_255765309_priv = lst_EMPTY_NODE, \
			._private_1916829317_priv = (CB), \
			._private_685688864_priv = (FREE), \
			._private_1769794728_priv = 303363249 \
		}
	#else
		#define act_ACTION(CB, FREE) { \
			._private_255765309_priv = lst_EMPTY_NODE, \
			._private_1916829317_priv = (CB), \
			._private_685688864_priv = (FREE) \
		}
	#endif

	static inline bool isAction(
		const struct Action *a
	) {
		if (! a) { return false; }
		#if CONFIG_WITH_MAGIC
			if (a->_private_1769794728_priv !=
				303363249
			) {
				return false;
			}
		#endif
		return true;
	}

	struct Action *initAction(
		struct Action *a,
		act_Callback cb,
		act_Free free
	)
	#if act_IMPL
		{
			if (! a) { return NULL; }
			if (! cb) { return NULL; }
			a->_private_1916829317_priv = cb;
			a->_private_685688864_priv = free;
			#if CONFIG_WITH_MAGIC
				a->_private_1769794728_priv = 303363249;
			#endif
			return a;
		}
	#else
		;
	#endif

	bool invokeAction(
		struct Schedule *s,
		struct Action *a
	)
	#if act_IMPL
		{
			if (! s) { return false; }
			if (! isAction(a)) { return false; }
			act_Callback cb = a->_private_1916829317_priv;
			if (! cb) { return false; }
			cb(s, a);
			return true;
		}
	#else
		;
	#endif

	void freeAction(struct Action *a)
	#if act_IMPL
		{
			if (isAction(a)) {
				act_Free f = a->_private_685688864_priv;
				if (f) { f(a); }
			}
		}
	#else
		;
	#endif


