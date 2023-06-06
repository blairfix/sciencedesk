+++
author = "Blair Fix"
title =  "14. What are packages and how do I use them in R?"
date = "2022-10-01"
slug = "r-packages"
description = "Working with R means using packages. Here's what that means."
tags = [ "R", "packages", "CRAN" , "libraries"]
+++


One of the great things about open-source projects is that they tend to develop an ecosystem of software that surrounds them. In the world of internet browsers, we call this ecosystem 'extensions'. In the programming world, we call these extensions 'libraries' and/or 'packages'.

Here's how packages work in R.


### Sharing functions

In my last post, I covered some of the functions that I use frequently. On of my favorites is called the `summary` function, which provides a quick snapshot of some useful summary statistics. An example:

```R
> x = c(1, 5, 6, 3, 10)

> summary(x)
   Min. 1st Qu.  Median    Mean 3rd Qu.    Max.
      1       3       5       5       6      10
```

Now, suppose that I wanted a summary function that included more information. If I'm a competent R programmer, I could easily write such a function. 

Next, suppose that other people express interest in this function and want to use it. How do I give it to them? Well, one option would be to send them my source code. But suppose that I built many custom functions. Then, simply sharing the source code becomes a bit tedious.

That's where packages come in. An R package is just a way to bundle up many functions and make them easily accessible to other R users. Anyone can make an R package. On that front, I often make my own R packages that bundle up code that I use frequently. ([Here's an example](https://github.com/blairfix/hmod).)

So a 'package' is just a bundle of code that is designed for sharing. Typically, though, there is a distinction between 'official' and 'unofficial' packages. In R, an 'official' package is one that is hosted on the [CRAN](https://cran.r-project.org/) --- the Comprehensive R Archive Network. Having a package on the CRAN means two things:

1. The package is centrally available to all R users
2. The package has been vetted to meet the CRAN's standards

What you need know about the CRAN is that it is *huge*. As I am typing this, the CRAN contains over 18,000 packages chalk full of useful functions.

Here's what that means in practice. R has a large user base of scientists, statisticians, and analysts who write code to meet their needs. Then they share this code on the CRAN for you to use. That means that when you're solving a coding problem, often the first thing you should do is see if someone has made a package that does the work for you.

Head to your preferred search engine and type: "R package for ... [thing that you need]".


### Installing and loading packages

If you use Rstudio, it provides a nice GUI (graphical user interface) for installing packages. But for now, let's cover the commands that come with basic R.

To install a package that is on the CRAN, use the `install.packages` function. For example, here's how I'd install the `data.table` package:

```R
install.packages('data.table')
```

Yes, you need the quotes around the package name. Without them, R will throw an error.

Once you've got the package, you can load it using the `library` command:

```R
library(data.table)
```

(This time, you *don't* need quotes around the package. Also, note that you only need to install the package once. After that, you can load it anytime you want using the `library` command.)


Once you got the package loaded, you have access to all the functions it contains. Of course, to *use* these functions you'll have to read the documentation.


### Documentation

Some of the bigger packages (like the [Tidyverse](https://www.tidyverse.org/)) have their own websites containing detailed documentation. But in general, all packages have PDF user manuals hosted on the CRAN. 

Another option is to read the documentation within R. To do that, just type `?` followed by the package name:

```R
?data.table
```

(Note that you have to have the package installed and loaded for this command to work.)

R will show you the basic documentation. For data.table, it looks like this:

```R
data.table-package         package:data.table          R Documentation

Enhanced data.frame

Description:

     ‘data.table’ _inherits_ from ‘data.frame’. It offers fast and
     memory efficient: file reader and writer, aggregations, updates,
     equi, non-equi, rolling, range and interval joins, in a short and
     flexible syntax, for faster development.

     It is inspired by ‘A[B]’ syntax in R where ‘A’ is a matrix and ‘B’
     is a 2-column matrix. Since a ‘data.table’ _is_ a ‘data.frame’, it
     is compatible with R functions and packages that accept _only_
     ‘data.frame’s.
```

When you're done reading, type `q` to exit.

Note that you can use the same syntax to lookup the documentation for functions. Here's how to lookup the documentation for the `mean` function:

```R
?mean
```

Here's what you'll get:

```R
mean                   package:base                    R Documentation

Arithmetic Mean

Description:

     Generic function for the (trimmed) arithmetic mean.

Usage:

     mean(x, ...)

     ## Default S3 method:
     mean(x, trim = 0, na.rm = FALSE, ...)
```

Okay, so pulling documentation is easy. Actually *understanding* it takes some practice. (Programmers are not known for the clarity of their prose.)

At any rate, now you know what an R package is and how to get it. The bigger job is figuring out the packages that will drive your daily work.  More on that in the future.










