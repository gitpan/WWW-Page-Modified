use Module::Info;
use Test::More tests => 6;
use strict;
use warnings;

my $pkg = 'WWW::Page::Modified';

my $mod = Module::Info->new_from_module($pkg);

my $name    = $mod->name;
my $version = $mod->version;
my $dir     = $mod->inc_dir;
my $file    = $mod->file;
my $is_core = $mod->is_core;

# Only available in perl 5.6.1 and up.
# These do compile the module.
my @packages = $mod->packages_inside;
my @used     = $mod->modules_used;
my %subs     = $mod->subroutines;

# Check details:
is $name => $pkg;
like $version => qr/^(\d\.)\d/;
is $is_core => 0;

# Check package usage:
ok eq_set(\@packages => [ $pkg ]);
ok eq_set(\@used => [
          'LWP::UserAgent',
          'constant',
          'Date::Manip',
          'Data::Dumper',
          'URI::URL',
          'strict',
          'HTTP::Request::Common',
          'warnings',
          'HTTP::Date',
          'vars',
          'Carp',
        ]);

# See that the methods we have exist:
my @methods = qw/ _get_url_head new get_modified _ua /;
my @exists = grep { exists $subs{"${pkg}::$_"} } @methods;
ok eq_array(\@exists => \@methods);

