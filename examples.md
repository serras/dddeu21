# Set of examples

## Our first exploration

```scala
sig Person { }
sig Course {
  teacher  : Person,
  students : set Person
}
```

## Everything is a set

```scala
sig Person { }
sig Course {
  teacher  : Person,
  students : some Person
} {
  no teacher & students
}
```

## Counter-examples

```scala
assert NoTeacherIsStudent {
  all c1 : Course | no c2 : Course | c1.teacher in c2.students
}

check NoTeacherIsStudent for 3
```

## Referees and players

```scala
abstract sig Person { }  // no elements
sig Referee extends Person { }
sig Player  extends Person { }
```

## Matches for a given week

```scala
// a week is tied to a match
sig Week  { }
sig Match { week : Week }

fact EachWeekHasOneMatch {
  all w : Week | some week.w  // post-join
}
```

## Cart model - describing a snapshot

```scala
open util/integer

one sig Product {
  available: Int
}

enum Status { Open, CheckedOut }

sig Cart {
  status: Status,
  amount: Int
}
```

## There's more!

## Relations

```scala
sig Person { }

abstract sig Grade { }
one sig Fail extends Grade { }
sig Pass extends Grade { }

sig Course { 
  grades : Person -> one Grade
}
```

### Dependent fields

```scala
sig Person { }
sig Team {
  players : set Person,
  captain : one players
}
```