+++
author = "Blair Fix"
title = "3. Tips for working with big data in the terminal"
slug = "tips-big-data-terminal"
date = "2022-07-18"
description = "Tips for working with big data in the terminal"
tags = [ "R", "managing big data", "split",  "grep", "wc", "terminal", "Linux" ]
+++


As a long-time student, I've spent most of my career working on cheap computers with minimal memory. That can make it difficult to work with big datasets.

When you work in R, for example, the analysis usually has 3 steps:

1. Read the data into memory
2. Analyze the data
3. Write out some results

As long as you can read the whole database into your computer's memory, this approach works well. But if the database is huge, then you can't get past step 1. Here are some tricks to help get around this roadblock. 


### 1. Open a Linux/Unix terminal

For the steps ahead, we're going to use Linux/Unix commands that can be executed from a terminal. The reason we're going to do this (instead of opening R or Python) is because the Linux/Unix terminal has some fantastic commands for manipulating text files.  

If you use Linux or MacOS, just open your terminal and try out the commands below. If you're a Windows user, you have to first install the [Windows Subsystem for Linux](https://docs.microsoft.com/en-us/windows/wsl/about). Once you've got that running, you'll have a Linux terminal at your disposal.


### 2. Get some data

Assuming you have a Linux/Unix terminal open, we're going to use it to get some data.
Let's download postal code data from [geonames.org](https://www.geonames.org/). To do that, we'll use the `wget` command:

```bash
wget http://download.geonames.org/export/zip/GB_full.csv.zip
```

If all goes well, you'll now have a file called `GB_full.csv.zip`, which is a zip file containing postal codes for Great Britain. (The file will be located in the directory in which you ran the `wget` command.) 

Next, let's unzip the data:

```bash
unzip GB_full.csv.zip
```

Now you should have a file called `GB_full.txt`. That's got the data we'll work with.

The `GB_full.txt` database is about 170 MB, so it's not actually that large. You could easily read the whole file into memory on almost any computer. But let's pretend it's an enormous dataset that's too big for your computer.  Here's some tips for working with the data.


### 3. Use `head` to get a sense for the data

Whenever I download a new dataset, one of the first things I do is have a look at it. If the dataset is small, I typically read the whole thing into R, and then peruse  it from there. But if the data is too big for that, I use the Linux `head` command. The `head` command will print out the top of the file. To see the head of our `GB_full.txt` file, we'd enter:

```bash
head GB_full.txt
```

By default, `head` will print the first 10 lines of the file.  For our dataset, it looks like this (scroll to the left to see all the data):

```bash

GB	AL3 8QE	Slip End	England	ENG	Bedfordshire		Central Bedfordshire	E06000056	51.8479	-0.4474	6
GB	AL5 3NG	Harpenden	England	ENG	Bedfordshire		Central Bedfordshire	E06000056	51.8321	-0.383	6
GB	AL5 3NS	Hyde	England	ENG	Bedfordshire		Central Bedfordshire	E06000056	51.8333	-0.3763	6
GB	AL5 3QF	Hyde	England	ENG	Bedfordshire		Central Bedfordshire	E06000056	51.8341	-0.385	6
GB	B10 0AB	Birmingham	England	ENG	West Midlands		Birmingham District (B)	E08000025	52.4706	-1.875	6
GB	B10 0AD	Birmingham	England	ENG	West Midlands		Birmingham District (B)	E08000025	52.4691	-1.8737	6
GB	B10 0AE	Birmingham	England	ENG	West Midlands		Birmingham District (B)	E08000025	52.4661	-1.8637	6
GB	B10 0AF	Birmingham	England	ENG	West Midlands		Birmingham District (B)	E08000025	52.469	-1.859	6
GB	B10 0AL	Birmingham	England	ENG	West Midlands		Birmingham District (B)	E08000025	52.4697	-1.8682	6
GB	B10 0AR	Birmingham	England	ENG	West Midlands		Birmingham District (B)	E08000025	52.4654	-1.8604	6
```

What's nice about `head` is that it is super fast, even if the database is enormous. And although it prints only a small portion of the data, that's often enough to understand what's in the dataset. 

