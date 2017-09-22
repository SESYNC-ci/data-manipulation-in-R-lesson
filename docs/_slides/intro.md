---
---

## Objectives for this lesson

- Review what makes a **tidy** datasets
- Learn to transform datasets with split-apply-combine procedures
- Pay attention to code clarity

===

## Specific achievements

- Reshape data frames with [tidyr](){:.rlib}
- Summarize data by groups with [dplyr](){:.rlib}
- Combine multiple data frame operations with pipes

Data frames generally occupy a central place in R analysis workflows. While the base R functions provide most necessary tools to subset, reformat and transform data frames, the specialized packages in this lesson offer a more succinct and often computationally faster way to perform the common data frame processing steps. Their straightforward syntax also makes scripts more readable and easier to debug. The key functions from the tidyr and dplyr packages all have close counterparts in SQL (Structured Query Language), which provides the added bonus of facilitating translation between R and relational databases.
{:.notes}
