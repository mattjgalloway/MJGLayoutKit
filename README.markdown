# MJGLayoutKit

## Introduction

MJGLayoutKit is a layout framework for iOS which gives options for automatically laying out views.

An example of what MJGLayoutKit can do is shown below where the layout is automatically reflowed when 
the size of the image is changed. In this layout there is 1 vertical layout, 1 horizontal layout and 
1 frame layout. The different colours show the different views/layouts indicating how padding and 
margins can be set.

![sample-1](https://github.com/mattjgalloway/MJGLayoutKit/raw/master/Images/Sample-1.png) 
![sample-2](https://github.com/mattjgalloway/MJGLayoutKit/raw/master/Images/Sample-2.png)

In this example, the green view is a horizontal layout containing a frame layout on the left and 
an empty view on the right. The frame layout is set to fill all remaining space and contains three 
empty views (blue, orange and purple). The empty view on the right is set to be a fixed width and 
fill height. The horizontal layout is then within a vertical layout along with the image at the top. 
The image is set to wrap its content (i.e. take up just as much room as is required by the image) 
and the horizontal layout is set to fill both width and height.

## License

MJGLayoutKit uses the 2-clause BSD license. So you should be free to use it pretty much however 
you want. Contact me if you require further information.

Copyright (c) 2012 Matt Galloway. All rights reserved.

Redistribution and use in source and binary forms, with or without
modification, are permitted provided that the following conditions are met:

1. Redistributions of source code must retain the above copyright notice, this
list of conditions and the following disclaimer.

2. Redistributions in binary form must reproduce the above copyright notice,
this list of conditions and the following disclaimer in the documentation
and/or other materials provided with the distribution.

THIS SOFTWARE IS PROVIDED BY THE COPYRIGHT HOLDERS AND CONTRIBUTORS "AS IS"
AND ANY EXPRESS OR IMPLIED WARRANTIES, INCLUDING, BUT NOT LIMITED TO, THE
IMPLIED WARRANTIES OF MERCHANTABILITY AND FITNESS FOR A PARTICULAR PURPOSE ARE
DISCLAIMED. IN NO EVENT SHALL THE COPYRIGHT HOLDER OR CONTRIBUTORS BE LIABLE
FOR ANY DIRECT, INDIRECT, INCIDENTAL, SPECIAL, EXEMPLARY, OR CONSEQUENTIAL
DAMAGES (INCLUDING, BUT NOT LIMITED TO, PROCUREMENT OF SUBSTITUTE GOODS OR
SERVICES; LOSS OF USE, DATA, OR PROFITS; OR BUSINESS INTERRUPTION) HOWEVER
CAUSED AND ON ANY THEORY OF LIABILITY, WHETHER IN CONTRACT, STRICT LIABILITY,
OR TORT (INCLUDING NEGLIGENCE OR OTHERWISE) ARISING IN ANY WAY OUT OF THE USE
OF THIS SOFTWARE, EVEN IF ADVISED OF THE POSSIBILITY OF SUCH DAMAGE.

## Automatic Reference Counting (ARC)

This project uses ARC.

## Author

MJGLayoutKit is written and maintained by Matt Galloway <http://iphone.galloway.me.uk>.

## Motivation

My motivation for creating this framework was that I liked the way Android did its UI layout where 
you can define your views to layout horizontally or vertically, or stacked on top of each other 
and the view subsytem will automatically flow your layout for you according to how you have defined 
it.

This level of flexibility is not generally necessary on iOS because we know the size of the screen 
but for a certain project I had a requirement to be able to dynamically change the layout of a 
certain view having been given a description of the format coming from a web API. This is to be 
cross platform so we couldn't really hard code sizes.

The project requirement turned into this project. And as they say, the rest is history.

## How to use

**MJGLayoutKit is currently under active development and is not ready for use properly yet!**
