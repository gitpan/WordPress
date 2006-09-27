#!/usr/bin/perl

######
### Copyright 2006: John Bokma / Web: http://johnbokma.com/mexit/2006/07/06/perl-post-wordpress-xml-rpc.html
### Copyright 2006: Sebastian Enger / Web: http://www.sebastian-enger.com/
######

use strict;
use warnings;

use WordPress;

my $wp = WordPress->new(

    'http://yourwebsite/xmlrpc.php',
    'user',
    'passwd'
);

# show the available categories
my @categories = @{ $wp->get_categories };
print map { "$_\n" } @categories;

# post in a random category
$wp->post(

    "Hello, Perl World!",
    "<h1>Posted via Perl</h1>",
    [ $categories[ rand @categories ] ]
);

exit;