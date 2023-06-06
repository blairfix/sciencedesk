+++
author = "Blair Fix"
title =  "21. Making functions in R"
date = "2023-03-06"
slug = "r-functions"
description = "How to make and use functions!"
tags = [ "functions", "R" ]
+++


Today, we're going to talk about writing functions in R. A function is basically a wrapper for a piece of code --- a wrapper that makes the code easier to reuse. Let's dive in.


### Square me

To understand functions, let's start with a simple math operation. Suppose we have a vector `x` containing the numbers 1 to 10. Let's define `y` to be the square of `x`:

```R
x = 1:10
y = x^2
```

Let's see what's inside `y`:

```R
> y
 [1]   1   4   9  16  25  36  49  64  81 100
```


The above code is simple, but not very portable. The problem is that we've hard coded our math to operate on the variable `x`. But suppose we want a function that squares anything we throw at it.  Here's how we'd write it in R:

```R
# a function for squaring a number
square_me = function(x){
    y = x ^2
    return(y)
}
```

What we're doing here is defining a function called `square_me`. 
The function takes an input called `x`, and dumps out the square of `x`. In other words, it does the same thing as our simple code above. The only difference is that by defining a function, we get a wrapper for interacting with our code.

For example, to square the numbers 1 to 10, we'd enter:

```R
> square_me(1:10)
 [1]   1   4   9  16  25  36  49  64  81 100
```

So now we have a function  for squaring numbers!


### Function guts

Some things to know about functions. First, the internal variables are merely placeholders. In the example above, I named the input variable `x`. But I could just as easily called it `my_variable`.


```R
square_me = function(my_variable){
    y = my_variable^2
    return(y)
}
```

The name change makes no difference when we call the function.

```R
> square_me(1:10)
 [1]   1   4   9  16  25  36  49  64  81 100
```

Of course,  instead of passing raw data to our function, we can pass a variable:

```R
z = c(1, 2, 4)
square_me(z)

[1]  1  4 16
```

And we can pass the output of our function into a new variable:

```R
result = square_me(z)
```

Back to our original function. The output variable `y` is also a placeholder. We can replace it with any name. 

```R
square_me = function(x){
    output = x ^2
    return(output)
}
```

The substitution does not change how the function behaves.

Also note that R cannot 'see' variables that are defined internally to a function. So inside `square_me`, we have a variable called `output`. It's defined inside the function, but not outside. So if we ask R what's inside `output`, it will throw an error:

```R
> output
Error: object 'output' not found
```


Now to the `return` command. This command tells R what to output from the function. The idea here is that functions can be full of many internal variables. The `return` command tells R what to dump out. 

Note that you can write simple functions without the `return` command:

```R
square_me = function(x){
    x^2
}
```

And if you want to keep things on one line, you can also remove the curly brackets:

```R
square_me = function(x) x^2
```

That said, I rarely write functions  using this simplified syntax. I like my code to be explicit.



### When functions are useful

Now that we understand how functions work, why use them? In general, I use functions when my code is going to be *reused*. 

For example, suppose I need to apply some complicated analysis dozens of times. One option would be to copy and paste the code dozens of times. A cleaner option, however, would be to put the analysis in a function, and then apply the function many times. 

Conceptually it looks like this:

```R

complicated_thing( x, y, z){

    lots of code

    return( results )
}
```

Now we use our code multiple times.

```R
data1 = complicated_thing( a, b, c)
data2 = complicated_thing( e, f, g)
data3 = complicated_thing( h, i, j)
```


### Put your functions in their own script

Here's a nifty trick: put functions in their own script file. For example, let's put the code below in a file called `functions.R`.


```R
# functions.R
# a script for functions

cube_me = function(x){
    y = x^3
    return(y)
}
```

To get access to our functions, we just need to source our script:

```R
source("functions.R")
```

Then we can use our functions as we like:

```R
> cube_me(1:5)
[1]   1   8  27  64 125
```


### Function tips

When I write code, I typically start without functions. Then, as the analysis gets more complicated, I'll find that I'm reusing chunks of code several times. At that point, I'll put these code chunks into a function, and then call the function repeatedly.

The nice part of this workflow is that it makes it easy to update your analysis. Instead of altering the same code dozens of times (and potentially making mistakes), you alter your code *once* in your function.

In short,  functions makes complicated analysis much easier. Happy coding!
