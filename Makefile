
all: index.js syntax.js

index.js: index.md
	sed -e  '/INLINE_CONTENT/{r index.md' -e 'd}' page.elm.template > index.elm
	# elm make --output index.js index.elm

syntax.js: syntax.md
	sed -e  '/INLINE_CONTENT/{r syntax.md' -e 'd}' page.elm.template > syntax.elm
	# elm make --output syntax.js syntax.elm

