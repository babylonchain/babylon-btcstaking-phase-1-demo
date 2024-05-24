DOCKER := $(shell which docker)
GIT_TOPLEVEL := $(shell git rev-parse --show-toplevel)

build-bitcoindsim:
	$(MAKE) -C $(GIT_TOPLEVEL)/submodules/contrib/images bitcoindsim

build-bitcoindsim-signer:
	$(MAKE) -C $(GIT_TOPLEVEL)/submodules/contrib/images bitcoindsim BITCOIN_CORE_VERSION=26.1

build-simple-staking:
	cd $(GIT_TOPLEVEL)/submodules/simple-staking && docker build -t babylonchain/simple-staking .

build-staking-api-service:
	$(MAKE) -C $(GIT_TOPLEVEL)/submodules/staking-api-service build-docker

build-staking-expiry-checker:
	$(MAKE) -C $(GIT_TOPLEVEL)/submodules/staking-expiry-checker build-docker

staking-indexer:
	$(MAKE) -C $(GIT_TOPLEVEL)/submodules/staking-indexer build-docker

cli-tools:
	$(MAKE) -C $(GIT_TOPLEVEL)/submodules/cli-tools build-docker

build-covenant-signer:
	$(MAKE) -C $(GIT_TOPLEVEL)/submodules/covenant-signer build-docker

build-deployment-btcstaking-phase1-bitcoind: build-bitcoindsim build-bitcoindsim-signer build-simple-staking build-staking-api-service build-staking-expiry-checker staking-indexer cli-tools build-covenant-signer

start-deployment-btcstaking-phase1-bitcoind: stop-deployment-btcstaking-phase1-bitcoind build-deployment-btcstaking-phase1-bitcoind
	./pre-deployment.sh
	docker compose -f artifacts/docker-compose.yml up -d
	./post-deployment.sh

start-deployment-btcstaking-phase1-bitcoind-demo: start-deployment-btcstaking-phase1-bitcoind
	./btcstaking-demo.sh

stop-deployment-btcstaking-phase1-bitcoind:
	docker compose -f artifacts/docker-compose.yml down
	rm -rf $(CURDIR)/.testnets
