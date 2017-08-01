---
---

## Database Connections

The [dplyr](){:.rlib} package reads data from multiple kinds of sources. We used CSV files above, but data could also be read from a database.

To read the "animals" table from a PostgreSQL database server using R as a database client:


~~~r
library(RPostgreSQL)
~~~

~~~
Error in library(RPostgreSQL): there is no package called 'RPostgreSQL'
~~~

~~~r
con <- dbConnect(PostgreSQL(), host = 'localhost', dbname = 'portal')
~~~

~~~
Error in dbConnect(PostgreSQL(), host = "localhost", dbname = "portal"): could not find function "dbConnect"
~~~

~~~r
animals_db <- tbl(con, 'animals')
~~~

~~~
Error in tbl(con, "animals"): object 'con' not found
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

~~~
Error in eval(lhs, parent, parent): object 'animals_db' not found
~~~
{:.text-document title="{{ site.handouts }}"}


~~~r
species_month_prop
~~~
{:.input}
~~~
Error in eval(expr, envir, enclos): object 'species_month_prop' not found
~~~
{:.output}

===

To complete the pivot table, however, the `species_month_prop` values must be copied into a R data.frame using `collect` for processing with `spread`. There is no SQL equivalent for what `spread` does.


~~~r
pivot <- species_month_prop %>%
  collect() %>%
  spread(month, prop, fill = 0)
~~~

~~~
Error in eval(lhs, parent, parent): object 'species_month_prop' not found
~~~
{:.text-document title="{{ site.handouts }}"}

===

Always disconnect from a database when finished. Terminating an R session works too.


~~~r
dbDisconnect(con)
~~~
{:.input}
~~~
Error in dbDisconnect(con): could not find function "dbDisconnect"
~~~
{:.output}
