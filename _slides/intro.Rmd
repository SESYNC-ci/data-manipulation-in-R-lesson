---
---

We will first discuss what is a **tidy** dataset and how to convert data to this standard form with `tidyr`.
Next, we will explore the data processing functions in `dplyr`, which work particularly well with the tidy data format.

<aside class="notes">

Data frames generally occupy a central place in R analysis workflows.
While the base R functions provide most necessary tools to subset, reformat and transform data frames, the specialized packages we will use in this lesson -- **tidyr** and **dplyr** -- offer a more succinct and often computationally faster way to perform the common data frame processing steps.
Beyond saving typing time, the simpler syntax also makes scripts more readable and easier to debug.
The key functions from that package all have close counterparts in SQL (Structured Query Language), which provides the added bonus of facilitating the transition from R to relational databases.

</aside>
