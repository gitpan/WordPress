#!/usr/bin/perl

package WordPress;

use Carp;
use strict;
use warnings;
use XMLRPC::Lite;

require Exporter;

our @ISA = qw(Exporter);

# Items to export into callers namespace by default. Note: do not export
# names by default without a very good reason. Use EXPORT_OK instead.
# Do not simply export all your public functions/methods/constants.

# This allows declaration	use WordPress ':all';
# If you do not need this, moving things directly into @EXPORT or @EXPORT_OK
# will save memory.
our %EXPORT_TAGS = ( 'all' => [ qw(
	
) ] );

our @EXPORT_OK = ( @{ $EXPORT_TAGS{'all'} } );

our @EXPORT = qw(
	get_categories
	post
);

our $VERSION = '0.1.1';


sub new() {

    my ( $class, $proxy, $username, $password ) = @_;

    my $self = {

        server   => XMLRPC::Lite->proxy( $proxy ),
        username => $username,
        password => $password
    };

    bless $self, $class;

    return $self;

}; # sub new() {}


sub get_categories() {

    my $self = shift;

    my $call = $self->{ server }->call(

        'metaWeblog.getCategories',
        1,                              # blogid, ignored
        $self->{ username },
        $self->{ password }
    );
    # $call->fault and croak 'get_categories: ', $call->faultstring;

    my @categories;
    push @categories, $_->{ categoryName } for @{ $call->result };

    return \@categories;

} # sub get_categories() {}


sub post() {

    my ( $self, $title, $description, $categories ) = @_;

    defined $categories or $categories = [];

    my $call = $self->{ server }->call(

        'metaWeblog.newPost',
        1,                              # blogid, ignored
        $self->{ username },
        $self->{ password }, {

            title       => $title,
            description => $description,
            categories  => $categories,
        },
        1                               # publish
    );
    
	# $call->fault and croak 'get_categories: ', $call->faultstring;
	return;

}; # sub post() {

1;

# Preloaded methods go here.

1;
__END__

=head1 NAME

WordPress - Perl extension for posting to wordpress blogs

=head1 SYNOPSIS

  use WordPress;
  use WordPress;

	my $wp = WordPress->new(

		'http://www.domain.com/xmlrpc.php',
		'admin',
		'pass!'
	);

	# show the available categories
	my @categories = @{ $wp->get_categories };
	print map { "$_\n" } @categories;

	# post in a random category
	$wp->post(

		"Hello, Perl asdf  World!",
		"<h1>Posted via Perl</h1>",
		[ $categories[ rand @categories ] ]
	);

=head1 DESCRIPTION

Post to wordpress with the help of perl


=head2 EXPORT

get_categories()
post()


=head1 SEE ALSO

http://www.zoozle.net
http://www.zoozle.org
http://www.zoozle.biz
http://www.p2p-blog.de
http://www.zoozle.es

=head1 AUTHOR

Sebastian Enger, E<lt>bigfish82-A!T-gmail.comE<gt>

=head1 COPYRIGHT AND LICENSE

Copyright 2006: John Bokma / Web: http://johnbokma.com/mexit/2006/07/06/perl-post-wordpress-xml-rpc.html
Copyright 2006,2007: Sebastian Enger / Web: http://www.sebastian-enger.com/


This library is free software; you can redistribute it and/or modify
it under the same terms as Perl itself, either Perl version 5.8.6 or,
at your option, any later version of Perl 5 you may have available.



=cut
