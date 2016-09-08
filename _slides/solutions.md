---
---

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

<!--split-->

### Solution 2


~~~r
surveys_RO <- filter(surveys, species_id == "RO")
~~~
{:.input}

~~~
Error in filter_(.data, .dots = lazyeval::lazy_dots(...)): object 'surveys' not found
~~~
{:.input}

~~~r
surveys_R0 <- select(surveys_RO, record_id, sex, weight)
~~~
{:.input}

~~~
Error in select_(.data, .dots = lazyeval::lazy_dots(...)): object 'surveys_RO' not found
~~~
{:.output}

<aside class="notes">

[Return](#exercise-2)

</aside>

<!--split-->

### Solution 3


~~~r
surveys_dm <- filter(surveys, species_id == "DM")
~~~
{:.input}

~~~
Error in filter_(.data, .dots = lazyeval::lazy_dots(...)): object 'surveys' not found
~~~
{:.input}

~~~r
surveys_dm <- group_by(surveys_dm, month)
~~~
{:.input}

~~~
Error in group_by_(.data, .dots = lazyeval::lazy_dots(...), add = add): object 'surveys_dm' not found
~~~
{:.input}

~~~r
summarize(surveys_dm, avg_wgt = mean(weight, na.rm = TRUE),
          avg_hfl = mean(hindfoot_length, na.rm = TRUE))
~~~
{:.input}

~~~
Error in summarise_(.data, .dots = lazyeval::lazy_dots(...)): object 'surveys_dm' not found
~~~
{:.output}

<aside class="notes">

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
Error in filter_(.data, .dots = lazyeval::lazy_dots(...)): object 'surveys_1990_winter_gb' not found
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
Error in mutate_(.data, .dots = lazyeval::lazy_dots(...)): object 'surveys_1990_winter_gb' not found
~~~
{:.output}

<aside class="notes">

[Return](#exercise-4)

</aside>
