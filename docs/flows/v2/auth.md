---
sidebar_position: 2
---

# Authorization

:::caution
Your credentials are only yours, belo will never ask them in any way and encourages to not share them with anybody
:::

:::danger
An insecure storage of credentials will potentially result in loss of funds
:::

To use API V2, you'll need to create an authentication token with the API_KEY and API_SECRET provided by belo. Through the [/token](/v2#tag/auth/paths/~1v2~1auth~1token/post) endpoint you will be able to create this token.

You can get this token by signing in through the [/login](/v2#tag/auth/paths/~1v2~1auth~1login/post) endpoint, using your username and password. Keep in mind that this token does expire, so you'll need to refresh it to keep using it.

For those endpoints that require your authentication, you'll need to provide this token in the request headers as indicated in the [documentation](/v2#tag/auth).

## Auth Flow

As mentioned above, to get the token you need to log in. To refresh this token, you should use the [/refresh-token](/v2#tag/auth/paths/~1v2~1auth~1refresh-token/post) endpoint by sending your refreshToken also provided when logging in.

If you no longer want to use your token, you can log out of the application through the [/logout](/v2#tag/auth/paths/~1v2~1auth~1logout/get) endpoint.

If you've forgotten your password and are having trouble logging in, you can always reset it using the [/change-password](/v2#tag/auth/paths/~1v2~1auth~1change-password/put) endpoint.

## MFA Authentication

Having created your token, you can activate MFA Authentication to grant more security to your belo account.
