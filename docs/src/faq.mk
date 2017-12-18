---
title: FAQ
---

:insert toc


### Where do I put my image files?

Image files, along with any other static assets, should be stored in the site's resources directory, `res`. The content of this directory is copied to the output directory when the site is built.

As an example, assume we have a file named `photo.jpg` stored in a directory named `images` within the `res` directory, i.e.

    site/
    |-- res/
        |-- images/
            |-- photo.jpg

This file will be copied to the output directory and can be accessed in templates and node files via the url:

    \\@root/images/photo.jpg



### Does Ivy support featured images or image galleries?

Ivy has no special support for WordPress-style featured images but we can implement similar functionality simply by adding the image name as an attribute to the page header, e.g.

::: yaml

    ---
    title: Page Title
    image: photo.jpg
    ---

We can then check for the presence of a featured image in the appropriate template file:

::: django

    {% if node.image %}
        <img src="\\@root/images/{{node.image}}">
    {% endif %}

Yaml supports lists so we can implement galleries in a similar manner by adding a list of image names to the header and then iterating over the list in the template file:

::: django

    {% for image in node.gallery %}
        <img src="\\@root/images/{{image}}">
    {% endfor %}



### Why do I get an error when I add a url to a Yaml header?

Yaml doesn't support unquoted values that begin with an `@` symbol so you'll get a scary looking error message if you add a bare `\\@root/` url to a Yaml header, e.g.

    ---
    image: \\@root/images/photo.jpg
    ---

Quoting the url solves the problem:

    ---
    image: "\\@root/images/photo.jpg"
    ---

And yes, I think it's ugly too.



### Can I build a blog using Ivy?

Sure, but you'll have to write some code to do it.

Ivy is actually a stripped-down version of an older static website generator that I worked on for years called [Malt][], which was fully blog-capable. One of the lessons I learned along the way is that it's pretty much impossible to build a simple, elegant, general-purpose static-site-plus-blog engine --- it just ends up being a WordPress-style rat's nest of options and switches.

It's actually quite easy to build a blog on top of Ivy by adding a simple plugin to assemble indexes, etc. --- at least, it's easy to do it for *one specific site*. I've certainly thought about releasing a general-purpose blog plugin, but it inevitably turns into its own mini rat's nest of options and switches all over again.

I don't have any personal use for a blog so I probably never will get around to working on the problem again, but if anyone else wants to try they're welcome to take a look at [Malt][] for inspiration.

[malt]: http://mulholland.xyz/docs/malt/
