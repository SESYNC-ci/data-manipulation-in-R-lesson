---
---

## Exercise solutions

===

## Solution 1

If any species/day combination is missing, the corresponding cell after `spread` is filled with `NA`. To interpret missing values as zero counts, use the optional `fill` argument: 


~~~r
spread(counts[-5, ], key = species, value = n, fill = 0)
~~~

~~~
  site hare lynx
1    1  341    2
2    2   42    7
3    3  289    0
~~~
{:.text-document title="{{ site.handouts }}"}

[Return](#exercise-1)
{:.notes}

===

## Solution 2


~~~r
animals_RO <- filter(animals, species_id == "RO")
sol2 <- select(animals_RO, id, sex, weight)
~~~
{:.text-document title="{{ site.handouts }}"}


~~~r
str(sol2)
~~~
{:.input}
~~~
'data.frame':	8 obs. of  3 variables:
 $ id    : int  18871 33397 33556 33565 34517 35402 35420 35487
 $ sex   : Factor w/ 2 levels "F","M": 1 2 2 1 2 1 2 1
 $ weight: int  11 8 9 8 11 12 10 13
~~~
{:.output}

[Return](#exercise-2)
{:.notes}

===

## Solution 3


~~~r
animals_dm <- filter(animals, species_id == "DM")
animals_dm <- group_by(animals_dm, month)
sol3 <- summarize(animals_dm, avg_wgt = mean(weight, na.rm = TRUE),
          avg_hfl = mean(hindfoot_length, na.rm = TRUE))
~~~
{:.text-document title="{{ site.handouts }}"}


~~~r
sol3
~~~
{:.input}
~~~
# A tibble: 12 x 3
   month  avg_wgt  avg_hfl
   <int>    <dbl>    <dbl>
 1     1 42.93697 36.09476
 2     2 43.95270 36.18777
 3     3 45.19864 36.11765
 4     4 44.75411 36.18793
 5     5 43.16449 35.82848
 6     6 41.52889 35.97699
 7     7 41.93692 35.71283
 8     8 41.84119 35.79850
 9     9 43.32794 35.83817
10    10 42.50980 35.95254
11    11 42.35932 35.94831
12    12 42.98561 36.04545
~~~
{:.output}

[Return](#exercise-3)
{:.notes}

===

## Solution 4


~~~r
sol4 <- animals_1990_winter %>%
    group_by(species_id, month) %>%
    summarize(count = n()) %>%
    mutate(prop = count / sum(count)) %>%
    select(-count) %>%
    spread(key = month, value = prop, fill = 0)
~~~
{:.text-document title="{{ site.handouts }}"}


~~~r
head(sol4)
~~~
{:.input}
~~~
# A tibble: 6 x 4
# Groups:   species_id [6]
  species_id       `1`       `2`       `3`
      <fctr>     <dbl>     <dbl>     <dbl>
1         AB 0.9600000 0.0000000 0.0400000
2         AH 0.7500000 0.2500000 0.0000000
3         BA 0.3333333 0.6666667 0.0000000
4         DM 0.4545455 0.2651515 0.2803030
5         DO 0.4769231 0.2615385 0.2615385
6         DS 0.5000000 0.1666667 0.3333333
~~~
{:.output}

[Return](#exercise-3)
{:.notes}
