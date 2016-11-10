---
---

## Reshaping multiple columns into category/value pairs

Let's load the **tidyr** package and use its `gather` function to reshape *counts_df* into a tidy format:


~~~r
library(tidyr)
counts_gather <- gather(counts_df,
			key = "species",
			value = "count",
			wolf:fox)
~~~
{:.text-document title="{{ site.worksheet }}"}

===


~~~r
counts_gather
~~~
{:.input}
~~~
        day species count
1    Monday    wolf     2
2   Tuesday    wolf     1
3 Wednesday    wolf     3
4    Monday    hare    20
5   Tuesday    hare    25
6 Wednesday    hare    30
7    Monday     fox     4
8   Tuesday     fox     4
9 Wednesday     fox     4
~~~
{:.output}

Here, `gather` takes all columns between `wolf` and `fox` and reshapes them into two columns, the names of which are specified as the key and value. For each row, the key column in the new dataset indicates the column that contained that value in the original dataset.

<aside class="notes" markdown="block">

Some notes on the syntax: From a workflow perspective, a big advantage of tidyr and dplyr is that each function takes a data frame as its first parameter and returns the transformed data frame. As we will see later, it makes it very easy to apply these functions in a chain. All functions also let us use column names as variables without having to prefix them with the name of the data frame (i.e. `wolf` instead of `counts_df$wolf`).

</aside>

===

If your analysis requires a "wide" data format rather than the tall format produced by `gather`, you can use the opposite operation, named `spread`.


~~~r
counts_spread <- spread(counts_gather,
			key = species,
			value = count)
~~~
{:.text-document title="{{ site.worksheet }}"}


~~~r
counts_spread
~~~
{:.input}
~~~
        day fox hare wolf
1    Monday   4   20    2
2   Tuesday   4   25    1
3 Wednesday   4   30    3
~~~
{:.output}

Question
: Why are `species` and `count` not quoted here?

Answer
: {:.fragment} They refer to existing column names.
^

===

### Exercise 1

Try removing a row from `counts_gather` (e.g. `counts_gather <- counts_gather[-8, ]`). How does that affect the outcome of `spread`? Let's say the missing row means that no individual of that species was recorded on that day. How can you reflect that assumption in the outcome of `spread`?

Hint: View the help file for that function by entering `?gather` on the console.

<aside class="notes" markdown="block">

[View solution](#solution-1)

</aside>
