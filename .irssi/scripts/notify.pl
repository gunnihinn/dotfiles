use strict;
use warnings;

use File::Temp;
use Irssi;
use JSON;

# Based on Akish Shukla's irssi-notify.pl

$::VERSION = '0.0.1';
%::IRSSI   = (
    authors     => 'Gunnar Magnusson',
    contact     => 'gmail.com!gunnar.thor.magnusson',
    name        => 'notify',
    description => 'Displays a notification on certain irssi messages',
    license     => 'GNU General Public License',
    changed     => '$Date$'
);

my $APPNAME = 'irssi';

my $CRIT = 'critical';
my $NORM = 'normal';

my %private_notifications;
my $private_threshold_sec = 60;

sub is_me {
    my ($msg) = @_;

    return $msg =~ m{gunnar|magn[^\s]+sson}i;
}

sub is_bad {
    my ($msg) = @_;

    return $msg =~ m{(smartav|outage|blocked|call)}i;
}

sub event_public_message {
    my ( $server, $msg, $nick, $address, $target ) = @_;

    # We can assume I know what I type
    return if is_me($nick);

    my $urgency;

    if ( $target =~ /live/ && ( is_me($msg) || is_bad($msg) ) ) {
        $urgency = $CRIT;
    }
    elsif ( is_me($msg) ) {
        $urgency = $NORM;
    }

    notify( "$target $nick", $msg, $urgency ) if $urgency;
}

sub event_private_message {
    my ( $server, $msg, $nick, $address, $target ) = @_;

    $private_notifications{$nick} //= 0;

    if ( time() - $private_notifications{$nick} > $private_threshold_sec )
    {
        notify( $nick, $msg, $NORM );
    }

    $private_notifications{$nick} = time;
}

sub notify {
    my ( $title, $msg, $urgency ) = @_;

    $msg =~ s/["';]//g;

    my $notification = {
        Summary => $title,
        Body => $msg,
        Urgency => $urgency,
    };

    my $fh = File::Temp->new(
        DIR => '/tmp/remote-notify',
        UNLINK => 0,
    );

    print $fh to_json($notification);
}

Irssi::signal_add_last( 'message public',  \&event_public_message );
Irssi::signal_add_last( 'message private', \&event_private_message );