You can control how many lines `head` prints out using the `-n` flag. For example, to print out the first 4 lines of our file, we'd enter:

```bash
head GB_full.txt -n 4
```



### 4. Use `wc` to tell how much data you have

The next thing you might want to know is how many lines are in your database. To find that out, we can use the `wc` command. By default, this command will print out the number of lines in the file, the number of words, and the number of bytes. If we only want the number of lines, we can use the `-l` flag:


```bash
wc -l GB_full.txt 
```

Here's what we get back:

```bash
1797499 GB_full.txt
```


So our database has about 1.8 million lines. On the scale of big datasets, that's fairly small. But it's not something you'd want to open in Excel.



### 5. `grep` the data you want

[`grep`](https://en.wikipedia.org/wiki/Grep) is a legendary command line tool created in 1973 by Unix developer Ken Thompson. It's basically a tool to do command line searches.

`grep` is useful if you have a huge dataset, but you only want to use a small portion of it. For example, in our postal code data, suppose we only want the data for one city --- say 'Birmingham'. We can use the `grep` function to find all the lines of data that contain the word 'Birmingham':

```bash
grep "Birmingham" GB_full.txt  
```

By default, grep will dump the results to your screen. If the dataset is large, this screen dump won't be helpful. 

A better option is to dump the grep results to a new file. For that, you can use the `>` pipe. The code below will dump our `grep` results into a file called `birmingham.txt`.


```bash
grep "Birmingham" GB_full.txt > birmingham.txt 
```

If the `birmingham.txt` file is a reasonable size, you can then read it into memory and work with. 

Another option is to use `grep` to explore the data. To do that, you can use the `|` command to send the output of grep to another command. For example, we already reviewed how to use `wc -l` to get the number of lines in a file. We can also use it to count the number of lines from our `grep` result.

For example, this code would tell us how many lines of our database reference 'Birmingham':

```bash
grep "Birmingham" GB_full.txt | wc -l 
```

I get back:

```bash
24025
```

So there are about 24K entries for Birmingham. 

Another option is to pipe the `grep` results to the `less` function:

```bash
grep "Birmingham" GB_full.txt | less
```

`less` will allow you to scroll through the results in your terminal. (When you're finished, press `q`.


Now, you may be wondering why we're doing this kind of data exploration with the Linux command line, when we could be doing the same thing with R (or Python). Well, the advantage here is that  unlike most R commands, these Linux commands don't require that you read the whole file into memory. If the dataset is huge, that's important.


### 6. Use `split` to breakup the dataset

Often, really big datasets are comprised of many different files, each of which is small enough to be read into memory. That's convenient. But even if the dataset comes as one giant file, you can easily break it up into smaller ones using the `split` command.

There are a number of ways to use `split`. You can use the `-l` flag to split by the number of lines. For example, the code below would split `GB_full.txt` into many files, each of which have no more than 100,000 lines.

```bash
split GB_full.txt  -l 100000
```

Be careful with this option! If you're not  paying attention, the command could return thousands and thousands of files. For example, out database contains about 1.7 million lines. If you decided to split every 100 lines, you'd get back 17,000 files. Not ideal!

Because of these pitfalls,  I prefer to use the `-n` flag, which tells `split` how many files to create. The code below would split our dataset into 10 different files:


```bash
split GB_full.txt  -n  10
```

Here's what they would be called:


```bash
xaa
xab
xac
xad
xae
xaf
xag
xah
xai
xaj
```

Now that we have our split data, we can work with it iteratively. The idea would be to read one file into memory at a time, and do the manipulation and/or analysis you want. Then move on to the next one. 

### Consult the `man`

If you're on a terminal, you can find out more about a function using the manual command, `man`. For example:

```bash
man wc
```

Usually what I look for in the `man` are the options for the function. In unix-speak, command line options are often called 'flags', and denoted with a dash (as in the `-l` in `wc -l`.


### A moving target

What constitutes 'big data' depends on the specs of your computer. For example, if you have 64GB of RAM, you can read the vast majority of datasets into your memory without a problem. But if you have 8GB of memory,  you need to be more careful. 

Even if I can read a database into memory, I often use the commands above to get a quick sense of the data before I begin to work with it.




