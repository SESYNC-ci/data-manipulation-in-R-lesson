---
---

## Chaining operations with pipes (%>%)

<aside class="notes" markdown="block">

We have seen that dplyr functions all take a data frame as their first argument and return a transformed data frame. This consistent syntax has the added benefit of making these functions compatible the "pipe" operator (`%>%`). This operator actually comes from another R package, **magrittr**, which is loaded with dplyr by default.

</aside>

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
prop_1990_winter_piped <- surveys %>%
    filter(year == 1990, month %in% 1:3) %>% 
    select(-year) %>%
    group_by(species_id) %>%
    summarize(count = n()) %>%
    mutate(prop = count / sum(count))
~~~
{:.text-document title="{{ site.handouts }}"}


~~~r
identical(prop_1990_winter_piped, prop_1990_winter)
~~~
{:.input}
~~~
[1] TRUE
~~~
{:.output}
