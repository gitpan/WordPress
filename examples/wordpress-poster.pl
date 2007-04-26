#!/usr/bin/perl

use strict;
use warnings;

use WordPress;

my $wp = WordPress->new(

    'http://www.domain.com/xmlrpc.php',
    'admin',
    'Asd7443sol!'
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

exit;

# post in a random category
$wp->post(

    "Hello, Perl 23r23r World!",
    "<h1>Posted via Perl</h1>",
    [ $categories[ rand @categories ] ]
);


# post in a random category
$wp->post(

    "Hello, Perl 23r5sdfg World!",
    "<h1>Posted via Perl</h1>",
    [ $categories[ rand @categories ] ]
);

# post in a random category
$wp->post(

    "Hello, Perl 5345zr7u World!",
    "<h1>Posted via Perl</h1>",
    [ $categories[ rand @categories ] ]
);



exit;