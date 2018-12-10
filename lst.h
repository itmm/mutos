
	#pragma once
	
	#include <stdlib.h>

	#include <stdbool.h>

	#include <assert.h>

	
	struct lst_Node {
		struct lst_Node *_private_662096437_link;
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

	static inline bool lst_isNode(
		const struct lst_Node *node
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

	static inline
	struct lst_Node *lst_initNode(
		struct lst_Node *node,
		struct lst_Node *link
	) {
		assert(node);
		if (link) { assert(lst_isNode(link)); }
		node->_private_662096437_link = link;
		return node;
	}

	static inline
	struct lst_Node *lst_initEmptyNode(
		struct lst_Node *node
	) {
		return lst_initNode(node, NULL);
	}


	struct lst_List {
		struct lst_Node *_private_1000324269_first;
		struct lst_Node *_private_662075381_last;
		#if CONFIG_WITH_MAGIC
			unsigned _private_1001839981_magic;
		#endif
	};

	
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

	struct lst_Node *lst_pullFirst(
		struct lst_List *l
	)
	#if lst_IMPL
		{
			if (! l) { return NULL; }
			struct lst_Node *f = l->_private_1000324269_first;
			if (f) {
				struct lst_Node *n =
					f->_private_662096437_link;
				l->_private_1000324269_first = n;
				if (! n) {
					l->_private_662075381_last = NULL;
				}
			}
			return f;
		}
	#else
		;
	#endif

	void lst_pushLast(
		struct lst_List *l,
		struct lst_Node *n
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


