+++
author = "Blair Fix"
title =  "15. Reading data into R"
date = "2022-10-03"
slug = "read-data"
description = "Here's how you get data into and out of R"
tags = [ 'reading data', 'readLines', 'read.csv', 'read_csv', 'fread'  ]
+++

Today we're going to talk about reading data into R. I'll first show you the options that come with base R (meaning you don't need any packages). Then I'll talk about some improved versions of these functions.

### Reading unformatted data

Sometimes the data that you're working with consists of unformatted text. For example, maybe you're analyzing the contents of a website. To read this kind of data into R, I use the `readLines` function. As the name suggests, this function takes the lines of a file and reads them into memory. The syntax works like this:

```R
readLines(path_to_file)
```

By default, the `readLines` command will dump what it reads to your screen. If you want to actually use the data, you need to save it to a variable like this:

```R
data = readLines(path_to_file)
```

Here's an example. I've put a plain text file at the following url:


[https://sciencedesk.economicsfromthetopdown.com/2022/10/read-data/example_data/raw_text.txt](./example_data/raw_text.txt)

The file contains this text:

```
This is a text file.
It is not formatted in any particular way.
The best way to read it into R is with the readLines() function.

The line above is blank.
That's all for now.
```

A nice feature of R's reading functions is that they can accept a url as in input for the file path. So we could read in my example like this:

```R
url = "https://sciencedesk.economicsfromthetopdown.com/2022/10/read-data/example_data/raw_text.txt"

data = readLines(url)
```

Let's see what's in out `data` variable:

```R
> data
[1] "This is a text file."
[2] "It is not formatted in any particular way."
[3] "The best way to read it into R is with the readLines() function."
[4] ""
[5] "The line above is blank."
[6] "That's all for now."
```

So what happened is that each line of the file becomes an element in a character vector. Note that if there are empty lines in your file, R will give them an empty element, `""`.

If we wanted the text in the second line, for example, we'd input:

```R
> data[2]
[1] "It is not formatted in any particular way."
```


If your file happens to contain numbers, `readLines` will interpret them as characters. So if you want to actually use the numbers (as numbers), you'll have to do some data cleaning. More on that later.

For now, let's move on to reading in formatted data.



### Reading csv data

Formatted data can come in many shapes and forms. However, the most common is probably the 'csv' format --- which stands for *comma separated values*.

As the name suggests, this is data that is separated by a comma. Here's an example:

```R
name,age,height
Sally,29,1.64
David,55,1.71
Brenda,38,1.56
Emily,70,1.67
Mark,44,1.91
```

This is a toy dataset containing the names of 5 people, plus their age and height. I've stored it at the url below:


[https://sciencedesk.economicsfromthetopdown.com/2022/10/read-data/example_data/dataset.csv](./example_data/dataset.csv)

To read this csv data into R, we'll use the `read.csv` function. To get the data, we can just pass the url along:

```R
url = "https://sciencedesk.economicsfromthetopdown.com/2022/10/read-data/example_data/dataset.csv"

data = read.csv(url)
```

Let's see what's in the data:

```R
> data
    name age height
1  Sally  29   1.64
2  David  55   1.71
3 Brenda  38   1.56
4  Emily  70   1.67
5   Mark  44   1.91
```

The `read.csv` function will import the data as a data frame. We can access the columns using the `$` syntax. Let's get the data in the names column:

```R
> data$name
[1] "Sally"  "David"  "Brenda" "Emily"  "Mark"
```

Note that `name` represents the heading of the column containing the data we want. (R has no idea that the `name` column actually contains people's names.)

Let's get the data in the `height` column:


```R
> data$height
[1] 1.64 1.71 1.56 1.67 1.91
```

Notice that the heights are formatted as *numbers* (not characters). That's because the `read.csv` function is smart enough to know that if a particular column contains only numbers, you'll want the data formatted as a number.

Because we have numeric data, we can apply all of the standard stats functions that I talked about [here](https://sciencedesk.economicsfromthetopdown.com/2022/09/r-functions/). For example, let's get the average (mean) height:

```R
> mean(data$height)
[1] 1.698
```

Or how about the minimum age:

```R
> min(data$age)
[1] 29
```

These are just some simple examples. Once you've read the data into R, the real work begins.


### When you need speed

For small datasets, the `read.csv` function does the job just fine. But for big data, it's too slow to be usable. Here are two alternatives that are faster:


#### `fread` 

My preferred reading function is called `fread`. It comes from the `data.table` package, and is blazing fast. To use it, install the data.table package:

```R
install.packages("data.table")
```

Load the library and `fread` something:

```R
library(data.table)

url = "https://sciencedesk.economicsfromthetopdown.com/2022/10/read-data/example_data/dataset.csv"

data = fread(url)
```


Like the other reading functions, `fread` accepts a file path (or a url). `fread` is also smart and will guess how the data is formatted. So if the data happens to be tab separated (instead of comma separated) `fread` will know what to do.

Note that `fread` will import the data as a 'data table', which is slightly different than an R data frame. For simple analysis, though, nothing changes. 


#### read_csv 

The `read_csv` (note the underscore in the name) function comes from the `readr` package. It does much the same thing as the basic `read.csv`, except it does it much faster.

Install `readr` like this:

```R
install.packages("readr")
```

Read in data like this:

```R
library(readr)

url = "https://sciencedesk.economicsfromthetopdown.com/2022/10/read-data/example_data/dataset.csv"

data = read_csv(url)
```


### Reading from you local computer

I've shown you how to read data from a url. Now you should try the following:

1. Download my example files
2. Stash them somewhere on your computer
3. Read them into R


As an example, suppose I saved the `dataset.csv` file in my Downloads folder. On my computer, the filepath is:

```R
/home/blair/Downloads
```

Here's one way to get the data. First, set R's working directory to the Downloads path. To do that we use the `setwd` command:

```R
setwd("/home/blair/Downloads")
```

(Here's a [review of changing directories](https://sciencedesk.economicsfromthetopdown.com/2022/09/r-directory-nav/).)

Then read the file called `dataset.csv`:

```R
data = read.csv("dataset.csv")
```

Yes, you need the quotes around the file name.

As practice, try putting the downloaded data in different locations on your computer and asking R to read it. If it can't find the file, it will tell you:

```R
> data = read.csv("dataset.csv")
Error in file(file, "rt") : cannot open the connection
In addition: Warning message:
In file(file, "rt") :
  cannot open file 'dataset.csv': No such file or directory
```

Happy reading!


