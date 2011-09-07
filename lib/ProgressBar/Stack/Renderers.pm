package ProgressBar::Stack::Renderers;

require 5.006;

use warnings;
use strict;

=head1 NAME

ProgressBar::Stack::Renderers - The great new ProgressBar::Stack::Renderers!

=head1 VERSION

Version 0.3

=cut

our $VERSION = '0.3';

use base qw(Exporter);
our @EXPORT_OK = qw(betterThenDefault);

use Time::HiRes;


=head1 SYNOPSIS

Enhanced ProgressBar::Stack renderer(s).

Usage:

    use ProgressBar::Stack;
    use ProgressBar::Stack::Renderers qw(betterThenDefault);

    my ($renderer, $clearProgressBar) = betterThenDefault;
    init_progress(renderer => $renderer);
    ...
    # to print something without destroying the progress bar:
    &$clearProgressBar;
    print "Something\n";
    ...

=head1 EXPORT

betterThenDefault

=head1 FUNCTIONS

=head2 betterThenDefault

Returns a list of references to render function and clear function.

=cut

sub betterThenDefault
{
    my $width = 78;
    my @spin_sprites = split(//, "\\|/-");
    my $sprite_no = 0;

    # this has to be anonymous procedure to close over $width
    my $clear = sub { print "\r".(" " x $width)."\r"; };

    sub fmt_time {
        my $t = shift;

        my $sec = int($t) % 60;
        my $min = int($t / 60);
        if ($min < 60) {
            return sprintf("%d:%02d", $min, $sec);
        } else {
            return sprintf("%dh%02dm", int($min/60), $min%60);
        }
    }

    return (sub ($;$$) {
        my $val = shift;
        my $message = shift;
        my $self = shift;

        my $progress=sprintf("%5.1f", $val);
        my $etatime = $self->remaining_time();
        my $eta=$etatime>=0? fmt_time($etatime) : "?:??";

        my $sprite = $spin_sprites[ $sprite_no ];
        $sprite_no = ($sprite_no+1) % scalar @spin_sprites;
        my $tail = " $sprite  ${progress}% ETA: $eta ${message}";

        my $prog_len = $width - length($tail) - 2; # 2 are []
        my $hash_count = int( $progress / (100 / $prog_len) );
        my $remainder = $prog_len - $hash_count;

        local $|=1;
        &$clear;
        print "[".("#" x $hash_count).(" " x $remainder)."]$tail\r";
    }, $clear);
}

=head1 AUTHOR

Artem Baguinski, C<< <artm at v2.nl> >>

=head1 BUGS

Please report any bugs or feature requests to C<bug-progressbar-stack-renderers at rt.cpan.org>, or through
the web interface at L<http://rt.cpan.org/NoAuth/ReportBug.html?Queue=ProgressBar-Stack-Renderers>.  I will be notified, and then you'll
automatically be notified of progress on your bug as I make changes.

=head1 SUPPORT

You can find documentation for this module with the perldoc command.

    perldoc ProgressBar::Stack::Renderers


You can also look for information at:

=over 4

=item * RT: CPAN's request tracker

L<http://rt.cpan.org/NoAuth/Bugs.html?Dist=ProgressBar-Stack-Renderers>

=item * AnnoCPAN: Annotated CPAN documentation

L<http://annocpan.org/dist/ProgressBar-Stack-Renderers>

=item * CPAN Ratings

L<http://cpanratings.perl.org/d/ProgressBar-Stack-Renderers>

=item * Search CPAN

L<http://search.cpan.org/dist/ProgressBar-Stack-Renderers/>

=back


=head1 ACKNOWLEDGEMENTS


=head1 COPYRIGHT & LICENSE

Copyright 2010-2011 Artem Baguinski, all rights reserved.

This program is free software; you can redistribute it and/or modify it
under the same terms as Perl itself.


=cut

1; # End of ProgressBar::Stack::Renderers
