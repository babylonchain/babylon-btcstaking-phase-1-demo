# Babylon BTC Staking Phase-1 demo

This repository contains all the necessary artifacts and instructions to set up
and run Babylon's Phase-1 BTC Staking system locally.

More details about the system can be found [here](DEPLOYMENT.md).

## Prerequisites

1. Install Docker Desktop

    All components are executed as Docker containers on the local machine, so a
    local Docker installation is required. Depending on your operating system,
    you can find relevant instructions [here](https://docs.docker.com/desktop/).

2. Install `make`

    Required to build the service binaries. One tutorial that can be followed
    is [this](https://sp21.datastructur.es/materials/guides/make-install.html).

3. Clone the repository and initialize git submodules

    The aforementioned components are included in the repo as git submodules, so
    they need to be initialized accordingly.

    ```shell
    git clone git@github.com:babylonchain/babylon-timestamping-demo.git
    git submodule init && git submodule update
    ```

## Repo structure

The repository follows the below structure:

```shell
├── artifacts
│   ├── docker-compose.yml
│   ├── ...
├── Makefile
├── post-deployment.sh
└── pre-deployment.sh
```

## Perform system operations;w

To start the system **along with executing an
[additional post-deployment script](DEPLOYMENT.md#inspecting-the-btc-staking-phase-1-system-demo)
that will showcase the lifecycle of Staking requests inside the Phase-1
system**, execute the following:

```shell
make start-deployment-btcstaking-phase1-bitcoind-demo
```

Alternatively, to just start the system:

```shell
make start-deployment-btcstaking-phase1-bitcoind
```

To stop the system:

```shell
make stop-deployment-btcstaking-phase1-bitcoind
