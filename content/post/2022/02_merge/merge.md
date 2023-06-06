+++
author = "Blair Fix"
title = "2. Merging data in R"
slug = "merging-data-R"
date = "2022-07-16"
description = "How to merge datasets with R"
tags = [ "R", "merge", "managing data" ]
+++


One of the frustrating things about doing empirical research is that the data you want lives in many different places. Sometimes you can download a beautifully formatted database that contains exactly the data you need. But more often, the data you want must be pulled from many corners of the internet.

Once you have the data, you need to put it together so you can work with it.  If you're working in R, you can use the `merge` function. As the name suggests, the function merges two datasets.

What's funny is that I was several years into using R before I discovered this function. I had been banging my head writing custom code to combine various datasets, only to learn that there was a base R function that did exactly what I want. The lesson here is that before you write custom code, you're better off doing a quick search to see if there's a pre-written function that will do what you want. There usually is.

Back to the `merge` function. To understand how it works, imagine that you have a database called `sales` that contains sales data for various companies:



```R
sales: 

   year   company sales profit
1: 1997     Apple   105      5
2: 1999      Ford   505    105
3: 1999      Ford   505     51
4: 2000 Microsoft  2450    181
5: 2001 Microsoft  2509    203
```

Imagine that we want to calculate the 'markup' of each company. To do that we need profit data. The trouble is that this data lives in a seperate database, `profit`, that looks like this:


```R
profit: 

   year   company profit
1: 1999      Ford    105
2: 2001 Microsoft    203
3: 1997     Apple      5
4: 1999      Ford     51
5: 2000 Microsoft    181

```

To work with our sales and profit data, we need to combine it into one dataset. That's whate the `merge` function is designed for. It takes as an input two sets of data, `x` and `y`:

```R
merge(x, y, by)
```

The `by` value tells `merge` the variables you would like to use as indexes.  In our example, we want to merge the data by `year` and `company`. The function will then look for all the entries with the same year and company and merge them. Applying that to our sale and profit data, we'd enter:


```R
all = merge(sales, profit, by = c("year", "company"))
```

Some comments. Yes, the quotes around `"year"` and `"company"` are required. I don't know why ... that's just the way the function works. The `c()` argument is how R combines elements. Note that by default, `merge` will keep only the by elements that are common to both sets of data.


Here's what the function will output:

```R
all: 

   year   company sales profit
1: 1997     Apple   105      5
2: 1999      Ford   505    105
3: 2000 Microsoft  2450    181
4: 2001 Microsoft  2509    203

```

Now we can calculate the markup  for each company by dividing profits by sales:

```R
all$markup = all$profit / all$sales * 100

all:

   year   company sales profit    markup
1: 1997     Apple   105      5  4.761905
2: 1999      Ford   505    105 20.792079
3: 2000 Microsoft  2450    181  7.387755
4: 2001 Microsoft  2509    203  8.090873
```


So far, I haven't talked about the type of data we've been working with. The nice thing about `merge` is that it works both on data.frames --- R's basic data holder --- and also on [data.tables](https://www.rdocumentation.org/packages/data.table/versions/1.14.2). If you're working with large data, I recommend using data.tables as they are much much faster. 

Happy merging!


