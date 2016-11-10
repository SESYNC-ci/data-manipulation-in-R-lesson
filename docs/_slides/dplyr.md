---
---

## Key functions in dplyr

| Function                                 | Returns                                                                                                               |
|------------------------------------------+-----------------------------------------------------------------------------------------------------------------------|
| filter(*data*, *conditions*)             | rows from *data* where *conditions* hold                                                                              |
| select(*data*, *variables*)              | a subset of the columns in *data*, as specified in *variables*                                                        |
| arrange(*data*, *variables*)             | *data* sorted by *variables*                                                                                          |
| group_by(*data*, *variables*)            | a copy of *data*, with groups defined by *variables*                                                                  |
| summarize(*data*, *newvar* = *function*) | a data frame with *newvar* columns that summarize *data* (or each group in *data*) based on an aggregation *function* |
| mutate(*data*, *newvar* = *function*)    | a data frame with *newvar* columns defined by a *function* of existing columns                                        |

<aside class="notes" markdown="block">

The table above presents the most commonly used functions in `dplyr`, which we will demonstrate in turn, starting from the *surveys* data frame.

</aside>

===

## Subsetting and sorting

After loading dplyr, we begin our analysis by extracting the survey observations for the first three months of 1990 with `filter`:


~~~r
library(dplyr)
surveys_1990_winter <- filter(surveys,
			      year == 1990,
			      month %in% 1:3)
~~~
{:.text-document title="{{ site.worksheet }}"}


~~~r
str(surveys_1990_winter)
~~~
{:.input}
~~~
'data.frame':	491 obs. of  9 variables:
 $ record_id      : int  16879 16880 16881 16882 16883 16884 16885 16886 16887 16888 ...
 $ month          : int  1 1 1 1 1 1 1 1 1 1 ...
 $ day            : int  6 6 6 6 6 6 6 6 6 6 ...
 $ year           : int  1990 1990 1990 1990 1990 1990 1990 1990 1990 1990 ...
 $ plot_id        : int  1 1 6 23 12 24 12 24 12 17 ...
 $ species_id     : Factor w/ 48 levels "AB","AH","AS",..: 12 17 23 33 33 33 38 39 38 13 ...
 $ sex            : Factor w/ 2 levels "F","M": 1 2 2 1 2 2 2 1 2 2 ...
 $ hindfoot_length: int  37 21 16 17 17 17 25 30 28 36 ...
 $ weight         : int  35 28 7 9 10 9 35 73 44 55 ...
~~~
{:.output}

<aside class="notes" markdown="block">

Note that a logical "and" is implied when conditions are separated by commas. (This is perhaps the main way in which `filter` differs from the base R `subset` function.) Therefore, the example above is equivalent to `filter(surveys, year == 1990 & month %in% 1:3)`. A logical "or" must be specified explicitly with the `|` operator.

</aside>

===

To choose particular columns (rather than the rows) of a data frame, we would call `select` with the name of the variables to retain.


~~~r
select(surveys_1990_winter,
       record_id, month, day, plot_id,
       species_id, sex, hindfoot_length, weight)
~~~
{:.input}

===


Alternatively, we can *exclude* a column by preceding its name with a minus sign. We use this option here to remove the redundant year column from *surveys_1990_winter*:


~~~r
surveys_1990_winter <- select(surveys_1990_winter, -year)
~~~
{:.text-document title="{{ site.worksheet }}"}


~~~r
str(surveys_1990_winter)
~~~
{:.input}
~~~
'data.frame':	491 obs. of  8 variables:
 $ record_id      : int  16879 16880 16881 16882 16883 16884 16885 16886 16887 16888 ...
 $ month          : int  1 1 1 1 1 1 1 1 1 1 ...
 $ day            : int  6 6 6 6 6 6 6 6 6 6 ...
 $ plot_id        : int  1 1 6 23 12 24 12 24 12 17 ...
 $ species_id     : Factor w/ 48 levels "AB","AH","AS",..: 12 17 23 33 33 33 38 39 38 13 ...
 $ sex            : Factor w/ 2 levels "F","M": 1 2 2 1 2 2 2 1 2 2 ...
 $ hindfoot_length: int  37 21 16 17 17 17 25 30 28 36 ...
 $ weight         : int  35 28 7 9 10 9 35 73 44 55 ...
