+++
author = "Blair Fix"
title =  "11. The big three data types in R"
date = "2022-08-24"
slug = "R-big-three-data-types"
description = "A description of the R data types of that I the most"
tags = [ "R", "data frame", "vector", "scalar"  ]
+++


Let's talk data types in R. Here are the three that I use the most:

1. scalars
2. vectors
3. data frames

### Scalars

A 'scalar' is a fancy word for data that has one dimension. For example, if I defined the variable `x` to have the value `5`, `x` would be a scalar.

```R
x = 5
```

There are many reasons to use scalars in R, but one of the most important is to avoid 'magic numbers'  --- numbers that appear in your code for no apparent reason. In the code below, for example, the numbers `10` and `2` are magic.  They appear with no explanation of their meaning.

```R
speed = 10 / 2

```

To practice good coding, you want to avoid magic numbers by using scalar variables instead. Here's the same code, but with the values `10` and `2` dumped into variables that explain what they mean:

```R
distance = 10
time = 2
speed = distance / time
```

### Vectors

R is what's called a 'vectorized' language, meaning it's built to handle vectors by default. What's a vector? Well, its just a combination of multiple scalars, lumped into a single variable.

There are various ways to create vectors. The one I've [already reviewed](https://sciencedesk.economicsfromthetopdown.com/2022/07/vectors-in-r/) is to use the indexing function `:`, which creates an index of integers between two values. For example, to create a list of integers from 1 to 5 and dump them in the variable `x`, we'd enter:

```R
x = 1:5

> x
[1] 1 2 3 4 5
```

Another useful tool is the combine function, `c`. You can use it to create a vector with the specific values you want:

```R
x = c(1, 3, 6, 10, 20)

> x
[1]  1  3  6 10 20
```

Note that you can use `c` on vectors too. For example, let's first define two vectors, `x` and `y`. Then, we'll combine them in the variable `z`:

```R
x = 1:5
y = 10:15
z = c(x, y)

> z
 [1]  1  2  3  4  5 10 11 12 13 14 15
```


Vectors don't need to be numeric either. They can be made of characters like this:

```R
names = c("Alice", "Bob", "Sally")

> names
[1] "Alice" "Bob"   "Sally"
```

Notice that I've put quotes around my names. R requires that we do this. If we don't use quotes, R will think that Alice, Bob and Sally are variables. Try this:

```R
names = c(Alice, Bob, Sally)
```

R will throw an error:

```R
Error: object 'Alice' not found
```

No, it's not that R has lost 'Alice'. The problem is that R thinks 'Alice' is a variable, but we haven't defined any variable named 'Alice'. So R tells us that it's not found.

One more thing; note that you can combine numeric and character elements:

```R
x = c(1, "Bob")
```

If you do this, be warned that R will convert any numbers into characters. You can tell you have characters because the number is surrounded by quotes:

```R
> x
[1] "1"   "Bob"
```



### Data frames

A data frame is R's equivalent of a spreadsheet --- it contains various types of data. Usually this will be a combination of characters and numbers. Let's make a data frame of individual income.

First, we'll make a vector of names:

```R
names = c("Alice", "Bob", "Sally")
```

Next, we'll make a vector of incomes:

```R
income = c(10.3, 4.1, 15.5)
```

Finally, we combine these vectors into a data frame that we'll call `income_data`:

```R
income_data = data.frame(names, income)
```

Let's see what's there:

```R
> income_data

  names income
1 Alice   10.3
2   Bob    4.1
3 Sally   15.5
```

Looking at the results, you can see that the `data.frame` function takes the inputed vectors and puts them into the columns of a data frame.

In general, for the `data.frame` function to work nicely, the input vectors need to be the same length. If they're not, R will throw an error. For example, let's remove one of the income values and see what happens:

```R
names = c("Alice", "Bob", "Sally")
income = c(10.3, 4.1)

income_data = data.frame(names, income)
```

R doesn't like it:

```R
Error in data.frame(names, income) :
  arguments imply differing number of rows: 3, 2
```

The problem is that we are trying to make a data frame with vectors of different length. 
`names` has 3 elements and `income` has 2 elements. 

Generally, we don't build data frames from scratch, like we did here. Instead, we'll be reading them in from some sort of data base. Still, it's useful to play with toy data to get a sense for how R's data types work.



### Less-used data types

Aside from scalars, vectors and data frames, there are two other important data types in R: matrix's and lists.

In R, a matrix is like a data frame, except that it can only contain numeric values. A list is a bit more complicated. In R, you can think of a list as container for data that has many different dimensions.

As I noted above, data frames don't like it when you try to input vectors of different lengths. In data-speak, we say that data frames are 'rectangular', meaning each row of data must have the same number of columns (and vice versa). A list is a more versatile container that lets you combine data of different size. For certain situations, that's really powerful. But for now, we'll stick to data frames.

Next time we'll talk about how to access the elements of a data frame. Happy computing.
