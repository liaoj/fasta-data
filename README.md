# How to run

First, open Terminal.app or iTerm2.app and change to the ```src/``` directory:

    cd src/

All the following commands are run in this directory.

## Lengths

All the length values will be shown on screen.

    $ ./length.pl
    Total Length: 60233856
    Effective Length: 57637416
    N Length: 2596440
    GC Length: 21508836
    GC Rate: 0.357088810651604

## N50, N90

N50 and N90 will be shown on screen.

    $ ./N50.pl
    N50: 1580070
    N90: 1085026

## GC sliding counts

The GC counts in a 250bp sliding window are saved in ```../GC-count.txt```.

    $ ./window.pl

Then change the value of ```count_path``` in ```plot-gc-count.R``` appropriately.

![count-path](count-path.jpg "Change the path of GC-count.txt")

Open ```plot-gc-count.R``` in R.app.

![open-source-in-R](open-source-in-R.jpg "Open source in R")

R.app will produce the GC count histogram plot.

![GC-count](GC-count.jpg "GC count histogram")

## Extract CDS

The coding sequence will be saved in ```../Prunus_mume_scaffold.fasta```.

    $ ./coding-sequence.pl

## Translate CDS

The protein sequences translated from CDS will be save in ```../Prunus_mume_scaffold_protein.fasta```.

    $ ./translate.pl