~~~
{:.output}

===


To complete this section, we sort the 1990 winter surveys data by descending order of species name, then by ascending order of weight. Note that `arrange` assumes ascending order unless the variable name is enclosed by `desc()`.


~~~r
sorted <- arrange(surveys_1990_winter,
                  desc(species_id), weight)
~~~
{:.text-document title="{{ site.worksheet }}"}


~~~r
head(sorted)
~~~
{:.input}
~~~
  record_id month day plot_id species_id sex hindfoot_length weight
1     16929     1   7       3         SH   M              31     61
2     17172     2  25       3         SH   F              29     67
3     17327     3  30       2         SH   M              30     69
4     16886     1   6      24         SH   F              30     73
5     17359     3  30       3         SH   F              31     77
6     17170     2  25       3         SH   M              30     80
~~~
{:.output}

===

### Exercise 2

Write code that returns the *record_id*, *sex* and *weight* of all surveyed individuals of *Reithrodontomys montanus* (RO).

<aside class="notes" markdown="block">

[View solution](#solution-2)

</aside>

===

## Grouping and aggregation

Another common type of operation on tabular data involves the aggregation of records according to specific grouping variables. In particular, let's say we want to count the number of individuals by species observed in the winter of 1990.

<aside class="notes" markdown="block">

We first define a grouping of our *surveys_1990_winter* data frame with `group_by`, then call `summarize` to aggregate values in each group using a given function (here, the built-in function `n()` to count the rows).

</aside>


~~~r
surveys_1990_winter_gb <- group_by(surveys_1990_winter, species_id)
counts_1990_winter <- summarize(surveys_1990_winter_gb, count = n())
~~~
{:.text-document title="{{ site.worksheet }}"}


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

<aside class="notes" markdown="block">

You can see attributes either by running the `str()` function on the data frame or by inspecting it in the RStudio *Environment* pane.

</aside>

===


### Exercise 3

Write code that returns the average weight and hindfoot length of *Dipodomys merriami* (DM) individuals observed in each month (irrespective of the year). Make sure to exclude *NA* values.

<aside class="notes" markdown="block">

[View solution](#solution-3)

</aside>

===

## Pivot tables through aggregate and spread

A pivot table takes tidy data into an untidy format, summarizing data by two factors (one as a row, the other a column).
Its equivalent to a particular way of grouping and aggregation with `dplyr` combined with the `spread()` function.


~~~r
surveys_1990_winter_gb <- group_by(surveys_1990_winter, species_id, month)
counts_by_month <- summarize(surveys_1990_winter_gb, count = n())
pivot <- spread(counts_by_month, value = count, key = month, fill = 0)
~~~
{:.text-document title="{{ site.worksheet }}"}


~~~r
head(pivot)
~~~
{:.input}
~~~
Source: local data frame [6 x 4]
Groups: species_id [6]

  species_id     1     2     3
      <fctr> <dbl> <dbl> <dbl>
1         AB    24     0     1
2         AH     3     1     0
3         BA     1     2     0
4         DM    60    35    37
5         DO    31    17    17
6         DS     3     1     2
~~~
{:.output}

===

## Transformation of variables

The `mutate` function creates new columns by performing the same operation on each row. Here, we use the previously obtained *count* variable to derive the proportion of individuals represented by each species, and assign the result to a new *prop* column.


~~~r
prop_1990_winter <- mutate(counts_1990_winter,
                           prop = count / sum(count))
~~~
{:.text-document title="{{ site.worksheet }}"}


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

We often use `group_by` along with `summarize`, but you can also apply `filter` and `mutate` operations on groups.

- Filter a grouped data frame to return only rows showing the records from *surveys_1990_winter* with the minimum weight for each *species_id*.
- For each species in *surveys_1990_winter_gb*, create a new colum giving the rank order (within that species!) of hindfoot length. (Hint: Read the documentation under `?ranking`.)

<aside class="notes" markdown="block">

[View solution](#solution-4)

</aside>
