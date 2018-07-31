## B
- block gas limit: https://ethereum.stackexchange.com/questions/36565/what-is-a-private-proof-of-authority-transaction-speed
- bootnode: https://github.com/ethereum/go-ethereum#creating-the-rendezvous-point, https://github.com/ethereum/go-ethereum/blob/master/params/bootnodes.go
## G
- Gas: https://hudsonjameson.com/2017-06-27-accounts-transactions-gas-ethereum/

## K
- KYC (Know Your Customer): https://medium.com/swlh/kyc-using-blockchain-2669ff08abc7

## M 
- Masternodes (MN): https://coinsutra.com/masternodes/
- Minting: https://talk.peercoin.net/t/the-complete-guide-to-minting/2524

## T
- Transaction: https://en.bitcoin.it/wiki/Transaction

# Thoughts
- smart contract best practices: https://consensys.github.io/smart-contract-best-practices/
- advantages of smart contracts: https://medium.com/@ChainTrade/10-advantages-of-using-smart-contracts-bc29c508691a
- can blockchain reduce the impact of data breaches? https://bitsonblocks.net/2018/07/24/can-blockchains-reduce-the-impact-of-data-breaches/amp/
- why proof of authority? https://cointelegraph.com/news/why-blockchain-needs-proof-of-authority-instead-of-proof-of-stake
- what is the difference between minting and mining? https://www.reddit.com/r/reddCoin/comments/2jatza/what_is_the_difference_between_minting_and_mining/
- how bitcoin mining works? https://www.coindesk.com/information/how-bitcoin-mining-works/
- 21 supernodes https://bitcoinmagazine.com/articles/eos-hype-builds-over-50-candidates-vie-21-supernodes/
- bitcoin transaction types: https://www.cryptocompare.com/coins/guides/what-are-the-bitcoin-transaction-types/
- what is EOS: https://blockgeeks.com/guides/eos-blockchain/
- why 21 nodes on EOS: https://blog.cosmos.network/consensus-compare-tendermint-bft-vs-eos-dpos-46c5bca7204b
- https://np.reddit.com/r/ethereum/comments/6qm0y2/is_the_ethereum_team_defending_their_ground/
- mention of strong light client technology for validating transactions: https://vitalik.ca/general/2017/05/08/coordination_problems.html
- smart contract audit: https://www.devteam.space/blog/how-to-audit-a-smart-contract-a-guide/
- EOS Technical white paper: https://github.com/EOSIO/Documentation/blob/master/TechnicalWhitePaper.md
- Proof of Staking Velocity: https://reddcoin.com/papers/PoSV.pdf
- Masternodes vs Coin Staking Rewards: https://apollon.zendesk.com/hc/en-us/articles/360002929491-What-is-the-difference-between-masternode-rewards-and-coin-staking-rewards-
- Forking Ethereum: https://www.quora.com/How-does-forking-work-on-Ethereum


# Dashboards:
- WaltonChain https://wtc-gmn-tracker.herokuapp.com/

## No mining in PoA

`miner` is still valid. By definition, `mining` is the process by which transactions are verified and added to the public ledger. the only difference is

```
for `PoW`: The mining process involves compiling recent transactions into blocks and trying to solve a computationally difficult puzzle
for `PoA`: The mining process involves choosing a signer among a list of authorised signers to produce the block
```

when they say there is no mining in PoA, they mean you don’t need to solve any CPU-intensive cryptography puzzle
