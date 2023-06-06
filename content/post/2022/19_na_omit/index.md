+++
author = "Blair Fix"
title =  "19. Dealing with missing values in R"
date = "2022-11-23"
slug = "r-missing-values"
description = "I show you how to remove NA's in R"
tags = [ "missing values", "NAs", "na.omit", "na.rm", "data cleaning" ]
+++

Real-world datasets often have missing values. Here's some tips for dealing with them in R.


### The `NA`

In spreadsheets, missing data is typically represented by a blank cell. In R, missing data is given the symbol `NA`.

For an example, let's make a vector called `x` and fill it with some numbers and some missing values (NA's):


```R
x = c( 1, NA, 5, NA, 10 )
```

Now let's try to work with this data.


### Stats functions don't like NA's

Now that we've got `x`, let's do some simple statistics. Let's calculate the mean:

```R
mean(x)
```

R tells me that the mean is undefined:

```R
> mean(x)
[1] NA
```

What's going on? Well, by default, R will try to include the missing values in the calculation. Since missing values are undefined, the resulting mean is undefined.

We can fix the problem by telling R to remove the NA's from the calculation. We do that by setting the `na.rm`  option to `TRUE`:


```R
mean(x, na.rm = TRUE)
```

(Note: if you prefer to be less verbose, you can substitute `T` for `TRUE`, as in `na.rm = T`.)

The `na.rm` option tells R to remove missing values when it calculates the mean: Now we get back a sensible result:

```R
> mean(x, na.rm = TRUE)
[1] 5.333333
```

Other stats functions like `sd` (standard deviation), `median`, and `sum`  work the same way. If you want them to ignore missing values, you have use `na.rm`.

