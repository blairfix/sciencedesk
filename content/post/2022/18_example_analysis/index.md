+++
author = "Blair Fix"
title =  "18. Accessing data elements in R"
date = "2022-11-14"
slug = "r-access-elements"
description = "I review some simple ways to access elements of a database in R."
tags = [ "R", "data analysis", "subset", "indexes", "access elements"  ]
+++



Probably the most important part of learning R is figuring out how to access the elements of a database. In this post, we'll play with some financial data from US public corporations. I'll show you the quick way to access data using indexes. Then I'll show you some better options that are 'human readable'.


### Read in the data

Every R analysis starts by reading in the data you want. Here, we'll read in data from the following url:


```R
url = "https://sciencedesk.economicsfromthetopdown.com/2022/11/r-access-elements/data/fdata.csv"
```

We'll import the data  using the `read.csv` command and dump it into a variable called `fdata`. 


```R
fdata = read.csv(url)
```



### What's in my data?

Alright,  we've got some data contained in a variable called `fdata`. The first thing we'll do is look at what's there. 

We have many options. The simplest approach is to just type our variable name (`fdata`) in the console and hit enter: This option is fine for small datasets. But it's unwieldy if the dataset is large. The data dump will completely clog your terminal.

A better option is to use the `head` function. By default, it will dump the first 6 lines of the data:

```R
head(fdata)
```

Here's what I get back:

```R
  year ticker   profit     sales
1 2010    AIR   69.826  1775.782
2 2010 ADCT.1   62.000  1156.600
3 2010    AAL -471.000 22170.000
4 2010   CECE    2.105   140.602
5 2010    AVX  244.003  1653.176
6 2010    PNW  350.053  3263.645
```

Alright, it looks like we have four columns of data: `year`, `ticker`, `profit` and `sales`. If you haven't already guessed, we're looking at financial data for individual companies, organized by year and the stock ticker of the company.



### How much data do I have?

Once I've read in a dataset, usually the first thing I do is see how much data I have. For that, I use the `nrow` function, which tells us how many rows are in our database:

```R
nrow(fdata)
```

Here's what I get back:

```R
[1] 9019
```

So our database has just over 9 thousand rows. 

If we want to know how many columns we have, we can use the `ncol` function:

```R
ncol(fdata)
```

R will return:

```R
[1] 4
```

So our database has 4 columns (which we already knew).


### Accessing data by index

Now that we've got our database, let's talk about how we access its elements. One option is to use row and column indexes. The syntax looks like this:

```R
fdata[ row_number, column_number ]
```

For example, to access the data in the first row and first column of `fdata`, I'd type:

```R
fdata[ 1, 1 ]
```

I get back the first entry in the `year` column:

```R
[1] 2010
```

Another example. Let's get data from the 3rd row and 4th column:

```R
fdata[ 3, 4 ]
```

I get back the third entry in the `sales` column:

```R
[1] 22170
```

### Accessing whole rows by index


If we want all of the data in a particular row, we leave the column entry blank. For example, here's how to get all of the data in the second row of `fdata`:

```R
fdata[ 2, ]
```

Here's what we get back:

```
  year ticker profit  sales
2 2010 ADCT.1     62 1156.6
```

### Accessing whole columns by index

If we want all of the data in a particular column, we leave the row entry blank. Here's all the data in the third column of `fdata`:

```R
fdata[ , 3 ]
```

R will dump out several thousand entries that begin like this:


```R
 [1]     69.826     62.000   -471.000      2.105    244.003    350.053    118.376   4626.172
```


### Don't hardcode indexes

It's good to understand how  indexes work, because they are the most basic way of accessing data. That said, you want to avoid hard coding them into your analysis. Here's why.

Suppose my code contains the following entry:

```R
p = fdata[ 5, 3 ]
```

What does this code do? Well, it takes data from the 5th row and 3rd column of `fdata` and dumps it into a variable called `p`. But what is this data?  Our code doesn't tell us.

