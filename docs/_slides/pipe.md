---
---

## Chaining operations with pipes (%>%)

We have seen that dplyr functions all take a data frame as their first argument and return a transformed data frame. This consistent syntax has the added benefit of making these functions compatible the "pipe" operator (`%>%`). This operator actually comes from another R package, **magrittr**, which is loaded with dplyr by default.
{:.notes}

What a pipe, or `%>%`, does is to take the expression on its left-hand side and pass it as the first argument to the function on its right-hand side. Here is a simple example:


~~~r
c(1, 3, 5) %>% sum()
~~~
{:.input}
~~~
[1] 9
~~~
{:.output}

It's identical to `sum(c(1,3,5))`.

===

Additional arguments are accepted, a pipe only handles the first.


~~~r
c(1, 3, 5, NA) %>% sum(na.rm = TRUE)
~~~
{:.input}
~~~
[1] 9
~~~
{:.output}

===

The pipe operator's main utility is to condense a chain of operations applied to the same piece of data, when you don't need to save the intermediate results. We can do all the dplyr operations from above with a chain of pipes:


~~~r
sorted_pipe <- animals %>%
    filter(year == 1990, month %in% 1:3) %>%
    select(-year) %>%
    arrange(desc(species_id), weight)
~~~
{:.text-document title="{{ site.handouts }}"}


~~~r
head(sorted_pipe)
~~~
{:.input}
~~~
     id month day plot_id species_id sex hindfoot_length weight
1 16929     1   7       3         SH   M              31     61
2 17172     2  25       3         SH   F              29     67
3 17327     3  30       2         SH   M              30     69
4 16886     1   6      24         SH   F              30     73
5 17359     3  30       3         SH   F              31     77
6 17170     2  25       3         SH   M              30     80
~~~
{:.output}
