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
sub GetSearchArray {
    my $coreml = shift;
    my $format = shift;
    my $module = shift;
    my $uid = shift;
    my $searchstring = shift;
    #
    my %decoded_info=();
    my $gibc = $properties->splitToTree(qr/\./, 'core');
    foreach my $key (keys %{$gibc}) {
	my $info = LWP::Simple::get("http://". $gibc->{$key}->{'addr'} .":". $gibc->{$key}->{'port'} ."/". $coreml ."/". $format ."/?e=1&m=". $module ."&u=". $uid ."&searchstring=". $searchstring ."");
	$decoded_info{ $gibc->{$key}->{'name'} }{'result'} = $info;
    }
    #
    return (\%decoded_info);
}
#
sub RedirectClientInfo {
    my $corenode = shift;
    my $client = shift;
    my $core_module = shift;
    my $format = shift;
    my $module = shift;
    my $uid = shift;
    my %decoded_info=();
    #
    my $url;
    my $gibc = $properties->splitToTree(qr/\./, 'core');
    foreach my $key (keys %{$gibc}) {
	if ( $gibc->{$key}->{'name'} eq $corenode ) {
	    my $info = LWP::Simple::get("http://". $gibc->{$key}->{'addr'} .":". $gibc->{$key}->{'port'} ."/". $core_module ."/". $format ."/?e=1&m=". $module ."&c=". $client ."&u=". $uid ."");
	    $decoded_info{ $gibc->{$key}->{'name'} }{'result'} = $info;
	    $url = "http://". $gibc->{$key}->{'addr'} .":". $gibc->{$key}->{'port'} ."/". $core_module ."/". $format ."/?e=1&m=". $module ."&c=". $client ."&u=". $uid ."";
	}
    }
    #
    return (\%decoded_info);
    #return ($url);
}
#
sub RedirectJqGridInfo {
    my $corenode = shift;
    my $client = shift;
    my $core_module = shift;
    my $format = shift;
    my $module = shift;
    my $uid = shift;
    my $api_module = shift;
    my $search = shift;
    my $rows = shift;
    my $page = shift;
    my $sidx = shift;
    my $sord = shift;
    my %decoded_info=();
    #
    my $gibc = $properties->splitToTree(qr/\./, 'core');
    foreach my $key (keys %{$gibc}) {
	if ( $gibc->{$key}->{'name'} eq $corenode ) {
	    my $info = LWP::Simple::get("http://". $gibc->{$key}->{'addr'} .":". $gibc->{$key}->{'port'} ."/". $core_module ."/". $format ."/?e=1&m=". $module ."&cm=". $api_module ."&c=". $client ."&u=". $uid ."&_search=". $search ."&rows=". $rows ."&page=". $page ."&sidx=". $sidx ."&sord=". $sord ."");
	    $decoded_info{ $gibc->{$key}->{'name'} }{'result'} = $info;
	}
    }
    #
    return (\%decoded_info);
}
#
close ($CF);
#
1;
