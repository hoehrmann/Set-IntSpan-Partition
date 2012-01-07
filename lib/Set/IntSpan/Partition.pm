package Set::IntSpan::Partition;

use 5.008000;
use strict;
use warnings;
use base qw(Exporter);

our $VERSION = '0.01';

our %EXPORT_TAGS = ( 'all' => [ qw(
	
) ] );

our @EXPORT_OK = ( @{ $EXPORT_TAGS{'all'} } );

our @EXPORT = qw(
  intspan_partition
);

sub _uniq (@) {
  my %h;
  return map { $h{$_}++ == 0 ? $_ : () } @_;
}

sub _add {
  my $rest = shift;

  my @parts = map {
    my $old = $_;

    my $right = $rest->diff($old);
    my $left = $old->diff($rest);
    my $both = $old->intersect($rest);

    $rest = $right;

    grep { !$_->empty } $left, $both

  } @_;

  push @parts, $rest unless $rest->empty;  
  return @parts;
}

sub intspan_partition {
  my @parts = ();

  @parts = _add($_, @parts) for @_;

  # TODO: It's not really possible to get non-unique
  # items into the list? But play it safe for now.
  return _uniq @parts;
}

1;

__END__

=head1 NAME

Set::IntSpan::Partition - Partition int sets using Set::IntSpan objects

=head1 SYNOPSIS

  use Set::IntSpan::Partition;
  my @partition = intspan_partition( @list );

=head1 DESCRIPTION

Partition sets based on membership in a set of C<Set::IntSpan> objects.

=head1 FUNCTIONS

=over

=item intspan_partition( @list )

Given a set of C<Set::IntSpan> objects, this sub creates the smallest
set of C<Set::IntSpan> objects such that, iff an element was in one or
more of the input sets, it will be in exactly one of the output sets,
and an output set is either a subset of an input set or disjoint with
it.

=back

=head1 EXPORTS

C<intspan_partition>.

=head1 CAVEATS

Slow. Patches welcome. I don't like the name C<intspan_partition>,
ideas welcome.

=head1 AUTHOR / COPYRIGHT / LICENSE

  Copyright (c) 2008-2009 Bjoern Hoehrmann <bjoern@hoehrmann.de>.
  This module is licensed under the same terms as Perl itself.

=cut
