# Targets to configure different operating systems.

MAKEFILE_DIR := $(abspath $(dir $(abspath $(lastword $(MAKEFILE_LIST)))))
.DEFAULT_GOAL := all

# Common modules between systems.
COMMON := git bash-common bin-common vim

#######
# Linux
#######
UNAME_S := $(shell uname -s)
ifeq ($(UNAME_S),Linux)

# Invoke GNU stow on Linux.
STOW := : --dir=$(MAKEFILE_DIR) --target=$(HOME)

# The Linux-specific targets to install.
DEPS :=
TARGETS := $(COMMON) bash-linux bin-linux fonts-linux i3-linux x11-linux

endif

#######
# macOS
#######
ifeq ($(UNAME_S),Darwin)

# Invoke GNU stow on macOS.
STOW := /usr/local/bin/stow --dir=$(MAKEFILE_DIR) --target=$(HOME)

# The macOS-specific targets to install.
DEPS := /usr/local/bin/stow
TARGETS := $(COMMON) bash-macos bin-macos

# https://brew.sh/
/usr/local/bin/brew:
	/bin/bash -c "$(curl -fsSL https://raw.githubusercontent.com/Homebrew/install/HEAD/install.sh)"

# Install stow if needed
/usr/local/bin/stow: /usr/local/bin/brew
	/usr/local/bin/brew install stow

endif

# Install packages
.PHONY: all
all: $(DEPS)
	$(STOW) $(TARGETS)

# Remove packages.
# Pipe stderr to /dev/null, see https://github.com/aspiers/stow/issues/65
.PHONY: clean
clean:
	$(STOW) -D $(TARGETS) 2>/dev/null
