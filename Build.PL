use 5.006;
use strict;
use warnings;
use Module::Build;

my $builder = Module::Build->new(
    module_name         => 'ProgressBar::Stack::Renderers',
    license             => 'perl',
    dist_author         => q{Artem Baguinski <artm@v2.nl>},
    dist_version_from   => 'lib/ProgressBar/Stack/Renderers.pm',
    build_requires => {
        'Test::More' => 0,
    },
    requires => {
        'perl' => 5.006,
    },
    add_to_cleanup      => [ 'ProgressBar-Stack-Renderers-*' ],
    create_makefile_pl => 'traditional',
);

$builder->create_build_script();
