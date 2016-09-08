---
---

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

<aside class="notes" markdown="block">

The teaching dataset includes three tables: two contain summary information on the study plots and observed species, respectively, while the third and largest one (surveys) lists all individual observations. We only need the surveys table for this lesson.

</aside>

<!--split-->

Modify the function to specify what string in the CSV file represents NAs, a.k.a. data that is not-available or missing.


~~~r
surveys <- read.csv("data/surveys.csv", na.strings = "")
~~~
{:.text-document title="lesson-2.R"}

Question
: What has changed?

Answer
: {:.fragment} The `str` shows that the factors have one less level, and the empty string is not included.
