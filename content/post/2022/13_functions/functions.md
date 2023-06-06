+++
author = "Blair Fix"
title =  "13. R functions that I use all the time"
date = "2022-09-30"
slug = "r-functions"
description = "Here, in no particular order, are some R functions I find useful."
tags = [ "R", "functions", "basic functions", "base R" ]
+++


Out of the box, R comes with many functions that make data analysis easy. In this post, I'll review some of the functions that I use frequently, in whatever order rolls off the top of my head.

To get the ball rolling, we need a vector to work with. Let's define a vector `x` that contains some random(ish) numbers:

```R
> x = c(1, 4, -2, 10, 15, -5, -1, 2, 8, 0)
```

(Remember that the `c` function is how we combine numbers into vectors.)

Now on to the functions


### length

Having filled a vector with some data, often the first thing I want to know is how much data I have. R has a function for that called `length`. It tells you how many elements in a vector:

```R
> length(x)
[1] 10
```

Nice! It looks like I put 10 numbers into `x`.


### sort

When I see numbers that are in no particular order, I have an urge to sort them. R has a `sort` function for that:

```R
> sort(x)
 [1] -5 -2 -1  0  1  2  4  8 10 15
```

It just feels better seeing things in order!


### mean

Now let's get to some summary statistics. The mean is by far the most popular. R has a function for that call (drum roll) `mean`:

```R
> mean(x)
[1] 3.2
```

### median

Let's not leave out our friendly `median` function, which returns the midpoint of the data:

```R
> median(x)
[1] 1.5
```

Hmm ... the median is not the same as the mean. That means the data (that I made up) has a skew. More on skewness sometime in the future.


### standard deviation

The standard deviation is a workhouse stat that mathematicians love and the general public often misunderstands. Calculate it in R with `sd`:

```R
> sd(x)
[1] 6.124632
```

### max/min

Want to know the high and/or low values in your data. Use the `max` and `min` functions

```R
> max(x)
[1] 15

> min(x)
[1] -5
```

### summary

If you want to see all the summary statistics in one go, R has a function for that called `summary`:

```R
> summary(x)
   Min. 1st Qu.  Median    Mean 3rd Qu.    Max.
  -5.00   -0.75    1.50    3.20    7.00   15.00
```

From left to right, you get the minimum value, the 1st quartile, the median, the mean, the third quartile, and the max. Nifty!


### quantiles

Speaking of quartiles, R has a nice function for calculating 'quantiles'. It's called `quantiles`. If that language is confusing, you can think of the function as returning percentiles. 

For example, here's how I'd get the 30th percentile in `x`:

```R
> quantile(x, 0.3)
 30%
-0.3
```

R gives me the percentile I'm calculating, followed by its value.

Here's the 90th percentile:

```R
> quantile(x, 0.9)
 90%
10.5
```

### head and tail

The `head` and `tail` functions return the start and end of a vector. 

Here's the first 4 values of `x`:

```R
> head(x, 4)
[1]  1  4 -2 10
```

And here are the last 3 values of `x`:

```R
> tail(x, 3)
[1] 2 8 0
```



### N largest/smallest values

To get the single largest/smallest value, we've got the `max` and `min` functions. But what about if I want to know the 3 largest/smallest values? How would I do that?

The answer is that we combine the max/min functions with head/tail functions. 

Suppose we want the 3 largest values in `x`. First we'd sort `x`:

```R
> sort(x)
 [1] -5 -2 -1  0  1  2  4  8 10 15
```

You can see that the 3 largest values live in the last 3 elements. So we'll take the tail of the sorted values:

```R
x_sort = sort(x)
tail(x_sort, 3)
[1]  8 10 15
```

Or suppose we want the 2 smallest values. Now we take the head of `x_sort`:

```R
x_sort = sort(x)
head(x_sort, 2)
[1] -5 -2
```

### That pretty much covers it

I'd say that the functions above cover 90% of the calculating that I do in my own research. 

The hard part isn't using these functions. (As you can see, they're super easy.) The hard part is usually getting the data into a suitable form to apply these functions.

More on that in the future.

