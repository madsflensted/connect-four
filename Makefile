
all: notes.js slides


notes.js: notes.md
	sed -e  '/INLINE_CONTENT/{r notes.md' -e 'd}' page.elm.template > notes.elm
	elm make --output notes.js notes.elm


slides: 
	elm make SlideShow.elm


.dummy: slides
