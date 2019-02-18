
	#pragma once
	
	#include <stdlib.h>

	#include <stdbool.h>

	
	struct Node {
		struct Node *_private_1833293737_link;
		#if CONFIG_WITH_MAGIC
			unsigned _private_609616670_magic;
		#endif
	};

	
	#if CONFIG_WITH_MAGIC
		#define lst_NODE(LINK) { \
			._private_1833293737_link = (LINK), \
			._private_609616670_magic = 1366676419 \
		}
	#else
		#define lst_NODE(LINK) { \
			._private_1833293737_link = (LINK) \
		}
	#endif

	#define lst_EMPTY_NODE lst_NODE(NULL)

	static inline bool isNode(
		const struct Node *node
	) {
		if (! node) { return false; }
		#if CONFIG_WITH_MAGIC
			if (node->_private_609616670_magic !=
				1366676419
			) {
				return false;
			}
		#endif
		return true;
	}

	struct Node *lst_initNode(
		struct Node *node,
		struct Node *link
	)
	#if lst_IMPL
		{
			if (! node) { return NULL; }
			if (link && !isNode(link)) {
				return NULL;
			}
			node->_private_1833293737_link = link;
			#if CONFIG_WITH_MAGIC
				node->_private_609616670_magic = 1366676419;
			#endif
			return node;
		}
	#else
		;
	#endif

	static inline
	struct Node *lst_initEmptyNode(
		struct Node *node
	) {
		return lst_initNode(node, NULL);
	}


	struct List {
		struct Node *_private_1309463449_first;
		struct Node *_private_1287679325_last;
		#if CONFIG_WITH_MAGIC
			unsigned _private_609616670_magic;
		#endif
	};

	
	static inline bool isList(
		const struct List *l
	) {
		if (! l) { return false; }
		#if CONFIG_WITH_MAGIC
			if (l->_private_609616670_magic != 614343215) {
				return false;
			}
		#endif
		return true;
	}

	#if CONFIG_WITH_MAGIC
		#define lst_LIST(FIRST, LAST) { \
			._private_1309463449_first = (FIRST), \
			._private_1287679325_last = (LAST), \
			._private_609616670_magic = 614343215 \
		}
	#else
		#define lst_LIST(FIRST, LAST) { \
			._private_1309463449_first = (FIRST), \
			._private_1287679325_last = (LAST) \
		}
	#endif

	#define lst_EMPTY_LIST lst_LIST(NULL, NULL)

	struct Node *lst_pullFirst(
		struct List *l
	)
	#if lst_IMPL
		{
			if (! isList(l)) { return NULL; }
			struct Node *f = l->_private_1309463449_first;
			if (isNode(f)) {
				
	struct Node *n = f->_private_1833293737_link;
	l->_private_1309463449_first = n;
	if (! n) {
		l->_private_1287679325_last = NULL;
	}
	f->_private_1833293737_link = NULL;
;
				return f;
			} else {
				return NULL;
			}
		}
	#else
		;
	#endif

	void lst_pushLast(
		struct List *l,
		struct Node *n
	)
	#if lst_IMPL
		{
			if (! l || ! n) { return; }
			n->_private_1833293737_link = NULL;
			if (l->_private_1309463449_first) {
				l->_private_1287679325_last->_private_1833293737_link = n;
			} else {
				l->_private_1309463449_first = n;
			}
			l->_private_1287679325_last = n;
		}
	#else
		;
	#endif


