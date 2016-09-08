---
---

## Sample data

We will use the [Portal teaching database](http://github.com/weecology/portal-teachingdb), a simplified dataset derived from a long-term study of animal populations in the Chihuahuan Desert.


~~~r
surveys <- read.csv("data/surveys.csv")
~~~
{:.text-document title="lesson-2.R"}

~~~
Warning in file(file, "rt"): cannot open file 'data/surveys.csv': No such
file or directory
~~~
{:.text-document title="lesson-2.R"}

~~~
Error in file(file, "rt"): cannot open the connection
~~~
NA


~~~r
str(surveys)
~~~
{:.input}

~~~
Error in str(surveys): object 'surveys' not found
~~~
{:.output}

<aside class="notes">

The teaching dataset includes three tables: two contain summary information on the study plots and observed species, respectively, while the third and largest one (surveys) lists all individual observations. We only need the surveys table for this lesson.

</aside>

<!--split-->

Modify the function to specify what string in the CSV file represents NAs, a.k.a. data that is not-available or missing.


~~~r
surveys <- read.csv("data/surveys.csv", na.strings = "")
~~~
{:.text-document title="lesson-2.R"}

~~~
Warning in file(file, "rt"): cannot open file 'data/surveys.csv': No such
file or directory
~~~
{:.text-document title="lesson-2.R"}

~~~
Error in file(file, "rt"): cannot open the connection
~~~
NA

Question
: What has changed?

Answer
: {:.fragment} The `str` shows that the factors have one less level, and the empty string is not included.
