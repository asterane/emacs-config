

<a id="org5832e38"></a>

# My Emacs Configuration


# Table of Contents

1.  [Overview](#org4a432d3)


<a id="org4a432d3"></a>

# Overview

My Emacs configuration is reproduced in this repository. I use Emacs
for all my text editing because it is unequivocally the cleanest, most
powerful tool available. I recommend it to anyone.

The configuration I use comprises two files, `init.el` and
`config.org`. Emacs automatically loads `.emacs.d/init.el` on startup,
running all of the elisp code contained within. Using exclusively this
file can lead to a messy configuration that is difficult to read, as
settings and functions accumulate. Comments help somewhat, but the
file is still prone to excessive length.

Org offers a great solution to this configuration file issue. Source
code blocks (elisp in this case) may be placed in any org file. A
function can then be run to "tangle" the file, converting it into a
source file containing only the code blocks. Using Org allows me to
fit all of my configuration changes into a foldable outline so that I
can easily navigate to any part of the file, organize changes by type,
and include clear explanations.

My init file automatically loads all of the changes in my config
file. The initialization file has some explanatory comments but is
brief. Everything in that file is a necessity. All other configuration
is in the Org file, which has commentary throughout, preceding the
code blocks. I will not include more explanation here because it is
already present in the files. Feel free to use these as inspiration
for your own config.

