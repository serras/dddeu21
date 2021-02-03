open util/integer

one sig Product {
  var available: Int
}

enum Status { Open, CheckedOut }

sig Cart {
  var status: Status,
  var amount: Int
}

pred addToCart[c: Cart, n: Int] {
  // pre
  c.status = Open
  gt[n, 0]                   // n > 0
  gte[Product.available, n]  // Product.available >= n
  // refined
  gte[Product.available, add[c.amount, n]]
  // changed
  c.amount' = add[c.amount, n]
  // unchanged
  c.status' = Open
  Product.available' = Product.available
  all d: Cart - c | d.status' = d.status && d.amount' = d.amount
}

pred checkOut[c: Cart] {
  // pre
  c.status = Open
  gt[c.amount, 0]
  // changed
  c.status' = CheckedOut
  Product.available' = minus[Product.available, c.amount]
  // unchanged
  c.amount' = c.amount
  all d: Cart - c | d.status' = d.status && d.amount' = d.amount
}

pred skip {
  // everything is unchanged
  Product.available' = Product.available
  all c: Cart |
    c.status' = c.status && c.amount' = c.amount
}

fact trace {
  // initial status
  Product.available = 2
  all c: Cart | c.amount = 0 && c.status = Open
  // steps
  always (skip or (some c : Cart, n: Int | addToCart[c,n]) or (some c: Cart | checkOut[c]))
}

assert AlwaysOpen {
  always (all c: Cart | c.status = Open)
}

assert AtTheEndCheckedOut {
  eventually (all c: Cart | c.status = CheckedOut)
}

assert NotLessThanZeroProducts {
  always gte[Product.available, 0]
}

check NotLessThanZeroProducts