
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
			._private_1001839981_magic = 1962834743 \
		}
	#else
		#define lst_NODE(LINK) { \
			._private_662096437_link = (LINK} \
		}
	#endif

	#define lst_EMPTY_NODE lst_NODE(NULL)

	static inline bool lst_isNode(
		const struct lst_Node *node
	) {
		if (! node) { return false; }
		#if CONFIG_WITH_MAGIC
			if (node->_private_1001839981_magic != 1962834743) {
				return false;
			}
		#endif
		return true;
	}

	static inline struct lst_Node *lst_initNode(
		struct lst_Node *node,
		struct lst_Node *link
	) {
		assert(node);
		if (link) { assert(lst_isNode(link)); }
		node->_private_662096437_link = link;
		return node;
	}

	static inline struct lst_Node *lst_initEmptyNode(
		struct lst_Node *node
	) {
		return lst_initNode(node, NULL);
	}



