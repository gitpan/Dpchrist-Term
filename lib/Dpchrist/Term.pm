#######################################################################
# $Id: Term.pm,v 1.12 2010-11-27 03:38:00 dpchrist Exp $
#######################################################################
# package:
#----------------------------------------------------------------------

package Dpchrist::Term;

use strict;
use warnings;

require Exporter;

our @ISA = qw(Exporter);

our %EXPORT_TAGS = ( 'all' => [ qw(
    prompt	    
) ] );

our @EXPORT_OK = ( @{ $EXPORT_TAGS{'all'} } );

our @EXPORT = ();

our $VERSION = sprintf("%d.%03d", q$Revision: 1.12 $ =~ /(\d+)/g);

#######################################################################
# uses:
#----------------------------------------------------------------------

use Data::Dumper;

#######################################################################

=head1 NAME

Dpchrist::Term - terminal I/O routines


=head1 DESCRIPTION

This documentation describes module revision $Revision: 1.12 $.


This is alpha test level software
and may change or disappear at any time.


=head2 SUBROUTINES

=cut

#######################################################################

=head3 prompt

    prompt EXPR,LIST

Prints EXPR and LIST (in parenthesis) to STDOUT,
and waits for user input on STDIN.
Returns whatever the user input,
or first LIST item if the user presses < Enter >.

Returns first LIST item
if process is not connected to a tty.

=cut

#----------------------------------------------------------------------

sub prompt
{
    my $prompt = shift;
    my $default = $_[0];

    my $retval;

    if (-t STDIN && -t STDOUT) {

	### interactive

	print $prompt, ' (', join("/", @_), ')? ';

	$retval = <STDIN>;
	$retval = $default if $retval eq "\n";
    }
    else {

	### non-interactive

	$retval = $default;
    }

    return $retval;
}

#######################################################################
# end of code:
#----------------------------------------------------------------------

1;
__END__

#######################################################################
# pod:
#----------------------------------------------------------------------

=head2 EXPORT

None by default.

All of the subroutines may be imported by using the ':all' tag:

    use Dpchrist::Debug		qw( :all );

See 'perldoc Export' for everything in between.


=head1 INSTALLATION

Old school:

    $ perl Makefile.PL
    $ make    
    $ make test
    $ make install 

Minimal:

    $ cpan Dpchrist::Debug

Complete:

    $ cpan Bundle::Dpchrist

The following warning may be safely ignored:

    Can't locate Dpchrist/Module/MakefilePL.pm in @INC (@INC contains: /
    etc/perl /usr/local/lib/perl/5.10.0 /usr/local/share/perl/5.10.0 /us
    r/lib/perl5 /usr/share/perl5 /usr/lib/perl/5.10 /usr/share/perl/5.10
    /usr/local/lib/site_perl .) at Makefile.PL line 22.


=head2 PREREQUISITES

See Makefile.PL in the source distribution root directory.


=head1 SEE ALSO

    "Perl Cookbook", 2 e., Recipe 15.2


=head1 AUTHOR

David Paul Christensen  dpchrist@holgerdanske.com


=head1 COPYRIGHT AND LICENSE

Copyright 2010 by David Paul Christensen dpchrist@holgerdanske.com

This program is free software; you can redistribute it and/or modify
it under the terms of the GNU General Public License as published by
the Free Software Foundation; version 2.

This program is distributed in the hope that it will be useful, but
WITHOUT ANY WARRANTY; without even the implied warranty of
MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE.  See the GNU
General Public License for more details.

You should have received a copy of the GNU General Public License
along with this program; if not, write to the Free Software
Foundation, Inc., 59 Temple Place, Suite 330, Boston, MA 02111-1307,
USA.

=cut

#######################################################################
