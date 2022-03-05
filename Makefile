# Targets to configure different operating systems.

MAKEFILE_DIR := $(abspath $(dir $(abspath $(lastword $(MAKEFILE_LIST)))))

#######
# Linux
#######
UNAME_S := $(shell uname -s)
ifeq ($(UNAME_S),Linux)

STOW := : --dir=$(MAKEFILE_DIR) --target=$(HOME)

.PHONY: all
all:
	:

.PHONY: clean
clean:
	:

endif

#######
# MacOS
#######
ifeq ($(UNAME_S),Darwin)

STOW := /usr/local/bin/stow --dir=$(MAKEFILE_DIR) --target=$(HOME)

# Make links.
.PHONY: all
all: /usr/local/bin/stow
	$(STOW) git

.PHONY: clean
clean:
	$(STOW) -D git

# https://brew.sh/
/usr/local/bin/brew:
	/bin/bash -c "$(curl -fsSL https://raw.githubusercontent.com/Homebrew/install/HEAD/install.sh)"

# Install stow if needed
/usr/local/bin/stow: /usr/local/bin/brew
	/usr/local/bin/brew install stow

endif

