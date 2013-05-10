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
use Data::Printer;

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

option 'dump' => (
	doc => 'Dump a keepass2 file',
	is => 'ro',
	short => 'd',
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
	$self->_dump, return if ($self->dump);
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

sub _create {
	my ($self) = @_;
	$self->_fkp->clear;
	my $root = $self->_fkp->add_group({title => 'My Passwords', icon => 52});
	my $gid = $root->{'id'};
	$self->_fkp->add_group({title => 'Internet', group => $gid, icon => 1});
	$self->_fkp->add_group({title => 'Private', group => $gid, icon => 58});
	$self->_fkp->add_group({title => 'Bank', group => $gid, icon => 66});
	$self->_fkp->unlock if $self->_fkp->is_locked;
	my $master = $self->_get_master_key;
	my $confirm = $self->_get_confirm_key;
	croak "Your master password is different from the confirm password !" if $master ne $confirm;
	$self->_fkp->save_db($self->file, $master);
	return;
}

sub _dump {
	my ($self) = @_;
	$self->_fkp->load_db($self->file, $self->_get_master_key);
	p($self->_fkp->groups);
	return;
}
1;
