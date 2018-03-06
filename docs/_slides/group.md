---
---

## Split-apply-combine

A very common data manipulation procedure is doing some "group-wise" operations on a dataset and combing the results for each group into a single table. For example, say you need to count the number of individuals *of each species* observed in the winter of 1990.

===

## Grouping

The dplyr function `group_by` begins the process by indicating how the data frame should be split into subsets.


~~~r
counts_1990_winter <- animals_1990_winter %>%
    group_by(species_id)
~~~
{:.text-document title="{{ site.handouts[0] }}"}

===

At this point, nothing has really changed:


~~~r
str(counts_1990_winter)
~~~
{:.input}
~~~
Classes 'grouped_df', 'tbl_df', 'tbl' and 'data.frame':	491 obs. of  8 variables:
 $ id             : int  16879 16880 16881 16882 16883 16884 16885 16886 16887 16888 ...
 $ month          : int  1 1 1 1 1 1 1 1 1 1 ...
 $ day            : int  6 6 6 6 6 6 6 6 6 6 ...
 $ plot_id        : int  1 1 6 23 12 24 12 24 12 17 ...
 $ species_id     : Factor w/ 48 levels "AB","AH","AS",..: 12 17 23 33 33 33 38 39 38 13 ...
 $ sex            : Factor w/ 2 levels "F","M": 1 2 2 1 2 2 2 1 2 2 ...
 $ hindfoot_length: int  37 21 16 17 17 17 25 30 28 36 ...
 $ weight         : int  35 28 7 9 10 9 35 73 44 55 ...
 - attr(*, "vars")= chr "species_id"
 - attr(*, "drop")= logi TRUE
 - attr(*, "indices")=List of 20
  ..$ : int  13 46 88 102 103 108 113 114 121 127 ...
  ..$ : int  22 141 147 325
  ..$ : int  72 295 311
  ..$ : int  0 33 35 51 56 60 63 64 66 67 ...
  ..$ : int  9 12 20 27 41 42 44 49 53 54 ...
  ..$ : int  79 99 228 352 409 474
  ..$ : int  37 116 254 258 267 285 351 396 402 438
  ..$ : int  1 24 157 164 273 278 420
  ..$ : int  11 14 15 48 62 82 137 152 185 194 ...
  ..$ : int  243 283 296 302 320 332 340
  ..$ : int  32 47 58 76 109 110 112 118 142 165 ...
  ..$ : int  2 36 45 105 120 123 144 174 237 246 ...
  ..$ : int  136 140 146 148
  ..$ : int  145 276 393
  ..$ : int 80
  ..$ : int  52 59 124 135 225 233 312 373 425 433
  ..$ : int  3 4 5 17 19 21 23 25 26 28 ...
  ..$ : int  6 8 10 16 18 111 119 138 248 252 ...
  ..$ : int  7 50 291 293 421 448 480
  ..$ : int 104
 - attr(*, "group_sizes")= int  25 4 3 132 65 6 10 7 22 7 ...
 - attr(*, "biggest_group_size")= int 132
 - attr(*, "labels")='data.frame':	20 obs. of  1 variable:
  ..$ species_id: Factor w/ 48 levels "AB","AH","AS",..: 1 2 4 12 13 14 16 17 18 21 ...
  ..- attr(*, "vars")= chr "species_id"
  ..- attr(*, "drop")= logi TRUE
~~~
{:.output}

The `group_by` statement does not change any values in the data frame; it only adds attributes to the the original data frame. You can add multiple variables (separated by commas) in `group_by`; each distinct combination of values across these columns defines a different group.
{:.notes}

===

## Summarize

The operation to perform on each species is counting: we need to count how many records are in each group.


~~~r
counts_1990_winter <- animals_1990_winter %>%
    group_by(species_id) %>%
    summarize(count = n())
~~~
{:.text-document title="{{ site.handouts[0] }}"}

===


~~~r
str(counts_1990_winter)
~~~
{:.input}
~~~
Classes 'tbl_df', 'tbl' and 'data.frame':	20 obs. of  2 variables:
 $ species_id: Factor w/ 48 levels "AB","AH","AS",..: 1 2 4 12 13 14 16 17 18 21 ...
 $ count     : int  25 4 3 132 65 6 10 7 22 7 ...
~~~
{:.output}

===

The "combine" part of "split-apply-combine" occurs automatically, when the attributes introduced by `group_by` are dropped. You can see attributes either by running the `str()` function on the data frame or by inspecting it in the RStudio *Environment* pane.

===

The function `n()` takes no arguments and returns the number of records in a group. Any function that collapses a vector input to a single output is a suitable function to use within `summarize`.


~~~r
weight_1990_winter <- animals_1990_winter %>%
    group_by(species_id) %>%
    summarize(avg_weight = mean(weight, na.rm = TRUE))
~~~
{:.text-document title="{{ site.handouts[0] }}"}

===


~~~r
head(weight_1990_winter)
~~~
{:.input}
~~~
# A tibble: 6 x 2
  species_id avg_weight
  <fct>           <dbl>
1 AB             NaN   
2 AH             NaN   
3 BA               7.67
4 DM              43.4 
5 DO              48.2 
6 DS             130.  
~~~
{:.output}

===

## Exercise 3

Write code that returns the average hindfoot length of *Dipodomys merriami* (DM) individuals observed in each month (irrespective of the year). Make sure to exclude *NA* values.

[View solution](#solution-3)
{:.notes}

===

## Transformation of variables

The `mutate` function creates new columns from existing ones. The data frame returned has an additional column for each argument to `mutate`, unless a name is reused. Overwriting an existing column does not generate a warning.

===

The `count` variable just defined, for example, can be used to calculate the proportion of individuals represented by each species.


~~~r
prop_1990_winter <- counts_1990_winter %>%
    mutate(prop = count / sum(count))
~~~
{:.text-document title="{{ site.handouts[0] }}"}

===


~~~r
head(prop_1990_winter)
~~~
{:.input}
~~~
# A tibble: 6 x 3
  species_id count    prop
  <fct>      <int>   <dbl>
1 AB            25 0.0509 
2 AH             4 0.00815
3 BA             3 0.00611
4 DM           132 0.269  
5 DO            65 0.132  
6 DS             6 0.0122 
~~~
{:.output}
For a concise way to apply the same transformation to multiple columns, check the `mutate_each` function. There is also a `summarize_each` function to perform the same aggregation operation on multiple columns.
{:.notes}

===

Both `mutate` and `summarize` can be used in the "apply" part of a "split-apply-combine" procedure. The difference is that the results are combine into data frames with differing numbers of rows.

===

Question
: How many rows do you expect in the result of a `mutate` operation?

Answer
: {:.fragment} The same number you started with.

===

## Exercise 4

A "pivot table" is a transformation of tidy data into a wide summary table. First, data are summarized by *two* grouping factors, then one of these is "pivoted" into columns. Starting from the `animals` data frame, chain a `group_by` and `summarize` transformation into a [tidyr](){:.rlib} `spread` function to get the number of individuals counted in each month (across 12 columns) by species (across rows).
