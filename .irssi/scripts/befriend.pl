use strict;
use warnings;

use Digest::MD5 qw(md5_hex);
use Data::Dumper;
use Irssi;

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

sub get_nicks {
    my %nicks;

    for my $ch (Irssi::channels()) {
        for my $nick ($ch->nicks()) {
            $nicks{$nick->{nick}} = undef;
        }
    }

    return keys %nicks;
}

sub datefile {
    my ($sec, $min, $hour, $mday, $mon, $year, $wday, $yday, $isdst) = localtime();

    $year += 1900;

    return "/tmp/$year-$yday";
}

sub today_minute {
    my ($sec,$min,$hour,$mday,$mon,$year,$wday,$yday,$isdst) = localtime();
    my $d = "$year-$yday";

    my @hs = split //, md5_hex($d);
    my $h = join('', @hs[0 .. 4]);
    my $r = hex($h) % 360;

    return 600 + $r;
}

sub minute {
    return int(time() / 60) % (24 * 60);
}

sub not_today {
    my ($sec,$min,$hour,$mday,$mon,$year,$wday,$yday,$isdst) = localtime();

    $year += 1900;

    return $year == 2018 && $mon == 11 && $mday == 19;
}

sub handler {
    my ( $server, $msg, $nick, $address, $target ) = @_;

    if (not_today()) {
        return;
    }

    my $d = datefile();
    if (-f $d) {
        return;
    }

    # Is this today's minute?
    if (minute() < today_minute()) {
        return;
    }

    system "touch $d" and return;

    my @nicks = get_nicks();

    my %friends;
    while (keys %friends < 3) {
        my $f = $nicks[int(rand() * (scalar @nicks))];
        $friends{$f} = undef;
    }

    for my $friend (keys %friends) {
        my $msg = "MSG $friend Hey, how's it going?";
        $server->command($msg);
    }
}

Irssi::signal_add_last( 'message public', \&handler );
