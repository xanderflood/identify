Identify
=

Identify is a lil JWT authority application built on Rails and Devise. It is essntially a Rails application consisting only of Devise views, with two important properties:
- signed-in users will be given a fresh JWT, stored in a cookie, on every request
- visitors to the root path will be assigned a cookie that stores their `referrer_url` param, if set, so they can be redirected there after sign-in

The idea is that Identify lives on one subdomain of several, such as `login.example.com`, where `app1.example.com` and `app2.example.com` are other apps that use a JWT-authenticated API. Those apps, when `app1` (for instance) receives a request with no JWT, the following will happen:
1. The app redirects the user to `https://login.examples.com?referrer_url=https://app1.example.com`.
2. The user logs in, either using an existing account, or after registering and confirming a new one.
3. A JWT is stored on the `example.com` domain.
4. The user is then redirected back to `https://app1.example.com` per their referrer cookie, which is subsequently deleted.
5. The `app1.example.com` frontend uses its `example.com` JWT cookie to make backend requests.

If the user visits `login.example.com` directly, with no referrer, then they will arrive at a simple account management menu, once authenticated.

Identify is configured using environment variables. See `config/application.rb` for available configurations.
