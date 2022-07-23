package Main;

use 5.24.0;
use strict;
use warnings;

my ($input) = @ARGV;
open(my $handle, $input) or die "can't open $input: $!";
chomp(my @lines = <$handle>);
close $handle or die "can't close $input: $!";

package Submarine {
    sub new {
        my $class = shift;

        my $self = bless {
            depth => 0,
            horizontal_position => 0,
            aim => 0
        }, $class;

        return $self;
    }

    sub forward {
        my $self = shift;
        my ($value) = @_;

        $self->{horizontal_position} += $value;
        $self->{depth} += ($self->{aim} * $value);
    }

    sub down {
        my $self = shift;
        my ($value) = @_;

        #$self->{depth} += $value;
        $self->{aim} += $value;
    }

    sub up {
        my $self = shift;
        my ($value) = @_;

        #$self->{depth} -= $value;
        $self->{aim} -= $value;
    }
};

my $submarine = Submarine->new();
foreach my $line (@lines) {
    my ($command, $value) = $line =~/^([a-zA-Z]+) (\d+)$/s;
    $value = int $value;
    if ($submarine->can($command)) {
        $submarine->$command($value);
    }
}

say "part 2: ", $submarine->{depth} * $submarine->{horizontal_position};

# my $depth = 0;
# my $horizontal_position = 0;
# my $aim = 0;
# foreach my $line (@lines) {
#     my ($command, $value) = $line =~/^([a-zA-Z]+) (\d+)$/s;
#     $value = int $value;
#     if ($command =~ "forward") {
#         $horizontal_position += $value;
#         $depth += ($aim * $value);
#     }
#     elsif ($command =~ "down") {
#         $depth += $value;
#         $aim += $value;
#     }
#     elsif ($command =~ "up") {
#         $depth -= $value;
#         $aim -= $value;
#     }
# }
# 
# say "part 1: ", $depth * $horizontal_position;
# 
# 
