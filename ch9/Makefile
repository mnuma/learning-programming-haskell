.PHONY: help

help:
	@awk 'BEGIN {FS = ":.*?## "} /^[a-zA-Z_-]+:.*?## / {printf "\033[36m%-30s\033[0m %s\n", $$1, $$2}' $(MAKEFILE_LIST)

brew-install-caba-install: ## brew install caba install.
	brew install cabal-install

cabal-update: ## cabal update.
	cabal update

run-caluclator: ## run caluclator.
	@ghc -e run Calculator.hs

run-game-of-life:
	@ghc -e run GameOfLife.hs
