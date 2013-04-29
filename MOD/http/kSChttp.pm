#!/usr/bin/perl
#########################################################
#                                                       #
# Basis Funktionen für kVASy System Control             #
#                                                       #
#########################################################
use strict;
use LWP::Simple;
use Config::Properties;
use Encode;
# Name
package kSChttp;
# Redirect Error Output
#########################################################
#                                                       #
#                  Read Configuration                   #
#                                                       #
#########################################################
open my $CF, '<', '/kSCproxy/CFG/proxy.properties' or die "[". (localtime) ."] Kann Konfiguration '/kSCproxy/CFG/proxy.properties' nicht öffnen!";
my $properties = Config::Properties->new();
$properties->load($CF);
#########################################################
#                                                       #
#                       Functions                       #
#                                                       #
#########################################################
sub GetArray {
    my $coreml = shift;
    my $format = shift;
    my $module = shift;
    my $uid = shift;
    #
    my %decoded_info=();
    my $gibc = $properties->splitToTree(qr/\./, 'core');
    foreach my $key (keys %{$gibc}) {
	my $info = LWP::Simple::get("http://". $gibc->{$key}->{'addr'} .":". $gibc->{$key}->{'port'} ."/". $coreml ."/". $format ."/?e=1&m=". $module ."&u=". $uid ."");
	$decoded_info{ $gibc->{$key}->{'name'} }{'result'} = $info;
    }
    #
    return (\%decoded_info);
}
#
close ($CF);
#
1;
