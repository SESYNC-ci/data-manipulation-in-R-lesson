---
---

## Reshaping multiple columns into category/value pairs

Let's load the [tidyr](){:.rlib} package and use its `gather` function to reshape `response` into a tidy format:


~~~r
library(tidyr)

df <- gather(response, key = "factor", value = "response", -trial)
~~~
{:.text-document title="{{ site.handouts }}"}

Here, `gather` takes all columns accept for "trial" and reshapes them into two columns, the key becomes "factor" and the value is named "response". For each row in the result, the key is taken from the name of the column and the value from the data in the column.

===


~~~r
df
~~~
{:.input}
~~~
  trial    factor response
1     1 treatment     0.22
2     2 treatment     0.58
3     3 treatment     0.31
4     1   control     0.42
5     2   control     0.19
6     3   control     0.40
~~~
{:.output}

Some notes on the syntax: a big advantage of [tidyr](){:.rlib} and [dplyr](){:.rlib} is that each function takes a data frame as its first argument and returns a new data frame. As we will see later, it makes it very easy to apply these functions in a chain. All functions also use column names as variables without subsetting them from a data frame (i.e. `trial` instead of `response$trial`).
{:.notes}

===

Some analyses require a "wide" data format rather than the long format produced by `gather`. The community ecology package [vegan](){:.rlib} uses a matrix of species counts, where rows correspond to species and columns to sites.

Suppose the data are available in a long (or "entity-attribute-value" format)


~~~r
counts <- data.frame(
  site = rep(1:3, each = 2),
  species = rep(c("lynx", "hare"), 3),
  n = c(2, 341, 7, 42, 0, 289)
)
~~~
{:.text-document title="{{ site.handouts }}"}

===

Transform the data with the `spread` function, which "reverses" a `gather`.


~~~r
counts_spread <- spread(counts,
			key = species,
			value = n)
~~~
{:.text-document title="{{ site.handouts }}"}


~~~r
counts_spread
~~~
{:.input}
~~~
  site hare lynx
1    1  341    2
2    2   42    7
3    3  289    0
~~~
{:.output}

===

Question
: Why were `species` and `count` not quoted in the call to `spread`?

Answer
: {:.fragment} They refer to existing column names. In `gather`, quotes are used to create new column names.

===

### Exercise 1

It is uncommon for records of zero abundance to be recorded, so remove the row from `counts` that records 0 lynx in site 3. How does the outcome of `spread` differ with that one row taken out? Can you specify that the missing row actually means no individuals of that species were recorded? (Don't forget to `?gather` for help!)

[View solution](#solution-1)
{:.notes}
