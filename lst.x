# Listenbehandlung

```
D{file: lst.c}
	#define lst_IMPL 1
	#include "lst.h"
x{file: lst.c}
```

```
D{file: lst.h}
	#pragma once
	e{includes}
	e{structs}
x{file: lst.h}
```

```
d{structs}
	struct lst_Node {
		struct lst_Node *p{link};
		#if CONFIG_WITH_MAGIC
			unsigned p{magic};
		#endif
	};

	e{node functions}
x{structs}
```

```
d{node functions}
	#if CONFIG_WITH_MAGIC
		#define lst_NODE(LINK) { \
			.p{link} = (LINK), \
			.p{magic} = m{lst node} \
		}
	#else
		#define lst_NODE(LINK) { \
			.p{link} = (LINK} \
		}
	#endif
x{node functions}
```

```
d{includes}
	#include <stdlib.h>
x{includes}
```

```
a{node functions}
	#define lst_EMPTY_NODE lst_NODE(NULL)
x{node functions}
```

```
a{includes}
	#include <stdbool.h>
x{includes}
```

```
a{node functions}
	static inline bool lst_isNode(
		const struct lst_Node *node
	) {
		if (! node) { return false; }
		#if CONFIG_WITH_MAGIC
			if (node->p{magic} != m{lst node}) {
				return false;
			}
		#endif
		return true;
	}
x{node functions}
```

```
a{includes}
	#include <assert.h>
x{includes}
```

```
a{node functions}
	static inline struct lst_Node *lst_initNode(
		struct lst_Node *node,
		struct lst_Node *link
	) {
		assert(node);
		if (link) { assert(lst_isNode(link)); }
		node->p{link} = link;
		return node;
	}
x{node functions}
```

```
a{node functions}
	static inline struct lst_Node *lst_initEmptyNode(
		struct lst_Node *node
	) {
		return lst_initNode(node, NULL);
	}
x{node functions}
```

