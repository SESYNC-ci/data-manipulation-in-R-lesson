---
title: "Data manipulation with tidyr and dplyr"
author: "Philippe Marchand"
output: md_document
style: /master/css/lesson.css
---

<section>

# Data manipulation with tidyr and dplyr

Instructor: Philippe Marchand

<aside class="notes">

* ToC
{:toc}

</aside>

</section>
<section>

We will first discuss what is a **tidy** dataset and how to convert data to this standard form with `tidyr`. Next, we will explore the data processing functions in `dplyr`, which work particularly well with the tidy data format.

<aside class="notes">

Data frames generally occupy a central place in R analysis workflows. While the base R functions provide most necessary tools to subset, reformat and transform data frames, the specialized packages we will use in this lesson -- **tidyr** and **dplyr** -- offer a more succinct and often computationally faster way to perform the common data frame processing steps. Beyond saving typing time, the simpler syntax also makes scripts more readable and easier to debug. The key functions from that package all have close counterparts in SQL (Structured Query Language), which provides the added bonus of facilitating the transition from R to relational databases.

</aside>

</section>
<section>
  <section>

## Tidy data concept

R developer Hadley Wickham (author of the tidyr, dplyr and ggplot packages, among others) defines tidy datasets as those where:

* each variable forms a column;
* each observation forms a row; and
* each type of observational unit forms a table. ([Wickham 2014](http://www.jstatsoft.org/v59/i10/paper))

These guidelines may be familiar to some of you, as they closely map to best practices in database design.

  </section>
  <section>

Build a `data.frame` where the counts of three species are recorded for each day in a week:


~~~r
counts_df <- data.frame(
  day = c("Monday", "Tuesday", "Wednesday"),
  wolf = c(2, 1, 3),
  hare = c(20, 25, 30),
  fox = c(4, 4, 4)
)
~~~
{:.text-document title="lesson-2.R"}

~~~r
counts_df
~~~
{:.input}

~~~
        day wolf hare fox
1    Monday    2   20   4
2   Tuesday    1   25   4
3 Wednesday    3   30   4
~~~
{:.output}

  </section>
  <section>

Question
: How would you structure this data in a tidy format as defined above?

Answer
: {:.fragment} *counts_df* currently has three columns (*wolf*, *hare* and *fox*) representing the same variable (a count). Since each reported observation is the count of individuals from a given species on a given day: the tidy format should have three columns: *day*, *species* and *count*.

<aside class="notes">

To put it another way, if your analysis requires grouping observations based on some characteristic (e.g. draw a graph of the counts over time with a different color for each species), then this characteristic should be recorded as different levels of a categorical variable (species) rather than spread across different variables/columns. 

While the tidy format is optimal for many common data frame operations in R (aggregation, plotting, fitting statistical models), it is not the optimal structure for every case. As an example, community ecology analyses often start from a matrix of counts where rows and columns correspond to species and sites.

</aside>

  </section>
</section>
<section>
  <section>

## Reshaping multiple columns into category/value pairs

Let's load the **tidyr** package and use its `gather` function to reshape *counts_df* into a tidy format:


~~~r
library(tidyr)
counts_gather <- gather(counts_df, key = "species", value = "count", wolf:fox)
~~~
{:.text-document title="lesson-2.R"}

  </section>
  <section>


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

<aside class="notes">

Some notes on the syntax: From a workflow perspective, a big advantage of tidyr and dplyr is that each function takes a data frame as its first parameter and returns the transformed data frame. As we will see later, it makes it very easy to apply these functions in a chain. All functions also let us use column names as variables without having to prefix them with the name of the data frame (i.e. `wolf` instead of `counts_df$wolf`).

</aside>

  </section>
  <section>

If your analysis requires a "wide" data format rather than the tall format produced by `gather`, you can use the opposite operation, named `spread`.


~~~r
counts_spread <- spread(counts_gather, key = species, value = count)
~~~
{:.text-document title="lesson-2.R"}


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

  </section>
  <section>

### Exercise 1

Try removing a row from `counts_gather` (e.g. `counts_gather <- counts_gather[-8, ]`). How does that affect the outcome of `spread`? Let's say the missing row means that no individual of that species was recorded on that day. How can you reflect that assumption in the outcome of `spread`?

Hint: View the help file for that function by entering `?gather` on the console.

<aside class="notes">

[View solution](#solution-1)

</aside>

  </section>
</section>
<section>
  <section>

## Sample data

We will use the [Portal teaching database](http://github.com/weecology/portal-teachingdb), a simplified dataset derived from a long-term study of animal populations in the Chihuahuan Desert.


~~~r
surveys <- read.csv("data/surveys.csv")
~~~
{:.text-document title="lesson-2.R"}


~~~r
str(surveys)
~~~
{:.input}

~~~
'data.frame':	35549 obs. of  9 variables:
 $ record_id      : int  1 2 3 4 5 6 7 8 9 10 ...
 $ month          : int  7 7 7 7 7 7 7 7 7 7 ...
 $ day            : int  16 16 16 16 16 16 16 16 16 16 ...
 $ year           : int  1977 1977 1977 1977 1977 1977 1977 1977 1977 1977 ...
 $ plot_id        : int  2 3 2 7 3 1 2 1 1 6 ...
 $ species_id     : Factor w/ 49 levels "","AB","AH","AS",..: 17 17 13 13 13 24 23 13 13 24 ...
 $ sex            : Factor w/ 3 levels "","F","M": 3 3 2 3 3 3 2 3 2 2 ...
 $ hindfoot_length: int  32 33 37 36 35 14 NA 37 34 20 ...
 $ weight         : int  NA NA NA NA NA NA NA NA NA NA ...
~~~
{:.output}

<aside class="notes">

The teaching dataset includes three tables: two contain summary information on the study plots and observed species, respectively, while the third and largest one (surveys) lists all individual observations. We only need the surveys table for this lesson.

</aside>

  </section>
  <section>

Modify the function to specify what string in the CSV file represents NAs, a.k.a. data that is not-available or missing.


~~~r
surveys <- read.csv("data/surveys.csv", na.strings = "")
~~~
{:.text-document title="lesson-2.R"}

Question
: What has changed?

Answer
: {:.fragment} The `str` shows that the factors have one less level, and the empty string is not included.
^

  </section>
</section>
<section>
  <section>

## Key functions in dplyr

| Function                                 | Returns                                                                                                               |
|------------------------------------------+-----------------------------------------------------------------------------------------------------------------------|
| filter(*data*, *conditions*)             | rows from *data* where *conditions* hold                                                                              |
| select(*data*, *variables*)              | a subset of the columns in *data*, as specified in *variables*                                                        |
| arrange(*data*, *variables*)             | *data* sorted by *variables*                                                                                          |
| group_by(*data*, *variables*)            | a copy of *data*, with groups defined by *variables*                                                                  |
| summarize(*data*, *newvar* = *function*) | a data frame with *newvar* columns that summarize *data* (or each group in *data*) based on an aggregation *function* |
| mutate(*data*, *newvar* = *function*)    | a data frame with *newvar* columns defined by a *function* of existing columns                                        |

<aside class="notes">

The table above presents the most commonly used functions in `dplyr`, which we will demonstrate in turn, starting from the *surveys* data frame.

</aside>

  </section>
  <section>

## Subsetting and sorting

After loading dplyr, we begin our analysis by extracting the survey observations for the first three months of 1990 with `filter`:


~~~r
library(dplyr)
surveys_1990_winter <- filter(surveys, year == 1990, month %in% 1:3)
~~~
{:.text-document title="lesson-2.R"}


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

<aside class="notes">

Note that a logical "and" is implied when conditions are separated by commas. (This is perhaps the main way in which `filter` differs from the base R `subset` function.) Therefore, the example above is equivalent to `filter(surveys, year == 1990 & month %in% 1:3)`. A logical "or" must be specified explicitly with the `|` operator.

</aside>

  </section>
  <section>

To choose particular columns (rather than the rows) of a data frame, we would call `select` with the name of the variables to retain.


~~~r
select(surveys_1990_winter, record_id, month, day, plot_id, species_id, sex, hindfoot_length, weight)
~~~
{:.input}

  </section>
  <section>

Alternatively, we can *exclude* a column by preceding its name with a minus sign. We use this option here to remove the redundant year column from *surveys_1990_winter*:


~~~r
surveys_1990_winter <- select(surveys_1990_winter, -year)
~~~
{:.text-document title="lesson-2.R"}


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

  </section>
  <section>

To complete this section, we sort the 1990 winter surveys data by descending order of species name, then by ascending order of weight. Note that `arrange` assumes ascending order unless the variable name is enclosed by `desc()`.


~~~r
sorted <- arrange(surveys_1990_winter, desc(species_id), weight)
~~~
{:.text-document title="lesson-2.R"}


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

  </section>
  <section>

### Exercise 2

Write code that returns the *record_id*, *sex* and *weight* of all surveyed individuals of *Reithrodontomys montanus* (RO).

<aside class="notes">

[View solution](#solution-2)

</aside>

  </section>
  <section>

## Grouping and aggregation

Another common type of operation on tabular data involves the aggregation of records according to specific grouping variables. In particular, let's say we want to count the number of individuals by species observed in the winter of 1990.

<aside class="notes">

We first define a grouping of our *surveys_1990_winter* data frame with `group_by`, then call `summarize` to aggregate values in each group using a given function (here, the built-in function `n()` to count the rows).

</aside>


~~~r
surveys_1990_winter_gb <- group_by(surveys_1990_winter, species_id)
counts_1990_winter <- summarize(surveys_1990_winter_gb, count = n())
~~~
{:.text-document title="lesson-2.R"}


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

  </section>
  <section>

A few notes on these functions: 

- `group_by` makes no changes to the data frame values, but it adds metadata -- in the form of R *attributes* -- to identify groups.
- You can add multiple variables (separated by commas) in `group_by`; each distinct combination of values across these columns defines a different group.
- A single call to `summarize` can define more than one variable, each with its own function.

<aside class="notes">

You can see attributes either by running the `str()` function on the data frame or by inspecting it in the RStudio *Environment* pane.

</aside>

</section>
  <section>

### Exercise 3

Write code that returns the average weight and hindfoot length of *Dipodomys merriami* (DM) individuals observed in each month (irrespective of the year). Make sure to exclude *NA* values.

<aside class="notes">

[View solution](#solution-3)

</aside>

  </section>
  <section>

## Transformation of variables

The `mutate` function creates new columns by performing the same operation on each row. Here, we use the previously obtained *count* variable to derive the proportion of individuals represented by each species, and assign the result to a new *prop* column.


~~~r
prop_1990_winter <- mutate(counts_1990_winter, prop = count / sum(count))
~~~
{:.text-document title="lesson-2.R"}


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

  </section>
  <section>

A few notes about transformations:

- With `mutate`, you can assign the result of an expression to an existing column name to overwrite that column.

- As we will see below, `mutate` also works with groups. The key difference between `mutate` and `summarize` is that the former always returns a data frame with the same number of rows, while the latter reduces the number of rows.

- For a concise way to apply the same transformation to multiple columns, check the `mutate_each` function. There is also a `summarize_each` function to perform the same aggregation operation on multiple columns.
^

  </section>
  <section>

### Exercise 4

We often use `group_by` along with `summarize`, but you can also apply `filter` and `mutate` operations on groups.

- Filter a grouped data frame to return only rows showing the records from *surveys_1990_winter* with the minimum weight for each *species_id*.
- Calculate the fraction of total counts by taxa (birds or rodents) represented by each species within that taxon.

<aside class="notes">

[View solution](#solution-4)

</aside>

  </section>
</section>
<section>
  <section>

## Chaining operations with pipes (%>%)

<aside class="notes">

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

  </section>
  <section>

Additional arguments are accepted, a pipe only handles the first.


~~~r
c(1, 3, 5, NA) %>% sum(na.rm = TRUE)
~~~
{:.input}

~~~
[1] 9
~~~
{:.output}

  </section>
  <section>

The pipe operator's main utility is to condense a chain of operations applied to the same piece of data, when you don't need to save the intermediate results. We can do all the dplyr operations from above with a chain of pipes:


~~~r
prop_1990_winter_piped <- surveys %>%
    filter(year == 1990, month %in% 1:3) %>% 
    select(-year) %>%
    group_by(species_id) %>%
    summarize(count = n()) %>%
    mutate(prop = count / sum(count))
~~~
{:.text-document title="lesson-2.R"}


~~~r
identical(prop_1990_winter_piped, prop_1990_winter)
~~~
{:.input}

~~~
[1] TRUE
~~~
{:.output}

  </section>
</section>
<section>

## Additional information

Data wrangling with dplyr and tidyr [RStudio cheat sheet](http://www.rstudio.com/wp-content/uploads/2015/02/data-wrangling-cheatsheet.pdf).

<aside class="notes">

One of several cheat sheets available on the RStudio website, it provides a brief, visual summary of all the key functions discussed in this lesson. It also lists some of the auxiliary functions that can be used within each type of expression, e.g. aggregation functions for summarize, "moving window" functions for mutate, etc. 

</aside>

</section>
<section>

## Exercise solutions

### Solution 1

If any species/day combination is missing, the corresponding cell after `spread` is filled with `NA`. To interpret missing values as zero counts, use the optional `fill` argument: 


~~~r
sol1 <- spread(counts_gather, key = species, value = count, fill = 0)
~~~
{:.text-document title="lesson-2.R"}


~~~r
str(sol1)
~~~
{:.input}

~~~
'data.frame':	3 obs. of  4 variables:
 $ day : Factor w/ 3 levels "Monday","Tuesday",..: 1 2 3
 $ fox : num  4 4 4
 $ hare: num  20 25 30
 $ wolf: num  2 1 3
~~~
{:.output}

<aside class="notes">

[Return](#exercise-1)

</aside>

</section>
<section>

### Solution 2

Write code that returns the *record_id*, *sex* and *weight* of all surveyed individuals of *Reithrodontomys montanus* (RO).

~~~r
surveys_RO <- filter(surveys, species_id == "RO")
surveys_R0 <- select(surveys_RO, record_id, sex, weight)
~~~
{:.input}

<aside class="notes">

[Return](#exercise-2)

</aside>

</section>
<section>

### Solution 3

Write code that returns the average weight and hindfoot length of *Dipodomys merriami* (DM) individuals observed in each month (irrespective of the year). Make sure to exclude *NA* values.

~~~r
surveys_dm <- filter(surveys, species_id == "DM")
surveys_dm <- group_by(surveys_dm, month)
summarize(surveys_dm, avg_wgt = mean(weight, na.rm = TRUE),
          avg_hfl = mean(hindfoot_length, na.rm = TRUE))
~~~
{:.input}

~~~
# A tibble: 12 x 3
   month  avg_wgt  avg_hfl
   <int>    <dbl>    <dbl>
1      1 42.93697 36.09476
2      2 43.95270 36.18777
3      3 45.19864 36.11765
4      4 44.75411 36.18793
5      5 43.16449 35.82848
6      6 41.52889 35.97699
7      7 41.93692 35.71283
8      8 41.84119 35.79850
9      9 43.32794 35.83817
10    10 42.50980 35.95254
11    11 42.35932 35.94831
12    12 42.98561 36.04545
~~~
{:.output}

<aside class="notes">

[Return](#exercise-3)

</aside>

</section>
<section>

### Solution 4a

Filter a grouped data frame to return only rows showing the records from *surveys_1990_winter* with the minimum weight for each *species_id*.


~~~r
filter(surveys_1990_winter_gb, weight == min(weight))
~~~
{:.input}

~~~
Source: local data frame [13 x 8]
Groups: species_id [11]

   record_id month   day plot_id species_id    sex hindfoot_length weight
       <int> <int> <int>   <int>     <fctr> <fctr>           <int>  <int>
1      16885     1     6      12         SF      M              25     35
2      16894     1     6       1         OT      F              21     20
3      16915     1     6      19         PF      F              16      6
4      16929     1     7       3         SH      M              31     61
5      16959     1     7      13         PP      M              21     14
6      17003     1    29      24         RF      F              19     11
7      17024     1    29      22         PH      F              28     33
8      17036     1    29       1         OL      F              22     24
9      17146     2    24       1         NL      M              25     48
10     17155     2    24      22         PH      F              27     33
11     17174     2    25       5         BA      M              14      7
12     17190     2    25       5         BA      F              14      7
13     17216     2    25      10         RM      M              17      6
~~~
{:.output}

</section>
<section>

### Solution 4b

For each species in surveys_1990_winter_gb, create a new colum giving the rank order of hindfoot length.


~~~r
mutate(surveys_1990_winter_gb, ranked_hf_length = row_number(hindfoot_length))
~~~
{:.input}

~~~
Source: local data frame [491 x 9]
Groups: species_id [20]

   record_id month   day plot_id species_id    sex hindfoot_length weight
       <int> <int> <int>   <int>     <fctr> <fctr>           <int>  <int>
1      16879     1     6       1         DM      F              37     35
2      16880     1     6       1         OL      M              21     28
3      16881     1     6       6         PF      M              16      7
4      16882     1     6      23         RM      F              17      9
5      16883     1     6      12         RM      M              17     10
6      16884     1     6      24         RM      M              17      9
7      16885     1     6      12         SF      M              25     35
8      16886     1     6      24         SH      F              30     73
9      16887     1     6      12         SF      M              28     44
10     16888     1     6      17         DO      M              36     55
# ... with 481 more rows, and 1 more variables: ranked_hf_length <int>
~~~
{:.output}

<aside class="notes">

[Return](#exercise-4)

</aside>

</section>
