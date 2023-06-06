+++
author = "Blair Fix"
title =  "23. Aggregating multivariable functions in R using data.table"
date = "2023-04-22"
slug = "data-table-multi-variable-aggregate"
description = "Here's a simple trick to get data.table aggregation to play nicely with multivariable functions."
tags = [ "R", "data.table", "multivariable", "aggregate",   ]
+++


In my [last post](https://sciencedesk.economicsfromthetopdown.com/2023/03/data-table-aggregate/), I showed you how to use the data.table package to aggregate data in R. In this follow up, I'll show you a simple trick to make the method work for multivariable functions.


### Paleoclimate data

To get started, let's load the `data.table` package. Then we'll download some data to play with --- in this case paleoclimate data.

```R
library(data.table)

url = "https://sciencedesk.economicsfromthetopdown.com/2023/03/data-table-aggregate/temp/temp.csv"
paleo = fread(url)
```

As a quick reminder, the `paleo` dataset contains data for the Earth's temperature (relative to the modern average) observed at various points in the past:


```R
> paleo
               age temperature
   1:     38.37379        0.88
   2:     46.81203        1.84
   3:     55.05624        3.04
   4:     64.41511        0.35
   5:     73.15077       -0.42
  ---
5781: 797408.00000       -8.73
5782: 798443.00000       -8.54
5783: 799501.00000       -8.88
5784: 800589.00000       -8.92
5785: 801662.00000       -8.82
```


### The `summary` function

Next, let's play with the `summary` function. It's a nice example of an R function that returns multiple variables. Let's start by summarizing the temperature column:

```R
# get summary of the temperature data
summary(paleo$temperature)
```

Here's the results:

```R
   Min. 1st Qu.  Median    Mean 3rd Qu.    Max.
 -10.58   -7.45   -5.20   -4.58   -1.82    5.46
```

Notice that most of the numbers are negative. That tells us that in the past, the Earth's climate was cooler than today. 


### Summarizing periods of data

Suppose that instead of summarizing our whole database, we want to get stats on groups of data. That's where the data.table package shines.

To run some grouped stats, we'll start by putting our `age` data into bins. We'll create a variable called `age_round` that rounds the age data down to the nearest 20,000 years:

```R
# round age data to 20K year intervals
accuracy = 2e4
paleo$age_round = floor( paleo$age / accuracy) *  accuracy
```

What we've done is create a new column that has rounded age data. 

```R
> paleo
               age temperature age_round
   1:     38.37379        0.88         0
   2:     46.81203        1.84         0
   3:     55.05624        3.04         0
   4:     64.41511        0.35         0
   5:     73.15077       -0.42         0
  ---
5781: 797408.00000       -8.73    780000
5782: 798443.00000       -8.54    780000
5783: 799501.00000       -8.88    780000
5784: 800589.00000       -8.92    800000
5785: 801662.00000       -8.82    800000
```

What's important is that there are multiple `temperature` observations for each unique value of `age_round`.  Now we can use data.table to aggregate the temperature data for each group of `age_round`.

For example, here's how we'd calculate the average temperature within each group of `age_round`:

```R
# average temperature by age_round
paleo[,
      mean(temperature),
      by = age_round
      ]
```

Here's the result:

```R
    age_round          V1
 1:         0 -1.88681111
 2:     20000 -8.67970588
 3:     40000 -6.85390476
 4:     60000 -7.24035616
 5:     80000 -4.81929293
 6:    100000 -3.57359773
 7:    120000  0.05665829
 8:    140000 -8.19197861
 9:    160000 -7.60094972
10:    180000 -6.01200000
```

Now, by default, our statistic is called `V1`, which is not very descriptive. (To see how to fix this name, see the [last post](https://sciencedesk.economicsfromthetopdown.com/2023/03/data-table-aggregate/).) Still, the results make sense. The `V1` column contains the mean temperature within each `age_round` group.

Next, let's try the same thing with the `summary` function:

```R
# summarize temperature data by age_round
paleo[,
      summary(temperature),
      by = age_round
      ]

```

The results don't make much sense:

```R
    age_round       V1
 1:         0 -10.4300
 2:         0  -2.7975
 3:         0  -0.8100
 4:         0  -1.8868
 5:         0  -0.0175
 6:         0   3.0400
 7:     20000 -10.5800
 8:     20000  -9.4600
 9:     20000  -8.8700
10:     20000  -8.6797
```

You see, we expect that the `summary` function is going to dump out six statistics for each unique observation of of `age_round`. So where are these stats?

The answer is that the stats are there, but have been formatted in an unhelpful way --- they've all been dumped into a single column called `V1`.


Admittedly, this output is an odd default behavior. Fortunately, it's easy to fix. To get the result we expected, we can surround our `summary` function by the code `as.list()`:

```R
# summarize temperature data by age_round
# putting the summary function inside as.list()
# fixes the output formatting
paleo[,
      as.list( summary(temperature) ),
      by = age_round
      ]
```

Now we get more sensible results. We get summary stats for each value of `age_round`:

```R
    age_round   Min. 1st Qu. Median        Mean 3rd Qu.  Max.
 1:         0 -10.43 -2.7975 -0.810 -1.88681111 -0.0175  3.04
 2:     20000 -10.58 -9.4600 -8.870 -8.67970588 -8.0500 -4.66
 3:     40000  -9.39 -7.5700 -6.840 -6.85390476 -6.1675 -4.03
 4:     60000 -10.19 -8.4600 -7.130 -7.24035616 -6.2100 -3.52
 5:     80000  -7.60 -5.4325 -4.855 -4.81929293 -4.2175 -2.01
 6:    100000  -7.74 -5.2600 -4.340 -3.57359773 -1.7100  2.11
 7:    120000  -9.43 -1.3675  1.540  0.05665829  2.4975  5.46
 8:    140000 -10.03 -8.7800 -8.220 -8.19197861 -7.6600 -5.74
 9:    160000  -9.49 -8.2750 -7.630 -7.60094972 -6.8950 -5.40
10:    180000  -9.26 -7.9400 -6.270 -6.01200000 -4.5750 -1.37
```

I use this kind of code all the time  for summarizing groups of data. 

### Other examples

Off the top of my head, here are a few other ways to summarize data. 

We can use the `range` function to get the minimum and maximum values:

```R
# get range
paleo[,
      as.list( range(temperature) ),
      by = age_round
      ]
```

Or, we can use the `quantile` function to get confidence intervals. Here's how to get the 90% confidence interval of the `temperature` data fore each value of `age_round`:

```R
# get 90% confidence interval of temperature data
# for each value of age_round
paleo[,
      as.list(
	      quantile(temperature, probs = c(0.05, 0.95 ) )
	      ),
      by = age_round
      ]
```

When I stop to think about it, this kind of aggregation covers the vast majority of my use cases. It's surprising the amount of punch packed into a few lines of `data.table` code.
