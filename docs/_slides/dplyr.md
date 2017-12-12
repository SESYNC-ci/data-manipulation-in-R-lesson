---
---

## Key dplyr functions

| Function    | Returns                                            |
|-------------+----------------------------------------------------|
| `filter`    | keep rows that staisfy conditions                  |
| `select`    | keep columns with matching names                   |
| `group_by`  | split data into groups by an existing factor       |
| `mutate`    | apply a transformation to existing [split] columns |
| `summarize` | summarize across rows [and combine split groups]   |

The table above presents the most commonly used functions in [dplyr](){:.rlib}, which we will demonstrate in turn, starting from the `animals` data frame.
{:.notes}

===

## Subsetting

The animals table includes numeric `year` and `month` columns. Of the 35,549 observations, lets see how many observations are left when we keep only observations from the first three months of 1990.


~~~r
library(dplyr)
~~~
{:.text-document title="{{ site.handouts[0] }}"}

===


~~~r
animals_1990_winter <- filter(
  animals,
  year == 1990,
  month %in% 1:3)
~~~
{:.text-document title="{{ site.handouts[0] }}"}

===


~~~r
str(animals_1990_winter)
~~~
{:.input}
~~~
'data.frame':	491 obs. of  9 variables:
 $ id             : int  16879 16880 16881 16882 16883 16884 16885 16886 16887 16888 ...
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

Note that a logical "and" is implied when conditions are separated by commas. (This is perhaps the main way in which `filter` differs from the base R `subset` function.) Therefore, the example above is equivalent to `filter(animals, year == 1990 & month %in% 1:3)`. A logical "or" must be specified explicitly with the `|` operator.
{:.notes}

===

To keep particular columns of a data frame (rather than choosing rows) , use the `select` with arguments that match the column names.


~~~r
colnames(animals)
~~~
{:.input}
~~~
[1] "id"              "month"           "day"             "year"           
[5] "plot_id"         "species_id"      "sex"             "hindfoot_length"
[9] "weight"         
~~~
{:.output}

===

One way to "match" is by including complete names, each one you want to keep:


~~~r
select(animals_1990_winter,
  id, month, day, plot_id,
  species_id, sex, hindfoot_length, weight)
~~~
{:.input}

===

Alternatively, we can use a negative "match": keep columns that do not match the name preceded by minus sing.


~~~r
animals_1990_winter <- select(
  animals_1990_winter,
  -year)
~~~
{:.text-document title="{{ site.handouts[0] }}"}

Use this option to remove a single column from a data frame.
{:.notes}

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

<!--
===

To complete this section, we sort the 1990 winter animals data by descending order of species name, then by ascending order of weight. Note that `arrange` assumes ascending order unless the variable name is enclosed by `desc()`.


~~~r
sorted <- arrange(animals_1990_winter,
                  desc(species_id), weight)
~~~
{:.text-document title="{{ site.handouts[0] }}"}


~~~r
head(sorted)
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
-->

===

![]({{ site.baseurl }}/images/img_4185.jpg){:width="40%"}  
*Credit: [The Portal Project](https://portalproject.wordpress.com)*
{:.captioned}

===

## Exercise 2

Write code that returns the `id`, `sex` and `weight` of all surveyed individuals of *Reithrodontomys montanus* (RO).

[View solution](#solution-2)
{:.notes}
