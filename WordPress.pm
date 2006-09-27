#!/usr/bin/perl

######
### Copyright 2006: John Bokma / Web: http://johnbokma.com/mexit/2006/07/06/perl-post-wordpress-xml-rpc.html
### Copyright 2006: Sebastian Enger / Web: http://www.sebastian-enger.com/
######

package WordPress;

use strict;
use warnings;

use Carp;
use XMLRPC::Lite;


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