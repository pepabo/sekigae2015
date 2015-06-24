#!/usr/bin/env perl
use 5.14.0;
use warnings;
# Usage: perl sekigae.pl names.txt

package List {
    use List::Util ();
    sub new {
        my $class = shift;
        bless [@_], (ref $class || $class);
    }
    sub map :method {
        my ($self, $cb) = @_;
        $self->new(map { $cb->() } @$self);
    }
    sub each :method {
        my ($self, $cb) = @_;
        $cb->() for @$self;
    }
    sub max {
        my $self = shift;
        List::Util::max(@$self);
    }
    sub shuffle {
        my $self = shift;
        $self->new(List::Util::shuffle(@$self));
    }
    sub each_slice {
        my ($self, $num) = @_;
        my @list = @$self;
        my $i = 0;
        my @slice;
        while ($i < @list) {
            my $end = List::Util::min($i + $num - 1, $#list);
            push @slice, $self->new(@list[$i..$end]);
            $i += $num;
        }
        $self->new(@slice);
    }
    sub transpose {
        my $self = shift;
        my @list = @$self;
        my @transpose;
        for my $i (0 .. $#list) {
            for my $j (0 .. $#{ $list[$i] }) {
                $transpose[$j][$i] = $list[$i][$j];
            }
        }
        $_ = $self->new(@$_) for @transpose;
        $self->new(@transpose);
    }
    sub join :method {
        my ($self, $char) = @_;
        join $char, @$self;
    }
}

List->new(<>)
    ->map(sub { chomp; $_ })
    ->shuffle
    ->each_slice(2)
    ->map(sub { my $l = $_->map(sub { length })->max; $_->map(sub { sprintf "%-${l}s", $_ }) })
    ->transpose
    ->each(sub { say $_->join(' ') });
