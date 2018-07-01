Zero values for Data Types
```
Integer types: 0
bool: false
address: 0x0
byte types: 0
array: []
mapping: no keys
```

## Useful Geth Commands

| Command | Description |
| - | - |
| geth | Default geth mode, used for basic operation |
| geth console --verbosity 0 | Interactive console (silent mode) |
| geth help | Command reference |
| geth --rinkeby | Rinkeby network: pre-configured proof-of-authority test network |
| geth --testnet | Ropsten network: pre-configured proof-of-work test network |
| geth account | Account management |
| geth account new | Create account |
| geth --rinkeby account new | Create account on testnet |
| geth --fast --cache=1024 | Sync mainnet | 
| geth --rinkeby --fast --cache=1024 | Sync Rinkeby |
| geth --rpc | RPC mode |  
| geth --rpc --rpcapi web3,eth,net,personal | RPC mode with local wallet access |
| geth --port <port> | Listen on custom network port |
| geth --rpc --rpcport <port> | Listen on custom RPC port |
| geth --rinkeby --verbosity 0 console | Open a Rinkeby geth console |

## Glossary
- Test network: A network that runs the Ethereum protocol, but whose token has no value. Used for testing code, deployments, and transactions without paying gas.
-- Faucets: Sites that sends free crypto, normally for testnets.



## Compilation

- How to compile the contract? 
- What is the expected output?

```
solc --abi --bin ....
```

The bin is what we need to deploy the contract.
The ABI is what we need to communicate with the contract.

## Deployment

- How much gas is required to perform the transaction?
- What is the data to send as the transaction?

```
// replace <password> with your actual password
$ personal.unlockAccount(eth.accounts[0], <password>)
$ tx = eth.sendTransactions({ from: eth.accounts[0], data: bytecode, gas: 500e3 })
```

Output:

```
web3.eth.getTransactionReceipt(tx)
{
  blockHash: "",
  blockNumber: 0,
  contractAddress: <we_need_this>
  ...
}
```

To interact with the contract, we need to know the contract's address and ABI. The address can be obtained from the transaction receipt.

```
web3.eth.getTransactionReceipt(tx).contractAddress
```

## Creating contract address

```
HelloWorld = web3.eth.contract(abi).at(address)
HelloWorld.greet()
```

## Function Visibility Modifiers
| Modifier | Description |
|-|-|
| private | only the current contract can use the function |
| internal | only the current contract and contracts inheriting the current contract can execute the function |
| external | the function can be triggered only by a transaction or external contract |
| public | there are no restriction on how the function can be called |

## State permissions modifiers

| Modifier | Description |
|-|-|
| view | Can read information from the state tree but cannot modify state |
| pure | Cannot read or modify the state tree. The return value depends on only the function arguments |
| constant | An alias for view. Deprecated |

RPC calls to `view` or `pure` functions return immediately and don't send a transaction. This means you can get back the information you need without paying gas fees or waiting for the transaction to mine.

## Payable

- Allows function to accept ether
- The amount of ether sent will be available in `msg.value` field in units of `wei`

```sol
function buyLottoTicket() payable {
  require(msg.value == TICKET_PRICE);
  players.push(msg.sender);
}
```

EOS Crowdsale fallback function:

```
function () payable {
  buy();
}
```

Sending ether to the contract will execute the buy function.