(Side note: `na.rm` is what we call a 'default' option. If you don't specify it, R will assume you want `na.rm = FALSE`.)


### `summary` handles NA's by default

Interestingly, the `summary` function works differently. By default, it will remove missing values when it calculates summary statistics. Then, it will report how may NA's are in the data.


Let's run `summary` on `x`:

```R
summary(x)
```

I get back:

```R
   Min. 1st Qu.  Median    Mean 3rd Qu.    Max.    NA's
  1.000   3.000   5.000   5.333   7.500  10.000       2
```

The last column tells us the number of missing values. As expected, there are 2.


### Removing missing values from your data

When you pass the `na.rm` option to stats functions, your underlying data remains unchanged. Sometimes that's what you want. Other times, you want to omit the NA's from your source data. 

In R, there are a few ways to do that. The most universal is a function called `na.omit`. Let's run it on `x`:

```R
na.omit(x)
```

Here's what I get back:

```R
[1]  1  5 10
attr(,"na.action")
[1] 2 4
attr(,"class")
[1] "omit"
```

That's weird output.

What's going on here is that `na.omit` is returning two things:

1. a vector with NA's removed from `x`
2. metadata containing the indexes of the NA's that were removed

I personally find this output an odd choice on the part of R developers. When I use a function called `na.omit`, I expect it will return my data with the NA's omitted. Interestingly, when we pass a data frame to `na.omit`, that's exactly what happens. But for some reason, the function works differently on vectors.

At any rate, we can get rid of the unwanted metadata by putting the `as.vector` function around `na.omit`. That tells R to convert the output to a plain vector:

```R
as.vector( na.omit(x) )
```

The output is what we expect

```R
> as.vector( na.omit(x) )
[1]  1  5 10
```


### Remove NA's using `is.na`

Because `na.omit` has unexpected behavior when applied to a vector, you'll often see R programmers use the following code to remove NA's:

```R
x[ ! is.na(x) ]
```

The code is simple enough to copy and paste. But what does it mean?

To understand the code, we'll start with the `is.na` function. Lets' run it on `x`:

```R
is.na(x)
```

I get back:

```R
[1] FALSE  TRUE FALSE  TRUE FALSE
```

The purpose of `is.na` is to test if the  elements of a vector are  NA. If `is.na` finds a missing value, it returns `TRUE`. If not, the function returns `FALSE`.  The result is a vector of true/false values that correspond to the NA status of elements in `x`.

Now, the interesting thing about R is that you use true/false values to subset a vector. For example, suppose I have a vector `z` that contains the elements 1 and 2:

```R
z = c(1, 2)
```

Now let's make a logical vector that contains the values `FALSE` and `TRUE`:

```R
index = c(FALSE, TRUE)
```

In R, we can pass these true/false indexes to z using the bracket operator `[]`:

```R
z[index]
```

What happens is that R will return the elements of `z` for which `index` is `TRUE`.

```R
> z[index]
[1] 2
```

The code `x[ ! is.na(x) ]` does something similar, but with more nested pieces.


### Tracking the nested logic

To keep track of what's going on with nested code, I find it helpful to do things in steps. To break down our NA-remove code, let's define a variable called `index` that will store the true/false output of `is.na`:

```R
index = is.na(x)
```

Now we can tell R to subset `x` according to `index`:

```R
x[index]
```

We'll get back the values of `x` for which `is.na(x)` is `TRUE`. In other words, we'll get back our NA's:

```R
> x[index]
[1] NA NA
```

That's fun, but not what we want. Our goal is to *remove* missing values, not keep them. That's where the `!` comes in. In R, the `!` is the logical 'not' operator. 

In the case of true/false data, the `!` operator reverses the values, converting `TRUE` to `FALSE`, and vice versa.

Back to our `index` vector. To review, `index` contained:

```R
> index
[1] FALSE  TRUE FALSE  TRUE FALSE
```

If we tell R to return `!index`, our logical values get flipped:

```R
> !index
[1]  TRUE FALSE  TRUE FALSE  TRUE
```

Now, if we pass `!index` back to `x`, we'll get all of the values that are *not* NA's:

```R
x[ !index ]
```

The results are what we want --- our vector `x` with the NA's removed:

```R
> x[ !index ]
[1]  1  5 10
```

Seasoned R programmers take this thinking and compress it into one line of code. Find the indexes that are *not* NA, and subset `x` using those values. Translated into code, we get:

```R
# long version
index = is.na(x)
x[ !index ]

# nested version
x[ ! is.na(x) ]
```


### `na.omit` on data frames

Unlike on vectors,  `na.omit` behaves as expected on data frames. It returns your data frame with the missing values removed.

To use `na.omit`, let's first make an example dataset called `d`:

```R
x = c(1, NA, 3)
y = c(2, NA, 5)

d = data.frame(x, y)
```

Here's what's in `d`:


```R
   x  y
1  1  2
2 NA NA
3  3  5
```

Now let's use `na.omit` to get rid of the missing values:

```R
na.omit(d)
```

It works like a charm. We get:

```R
> na.omit(d)
  x y
1 1 2
3 3 5
```


### Be careful when using `na.omit` on sparse data

Be warned that if your dataset is 'sparse' ---  meaning there are lots of NAs sprinkled in different places --- `na.omit` can have unintended consequences.

To see what can happen, let's make another data frame:


```R
x = c(NA, 1, 3)
y = c(2, NA, 5)
z = c(4, 2, NA)

d = data.frame(x, y, z)
```

Here's what's in `d`:

```R
   x  y  z
1 NA  2  4
2  1 NA  2
3  3  5 NA
```

Notice that the missing values are not in one row. Instead, they're sprinkled in different rows. When we use `na.omit`  on this data, we have a problem. We get back an empty data frame:

```R
> na.omit(d)
[1] x y z
<0 rows> (or 0-length row.names)
```

Why did this happen? 

The problem is that `na.omit` works row by row. If it finds a missing value in a row, it removes the *whole row*. The effect is to remove data that, in other columns, was not missing. 

Often, that's not what you want to do. For example, suppose that in our dataset', we're only interested in `x` and `y`. In that case, we don't care if an element of `z` is missing.  So when we run `na.omit` on the whole dataset, we're losing data for `x` and `y`.

How do we fix the problem? 

Usually what I do is make a new data frame that keeps only the data that I want.  Let's define `d_keep` to have the `x` column (`d$x`) and `y` column `d$y` from `d`:

```R
d_keep = data.frame( x = d$x, y = d$y )
```

Here's what's in `d_keep`:

```R
> d_keep
   x  y
1 NA  2
2  1 NA
3  3  5
```

Now we can run `na.omit` and keep rows with values for both `x` and `y`:

```R
> na.omit(d_keep)
  x y
3 3 5
```

### Clean, but not too clean 

Removing missing values is a basic part of 'cleaning' a dataset. The strategy is to clean your data just the right amount --- enough so the data is easy to work with, but not so much that you lose data that you want.

Whenever you run `na.omit`, it's good practice to check that you haven't unintentionally lost data. (I've learned this 'good practice' the hard way.)

