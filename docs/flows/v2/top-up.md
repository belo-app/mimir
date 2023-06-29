---
sidebar_position: 5
---

# Top up your account

To start using your account in production you will need to deposit some assets. You can deposit fiat or cryptocurrencies.

First you should fetch your [deposit accounts](/v2#tag/account/paths/~1v2~1account~1deposit-address/get) and [currencies](/v2#tag/data/paths/~1v2~1data~1currency/get)

You can choose whatever you like to deposit, the response will look like this:

```json
{
  "data": [
    {
      "currencyId": "7",
      "addresses": [
        {
          "type": "ETHEREUM",
          "value": "0xed45caccc17b5cd199c63aaf42d47f088d6f89cb"
        },
        {
          "type": "TRON",
          "value": "TQHfnbn9jgE8sTwgPfjuVTJqSjzEndU8K6"
        }
      ]
    }
  ]
}
```

After sending some assets you will receive a notification in your mobile device when deposit is successful, you can check it at [transaction history](/v2#tag/transaction/paths/~1v2~1transaction~1/get) endpoint.
