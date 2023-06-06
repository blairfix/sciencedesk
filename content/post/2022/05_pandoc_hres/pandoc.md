+++
author = "Blair Fix"
title = "5. Getting pandoc to make a Word document with hi-res images"
date = "2022-07-20"
slug = "pandoc-word-hi-res-images"
description = "By default, pandoc creates low-res images in word documents. Here's how to fix that."
tags = [ "pandoc", "word", "docx", "images", "high resolution", "plain text"]
+++

I use [pandoc](https://pandoc.org/) for nearly everything I write.[^hugo] It's a nifty command line tool for converting documents into any format.

The way I use pandoc is that I write using [markdown](https://en.wikipedia.org/wiki/Markdown)  --- a markup syntax that is simple and elegant.  Then I use pandoc to convert the finished product to the format I need. 

For example, when  I blog over at [Economics from the Top Down](https://economicsfromthetopdown.com/),  I write my posts in markdown. Then I use pandoc to generate HTML files, which I dump into WordPress. This way I never have to touch the much maligned WordPress editor.

When I write a long post, I've started hosting a PDF and EPUB version of the document. (Example [here](https://economicsfromthetopdown.com/2022/07/12/have-we-passed-peak-capitalism/).) How do I do that? You guessed it --- with pandoc.[^note]

It's hard for me to express how much simpler pandoc has made my life as a scientific writer. When I first made the jump to writing in [plain text](https://economicsfromthetopdown.com/2020/12/10/why-and-how-i-write-scientific-documents-in-plain-text/), I used LaTeX. That was great for my workflow as an academic, which involved making PDFs. But it came with one huge problem: when someone asked for a Word document, I was left kicking and screaming.

Pandoc changed that. To convert my markdown document to docx, it's as simple as:


```
pandoc article.md -o article.docx
```

The docx output is generally fantastic, with one exception. By default, pandoc likes to compress images when it puts them in a docx file. I learned that the hard way when I sent a manuscript for publishing, only to realize later that the figure resolution was crap.

Fortunately, this low resolution is easy to fix. Just run pandoc with the `dpi` (dots per inch) flag. I usually generate my figures at 600 dpi. So I pass that along to pandoc:

```
pandoc --dpi=600 article.md -o article.docx
```

Presto, you get a word document with stellar images. 


[^note]: I'm simplifying things a bit. I've written a bunch of code that integrates with pandoc to format the documents the way I like. But that's a topic for another post.

[^hugo]: The exception is this science desk, which I generate using [Hugo](https://gohugo.io/), which in turn, uses the [Goldmark](https://github.com/yuin/goldmark/) rendering engine. Goldmark is fast. But it is far less extensible than Pandoc, and is designed only too render HTML.
