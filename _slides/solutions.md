---
---

## Exercise solutions

### Solution 1

If any species/day combination is missing, the corresponding cell after `spread` is filled with `NA`. To interpret missing values as zero counts, use the optional `fill` argument: 


~~~r
sol1 <- spread(counts_gather, key = species, value = count, fill = 0)
~~~
{:.text-document title="lesson-4.R"}


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

<aside class="notes" markdown="block">

[Return](#exercise-1)

</aside>

<!--split-->

### Solution 2


~~~r
surveys_RO <- filter(surveys, species_id == "RO")
surveys_R0 <- select(surveys_RO, record_id, sex, weight)
~~~
{:.input}

<aside class="notes" markdown="block">

[Return](#exercise-2)

</aside>

<!--split-->

### Solution 3


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

<aside class="notes" markdown="block">

[Return](#exercise-3)

</aside>

<!--split-->

### Solution 4

#### Part 1


~~~r
filter(surveys_1990_winter_gb, weight == min(weight))
~~~
{:.input}
~~~
Source: local data frame [52 x 8]
Groups: species_id, month [36]

   record_id month   day plot_id species_id    sex hindfoot_length weight
       <int> <int> <int>   <int>     <fctr> <fctr>           <int>  <int>
1      16885     1     6      12         SF      M              25     35
2      16894     1     6       1         OT      F              21     20
3      16910     1     6      20         RM      M              16      7
4      16915     1     6      19         PF      F              16      6
5      16916     1     6      17         NL      F              32    165
6      16929     1     7       3         SH      M              31     61
7      16937     1     7      15         PE      F              20     19
8      16951     1     7       5         BA      F              13      9
9      16959     1     7      13         PP      M              21     14
10     17003     1    29      24         RF      F              19     11
# ... with 42 more rows
~~~
{:.output}

<!--split-->

### Solution 4

#### Part 2


~~~r
mutate(surveys_1990_winter_gb,
       ranked_hf_length = row_number(hindfoot_length))
~~~
{:.input}
~~~
Source: local data frame [491 x 9]
Groups: species_id, month [49]

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

<aside class="notes" markdown="block">

[Return](#exercise-4)

</aside>
