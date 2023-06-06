+++
author = "Blair Fix"
title =  "17. Adventures with PhotoPrism"
date = "2022-11-04"
slug = "photoprism-adventures"
description = "I spent the weekend setting up PhotoPrism to host my family's photos. Here's what I learned."
tags = [ "PhotoPrism", "Tailscale", "syncthing", "ExifTool", "self hosting", "DeGoogling" ]
+++


This week I'm taking a break from R tutorials. Instead, I'm going to tell you about my adventures setting up [PhotoPrism](https://photoprism.app/) to self-host my family's photos.

Here's what I used to get the job done.


### Tailscale

Many media tools are easy to implement on a home network, but more difficult to use over the open internet. To build my media setup, I wanted photos to sync from phones to my computer, regardless of whether the phone was at home. And I wanted my media library available on mobile devices anywhere they go. 

To make that possible, I've used [Tailscale](https://tailscale.com/). It allows you to freely setup a virtual private network on up to 20 devices. (More devices than that, and there's a paid option.) Tailscale is easy to install. You put the app on all of your devices, sign in with a single-sign-on provider (I used GitHub), and you're basically done.

From there, Tailscale assigns a static IP address to each of your devices, an IP that is magically available anywhere you go.


### Syncthing

Tailscale let's your devices talk to each other, but doesn't provide a way to sync files.  For that, I used [Syncthing](https://syncthing.net/). Think of it as an open-source version of Dropbox without the cloud storage. 

You tell Syncthing what directories you want synced between devices, and   it keeps them synced. It's as simple as that. 


### PhotoPrism

With Tailscale and Syncthing, every picture that my family takes ends up on my desktop computer. The next step is to host the photos so that you can browse them and (if you like) make photo albums.

For that, I chose [PhotoPrism](https://photoprism.app/). It's an open-source project that bills itself as "an AI-Powered Photos App for the Decentralized Web".  I think it meets that description.

It's [documentation](https://docs.photoprism.app/) is generally excellent. However, the installation guide assumes a working knowledge of how to get a Docker container running. Since I'd never done that before, I had to do some poking around. Basically, you have to install docker and docker-compose, and then make sure the docker daemon is running. From there, you can install PhotoPrism.

(Here's the [install script](scripts/install) I used on Arch Linux.)


After my initial hangups with getting docker running, installing PhotoPrism was flawless. Once it starts, you can access the server via your browser and start importing your pictures. On my trove of about 15,000 pictures, the import took a few hours.


### Face recognition

By default, PhotoPrism will attempt to recognize faces in your pictures. (The AI is totally private, so it doesn't share your data.)

On adults, I find the recognition is quite good. For my 7-year-old daughter, though, it's laughably poor. I guess that's understandable. Kids change a lot when they're young, in ways that are difficult for a bot to recognize.

### Hangups

Once I got all my photos into PhotoPrism, I found a few hangups, mostly to do with dates. PhotoPrism let's you browse photos by the date they were (ostensibly) taken. While I was browsing, I found large batches of photos that were in the wrong place.

It turns out that the problem was on my end. Back in the 2000's, my family had some, shall we say, not very good digital cameras. It appears that some of these devices were permanently stuck in the wrong year.

I never noticed because I never paid attention to the metadata that was embedded in the images. I just dumped them into a folder like `Christmas 2005` and that was that. Later on, I started importing photos and putting them in folders by year and month.

So here's where things get interesting. PhotoPrism has an algorithm for trying to date pictures. At the top of this algorithm is the folder structure of your pictures. So if you have a picture in the directory `/2012/03/`, PhotoPrism will date the picture as being taken in March 2012. This will happen even if the picture metadata indicates a different date. If the directory structure has no clear date system, then PhotoPrism will look at the image metadata.

Now, I think this is a perfectly reasonable system that works fine with modern devices that date photos accurately. But with a messy photo library like mine, there was a lot of fixing to do. And that brings me to my final tool.


### ExifTool

[ExifTool](https://exiftool.org/) is a command line program for editing image metadata. Like all command line tools, it has a fairly steep learning curve. But the payoff is that you can edit photos in large batches.

In my case, I found large batches of images that had the wrong year, but the other parts of the date seemed fine. I wrote a [bash script](scripts/fix_year) that I could run in a directory, and fix the year metadata for all pictures. After a few hours of doing that, my images appear in (nearly) flawless date order on PhotoPrism.


### Hands off 

I'm extremely happy with the photo system I've got running. Everything is automatic. Syncthing sends all new photos to my computer, and I've got PhotoPrism set to automatically scan for new images every few hours. 
Also, for the first time I can easily run searches on my entire library.[^note] Awesome!

Goodbye Google. I'm never coming back.

[^note]: Yes, you can run searches in Google Photos. But here's the problem. First, I didn't have the paid version, which meant I had to keep my online library (well) below 15GB. So most of my photos lived offline. Second, my wife and I have different Google accounts, so our photos were in two different places. 

