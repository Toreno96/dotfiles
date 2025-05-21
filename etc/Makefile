SHELL = /bin/sh

.PHONY: install shells

install: shells

shells:
	sudo rsync -bLPu 'shells' '/etc/shells'
	sudo chown root:wheel '/etc/shells'
	sudo chmod 664 '/etc/shells'
	stat '/etc/shells'
