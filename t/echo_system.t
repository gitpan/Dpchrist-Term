# $Id: echo_system.t,v 1.10 2010-12-16 01:46:26 dpchrist Exp $

use Test::More tests => 2;

use strict;
use warnings;


use Capture::Tiny		qw( capture );
use Carp;
use Data::Dumper;
use Dpchrist::Term		qw( echo_system );

$Data::Dumper::Sortkeys = 1;

my $line;
my $r;
my $stderr;
my $stdout;


$line = "echo hello, world!";
($stdout, $stderr) = capture {
    $r = eval { 
	echo_system $line;
    };
};
ok(								#     1
    !$@
    && $r == 0
    && $stdout
    && !$stderr,
    "'echo' should work"
) or confess join(' ', __FILE__, __LINE__,
    Data::Dumper->Dump([$line, $r, $stdout, $stderr, $@],
		     [qw(line   r   stdout   stderr   @)])
);

$line = "nosuchcommand";
($stdout, $stderr) = capture {
    $r = eval {
	echo_system $line;
    };
};
ok(								#     2
    !$@
    && $r
    && $stdout
    && $stderr,
    "nosuchcommand should fail"
) or confess join(' ', __FILE__, __LINE__,
    Data::Dumper->Dump([$line, $r, $stdout, $stderr, $@],
		     [qw(line   r   stdout   stderr   @)])
);

