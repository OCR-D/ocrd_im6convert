PREFIX=$(HOME)/.local

# BEGIN-EVAL makefile-parser --make-help Makefile

help:
	@echo ""
	@echo "  Targets"
	@echo ""
	@echo "    deps       Install deps"
	@echo "    install    Install the executable in $(PREFIX)/bin"
	@echo "    uninstall  Uninstall script"

# END-EVAL

# Install deps
deps:
	# apt-get install graphicsmagick

# Install the executable in $(PREFIX)/bin
install:
	mkdir -p $(PREFIX)/bin
	cp -t $(PREFIX)/bin ocrd-im6convert
	chmod a+x $(PREFIX)/bin/ocrd-im6convert

# Uninstall script
uninstall:
	rm $(PREFIX)/bin/ocrd-im6convert

