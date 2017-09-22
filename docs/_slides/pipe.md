---
---

## Chaining functions

All those functions from the dplyr package take a data frame as their first argument, and they return a data frame. This consistent syntax is on purpose. It is designed for easily chaining data transformations together: processing data frames in easy-to-read steps.

===

The "pipe" operator (`%>%`) from the [magrittr](){:.rpkg} package is loaded by dplyr. The pipe takes the expression on its left-hand side and hands it over as the first argument to the function on its right-hand side.

===

Equivalent to `sum(c(1,3,5))`, for example, we have:


~~~r
c(1, 3, 5) %>% sum()
~~~
{:.input}
~~~
[1] 9
~~~
{:.output}

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

The pipe operator's main utility is to condense a chain of operations applied to the same piece of data, when you don't need to save the intermediate results. We can do both the filter and select operations from above with one assignment.

===


~~~r
animals_1990_winter <- animals %>%
    filter(year == 1990, month %in% 1:3) %>%
    select(-year)
~~~
{:.text-document title="{{ site.handouts }}"}

===


~~~r
str(animals_1990_winter)
~~~
{:.input}
~~~
'data.frame':	491 obs. of  8 variables:
 $ id             : int  16879 16880 16881 16882 16883 16884 16885 16886 16887 16888 ...
 $ month          : int  1 1 1 1 1 1 1 1 1 1 ...
 $ day            : int  6 6 6 6 6 6 6 6 6 6 ...
 $ plot_id        : int  1 1 6 23 12 24 12 24 12 17 ...
 $ species_id     : Factor w/ 48 levels "AB","AH","AS",..: 12 17 23 33 33 33 38 39 38 13 ...
 $ sex            : Factor w/ 2 levels "F","M": 1 2 2 1 2 2 2 1 2 2 ...
 $ hindfoot_length: int  37 21 16 17 17 17 25 30 28 36 ...
 $ weight         : int  35 28 7 9 10 9 35 73 44 55 ...
~~~
{:.output}
