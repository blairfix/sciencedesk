+++
author = "Blair Fix"
title =  "10. Subviews of vectors in R"
date = "2022-07-26"
slug = "subview-vector-R"
description = "Here's how to look at the components of you R vectors."
tags = ["R", "vector", "subview", "subset", "conditional statement"  ]
+++


[Last time](https://sciencedesk.economicsfromthetopdown.com/2022/07/vectors-in-r/) we reviewed how R let's you do operations on vectors. Now let's get a sense for how we can access the elements of a vector:


### Access a single element of a vector

To get started, let's define a vector called `x` that contains the numbers 10 to 20:

```R
x = 10:20
```

Here's what's in `x`:

```R
> x
 [1] 10 11 12 13 14 15 16 17 18 19 20
```

Now suppose that we want only the first element of `x`, which contains the number 10. How do we get it? We type `x[1]`. Presto, we get back the first element of x:

```R
> x[1]
[1] 10
```

To access other elements, we just pass their number. Here's the 9th element:

```R
> x[9]
[1] 18 
```

You can also ask R for elements that are not there. For example, `x` has 10 elements. If we ask for element 20, we get:

```R
> x[20]
[1] NA
```

What does this mean? Well, `NA` is how R says 'nothing here'. It's telling you that there is nothing in the 20th element of x.

### Access multiple elements

Suppose we want to access the first 4 elements of `x`. That's easy. To do that, we use the `:` symbol. Recall that `1:4` will create the numbers 1 to 4:

```R
> 1:4
[1] 1 2 3 4
```

So to get the first 4 elements of `x`, we put `1:4` inside our brackets:

```R
> x[1:4]
[1] 10 11 12 13
```

Or maybe we want elements 4, 5 and 6:


```R
> x[4:6]
[1] 13 14 15
```

### Head 

Sometimes we just want the beginning of a vector. For that the `head` function has your back.  By default, `head` will show you the first 6 elements:

```R
> head(x)
[1] 10 11 12 13 14 15
```

We can change the number of elements we get back by telling R how many we want like this:

```R
> head(x, 2)
[1] 10 11
```

We get back the first 2 elements. 

### Tail

The `tail` function works exactly like `head`, except it returns the end of the vector. Here's the tail of `x`:

```R
> tail(x)
[1] 15 16 17 18 19 20
```

You can also tell `tail` how many elements you want. Here are the last 3:

```R
> tail(x, 3)
[1] 18 19 20
```


### Subset by condition

Sometimes we want to get the elements of a vector that satisfy some condition. For example, suppose we want all of the elements of `x` that are greater than 15. In R, that's really easy. 

First of all, we can ask R which elements of `x` are greater than 15. To do that, we type:

```R
x > 15
```

R will return a list of true/false statements. If the given element is greater than 15, we get `TRUE`. If not, we get `FALSE`. Here's what I get:

```R
 [1] FALSE FALSE FALSE FALSE FALSE FALSE  TRUE  TRUE  TRUE  TRUE  TRUE
```

Now, the way R works, we can pass these true/false statements back to our vector x. That will keep the elements that are greater than 15. We do that by putting the condition statement `x > 15` inside brackets:

```R
x[x > 15]
```

Here's what I get back:

```R
[1] 16 17 18 19 20
```

If we want to keep these values, we can dump them into another variable, say `y`:

```R
y = x[x > 15]
```

A lot of data analysis relies on this conditional type of access. 

To get a feel for how it works, try playing around with other conditions. Here are the valid operators:

* `>`: greater than
* `<`: less than
* `==` equal to
* `!=`: not equal to


For example, all the elements of `x` equal to 15:

```R
x[ x == 15 ]
```

All the elements of `x` not equal to 15:

```R
x[ x != 15 ]
```

Try some combinations out ands see what happens!



