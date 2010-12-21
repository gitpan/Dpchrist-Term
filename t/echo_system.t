# $Id: echo_system.t,v 1.12 2010-12-20 06:05:18 dpchrist Exp $

use strict;
use warnings;

use Test::More tests => 2;

use Dpchrist::Term		qw( echo_system );

use Capture::Tiny		qw( capture );
use Carp;
use Data::Dumper;

$|				= 1;
$Data::Dumper::Sortkeys		= 1;

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

