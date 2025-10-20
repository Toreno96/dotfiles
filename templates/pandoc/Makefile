SHELL = /bin/sh

.PHONY: all epub tex.pdf html.pdf tex html clean clean-epub clean-pdf clean-html

all: epub pdf html

# Alias for `make magic.epub`
epub: magic.epub

# Alias for `make magic.tex.pdf`
tex.pdf: magic.tex.pdf

# Alias for `make magic.html.pdf`
html.pdf: magic.html.pdf

# Alias for `make magic.tex`
tex: magic.tex

# Alias for `make magic.html`
html: magic.html

# Convert the source Markdown file to EPUB;
# depends on `style.css` because EPUB doesn't reload CSS automatically, as
# opposed to the HTML (copy of the CSS file is embedded in the resulting EPUB)
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

# Convert the source Markdown file to PDF, using LaTeX as an intermediate
# format;
# uses XeLaTeX to be able to use system fonts (mainly my favorite font:
# Literata)
magic.tex.pdf: magic.md
	pandoc \
		-f markdown \
		--pdf-engine=xelatex \
		--toc \
		-o magic.tex.pdf \
		magic.md

# Convert the source Markdown file to LaTeX;
# mostly for debugging purposes in case there's something wrong with
# `magic.tex.pdf`
magic.tex: magic.md
	pandoc \
		-f markdown \
		-t tex \
		--standalone \
		--toc \
		-o magic.tex \
		magic.md


# Convert the source Markdown file to PDF, using HTML as an intermediate format;
# depends on `style.css` because PDF doesn't reload CSS automatically, as
# opposed to the HTML
magic.html.pdf: magic.md style.css
	pandoc \
		-f markdown \
		-t html \
		--standalone \
		--css style.css \
		--toc \
		-V toc-title:"Spis treści" \
		-o magic.html.pdf \
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

# Delete all files in the current directory that were created by this makefile
clean: clean-epub clean-pdf clean-tex clean-html

# Delete EPUB files in the current directory that were created by this makefile
clean-epub:
	-rm -v magic.epub

# Delete PDF files in the current directory that were created by this makefile
clean-pdf:
	-rm -v magic.html.pdf magic.tex.pdf

# Delete LaTeX files in the current directory that were created by this makefile
clean-tex:
	-rm -v magic.tex

# Delete HTML files in the current directory that were created by this makefile
clean-html:
	-rm -v magic.html
