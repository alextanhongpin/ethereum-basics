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

With `solcjs`:
```bash
$ solc --abi --bin -o target HelloWorld.sol
```

With `truffle`:

```bash
$ truffle compile
```

The bin is what we need to deploy the contract.
The ABI is what we need to communicate with the contract.

## Go bindings

```bash
$ abigen --abi token.abi --pkg main --type Token --out token.go
```

## Deployment

- How much gas is required to perform the transaction?
- What is the data to send as the transaction?

```
// replace <password> with your actual password
$ personal.unlockAccount(eth.accounts[0], <password>)
$ tx = eth.sendTransaction({ from: eth.accounts[0], data: bytecode, gas: 500e3 })
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

## Enumerables

```sol
enum State { Active, Refunding, Closed }
State state = State.Refunding;
uint(state); // 1;
uint(State.Active); // 0
```

## Arrays

```sol
uint[3] ids; // Empty fixed size array
uint[] x; // Empty dynamic array
x.push(2); 
x.length; // 1
x.length = 2; // Adds a zero value element
```

## Structs

```
struct Bet {
  uint amount; // In wei
  int32 line;
  BetStatus status; // Enum
}

Bet memory bet = Bet(1, -1, BetStatus.Open);
bet.line; // 1
```

# Zero Values

| Data Type (s) | Zero Value |
| - | - |
| Integer types | 0 |
| bool | false |
| address | 0x0 |
| Byte types | 0 |
| Array | [] |
| mapping | No keys |

## Variable Visibility Modifiers

**State variables** are declared in the global contract scope.

**Local variables** are declared within a function and destroyed when the function is complete.

```sol
contract Bear {
  // State variables
  string public name = "gummy";
  uint internal id = 1;

  function touchMe (uint times) public pure returns (bool) 
  {
    bool touched = false; // Local variable
    if (times > 0) touched = true;
    return touched;
  }
}
```

## Storage vs. Memory

Solidity stores location in two places: in the state tree and in memory.

### Storage
- stored in the state tree persist on the blockchain
- is expensive and should only be used whenever possible
- local variables that aren't array or structs and all state variables are automatically forced into storage
- local arrays and structs default to storage, but we can choose where to store them

### Memory
- is cleared after every transactions
- is cheap and should be used whenever possible
- array and structs in function arguments default to memory

```
contract Airbud {
  // State variables forced into storage
  address[] users;
  mapping(address => uint) public balances;

  function yelp() public payable {
    // Local variables default to storage
    address user = msg.sender;

    // Local variables declared to memory
    uint[8] memory ids = [1, 2, 3];
  }
}
```

# Contract Structure

## Inheritance

```
contract owned {
  function owned() { owner = msg.sender; }
  address owner;
}

contract mortal is owned {
  function kill() {
    if (msg.sender == owner) selfdestruct(owner);
  }
}
```

## Modifiers

```
contract owned {
  function owned() { owner = msg.sender; }

  address owner;
  modifier onlyOwner {
    require(msg.sender == owner);
    _;
  }
}

contract mortal is owned {
  function kill() onlyOwner {
    selfdestruct(owner);
  }
}
```

## Logging and Events

```
event Withdrawal (
  address indexed user,
  uint amount,
  uint timestamp
);

function withdraw (uint amount) public {
  Withdrawal(msg.sender, amount, now);
}
```

# Operators and Built-in Functions

## Decimal precision

```
uint a = 10;
uint b = 3;

// Multiply by 10 ** n to add n zeros
// If you have n zeros, the last n digits will be the decimal digits
uint c = (a * 10 ** 6) / b; // 333333
```

## Time Comparison

The units `seconds`, `minutes`, `hours`, `days`, `weeks` and `years` are all automatically converted into a uint equivalent of seconds.

```
1 == 1 seconds;
60 seconds == 1 minutes;
3600 seconds == 1 hour;
1 year == 365 days;
```

The `now` keyword can be used to get the UNIX timestamp (seconds) after the UNIX epoch of **Jan 1 1070**. This makes it easy to create delayed actions:

```sol
contract TimedPayout {
  uint start;

  function TimedPayout () payable {
    start = now;
  }

  function claim() {
    if (now > start + 10 days) {
      msg.sender.transfer(address(this).balance)
    }
  }
}
```

## Currency Math

```
1 == 1 Wei;
1 ether == 10 ** 18 Wei;
2 ether == 2e18 Wei;
2 finney = .002 ether;
if (msg.value == 1 ether) buyLottoTicket();
msg.value; // 1e18 a.k.a. 1 ether
```

# Error Handling

When a smart contract throws an error, all changes made to the state tree during the current transactions are rolled back. The code can decide whether to refund any unused gas. 

When to consume unused gas? For errors that imply malicious intent. When to refund gas? For common errors.


The `revert` function throws a manual error and refunds all unused gas. `require(condition)` and `assert(condition)` throws an error and consume all unused gas if condition is false.

Avoid using `assert` function, when in doubt use `require` function to check input conditions.

```sol
contract BugSquash {
  enum State { Alive, Squashed };
  State state;
  address owner;

  constructor() {
    state = State.Alive;
    owner = msg.sender;
  }

  function squash() {
    // This should never throw an error
    assert(owner != address(0));

    if (state == State.Alive)
      state = State.Squashed;
    else if (state == State.Squashed)
      revert(); // User error, refund gas
  }

  function kill() {
    // Any nonowner tryibg to kill the contract likely has malicious intent
    require(msg.sender == owner);
    selfdestruct(owner);
  }
}
```

# Contract Security

- all values in the Ethereum state tree are 32-byte words. The length of the returned hex value s are 64 characters long, corresponding to 32 bytes of storage.
- common way of losing ether is by forgetting to include the `to` field in the transaction. This will send the ether to the null address and attempt a contract creation. With no data, an empty contract is created containing your ether, and your ether is lost forever.
- another common error is sending your contract creation data to the zero address instead of the null address. 
- self-destructing contracts can sometimes lead to problems. If a user sends ether to a self-destructed contract, the ether is impossible to reclaim.

```js
'abcdefghijklmnopqrstuvwxyz'.split('').map(i => i.charCodeAt(0))
[ 97,
  98,
  99,
  100,
  101,
  102,
  103,
  104,
  105,
  106,
  107,
  108,
  109,
  110,
  111,
  112,
  113,
  114,
  115,
  116,
  117,
  118,
  119,
  120,
  121,
  122 ]
> 'abcdefghijklmnopqrstuvwxyz'.split('').map(i => i.charCodeAt(0).toString(16))
[ '61', // a (16 * 6 + 1 === 97)
  '62', // b
  '63', // c
  '64', // d
  '65', // e
  '66', // f 
  '67', // g
  '68', // h
  '69', // i
  '6a', // j
  '6b', // k
  '6c', // l
  '6d', // m
  '6e', // n
  '6f', // o
  '70', // p
  '71', // q
  '72', // r
  '73', // s
  '74', // t
  '75', // u
  '76', // v
  '77', // w
  '78', // x
  '79', // y
  '7a'] // z 
```


## Sending Ether

Improper use of the ether transfer functions are the number one source of Solidity bugs and hacks. There are three ways to send ether in Solidity:

- address.transfer(value): throws error when fail, fixed gas stipend of 2300 gas. Most secure, use whenever possible.
- address.send(value): returns false when fail, fixed gas stipend of 2300 gas
- address.call.value(value)(): opens up to re-entrancy attacks, avoid using
