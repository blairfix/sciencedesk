+++
author = "Blair Fix"
title =  "7.  Using R as a calculator"
date = "2022-07-22"
slug = "r-as-calculator"
description = "Interested in learning R? Here's a way to dive in: use it as a calculator."
tags = [ "R", "calculator", "intro to R"  ]
+++

Interested in learning R? Good. R is awesome. It's a free, open source statistical language that I use as my daily driver for doing science.

To install R, head over to the [Comprehensive R Archive Network](https://cran.r-project.org/) --- what R folks call the 'CRAN' --- and follow their instructions.


### Launch R

There are many ways to run R. Today, we're going to take the simplest approach and run R in the terminal. 

In Windows, your R installation should come with an executable called `R.exe`. Run that and an R console will open. On Linux and Mac, you can open R from the terminal. So first open a terminal, then type `R` and press enter.


### Not much to see

Unlike when you launch a fancy GUI program like Word, there's not much to see when you open the R console. When I launch R, here's what I get: 

```R
R version 4.2.1 (2022-06-23) -- "Funny-Looking Kid"
Platform: x86_64-pc-linux-gnu (64-bit)

>
```

The first two lines are boilerplate stuff about what version of R I'm running.  Your boilerplate may differ depending on the platform you are using and what version of R you installed. 

Below the boilerplate, you get a carrot:


```R
>
```


This is R's command prompt. It's saying "Hey, I'm ready to do what you tell me."

It's here that many people get scared, because the command prompt doesn't tell you what to do. There are no buttons, no menus, nothing at all to guide you. That's scary at first.

But I want to show you that it's not so scary. You already know how to use a calculator. And so you already know how to use the most basic features of R.


### R is a big calculator

A very simple way to think of R is as a calculator that takes input from your keyboard. Let's convince ourselves that R can do math.

First, we'll add 2 + 2.  Into the console, we type `2+2`. Then we  press enter:

```R
> 2+2
```

R tells us the answer:

```R
[1] 4
```

Okay, our answer is 4. But in front of that, we've got the symbol `[1]`. What's that about? Well, it's  how R numbers its output. Here we have one output, the number 4. But it's possible to have many outputs, which R will number consecutively, starting with `[1]`. We're not going to use this feature for now, so don't worry about. Just remember that results are what appear after the `[1]`.


Some things to know about R's syntax. R does not care about spaces between math operations. So the following requests are identical

No spaces:

```R
> 2+2
[1] 4
```

With spaces around `+`:

```R
> 2 + 2
[1] 4
```

I like to add spaces, because it helps me keep track of what I'm doing. But that's just a preference.

Here are the symbols for our basic math operations:

* `+`: add
* `-`: subtract
* `*`: multiply
* `/`: divide
* `^`: exponent

Like a good calculator, R knows about order of operations. It will do the stuff in brackets first:

```R
> (5 - 1) * 4
[1] 16
```

And it handles exponents with ease:

```R
> (5 - 1)^2 * 4
[1] 64
```

One caveat. It's commonly understood that when a number is next to a bracket, that implicitly means multiply. So `5(2) = 5*2 `. But R does not work that way. If you try to use this syntax, R will throw an error:

```R
> 5(2)
Error: attempt to apply non-function
```

You have to include the multiplication symbol to make R happy:

```R
> 5*(2)
[1] 10
```

### R thinks like a mathematician

When using R, beware that it thinks like a mathematician, not an engineer. For example, engineers generally use the `log` symbol to indicate the base 10 logarithm. And they use `ln` to indicate the [natural logarithm](https://en.wikipedia.org/wiki/Natural_logarithm). 

Mathematicians, though, only care about the natural logarithm. And so they give it the symbol `log`. That's how R works. When you take the log, you're getting the natural log by default:

```R
> log(10)
[1] 2.302585
```

If you want a base 10 log, you have to tell R like this:

```R
> log10(10)
[1] 1
```

Similarly, R thinks like a mathematician when it applies trigonometric functions. It assumes your input is in radians, not degrees. So if you take `sin(30)`, you're getting the sin of 30 radians:


```R
> sin(30)
[1] -0.9880316
```

You'll get the answer you want by converting your angle to radians. Perhaps you recall from high school math that 30 degree is &pi;/6 radians. Putting that into R gives the correct result:

```R
> sin(pi/6)
[1] 0.5
```

I'll leave you to play around with your R calculator. When you're finished, type `q()` to quit.

```R
> q()
```

Obviously, R can do much more than act as a calculator. But I find it helpful to play around with the calculator feature first, to take away some of the command line fear. 

Happy calculating.



