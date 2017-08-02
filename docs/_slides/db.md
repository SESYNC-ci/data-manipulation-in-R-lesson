---
---

## Database Connections

The [dplyr](){:.rlib} package reads data from multiple kinds of sources. We used CSV files above, but data could also be read from a database.

To read the "animals" table from a PostgreSQL database server using R as a database client:


~~~r
library(RPostgreSQL)

con <- dbConnect(PostgreSQL(), host = 'localhost', dbname = 'portal')
animals_db <- tbl(con, 'animals')
~~~
{:.text-document title="{{ site.handouts }}"}

The "localhost" is not a typical location for a database server (because "localhost" means your own system). If you have a database administrator, that person will give you the correct host and credentials. If you do not have a database administrator, [here you go](https://www.postgresql.org/docs/).
{:.notes}

===

Many of the exact same operations can be performed *by the database* system, because the [dplyr](){:.rlib} functions map to standard structured query language (SQL) operations.


~~~r
species_month_prop <- animals_db %>%
    group_by(species_id, month) %>%
    summarize(count = n()) %>%
    mutate(prop = count / sum(count)) %>%
    select(-count)
~~~
{:.text-document title="{{ site.handouts }}"}


~~~r
species_month_prop
~~~
{:.input}
~~~
# Source:   lazy query [?? x 3]
# Database: postgres 9.6.3 [ian@localhost:5432/portal]
# Groups:   species_id
   species_id month       prop
        <chr> <int>      <dbl>
 1         AB     9 0.03960396
 2         AB     3 0.12541254
 3         AB     2 0.17161716
 4         AB     5 0.03960396
 5         AB    11 0.06600660
 6         AB     4 0.05940594
 7         AB    12 0.12871287
 8         AB    10 0.02970297
 9         AB     7 0.03960396
10         AB     6 0.01650165
# ... with more rows
~~~
{:.output}

===

To complete the pivot table, however, the `species_month_prop` values must be copied into a R data.frame using `collect` for processing with `spread`. There is no SQL equivalent for what `spread` does.


~~~r
pivot <- species_month_prop %>%
  collect() %>%
  spread(month, prop, fill = 0)
~~~
{:.text-document title="{{ site.handouts }}"}

===

Always disconnect from a database when finished. Terminating an R session works too.


~~~r
dbDisconnect(con)
~~~
{:.input}
~~~
[1] TRUE
~~~
{:.output}
