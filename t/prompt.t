# $Id: prompt.t,v 1.2 2009-12-03 03:19:43 dpchrist Exp $

use Test::More tests => 1;

use Dpchrist::Term		qw( prompt );
use Data::Dumper;

my $r;

$r = eval {
    prompt("foo", 'Y', 'n');
};
ok( $r eq 'Y',							#     1
    "call from non-interactive script should return default\n"
    . Data::Dumper->Dump([$r, $@], [qw(r @)]),
);
