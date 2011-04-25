###########################################
package GitMeta::SshDir;
###########################################
# 2010, Mike Schilli <m@perlmeister.com>
###########################################
use strict;
use warnings;
use base qw(GitMeta);
use Sysadm::Install qw(:all);
use Log::Log4perl qw(:easy);

###########################################
sub expand {
###########################################
  my($self) = @_;

  $self->param_check("host", "dir");

  INFO "Retrieving repos ",
       "from $self->{host}";

  my($stdout) = tap "ssh", $self->{host}, 
     "ls", $self->{dir};

  my @repos = ();

  while( $stdout =~ /(.*)\n/g ) {
      push @repos, 
        "$self->{host}:$self->{dir}/$1";
  }

  return @repos;
}

1;

__END__

=head1 NAME

    GitMeta::SshDir

=head1 SYNOPSIS

    # myrepos.gmf

    # All projects in directory 'projects' 
    # on some host via git/SSH
    -
        type: SshDir
        host: username@hoster.com
        dir:  projects

=head1 DESCRIPTION

GitMeta subclass to pull in repos from a server accessible via ssh.
Read the main GitMeta documentation for details.

=head1 LEGALESE

Copyright 2010-2011 by Mike Schilli, all rights reserved.
This program is free software, you can redistribute it and/or
modify it under the same terms as Perl itself.

=head1 AUTHOR

2010, Mike Schilli <cpan@perlmeister.com>
