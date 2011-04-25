###########################################
package GitMeta::Github;
###########################################
# 2010, Mike Schilli <m@perlmeister.com>
###########################################
use strict;
use warnings;
use base qw(GitMeta);
use LWP::UserAgent;
use XML::Simple;

###########################################
sub expand {
###########################################
  my($self) = @_;

  $self->param_check("user");

  my $user  = $self->{user};
  my @repos = ();

  my $ua = LWP::UserAgent->new();
  my $resp = $ua->get(
   "http://github.com/api/v1/xml/$user");

  if($resp->is_error) {
    die "API fetch failed: ",
        $resp->message();
  }

  my $xml = XMLin(
      $resp->decoded_content());

  my $by_repo = 
    $xml->{repositories}->{repository};

  for my $repo (keys %$by_repo) {
      push @repos, 
        "git\@github.com:$user/$repo.git";
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
