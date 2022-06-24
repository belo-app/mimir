---
sidebar_position: 4
---

# Top up your account

To start using your account in production you will need to deposit some assets. You can deposit fiat or cryptocurrencies.

First you should fetch your [deposit accounts](/v1#tag/contact/paths/~1v1~1contact~1account/get) and [currencies](/v1/#tag/currency/paths/~1v1~1currency~1/get)

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

After sending some assets you will receive a notification in your mobile device when deposit is successful, you can check it at [transaction history](/v1#tag/transaction/paths/~1v1~1transaction~1/get) endpoint.
