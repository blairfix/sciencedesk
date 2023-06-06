+++
author = "Blair Fix"
title =  "9. Playing with vectors in R"
date = "2022-07-25"
slug = "vectors-in-R"
description = "When you program in R, you use vectors. Here's what that means"
tags = ["R", "vectors"  ]
+++

When we left off [last time](https://sciencedesk.economicsfromthetopdown.com/2022/07/r-graphing-calculator/), we used R to plot a parabola. To do that, we used one of R's most basic features, which is that it accepts variables that contain multiple elements. In other languages, this type of variable is called an 'array' or a 'list'. But in R, we call it a 'vector'.

To review, we can create a vector of integers using the `:` symbol. Here's how we list the numbers 1 to 5:

```R
> 1:5
[1] 1 2 3 4 5
```

We can dump these numbers into a variable using the `=` sign:

```R
x = 1:5
```

Note that a variable can have any name. If we like, it can be long and descriptive:

```R
this_is_a_long_variable_name = 1:5
```

For now, though, I'll keep our variable names short and simple.


### Doing math with vectors

One of the nice features of R is that it makes doing math really easy. Let's play around with our vector `x`. First, let's define it as the numbers from 1 to 5

```R
x = 1:5
```

Let's check what's in `x`:

```R
> x
[1] 1 2 3 4 5
```

One of the simplest things we can do is multiply all of the elements of `x` by a constant value. To multiply each element of `x` by 2, we'd enter:

```R
> 2*x
[1]  2  4  6  8 10
```

Or to divide each element by 2, we'd enter:

```R
> x / 2
[1] 0.5 1.0 1.5 2.0 2.5
```

So unless you say otherwise, R assumes that you want an operation to be vectorized, meaning it applies to all of the elements of a variable. That makes manipulating data really easy. 


### More than one vector

R can do similar operations with multiple vectors. Let's define two vectors, `x` and `y`:

```R
x = 1:5
y = 6:10
```

Here's what's in each vector:

```R
> x
[1] 1 2 3 4 5

> y
[1]  6  7  8  9 10
```

Suppose we want to take each element of `x` and multiply it by the corresponding element of `y`. R has a really simple syntax for that. We just use the multiplication symbol, `*`:

```R
> x * y
[1]  6 14 24 36 50
```

So what R has done here is take the first element of `x` (1) and multiplied it by the first element of `y` (6). Then it does the same for the second element, and so on, until it gets to the end.

We can do the same thing with division. Here's how to divide each element of `x` by the corresponding element of `y`:

```R
> x / y
[1] 0.1666667 0.2857143 0.3750000 0.4444444 0.5000000
```

### Note: vectors must have the same length

The above operations worked because `x` and `y` each had the same length (they each have 5 elements). If the vectors do not have the same length, R will throw an error.

Let's redefine our variables:

```R
x = 1:5
y = 1:2
```

Now `y` is shorter than `x`:

```R
> x
[1] 1 2 3 4 5

> y
[1] 1 2
```

If we try to multiply the two, R will protest that the two vectors have different lengths:

```R
> x * y
[1] 1 4 3 8 5
Warning message:
In x * y : longer object length is not a multiple of shorter object length
```

We can verify this fact using the `length` function, which tells us how many elements are contained in a vector:

```R
> length(x)
[1] 5

> length(y)
[1] 2
```

Yep, the two vectors are different length. `x` has 5 elements. `y` has 2.


### R is built for manipulating sets of data

R's vectorized syntax is built to make data manipulation easy. For example, suppose we have a variable called `heights` which contained the heights of 1 million people. And we have a variable called `weights` that contains the weights of the same million people. 

Suppose we want to calculate the body mass index (BMI) of each person. That's easy. The BMI is defined as a person's weight divided by the square of their height. We can calculate one million BMI's with one line of code:

```R
BMI = weights / heights^2 
```

This is the power of R's vector syntax. It is designed to make data analysis simple, which is why analysts like me love it.
