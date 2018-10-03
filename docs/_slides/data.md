---
---

## Sample data

To learn about data transformation with dplyr, we need more data. The [Portal teaching database](http://github.com/weecology/portal-teachingdb) is a simplified dataset derived from a long-term study of animal populations in the Chihuahuan Desert.

===

![]({{ site.baseurl }}/images/portal-oct-07-15.jpg){: width="40%"}  
*Credit: [The Portal Project](https://portalproject.wordpress.com)*
{:.captioned}

===

The teaching dataset includes three tables: two contain summary information on the study plots and observed species, respectively, while the third and largest one (animals) lists all individual observations. We only need the animals table for this lesson.
{:.notes}



~~~r
animals <- read.csv('data/animals.csv')
~~~
{:.text-document title="{{ site.handouts[0] }}"}



~~~r
> str(animals)
~~~
{:.input title="Console"}


~~~
'data.frame':	35549 obs. of  9 variables:
 $ id             : int  2 3 4 5 6 7 8 9 10 11 ...
 $ month          : int  7 7 7 7 7 7 7 7 7 7 ...
 $ day            : int  16 16 16 16 16 16 16 16 16 16 ...
 $ year           : int  1977 1977 1977 1977 1977 1977 1977 1977 1977 1977 ...
 $ plot_id        : int  3 2 7 3 1 2 1 1 6 5 ...
 $ species_id     : Factor w/ 49 levels "","AB","AH","AS",..: 17 13 13 13 24 23 13 13 24 15 ...
 $ sex            : Factor w/ 3 levels "","F","M": 3 2 3 3 3 2 3 2 2 2 ...
 $ hindfoot_length: int  33 37 36 35 14 NA 37 34 20 53 ...
 $ weight         : int  NA NA NA NA NA NA NA NA NA NA ...
~~~
{:.output}


===

Modify the function to specify what string in the CSV file represents NAs, a.k.a. data that is not-available or missing.



~~~r
animals <- read.csv(
  'data/animals.csv',
  na.strings = '')
~~~
{:.text-document title="{{ site.handouts[0] }}"}


===

Question
: What changed?

Answer
: {:.fragment} Using `str()` shows that the factors have one less level, and the empty string is no longer included.

