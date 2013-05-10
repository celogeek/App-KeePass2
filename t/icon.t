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
	my $id   = $kp2->get_icon_id($t);
	my $char = $kp2->get_icon_char($t);
	is $id, $idx, $char . "  has the id $id";

	$idx++;
}

done_testing;
