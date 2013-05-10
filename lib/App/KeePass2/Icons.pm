package App::KeePass2::Icons;
use strict;
use warnings;
# VERSION
use utf8::all;
use Moo::Role;

has 'icons' => (
	is => 'ro',
	default => sub { shift->_icons }
);

sub _icons {
	return {
		key => {
			id => 0,
			utf8 => "🔑"
		},
		internet => {
			id => 1,
			utf8 => "🌍"
		}

	}
}

sub get_icon_id {
	my ($self, $key) = @_;
	return $self->icons->{$key}->{id} // 0;
}

sub get_icon_char {
	my ($self, $key) = @_;
	return $self->icons->{$key}->{utf8} // '';
}

1;
