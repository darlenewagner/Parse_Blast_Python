#!/usr/bin/perl -w
use strict;
use warnings;

## testing a perl pattern for reading selected files from an input folder

my $somedir = shift;

opendir(DIR, $somedir) || die "Can't open directory $somedir: $!";
my @Knights = grep { ( /\.list\./ ) && -f "$somedir/$_" } readdir(DIR);
closedir(DIR);

foreach my $f (@Knights) {
    #print "\$f = $f\n";
    $f = $somedir."/".$f;
    open(FILE, $f) || die "Can't open file $f: $!";
    while(<FILE>) {
	if($_ =~ /^Ni/) {
	    print;
        }
    }
    close(FILE);
}
