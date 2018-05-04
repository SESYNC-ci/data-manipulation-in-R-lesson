---
---

## Exercise solutions

===

## Solution 1


~~~r
gather(wide_counts, key = "species", value = "n", -site)
~~~
{:.input}
~~~
  site   species   n
1    1  hare     341
2    2  hare      42
3    3  hare     289
4    1  lynx       2
5    2  lynx       7
6    3  lynx       0
~~~
{:.output}

[Return](#exercise-1)
{:.notes}

===

## Solution 2


~~~r
animals_RO <- filter(animals, species_id == "RO")
select(animals_RO, id, sex, weight)
~~~
{:.input}
~~~
     id sex weight
1 18871   F     11
2 33397   M      8
3 33556   M      9
4 33565   F      8
5 34517   M     11
6 35402   F     12
7 35420   M     10
8 35487   F     13
~~~
{:.output}

[Return](#exercise-2)
{:.notes}

===

## Solution 3


~~~r
filter(animals, species_id == "DM") %>%
  group_by(month) %>%
  summarize(
    avg_wgt = mean(weight, na.rm = TRUE),
    avg_hfl = mean(hindfoot_length, na.rm = TRUE))
~~~
{:.input}
~~~
# A tibble: 12 x 3
   month avg_wgt avg_hfl
   <int>   <dbl>   <dbl>
 1     1    42.9    36.1
 2     2    44.0    36.2
 3     3    45.2    36.1
 4     4    44.8    36.2
 5     5    43.2    35.8
 6     6    41.5    36.0
 7     7    41.9    35.7
 8     8    41.8    35.8
 9     9    43.3    35.8
10    10    42.5    36.0
11    11    42.4    35.9
12    12    43.0    36.0
~~~
{:.output}

[Return](#exercise-3)
{:.notes}

===

## Solution 4


~~~r
group_by(animals, species_id, month) %>%
  summarize(count = n()) %>%
  spread(key = month, value = count, fill = 0)
~~~
{:.input}
~~~
# A tibble: 49 x 13
# Groups:   species_id [49]
   species_id   `1`   `2`   `3`   `4`   `5`   `6`   `7`   `8`   `9`  `10`
   <fct>      <dbl> <dbl> <dbl> <dbl> <dbl> <dbl> <dbl> <dbl> <dbl> <dbl>
 1 AB            75    52    38    18    12     5    12    11    12     9
 2 AH            27    38    24    29    58    54    33    29    44    38
 3 AS             1     0     0     0     0     0     0     1     0     0
 4 BA             5     4     3     4     3     3     2     2     1     4
 5 CB             1     1     0     1     2     5     8     6    16     5
 6 CM             0     0     0     0     0     0     0     3     9     1
 7 CQ             3     0     0     0     0     1     5     6     0     1
 8 CS             0     0     0     1     0     0     0     0     0     0
 9 CT             0     0     0     0     0     0     0     0     0     0
10 CU             0     0     0     0     0     0     0     0     0     0
# ... with 39 more rows, and 2 more variables: `11` <dbl>, `12` <dbl>
~~~
{:.output}

[Return](#exercise-3)
{:.notes}
