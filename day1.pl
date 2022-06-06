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
    my ($ref, $n) = @_;

    my @list = @{ $ref };
    my @res;
    my $cursor = 0;

    do {
        push @res, [
            map { int $_ }
            grep { $_ }
            map { $list[$cursor + $_] }
            0 .. ($n -1 )
        ];
    } while (++$cursor != scalar @list);

    return @res;
}

my $increases = 0;
foreach my $ref ( sliding_window(\@lines, 2) ) {
    my ($a_val, $b_val) = @{ $ref };
    next unless defined $a_val and defined $b_val;
    $increases++ if $a_val < $b_val;
}
print $increases;

