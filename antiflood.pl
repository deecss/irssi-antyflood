use strict;
use Irssi;
use vars qw($VERSION %IRSSI);

$VERSION = '1.0';
%IRSSI = (
    authors     => 'dee',
    contact     => 'enode@enode.pl',
    name        => 'antispam',
    description => 'Block spam messages from users with random nicks and idents, as well as repeated vhosts',
    license     => 'Public Domain',
);

my %blocked_vhosts;

sub check_random_string {
    my ($str) = @_;
    return ($str =~ /^[a-zA-Z0-9]{6,}$/);
}

sub on_privmsg {
    my ($server, $msg, $nick, $address) = @_;

    my ($ident, $vhost) = split(/@/, $address);

    if (check_random_string($nick) && check_random_string($ident)) {
        Irssi::print("Blocked message from spammer $nick!$ident\@$vhost");
        return;
    }

    if (exists $blocked_vhosts{$vhost} && $blocked_vhosts{$vhost} > 2) {
        Irssi::print("Blocked message from repeated vHost $vhost");
        return;
    }

    $blocked_vhosts{$vhost}++;

    Irssi::signal_continue($server, $msg, $nick, $address);
}

Irssi::signal_add('message private', 'on_privmsg');
