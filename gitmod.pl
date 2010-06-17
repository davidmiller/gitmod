#!/usr/bin/env perl

use strict;
use warnings;

my $status;
$status = `git status`;
print $status =~ /#\h+modified:\h+(.*)/g;
print "\n";
