# README

This repo contains a programming challenge for people who are interested in applying
for a backend developer job at SeQura.

## The code

The code in this repo represents a very simplified view of the data model used in SeQura's
backend.  It contains three models:

* `Merchant`: A merchant is a person or company who has a shop on the internet and offers
	SeQura's payment methods.
* `Order`: Orders are the central object in the day-to-day work at SeQura.  They represent
	a shopper's order in an online store, and they are only present in this system if
	SeQura approved the shopper's request for a short-term credit.
* `Cart`: A cart represents a list of items such as products, shipment fees, service fees,
	discounts, etc.  Each order has two such lists, one representing the items that have
	been sent and one representing the items that have not yet been sent.  In its role as
	intermediary, SeQura collects payment from the shopper for the value of _both_ carts,
	but only pays the merchant the value of the items that have been shipped.

## The challenge

Every week on Tuesdays, SeQura will pay out money to the merchants in a process called _disbursement_.
Your task is to make
the system calculate _how much_ money should be paid to each merchant based on the following
rules:

1. If an order is included in the disbursement for the first time, we should pay to the merchant
	the value of the shipped cart minus 50 cents, which is our commission.
1. If the value of the shipped cart has changed since last time the order was disbursed, the order should
	be included in the disbursement again.  (The value of the shipped cart changes quite often, sometimes
	because the merchant shipped the second half of an order, and sometimes because the shopper returned
	one or more items.)
1. After a disbursement, SeQura should not owe any money for orders which were shipped _before_ last week
	or earlier.  Orders which were _not_ shipped at the beginning of last week should _not_ be included in
	the disbursement.

You should implement the calculation logic so that it can be launched by a cronjob on a server
using a syntax similar to this:

```bash
rails runner DisbursementBuilder.run_weekly
```

Running this should not produce anything on stdout, but feel free to log what you are doing using
Rails's logger.

The result should be accessible from each merchant's page, so that if you go to `http://localhost:3000/merchants/1`
you should see a list of disbursements, like so:

* Disbursement 2016-03-01
* Disbursement 2016-03-08

Clicking on one of the dates should render a list that can be used by us to know the amount to pay to the merchant
on that day, and a list of the orders (using order numbers) included in this disbursement, so that the merchant can update their books
and feel assured that we have paid them what we owe them.  An example:

```
Disbursement 2016-03-01

O#BBB123	12.34 €
O#BBB125	 2.34 €
O#BBB111	-8.33 €

=total=		 6.35 €
```

### Instructions

1. You are not allowed to _change_ anything that is defined.  Other parts of the system rely on the models looking
	and working like they do.
1. You can add new models as you see fit.
1. You can add attributes to the existing models, but try to keep your solution to your objects.
1. Use meaningful names for models, methods and associations.
1. Avoid calling things "payment" or anything close to that word.  The reason is that we use "payment"
	when we talk about the money that they shopper gives to us, and we want to avoid confusion.
1. You are programming money and the rules are complex.  Automatic tests are absolutely mandatory.

### Notes

1. Once created, cart objects do not change.  Instead when an order changes, we create a _new_ cart object
	and change the association on the order object.

## To get started

The code in the repo was developed with Rails 5.0.0beta3 and sqlite3.  There are
a few tests that show how the models work, individually and together.  You should be able
to set up this repo locally for development with these steps:

```bash
git clone git@github.com:sequra/disbursement-challenge.git
cd disbursement-challenge
bundle
rails db:migrate
rails test
```
