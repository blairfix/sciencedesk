+++
author = "Blair Fix"
title = "6. Using the command line to see into nested directories"
date = "2022-07-21"
description = "When files are nested but sparse, here's a trick to see them all."
slug = "command-line-nested-directories"
tags = [ "command line", "ls", "nested directories", "tree", "data management"]
+++


I remember the day when my Dad brought home our first Macintosh computer. Gone were the hours of typing text onto the green screen of our Apple IIe. Suddenly there was a rich visual environment to interact with. I never wanted to leave it.

Flash forward 35 years, and I spend much of my time typing text into a command line. The reason is that I find a text-based workflow is often more useful for managing and manipulating data.

Here's a simple example. Suppose you download a new database and want to get a quick snapshot of the files that are in it. Suppose also that this database is heavily nested, meaning there are folders within folders within folders. How would figure out what's there?

In this situation, I find a graphic file browser is quite cumbersome. Yes, you can click your way in and out of folders. But you can't get a high-level view of the whole database.

That's where the command line comes in. In the Linux/Unix command line, there's a function called `ls` whose job is to list what's in a directory. In that sense, `ls` does exactly what a file browser will do, except without the nice graphics. Where `ls` really shines, though, is if you want to see into all of the subdirectories at once. To do that, you use the `-R` flag, which stands for 'recursive'.

```
ls -R
```

I find this command especially useful when a database is heavily nested yet sparse, meaning there are many nested folders, each of which contains only a few files. This type of structure is frustrating to explore with a file browser. But it is simple to see with `ls`.

Here's an example on a made-up database. Typing `ls -R` gives:

```
database/:
2020  2021

database/2020:
Jan  Jun

database/2020/Jan:
file1.txt

database/2020/Jun:
file2.txt  file3.txt

database/2021:
May

database/2021/May:
file4.txt
```

Here we get to see the whole directory structure at once. There are two high-level folders, `2020` and `2021`. And within those, there are month folders. And within those there are text files, which contain the data we are interested in. The way I use `ls -R` is to find where the actual files live (here `.txt` files) in a heavily nested directory. 

If you want something a bit prettier, there's also the `tree` command, which would return this:

```
database/
├── 2020
│   ├── Jan
│   │   └── file1.txt
│   └── Jun
│       ├── file2.txt
│       └── file3.txt
└── 2021
    └── May
        └── file4.txt

5 directories, 4 files
```

Now, depending on what you want to do with this data, the nested structure may or may not be useful. Often I find that it is not useful, especially if I want to process the entire database. In that case, I like to 'flatten' the database by pulling all of the files out and putting them in one directory. 

If there are thousands of files, this task would be arduous in a file browser. It takes seconds in on the command line. Enter this command:


```
find . -mindepth 2 -type f -print -exec mv {} . \;
```

And suddenly all of the previously nested files live in one directory.


```
file1.txt  file2.txt  file3.txt  file4.txt
```

That's pretty magical.