That's a problem. Remember, when you write R code, the goal is to both analyze data and *document* what you've done. Sure, hard-coded indexes are a quick and easy way to analyze data. But since they contain no metadata, they lead to code that is horribly opaque.

Fortunately, R has many 'human readable' ways to access data. The most basic is probably the column operator, `$`.



### Accessing columns by name

To understand the `$` operator, we need to back up a bit and look at how R imports data. By default, R assumes that the first row of your dataset contains column names --- names that describe the data below. When R reads in this data, it applies these names to each column of the imported data frame.

We can access these column names using the `name` function:

```R
names(fdata)
```

R returns:

```R
[1] "year"   "ticker" "profit" "sales"
```

The `$` operator allows us to access columns by name.
For example, if I wanted all of the data in the `year` column of `fdata`, I'd type:

```R
fdata$year
```

Note that I could access the same data using indexes. The `year` data is in the first column, so I'd enter:

```R
fdata[ , 1 ]
```

To R, the two operations are identical. But to *humans*, `fdata$year` is far more descriptive.


### Accessing rows by condition

To review, the `$` allows us to access columns by name. Is there a similar way to access *rows* by name?

The answer is no. Unlike columns, R does not (by default) attach names to each row of data. The assumption is that column names describe the data, and then everything that follows is *part* of the dataset. So instead of accessing rows by 'name', we access them by 'condition'.

Here's an example. Suppose we want to find data for Apple. How would we do it? Well, the obvious option is to search the `ticker` column for Apple's stock ticker "AAPL".

R has many options for this type of search, but here we'll use the `subset` function. Its syntax works like this:

```R
subset( dataset, contition )
```

Here, our dataset is `fdata`. And the condition is that the data in the `ticker` column should equal `"AAPL"`.  To write this condition, we use the `==` symbol. The full request is:

```R
subset( fdata, ticker == "AAPL" )
```

(Note: If you use the single equals sign (as in `ticker = "AAPL"`), R will throw an error. That's because it thinks you're *defining* the `ticker` variable, rather than searching for equality.)


Here's what I get back from our subset request:

```R
   year ticker profit sales
96 2010   AAPL  14013 65225
```

So it looks like there's one line of `AAPL` data, which happens to be in row 96. 


### Getting Apple's profit

Suppose that I want to get profit data for Apple. Here's one way to do it. From the example above, I know that Apple's data is in row 96. And profit data is in column 3. So I can get Apple's profit by hard coding those indexes:

```R
apple_profit = fdata[ 96, 3 ]
```

The code is succinct, but opaque. And if the database changed, my code would give me the wrong result. 

Here's a better way to get Apple's profit data. First, I ask R to subset the data on the condition that the `ticker` column equals "AAPL". Let's call that result `apple`:

```R
apple = subset( fdata, ticker == "AAPL" )
```
Then I use the `$` operator to access the `profit` column of our `apple` data:

```R
apple_profit = apple$profit
```

Let's see what we found:


```R
> apple_profit
[1] 14013
```

If all went well, it's the same data as `fdata[ 96, 3]`. Let's check:

```R
> fdata[ 96, 3]
[1] 14013
```

Yep, it's the same. 


### The coding payoff

At first, it may seem annoying to take the long, descriptive route to accessing elements of your data. But as you learn to use R, you'll realize the advantages. First, your code will be self-documenting. Second, your code will 'scale' with ease. By 'scale', I mean that you can use the same code, regardless of the size of your database. 

In our example, there was one line of Apple data. But the same code (using the `subset` function) would work if there were a million lines of Apple data. That's the beauty of a coding language like R. For simple analysis, the code may seem cumbersome compared to what you'd do in a spreadsheet. But that same code will work on a enormous database --- one that Excel couldn't even load.

Because accessing elements of your data is such a basic part of analysis, R provides many many ways to do it. But that's a topic for the future. For now, I recommend that you play with the `subset` function to see what you can do.

Here's some examples to try:

```R
# data with positive profit
subset( fdata, profit > 0 )

# data with negative profit
subset( fdata, profit < 0 )

# data in which sales are less than profit
subset( fdata, sales < profit )
```

Happy subsetting!
