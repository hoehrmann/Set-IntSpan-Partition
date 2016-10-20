#!perl

use strict;
use warnings;

use Set::IntSpan;
use Set::IntSpan::Partition qw(intspan_partition);

# http://www.careercup.com/question?id=13014685
#
# Google interview question.
# Given a set of non overlapping intervals
# (1,5) (6, 15) (20, 21) (23, 26) (27, 30) (35, 40)
# and another interval (14, 33), merge them and find the result.
#
# Expected output: (1,5) (6, 33) (35, 40)

my @spans = (
    Set::IntSpan->new('1-5'),
    Set::IntSpan->new('6-15'),
    Set::IntSpan->new('20-21'),
    Set::IntSpan->new('23-26'),
    Set::IntSpan->new('27-30'),
    Set::IntSpan->new('35-40'),
);

my $span_to_merge = Set::IntSpan->new('14-33');

push @spans, $span_to_merge;

my @output = intspan_partition @spans;

print join ',', @output;
