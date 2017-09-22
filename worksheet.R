## Tidy data concept

response <- read.csv(text = "
trial, drug_A, drug_B, placebo
1,     0.22,   0.58,   0.31
2,     0.12,   0.98,   0.47
3,     0.42,   0.19,   0.40
")

## Reshaping multiple columns in category/value pairs

library(...)
tidy_response <- gather(...,
  ...)

counts <- read.csv(text = "
site, species, n
1,    lynx,    2
1,    hare,    341
2,    lynx,    7
2,    hare,    42
3,    hare,    289
")

wide_counts <- ...(counts,
			...,
			...)

wide_counts <- spread(counts,
  key = species,
  value = n,
  ...)

## Exercise 1

...

## Read comma-separated-value (CSV) files

animals <- ...

animals <- read.csv(
  'data/animals.csv',
  ...)

## Subsetting and sorting

library(...)

animals_1990_winter <- filter(
  ...,
  ...,
  ...)

animals_1990_winter <- select(
  ...,
  ...)

## Exercise 2

...

## Chainning with pipes

animals_100_winter <- animals %>%
    ... # filter to the first 3 months of 1990
    ... # select all columns but year

## Grouping and aggregation

counts_1990_winter <- animals_1990_winter %>%
    group_by(...)

counts_1990_winter <- animals_1990_winter %>%
  group_by(...)

weight_1990_winter <- animals_1990_winter %>%
  group_by(species_id) %>%
  ...

## Exercise 3

...

## Transformation of variables

prop_1990_winter <- counts_1990_winter %>%
    mutate(...)

## Exercise 4

...
