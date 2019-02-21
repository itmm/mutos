# Listenbehandlung

```
@Def(file: lst.c)
	#define lst_IMPL 1
	#include "lst.h"
@end(file: lst.c)
```
* C-Datei inkludiert nur Header

```
@Def(file: lst.h)
	#pragma once
	@put(includes)
	@put(structs)
@end(file: lst.h)
```
* Header enthält Includes und Strukturen

# Knoten
* Knoten einer einfach verketteten Liste

```
@def(structs)
	struct Node {
		struct Node *p{link};
		#if CONFIG_WITH_MAGIC
			unsigned p{magic};
		#endif
	};

	@put(node functions)
@end(structs)
```
* Zeiger auch Nachfolger
* Und Magic-Feld

```
@def(node functions)
	#if CONFIG_WITH_MAGIC
		#define lst_NODE(LINK) { \
			.p{link} = (LINK), \
			.p{magic} = m{node} \
		}
	#else
		#define lst_NODE(LINK) { \
			.p{link} = (LINK) \
		}
	#endif
@end(node functions)
```
* Nachfolger wird initialisiert

```
@def(includes)
	#include <stdlib.h>
@end(includes)
```
* Definition von `NULL`

```
@add(node functions)
	#define lst_EMPTY_NODE lst_NODE(NULL)
@end(node functions)
```
* Leerer Knoten hat keinen Nachfolger

```
@add(includes)
	#include <stdbool.h>
@end(includes)
```
* Definition von `bool`

```
@add(node functions)
	static inline bool isNode(
		const struct Node *node
	) {
		if (! node) { return false; }
		#if CONFIG_WITH_MAGIC
			if (node->p{magic} !=
				m{node}
			) {
				return false;
			}
		#endif
		return true;
	}
@end(node functions)
```
* `NULL` ist kein Knoten
* `magic` muss passen

```
@add(node functions)
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
			node->p{link} = link;
			#if CONFIG_WITH_MAGIC
				node->p{magic} = m{node};
			#endif
			return node;
		}
	#else
		;
	#endif
@end(node functions)
```
* `node` darf nicht `NULL` sein
* `link` muss ein Knoten oder `NULL` sein
* `magic` wird initialisiert

```
@add(node functions)
	static inline
	struct Node *lst_initEmptyNode(
		struct Node *node
	) {
		return lst_initNode(node, NULL);
	}
@end(node functions)
```
* Kurzform

# Liste
* Einfach verkettete Liste
* Am Anfang und am Ende kann eingefügt werden
* Am Anfang kann entfernt werden

```
@add(structs)
	struct List {
		struct Node *p{first};
		struct Node *p{last};
		#if CONFIG_WITH_MAGIC
			unsigned p{magic};
		#endif
	};

	@put(list functions)
@end(structs)
```
* Zeiger auf erstes und letztes Element
* Und `magic` Feld

```
@def(list functions)
	static inline bool isList(
		const struct List *l
	) {
		if (! l) { return false; }
		#if CONFIG_WITH_MAGIC
			if (l->p{magic} != m{list}) {
				return false;
			}
		#endif
		return true;
	}
@end(list functions)
```

```
@add(list functions)
	#if CONFIG_WITH_MAGIC
		#define lst_LIST(FIRST, LAST) { \
			.p{first} = (FIRST), \
			.p{last} = (LAST), \
			.p{magic} = m{list} \
		}
	#else
		#define lst_LIST(FIRST, LAST) { \
			.p{first} = (FIRST), \
			.p{last} = (LAST) \
		}
	#endif
@end(list functions)
```
* Initialisierung mit erstem und letztem Element

```
@add(list functions)
	#define lst_EMPTY_LIST lst_LIST(NULL, NULL)
@end(list functions)
```
* Kurzform

```
@add(list functions)
	struct Node *lst_pullFirst(
		struct List *l
	)
	#if lst_IMPL
		{
			if (! isList(l)) { return NULL; }
			struct Node *f = l->p{first};
			if (isNode(f)) {
				@put(move head to next);
				return f;
			} else {
				return NULL;
			}
		}
	#else
		;
	#endif
@end(list functions)
```
* Erstes Element aus Liste entfernen

```
@def(move head to next)
	struct Node *n = f->p{link};
	l->p{first} = n;
	if (! n) {
		l->p{last} = NULL;
	}
	f->p{link} = NULL;
@end(move head to next)
```
* Erstes Element der Liste wird aktualisiert
* Wenn Liste leer wird, dann muss letztes Element aktualisiert werden
* `link` wird zur Sicherheit auf `NULL` gesetzt

```
@add(list functions)
	void lst_pushLast(
		struct List *l,
		struct Node *n
	)
	#if lst_IMPL
		{
			if (! l || ! n) { return; }
			n->p{link} = NULL;
			if (l->p{first}) {
				l->p{last}->p{link} = n;
			} else {
				l->p{first} = n;
			}
			l->p{last} = n;
		}
	#else
		;
	#endif
@end(list functions)
```
