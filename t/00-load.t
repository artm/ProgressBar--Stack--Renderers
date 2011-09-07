#!perl -T

use Test::More tests => 1;

BEGIN {
    use_ok( 'ProgressBar::Stack::Renderers' ) || print "Bail out!\n";
}

diag( "Testing ProgressBar::Stack::Renderers $ProgressBar::Stack::Renderers::VERSION, Perl $], $^X" );
