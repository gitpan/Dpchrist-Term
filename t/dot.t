# $Id: dot.t,v 1.1 2010-12-04 01:08:41 dpchrist Exp $

use Test::More tests => 2;

use strict;
use warnings;


use Capture::Tiny		qw( capture );
use Carp;
use Data::Dumper;
use Dpchrist::Term		qw( dot );

$Data::Dumper::Sortkeys = 1;

my $r;
my $stderr;
my $stdout;


($stdout, $stderr) = capture {
    $r = eval { dot };
};
ok(								#     1
    !$@
    && !defined($r)
    && $stdout eq '.'
    && $stderr eq '',
) or confess join(' ', __FILE__, __LINE__,
    Data::Dumper->Dump([$r, $stdout, $stderr, $@],
		     [qw(r   stdout   stderr   @)])
);

($stdout, $stderr) = capture {
    $r = eval {
	sleep 1;
	my $t = time;
	dot while ($t == time);
	dot;
    };
};
ok(								#     2
    !$@
    && !defined($r)
    && $stdout eq '..'
    && $stderr eq '',
) or confess join(' ', __FILE__, __LINE__,
    Data::Dumper->Dump([$r, $stdout, $stderr, $@],
		     [qw(r   stdout   stderr   @)])
);
