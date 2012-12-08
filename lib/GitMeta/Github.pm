###########################################
package GitMeta::Github;
###########################################
# 2010, Mike Schilli <m@perlmeister.com>
###########################################
use strict;
use warnings;
use base qw(GitMeta);
use Net::Github;

###########################################
sub expand {
###########################################
  my($self) = @_;

  $self->param_check("user");

  my $user  = $self->{user};
  my @repos = ();

  my $gh = Net::GitHub::V3->new;
  my @by_repos = $gh->repos->list_user($user);

  for my $repo (@by_repos) {
      push @repos, 
        $repo->{'ssh_url'};
  }

  return @repos;
}

1;

__END__

=head1 NAME

    GitMeta::Github

=head1 SYNOPSIS

    # myrepos.gmf

    # All github projects of user 'mschilli'
    -
        type: Github
        user: mschilli

=head1 DESCRIPTION

GitMeta subclass to pull in all Github repos of a specified user.
Read the main GitMeta documentation for details.

=head1 LEGALESE

Copyright 2010-2011 by Mike Schilli, all rights reserved.
This program is free software, you can redistribute it and/or
modify it under the same terms as Perl itself.

=head1 AUTHOR

2010, Mike Schilli <cpan@perlmeister.com>
