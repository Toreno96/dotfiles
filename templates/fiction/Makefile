SHELL = /bin/sh

.PHONY: pdf html clean clean-pdf clean-html

# Alias for `make a.pdf`
pdf: a.pdf

# Alias for `make a.html`
html: a.html

# Convert the final HTML to PDF
a.pdf: a.html
	'/Applications/Brave Browser.app/Contents/MacOS/Brave Browser' \
		--headless \
		--incognito \
		--disable-gpu \
		--run-all-compositor-stages-before-draw \
		--virtual-time-budget=10 \
		--no-pdf-header-footer \
		--print-to-pdf='a.pdf' \
		a.html

# Build the final HTML
a.html: intermediate.html
	sed \
		-e '/PLACEHOLDER/r intermediate.html' \
		-e 's///' \
		template.html >a.html

# Build an intermediate HTML that can be later merged with the template HTML
# (template.html)
intermediate.html: a.md template.html config.json
	markdown_py \
		-x def_list \
		-x footnotes \
		-x pymdownx.tilde \
		-x tables \
		-x toc \
		-c config.json a.md >intermediate.html

# Delete all files in the current directory that are created by this makefile
clean: clean-pdf clean-html

# Delete PDF files in the current directory that are created by this makefile
clean-pdf:
	-rm -v a.pdf

# Delete HTML files in the current directory that are created by this makefile
clean-html:
	-rm -v intermediate.html a.html
