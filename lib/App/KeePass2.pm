package App::KeePass2;

# ABSTRACT: KeePass2 commandline tools

use strict;
use warnings;
# VERSION
use Moo;
use MooX::Options;
use File::KeePass;

=method run

Start the cli app

  use App::KeePass2;
  my $keepass = App::KeePass2->new_with_options;
  $keepass->run;

=cut
sub run {
	my ($self) = @_;

	return;
}

1;
