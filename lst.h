
	#pragma once
	
	#include <stdlib.h>

	#include <stdbool.h>

	
	struct Node {
		struct Node *_private_662096437_link;
		#if CONFIG_WITH_MAGIC
			unsigned _private_1001839981_magic;
		#endif
	};

	
	#if CONFIG_WITH_MAGIC
		#define lst_NODE(LINK) { \
			._private_662096437_link = (LINK), \
			._private_1001839981_magic = 662158773 \
		}
	#else
		#define lst_NODE(LINK) { \
			._private_662096437_link = (LINK) \
		}
	#endif

	#define lst_EMPTY_NODE lst_NODE(NULL)

	static inline bool isNode(
		const struct Node *node
	) {
		if (! node) { return false; }
		#if CONFIG_WITH_MAGIC
			if (node->_private_1001839981_magic !=
				662158773
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
			node->_private_662096437_link = link;
			#if CONFIG_WITH_MAGIC
				node->_private_1001839981_magic = 662158773;
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
		struct Node *_private_1000324269_first;
		struct Node *_private_662075381_last;
		#if CONFIG_WITH_MAGIC
			unsigned _private_1001839981_magic;
		#endif
	};

	
	static inline bool isList(
		const struct List *l
	) {
		if (! l) { return false; }
		#if CONFIG_WITH_MAGIC
			if (l->_private_1001839981_magic != 662108149) {
				return false;
			}
		#endif
		return true;
	}

	#if CONFIG_WITH_MAGIC
		#define lst_LIST(FIRST, LAST) { \
			._private_1000324269_first = (FIRST), \
			._private_662075381_last = (LAST), \
			._private_1001839981_magic = 662108149 \
		}
	#else
		#define lst_LIST(FIRST, LAST) { \
			._private_1000324269_first = (FIRST), \
			._private_662075381_last = (LAST) \
		}
	#endif

	#define lst_EMPTY_LIST lst_LIST(NULL, NULL)

	struct Node *lst_pullFirst(
		struct List *l
	)
	#if lst_IMPL
		{
			if (! isList(l)) { return NULL; }
			struct Node *f = l->_private_1000324269_first;
			if (isNode(f)) {
				
	struct Node *n = f->_private_662096437_link;
	l->_private_1000324269_first = n;
	if (! n) {
		l->_private_662075381_last = NULL;
	}
	f->_private_662096437_link = NULL;
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
			n->_private_662096437_link = NULL;
			if (l->_private_1000324269_first) {
				l->_private_662075381_last->_private_662096437_link = n;
			} else {
				l->_private_1000324269_first = n;
			}
			l->_private_662075381_last = n;
		}
	#else
		;
	#endif


