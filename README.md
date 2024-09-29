## Project title
Cash register.

## Description
This app allows to see a list of products, add them to a cart and compute the total price, taking into account special discounts.

**Generalities**
Each product has:
- product code,
- name,
- price,
- discount if applicable.

You can:
1- Add products to a cart
2- Compute the total price

3- It displays a checkout with:
- basket, with list of product codes,
- total price expected in €,

that:
- scans items randomly,
- needs to be flexible regarding pricing rules.

**Special offers**
- If you buy 1 green tea the 2nd is free (flexible pricing rule).
- If you buy 3 or more strawberry the price drops from 5 to 4.50 per package (flexible pricing rule).
- If you buy 3 or more coffe the price drops to 2/3 of the price.

## How to use it
- you can use in CLI by launching in terminal: ruby app.rb
- you can launch it in browser
