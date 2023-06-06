+++
author = "Blair Fix"
title =  "12. Moving around your computer in R"
date = "2022-09-26"
slug = "r-directory-nav"
description = "Here's how you use R to navigate directories"
tags = [ "R", "setwd", "change directory", "set working directory", "project template", "getwd", "here package" ]
+++

In my [last entry](https://sciencedesk.economicsfromthetopdown.com/2022/08/r-big-three-data-types/), I introduced the most common data types in R. Then I promised to show you how to access the elements of a data frame. Well, I changed my mind. Instead,  I've decided that we should back up and discuss the bigger picture of working with data in R.

If you are used to working with spreadsheets, then using R requires a philosophical adjustment. When you use a spreadsheet, your typical workflow is as follows:

1. Download some data
2. Open the data in a spreadsheet
3. Manipulate the data right there

The key here is that the data manipulation happens in the same place that the data itself lives. The advantage of this approach is that it gives you a hands-on feel for the data. The disadvantage is that if you're not careful, you can wreck your original data. Also, it's difficult to keep track of what you've done.

When you use a scripting language like R, your workflow is different. In short, you never 'touch' the raw data. Basically, you treat the raw data like a read-only database. The goal is then to read the data into R, do some analysis, and write the results in a *separate* file.

The nice thing about this approach is that you can never ruin your raw data. Also, your R code documents your analysis --- it tells you how you manipulated the data. 

With this workflow in mind, let's look at your computer's file structure from R's vantage point.


### Where does R live?

By default, R lives in the directory in which you opened it. Here's what I mean. If you write an R script (which I haven't yet discussed) and open it in Rstudio (which I also haven't discussed), R will live in the directory of your script. 

Another scenario is that you've opened R from the command line. In that case, R will live in whatever directory your terminal was in when you typed `R`.

Regardless of how you opened R, you can get its current 'working directory' using the `getwd` command. If I was in my `Desktop` folder, R would return the following:

```R
> getwd()
[1] "/home/blair/Desktop"
```

The path `/home/blair/Desktop` is called an 'absolute' file path. It's 'absolute' because it starts at your computers 'root' folder, and then specifies how to get to the current directory.

(If you're not accustomed to reading file paths, know that the `/` symbol separates different folders --- or what Linux/Unix users call 'directories'.)

Now that R has told us the absolute file path to our working directory, we can go ahead and *forget about this path*. That's because working with absolute file paths is bad practice.  Instead, we want to work with *relative* file paths. 

Here's why.

When you work with relative file paths, it makes your project portable. The goal is to have your entire project contained within a folder. Within that folder, you tell R to access relative file paths. The advantage is that when you're done, your project folder is completely portable. You can move it anywhere on your computer and the code within it will still run. More importantly, you can send the project folder to someone else, and the code will still run on *their* computer.


### Relative file paths

In R,  we use the `setwd` function to set the working directory. To start with, know that `setwd` can accept absolute file paths. So if I want to send R to my desktop, I'd enter:

```R
setwd("/home/blair/Desktop")
```

(Note that the quotes around directory text are necessary.)

When I first learned R, this is how I used it.  If I wanted to move to directory `x`, I'd tell R the absolute file path. The result was that my code was horribly non-portable.

Bad Blair.

Now I know better. Today, I tell R to move around using relative files paths. 

Here's a common use case. When I do analysis, I'll often structure my project like this:

```R
.
└── project
    ├── my_script.R
    ├── raw_data
    │   └── dataset.csv
    └── results
        └── my_result.csv
```

So inside my project, I have an R script (`my_script.R`). The goal of this script is to access the data that's contained in the `raw_data` folder, and to dump the results into the `results` folder.

So how do we navigate these directories?


### Start with the `here` package

I like to start all of my analysis with the `here` package. The purpose of this package is to do one thing: tell R the location of your current script.

To get `here`, install it with this command:

```R
install.packages('here')
```

Once the package is installed, load it like this:

```R
library(here)
```

Then run the following command:

```R
here()
```

The `here` function tells you the location of the R script that you are running. Think of this location as your home base. As we move around our computer, we'll often want to get back to our home base.

The way I use `here()` is to envoke it a the beginning of a script and put the resulting file path in a variable. Let's call it `home_base`:

```R
home_base = here()
```

Then I'll set my working directory to home base:

```R
setwd(home_base)
```

(Notice that there's no quotes around `home_base`. That's because we want R to treat it as a variable, not a string.)

Now technically I don't need to have this step, because when I run my script, R will already be living in the script's directory. That said, explicitly setting the working directory is helpful for debugging. 

Our next step is to get into the `raw_data` directory, which as a reminder, is located in a subfolder below our script:


```R
.
└── project
    ├── my_script.R
    ├── raw_data
    │   └── dataset.csv
    └── results
        └── my_result.csv
```

Moving to this subfolder is easy. We just put the subfolder's name (and nothing else) into `setwd`:


```R
setwd("raw_data")
```

If everything works, R will give you a blank response. R only sends something back if there's an error. For example, if I mispelled the folder name, R will tell me it can't change the directory:


```R
> setwd("rw_data")
Error in setwd("rw_data") : cannot change working directory
```

Assuming there was no error, we're now living in our `raw_data` directory. From there we can read in our data set. (We'll talk about doing that in a future post.) 

For now, let's move on to the next task, which is to dump our results into the `results` folder. How do we get there?

What I typically do is first move back to my 'home base':

```R
setwd(home_base)
```

As a reminder, this takes us back to the location of our script. From there we can move to the `results` subfolder using:

```R
setwd('results')
```

Now that we're in our `results` directory, we can write out our results. (More on how to do that later.)


### A script template

Putting everything together, the code below is a template that I use frequently.


```R
library(here)

home_base = here()
setwd(home_base)

# get raw data
setwd('raw_data')

# ----- do some stuff with the data -----

# write out the results
setwd(home_base)
setwd('results')

# ----- export your data  -----

```

(The `#` denotes a comment. It's for telling humans about your code. R will ignore any line starting with `#`.)

Of course, there are more complicated ways to structure your analysis. But this is my go-to approach. I put raw data in a `raw_data` folder. I put results in a `results` folder. Then I make a script that navigates between them and does analysis on the way.

The nice thing about this template is that it is self-documenting. That's important, because when you revisit old code, you'll have forgotten what you've done. If the project is structured well, the steps of the analysis should be obvious.

Happy navigating!
