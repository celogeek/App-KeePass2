package App::KeePass2::Icons;
use strict;
use warnings;
# VERSION
use utf8::all;
use Moo::Role;

has '_icons' => (
	is => 'lazy',
);

has '_icon_id_to_key' => (
	is => 'lazy',
);

sub _build__icons {
	return {
		key 		=> { id =>  0, utf8 => "🔑" },
		internet 	=> { id =>  1, utf8 => "🌍" },
		warning 	=> { id =>  2, utf8 => "🚧" },
		network     => { id =>  3, utf8 => "💻" },
		note        => { id =>  4, utf8 => "📝" },
		talk        => { id =>  5, utf8 => "🙇" },
		cube        => { id =>  6, utf8 => "" },
		note2       => { id =>  7, utf8 => "" },
		internet2   => { id =>  8, utf8 => "🌎" },
		card        => { id =>  9, utf8 => "💳" },
		note3       => { id => 10, utf8 => "📄" },
		camera 		=> { id => 11, utf8 => "" },
		wifi        => { id => 12, utf8 => "📡" },
		key2        => { id => 13, utf8 => "🔐" },
		wire 		=> { id => 14, utf8 => "🔌" },
		scan 		=> { id => 15, utf8 => "📇" },
		internet3   => { id => 16, utf8 => "🌏" },
		disk  		=> { id => 17, utf8 => "💿" },
		computer    => { id => 18, utf8 => "💻" },
		email       => { id => 19, utf8 => "📨" },
		setting     => { id => 20, utf8 => "" },
		note4       => { id => 21, utf8 => "" },
	}
}

sub _build__icon_id_to_key {
	my ($self) = @_;
	my @res;

	for my $key(keys %{$self->_icons}) {
		$res[$self->_icons->{$key}->{id}] = $key;
	}

	return \@res;
}

=method get_icon_id_from_key

Return the id of the icon base on his name

=cut
sub get_icon_id_from_key {
	my ($self, $key) = @_;
	return $self->_icons->{$key}->{id} // 0;
}

=method get_icon_key_from_id

Return key of icon base on his id

=cut
sub get_icon_key_from_id {
	my ($self, $id) = @_;
	return $self->_icon_id_to_key->[$id];
}

=method get_icon_char_from_key

Return the icon from his name

=cut
sub get_icon_char_from_key {
	my ($self, $key) = @_;
	return $self->_icons->{$key}->{utf8} // 0;
}

1;
