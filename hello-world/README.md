truffle init

geth --testnet account new

geth --testnet --fast --rpc --rpcapi eth,net,web3,personal

geth attach http://127.0.0.1:8545

personal.unlockAccount(eth.accounts[3])
