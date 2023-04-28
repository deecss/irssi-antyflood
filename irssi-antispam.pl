use strict;
use Irssi;
use Time::HiRes qw(time);

use vars qw($VERSION %IRSSI);
$VERSION = '1.0';
%IRSSI = (
    authors     => 'dee',
    contact     => 'enode@enode.pl',
    name        => 'irssi-antispam',
    description => 'Block spam and flood messages in private and channel messages',
    license     => 'GPLv3',
);

my %flooders;

sub antispam {
    my ($server, $msg, $nick, $address, $target) = @_;
    my $block_spam = Irssi::settings_get_bool('antispam_block');
    my $block_flood = Irssi::settings_get_bool('antispam_block_flood');
    my $flood_duration = Irssi::settings_get_int('antispam_flood_duration');
    my $patterns = Irssi::settings_get_str('antispam_patterns');

    if ($block_flood) {
        if (exists $flooders{$nick}) {
            my $last_msg_time = $flooders{$nick};
            if (time - $last_msg_time < $flood_duration) {
                Irssi::print("Blocked flood from $nick!$address ($target)");
                return;
            }
        }
        $flooders{$nick} = time;
    }

    if ($block_spam) {
        my @patterns = split(/,/, $patterns);
        foreach my $pattern (@patterns) {
            if ($msg =~ /$pattern/i) {
                Irssi::print("Blocked spam from $nick!$address ($target)");
                return;
            }
        }
    }

    Irssi::signal_continue($server, $msg, $nick, $address, $target);
}

Irssi::signal_add('message private', 'antispam');
Irssi::signal_add('message public', 'antispam');

Irssi::settings_add_bool('antispam', 'antispam_block', 1);
Irssi::settings_add_bool('antispam', 'antispam_block_flood', 1);
Irssi::settings_add_int('antispam', 'antispam_flood_duration', 5);
Irssi::settings_add_str('antispam', 'antispam_patterns', 'default_spam_patterns_here');