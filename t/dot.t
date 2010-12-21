# $Id: dot.t,v 1.3 2010-12-20 06:05:18 dpchrist Exp $

use strict;
use warnings;

use Test::More tests		=> 2;

use Dpchrist::Term		qw( dot );

use Capture::Tiny		qw( capture );
use Carp;
use Data::Dumper;

$|				= 1;
$Data::Dumper::Sortkeys		= 1;

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
