#!perl
use strict;
use warnings;
use utf8::all;
use Test::More;
use App::KeePass2;

my @tests = qw(
	key
	internet
);

my $kp2 = App::KeePass2->new(file => "test");

my $idx = 0;
for my $t(@tests) {
	my $id   = $kp2->get_icon_id_from_key($t);
	my $char = $kp2->get_icon_char_from_key($t);
	my $key  = $kp2->get_icon_key_from_id($idx);
	ok defined $char, "the $char  char is present";
	is $id, $idx, "... and " . $char . "  has the id $id";
	is $t, $key, "... and the id $idx correspond to $char";

	$idx++;
}

done_testing;
