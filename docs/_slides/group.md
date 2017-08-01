---
---

## Grouping and aggregation

Another common type of operation on tabular data involves the aggregation of records according to specific grouping variables. In particular, let's say we want to count the number of individuals by species observed in the winter of 1990.

We first define a grouping of our *animals_1990_winter* data frame with `group_by`, then call `summarize` to aggregate values in each group using a given function (here, the built-in function `n()` to count the rows).
{:.notes}


~~~r
counts_1990_winter <- animals_1990_winter %>%
    group_by(species_id) %>%
    summarize(count = n())
~~~
{:.text-document title="{{ site.handouts }}"}


~~~r
head(counts_1990_winter)
~~~
{:.input}
~~~
# A tibble: 6 x 2
  species_id count
      <fctr> <int>
1         AB    25
2         AH     4
3         BA     3
4         DM   132
5         DO    65
6         DS     6
~~~
{:.output}

===

A few notes on these functions: 

- `group_by` makes no changes to the data frame values, but it adds metadata -- in the form of R *attributes* -- to identify groups.
- You can add multiple variables (separated by commas) in `group_by`; each distinct combination of values across these columns defines a different group.
- A single call to `summarize` can define more than one variable, each with its own function.

You can see attributes either by running the `str()` function on the data frame or by inspecting it in the RStudio *Environment* pane.
{:.notes}

===

The aggregation function `n()` took no arguments, only counting the number of rows in each group. Any function that takes a vector, or multiple vectors, to a single output is an aggregation function.


~~~r
weight_1990_winter <- animals_1990_winter %>%
    group_by(species_id) %>%
    summarize(avg_weight = mean(weight, na.rm = TRUE))
~~~
{:.text-document title="{{ site.handouts }}"}


~~~r
head(weight_1990_winter)
~~~
{:.input}
~~~
# A tibble: 6 x 2
  species_id avg_weight
      <fctr>      <dbl>
1         AB        NaN
2         AH        NaN
3         BA   7.666667
4         DM  43.372093
5         DO  48.222222
6         DS 130.000000
~~~
{:.output}

===

## Exercise 3

Write code that returns the average hindfoot length of *Dipodomys merriami* (DM) individuals observed in each month (irrespective of the year). Make sure to exclude *NA* values.

[View solution](#solution-3)
{:.notes}

===

## Transformation of variables

The `mutate` function creates new columns by performing the same operation on each row. Here, we use the previously obtained *count* variable to derive the proportion of individuals represented by each species, and assign the result to a new *prop* column.


~~~r
prop_1990_winter <- counts_1990_winter %>%
    mutate(prop = count / sum(count))
~~~
{:.text-document title="{{ site.handouts }}"}


~~~r
head(prop_1990_winter)
~~~
{:.input}
~~~
# A tibble: 6 x 3
  species_id count       prop
      <fctr> <int>      <dbl>
1         AB    25 0.05091650
2         AH     4 0.00814664
3         BA     3 0.00610998
4         DM   132 0.26883910
5         DO    65 0.13238289
6         DS     6 0.01221996
~~~
{:.output}

===

A few notes about transformations:

- With `mutate`, you can assign the result of an expression to an existing column name to overwrite that column.
- As we will see below, `mutate` also works with groups. The key difference between `mutate` and `summarize` is that the former always returns a data frame with the same number of rows, while the latter reduces the number of rows.
- For a concise way to apply the same transformation to multiple columns, check the `mutate_each` function. There is also a `summarize_each` function to perform the same aggregation operation on multiple columns.
^

===

### Exercise 4

Combine the [tidyr](){:.rlib} `spread` function with the [dplyr](){:.rlib} tools (almost all of them!) to produce a "pivot table". Recall that a pivot table represents a values defined by two categorical variables: one given by the row name and the other by the column name. For the `animals_1990_winter` data only, create a pivot table that gives the proportion of individuals counted in each month, by species. Hint: begin with `animals_1990_winter` piped into a `group_by` on *both* species_id and month.
