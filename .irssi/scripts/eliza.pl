use strict;
use warnings;

use lib '/home/gmagnusson/.irssi/scripts/lib';

use Irssi;
use Chatbot::Eliza;

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

my $bot = new Chatbot::Eliza;

sub event_private_message {
    my ( $server, $msg, $nick, $address, $target ) = @_;

    # Ye olde organic typing delay
    sleep(5 + rand(10));

    my $resp = "MSG $nick " . $bot->transform($msg);
    $server->command($resp);
}

Irssi::signal_add_last( 'message private', \&event_private_message );
