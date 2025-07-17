SHELL = /bin/sh

.PHONY: epub pdf html clean clean-epub clean-pdf clean-html

all: epub pdf html

# Alias for `make magic.epub`
epub: magic.epub

# Alias for `make magic.pdf`
pdf: magic.pdf

# Alias for `make magic.html`
html: magic.html

# Convert the source Markdown file to EPUB
magic.epub: magic.md style.css
	pandoc \
		-f markdown \
		-t epub \
		--standalone \
		--css style.css \
		--toc \
		-V toc-title:"Spis treści" \
		-o magic.epub \
		magic.md

# Convert the source Markdown file to PDF
magic.pdf: magic.md style.css
	pandoc \
		-f markdown \
		-t html \
		--standalone \
		--css style.css \
		--toc \
		-V toc-title:"Spis treści" \
		-o magic.pdf \
		magic.md

# Convert the source Markdown file to HTML
magic.html: magic.md
	pandoc \
		-f markdown \
		-t html \
		--standalone \
		--css style.css \
		--toc \
		-V toc-title:"Spis treści" \
		-o magic.html \
		magic.md

# Delete all files in the current directory that are created by this makefile
clean: clean-epub clean-pdf clean-html

# Delete EPUB files in the current directory that are created by this makefile
clean-epub:
	-rm -v magic.epub

# Delete PDF files in the current directory that are created by this makefile
clean-pdf:
	-rm -v magic.pdf

# Delete HTML files in the current directory that are created by this makefile
clean-html:
	-rm -v magic.html
