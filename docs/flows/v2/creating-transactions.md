---
sidebar_position: 6
---

# Creating transactions

The transaction model uses the same pattern for every transaction:

- First step you create a preview, where transaction is checked and you get a promised price quote if valid.
- The preview is valid for 1 minute, after that you will have to update it, or create another one.
- While the preview is valid, you can confirm it in order to complete the transaction.

Either the transaction is successful or not, you will receive a notification in your mobile app as long as you are subscribed to transaction notifications in your [settings](/v1/#tag/settings).

## Create preview

### Transfer preview

Use the [preview swap](/v1#tag/transaction/paths/~1v1~1transaction~1transfer/post) endpoint

For example, suppose you want to transfer 1 USDT of Ethereum to other belo user through belotag:

```json
{
  "address": "user.belo",
  "addressType": "BELOTAG",
  "quoteAmount": "1",
  "quoteCurrencyId": "6",
  "currencyId": "4"
}
```

And the response will look like:

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

For example, suppose you want to transfer 1 USDT worth of Ether:

```json
{
  "pairCode": "ETH/USDT",
  "quoteAmount": "1",
  "quoteCurrencyId": "6",
  "type": "BUY"
}
```

And the response will look like:

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

In case the preview is expired you can update it using the [update preview](/v1#tag/transaction/paths/~1v1~1transaction~1preview~1%7Bid%7D/put) endpoint.

## Confirm preview

In case you want to proceed with the transaction, you will have to [confirm the preview](/v1#tag/transaction/paths/~1v1~1transaction~1confirm~1%7Bid%7D/put).
