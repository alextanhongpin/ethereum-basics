# Get the private

```python
from web3.auto import w3 
with open("keystore/UTC--2018-09-03T10-...") as keyfile:
	encrypted_key = keyfile.read()
	private_key = w3.eth.account.decrypt(encrypted_key, 
                                            'password')
import binascii
print(binascii.b2a_hex(private_key))
```
