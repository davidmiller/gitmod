#!/usr/bin/env perl

use strict;
use warnings;

sub is_modechange {
    my $file = shift(@_);
    my $diff = `git diff $file`;
    my $lines = split(/\n/, $diff);
    my $numlines = length($lines);
    if ($numlines != 1){
        return 0;
    }
    return 1;
}

my @commits = ();
my $status = `git status`;
my @lines = split /\n/, $status;
my @mod = grep(m/#\h+modified:(\h+.*)/g, @lines);
foreach my $file (@mod){
    my @words = split(/ /, $file);
    my $f = $words[-1];
    my $modechange = is_modechange($f);
    if ($modechange == 1){
        push(@commits, $f);
    }
}

if (length(@commits) > 0){
    print "we have commits!\n";
    exec("git commit @commits -m 'Auto commit #perl'");
}
