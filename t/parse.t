use Test::More tests => 9;
use Date::Manip;
use strict;
use warnings;

BEGIN
{
    use_ok 'WWW::Page::Modified';
}

my $pkg = 'WWW::Page::Modified';

my @expected = (
    {
	title	=> 'Microsoft',
	url	=> 'http://www.microsoft.com/',
	date	=> 'Tue, 18 Dec 2001 02:00:37 GMT',
    },
    {
	title	=> 'Dragonlair',
	url	=> 'http://dragonlair.anu.edu.au/',
	date	=> '0',
    },
    {
        title   => 'Aurora Energy Internet Payments',
        url     => '',
        date    => '',
    },
    {
        title   => 'Adventures in Cybersound: Peck, George',
        url     => 'http://www.cinemedia.net/SFCV-RMIT-Annex/rnaughton/PECK_BIO.html',
        date    => 'July 26, 2000',
    },
    {
        title   => 'Accrual Budget Implementation',
        url     => 'http://www.treasury.tas.gov.au/domino/dtf/dtf.nsf/main-v/accrual',
        date    => '2001-12-03',
    },
    {
        title   => 'A-Z State Government organisations',
        url     => 'http://www.service.tas.gov.au/GovOrgs/',
        date    => '2001/12/07',
    },
);

my $dm = $pkg->new();

isa_ok $dm => $pkg;

foreach my $site (@expected)
{
    #is get_modified($site->{url}) => $site->{date}, $site->{title};
    ok $dm->get_modified($site->{url}) >= ($site->{date}
    ?  UnixDate(ParseDate($site->{date}) => '%s') : 0), $site->{title};
}

do {
    use HTTP::Request::Common qw/HEAD/;
    my $site = $expected[0];
    my $req = HEAD $site->{url};
    my $url = $dm->_ua->request($req);
    ok $dm->get_modified($url) >= UnixDate(ParseDate($site->{date}) => '%s'), $site->{title};
}
