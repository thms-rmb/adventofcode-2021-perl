package Main;

use 5.24.0;
use strict;
use warnings;

use List::Util qw( sum );

my ($input) = @ARGV;
open(my $handle, $input) or die "can't open $input: $!";
chomp(my @lines = <$handle>);
close $handle or die "can't close $input: $!";

sub sliding_window {
    my ($n, @list) = @_;
    map {
        my $cursor = $_;

        [
            grep defined,
            map { $list[$cursor + $_] }
            0 .. ($n - 1)
        ];
    } 0 .. (scalar @list - 1)
}

my $increases = 0;
foreach my $ref ( sliding_window 2, map int, @lines ) {
    my ($a_val, $b_val) = @{ $ref };
    next unless defined $a_val and defined $b_val;
    $increases++ if $a_val < $b_val;
}
say "part 1: $increases";

$increases = 0;
foreach my $ref ( sliding_window 2,
                  map { sum grep defined, @{ $_ } }
                  sliding_window 3,
                  map int, @lines ) {
    my ($a_val, $b_val) = @{ $ref };
    next unless defined $a_val and defined $b_val;
    $increases++ if $a_val < $b_val;
}
say "part 2: $increases";

