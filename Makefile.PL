use ExtUtils::MakeMaker;
# See lib/ExtUtils/MakeMaker.pm for details of how to influence
# the contents of the Makefile that is written.
WriteMakefile(
    NAME		=> 'WWW::Page::Modified',
    VERSION_FROM	=> 'lib/WWW/Page/Modified.pm',
    PREREQ_PM => {
	'Carp'		=> 0,
	'Data::Dumper'	=> 2.102,
	'Date::Manip'	=> 5.40,
	'HTTP::Date'	=> 1.43,
	'HTTP::Request::Common'	=> 1.19,
	'LWP::UserAgent'	=> 2.000,
	'Test::More'	=> 0.33,
	'URI::URL'	=> 5.02,
    },
    ($] >= 5.005 ?    ## Add these new keywords supported since 5.005
      (ABSTRACT_FROM => 'lib/WWW/Page/Modified.pm', # retrieve abstract from module
      AUTHOR     => 'Iain Truskett <spoon@cpan.org>') : ()),
);
