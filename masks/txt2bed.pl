#!/usr/bin/env perl
use strict;

# Usage: txt2bed.pl coords.txt > coords.bed

while (<>) {
  chomp;
  my @x = split m/,/;
  print join("\t", "NC_000962", $x[0]-1, $x[1]),"\n";
}

