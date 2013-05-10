package App::KeePass2;

# ABSTRACT: KeePass2 commandline tools

use strict;
use warnings;
# VERSION
use Moo;
use MooX::Options;
use File::KeePass;
use IO::Prompt;
use Carp;

option 'file' => (
	doc => 'Your keepass2 file',
	is => 'ro',
	short => 'f',
	required => 1,
	format => 's',
);

option 'create' => (
	doc => 'Create a keepass2 file',
	is => 'ro',
	short => 'c',
);

has _fkp => (
	is => 'ro',
	default => sub {
		File::KeePass->new;
	}
);

=method run

Start the cli app

  use App::KeePass2;
  my $keepass = App::KeePass2->new_with_options;
  $keepass->run;

=cut
sub run {
	my ($self) = @_;
	$self->_create, return if ($self->create);
	return;
}

sub _create {
	my ($self) = @_;
	$self->_fkp->clear;
	my $root = $self->_fkp->add_group({title => 'My Passwords'});
	my $gid = $root->{'id'};
	$self->_fkp->add_group({title => 'Internet', group => $gid});
	$self->_fkp->add_group({title => 'Private', group => $gid});
	$self->_fkp->unlock if $self->_fkp->is_locked;
	my $master = $self->_get_master_key;
	my $confirm = $self->_get_confirm_key;
	croak "Your master password is different from the confirm password !" if $master ne $confirm;
	$self->_fkp->save_db($self->file, $master);
	return;
}

sub _get_master_key {
	my ($self) = @_;
	return "" . prompt("Master Password : ", -e => "*", -tty);
}

sub _get_confirm_key {
	my ($self) = @_;
	return "" . prompt("Confirm Password : ", -e => "*", -tty);
}
1;
