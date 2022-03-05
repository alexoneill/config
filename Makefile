# Targets to configure different operating systems.

#######
# Linux
#######
UNAME_S := $(shell uname -s)
ifeq ($(UNAME_S),Linux)

.PHONY: all
all:
	:

endif

#######
# MacOS
#######
ifeq ($(UNAME_S),Darwin)

# https://brew.sh/
/usr/local/bin/brew:
	/bin/bash -c "$(curl -fsSL https://raw.githubusercontent.com/Homebrew/install/HEAD/install.sh)"

# Install stow if needed
/usr/local/bin/stow: /usr/local/bin/brew
	/usr/local/bin/brew install stow

# Make links.
.PHONY: all
all: /usr/local/bin/stow
	:

endif

