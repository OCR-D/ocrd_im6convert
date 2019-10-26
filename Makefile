# Directory to install to ('$(PREFIX)')
PREFIX ?= $(if $(VIRTUAL_ENV),$(VIRTUAL_ENV),$(CURDIR)/.local)

BINDIR = $(PREFIX)/bin
SHAREDIR = $(PREFIX)/share/ocrd-im6convert

# Docker tag
DOCKER_TAG = ocrd/im6convert

# Python pip to install with ('$(PIP)')
PIP ?= $(shell which pip)

SCRIPTS = ocrd-im6convert

# BEGIN-EVAL makefile-parser --make-help Makefile

help:
	@echo ""
	@echo "  Targets"
	@echo ""
	@echo "    deps-ubuntu  Install system packages (for use with containers)"
	@echo "    deps         Install python packages"
	@echo "    install      Install the executable in $(PREFIX)/bin and the ocrd-tool.json to $(SHAREDIR)"
	@echo "    uninstall    Uninstall scripts and $(SHAREDIR)"
	@echo "    docker       Build Docker image"
	@echo ""
	@echo "  Variables"
	@echo ""
	@echo "    PREFIX      Directory to install to ('$(PREFIX)')"
	@echo "    DOCKER_TAG  Docker tag"
	@echo "    PIP         Python pip to install with ('$(PIP)')"

# END-EVAL

# Install system packages (for use with containers)
deps-ubuntu:
	apt-get install imagemagick

# Install python packages
deps:
	$(PIP) install ocrd # needed for ocrd CLI (and bashlib)

# Install the executable in $(PREFIX)/bin and the ocrd-tool.json to $(SHAREDIR)
install: deps
	mkdir -p $(BINDIR)
	for script in $(SCRIPTS);do \
		sed 's,^SHAREDIR.*,SHAREDIR="$(SHAREDIR)",' $$script > $(BINDIR)/$$script ;\
		chmod a+x $(BINDIR)/$$script ;\
	done
	mkdir -p $(SHAREDIR)
	cp ocrd-tool.json $(SHAREDIR)
ifeq ($(findstring $(BINDIR),$(subst :, ,$(PATH))),)
	@echo "you need to add '$(BINDIR)' to your PATH"
else
	@echo "you already have '$(BINDIR)' in your PATH"
endif

# Uninstall scripts and $(SHAREDIR)
uninstall:
	for script in $(SCRIPTS);do \
		rm --verbose --force "$(BINDIR)/$$script";\
	done
	rm -rfv $(SHAREDIR)

# Build Docker image
docker:
	docker build -t '$(DOCKER_TAG)' .
