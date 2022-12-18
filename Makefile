.PHONY: all restow stow delete

all: restow

restow:
	stow --verbose --target=$$HOME --restow .

stow:
	stow --verbose --target=$$HOME --stow .

delete:
	stow --verbose --target=$$HOME --delete .
