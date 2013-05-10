#!perl
use strict;
use warnings;
use utf8::all;
use Test::More;
use App::KeePass2;

my @tests = qw(
		key 		
		internet 	
		warning 	
		network     
		note        
		talk        
		cube        
		note2       
		internet2   
		card        
		note3       
		camera 		
		wifi        
		key2        
		wire 		
		scan 		
		internet3   
		disk  		
		computer    
		email       
		setting     
		note4       
);

my $kp2 = App::KeePass2->new(file => "test");

my $idx = 0;
for my $t(@tests) {
	my $id   = $kp2->get_icon_id_from_key($t);
	my $char = $kp2->get_icon_char_from_key($t);
	my $key  = $kp2->get_icon_key_from_id($idx);
	ok $char, "the $t char ( $char  ) is defined";
	is $id, $idx, "... and " . $char . "  has the id $id";
	is $t, $key, "... and the id $idx correspond to $char";

	$idx++;
}

done_testing;
