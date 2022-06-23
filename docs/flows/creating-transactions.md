---
sidebar_position: 5
---

# Creating transactions

Our transaction model use the same pattern for every transaction:

First step you create a preview, where we validate what you ask is possible and valid, then you see our promised price quote.
The preview is valid for 1 minute, after that you will have to update it, or create another one.
If the price seems ok, you can confirm the preview.

## Create preview

### Transfer preview

Use the [preview swap](/v1#tag/transaction/paths/~1v1~1transaction~1transfer/post) endpoint

For example you want to transfer 1 USDT of Ethereum

```json
{
  "address": "user.belo",
  "addressType": "BELOTAG",
  "quoteAmount": "1",
  "quoteCurrencyId": "6",
  "currencyId": "4"
}
```

And the response will look like

```json
{
  "data": {
    "createdAt": "2022-06-23T18:16:42.522Z",
    "type": "TRANSFER_OUTGOING",
    "status": "PREVIEW",
    "total": "0.00091823428542108",
    "outputCurrencyId": "4",
    "fromContact": {
      "name": "...",
      "uuid": "...",
      "nickname": "...",
      "image": "...",
      "belotag": "...",
      "addressType": "USER",
      "addressValue": "1"
    },
    "toContact": {
      "name": "...",
      "uuid": "...",
      "nickname": "...",
      "image": "...",
      "belotag": "...",
      "addressType": "USER",
      "addressValue": "3"
    },
    "inputs": [
      {
        "amount": "0.00091823428542108",
        "name": "Net Amount",
        "type": "NOMINAL",
        "quoteId": "3868336",
        "currencyId": "4",
        "transactionId": "3844419"
      }
    ]
  }
}
```

### Swap preview

Use the [preview swap](/v1#tag/transaction/paths/~1v1~1transaction~1swap/post) endpoint

For example you want to buy 1 USDT of Ethereum

```json
{
  "pairCode": "ETH/USDT",
  "quoteAmount": "1",
  "quoteCurrencyId": "6",
  "type": "BUY"
}
```

And the response will look like

```json
{
  "data": {
    "createdAt": "2022-06-23T18:24:49.032Z",
    "type": "SWAP",
    "status": "PREVIEW",
    "total": "0.000906535228051428",
    "outputCurrencyId": "4",
    "fromContact": {
      "name": "...",
      "uuid": "...",
      "nickname": "...",
      "image": "...",
      "belotag": "...",
      "addressType": "USER",
      "addressValue": "1"
    },
    "toContact": {
      "name": "...",
      "uuid": "...",
      "nickname": "...",
      "image": "...",
      "belotag": "...",
      "addressType": "USER",
      "addressValue": "1"
    },
    "inputs": [
      {
        "amount": "1",
        "name": "Swap Amount",
        "type": "NOMINAL",
        "quoteId": "3868709",
        "currencyId": "6",
        "transactionId": "3844771"
      }
    ]
  }
}
```

## Update preview

In case the preview is expired you can update it using the [update preview](/v1#tag/transaction/paths/~1v1~1transaction~1preview~1%7Bid%7D/put) endpoint

## Confirm preview

In case all is good you can [confirm the preview](/v1#tag/transaction/paths/~1v1~1transaction~1confirm~1%7Bid%7D/put)
