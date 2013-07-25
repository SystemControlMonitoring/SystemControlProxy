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
sub RedirectSysInfo {
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
sub RedirectDbInfo {
    my $corenode = shift;
    my $client = shift;
    my $db = shift;
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
	    my $info = LWP::Simple::get("http://". $gibc->{$key}->{'addr'} .":". $gibc->{$key}->{'port'} ."/". $core_module ."/". $format ."/?e=1&m=". $module ."&c=". $client ."&db=". $db ."&u=". $uid ."");
	    $decoded_info{ $gibc->{$key}->{'name'} }{'result'} = $info;
	    #$url = "http://". $gibc->{$key}->{'addr'} .":". $gibc->{$key}->{'port'} ."/". $core_module ."/". $format ."/?e=1&m=". $module ."&c=". $client ."&u=". $uid ."";
	}
    }
    #
    return (\%decoded_info);
    #return ($url);
}
#
sub RedirectODBAdmin {
    my $corenode = shift;
    my $client = shift;
    my $db = shift;
    my $core_module = shift;
    my $format = shift;
    my $module = shift;
    my $uid = shift;
    my $cm = shift;
    my $datestart = shift;
    my $dateend = shift;
    my %decoded_info=();
    #
    my $url;
    my $gibc = $properties->splitToTree(qr/\./, 'core');
    foreach my $key (keys %{$gibc}) {
	if ( $gibc->{$key}->{'name'} eq $corenode ) {
	    my $info = LWP::Simple::get("http://". $gibc->{$key}->{'addr'} .":". $gibc->{$key}->{'port'} ."/". $core_module ."/". $format ."/?e=1&m=". $module ."&c=". $client ."&db=". $db ."&u=". $uid ."&cm=". $cm ."&date_start=". $datestart ."&date_end=". $dateend ."");
	    $decoded_info{ $gibc->{$key}->{'name'} }{'result'} = $info;
	    #$url = "http://". $gibc->{$key}->{'addr'} .":". $gibc->{$key}->{'port'} ."/". $core_module ."/". $format ."/?e=1&m=". $module ."&c=". $client ."&u=". $uid ."";
	}
    }
    #
    return (\%decoded_info);
    #return ($url);
}
#
sub RedirectLogAdmin {
    my $corenode = shift;
    my $client = shift;
    my $log = shift;
    my $core_module = shift;
    my $format = shift;
    my $module = shift;
    my $uid = shift;
    my $cm = shift;
    my %decoded_info=();
    #
    my $url;
    my $gibc = $properties->splitToTree(qr/\./, 'core');
    foreach my $key (keys %{$gibc}) {
	if ( $gibc->{$key}->{'name'} eq $corenode ) {
	    my $info = LWP::Simple::get("http://". $gibc->{$key}->{'addr'} .":". $gibc->{$key}->{'port'} ."/". $core_module ."/". $format ."/?e=1&m=". $module ."&c=". $client ."&log=". $log ."&u=". $uid ."&cm=". $cm ."");
	    $decoded_info{ $gibc->{$key}->{'name'} }{'result'} = $info;
	    #$url = "http://". $gibc->{$key}->{'addr'} .":". $gibc->{$key}->{'port'} ."/". $core_module ."/". $format ."/?e=1&m=". $module ."&c=". $client ."&log=". $log ."&u=". $uid ."&cm=". $cm ."";
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
sub RedirectJqGridDbInfo {
    my $host = shift;
    my $client = shift;
    my $db = shift;
    my $core = shift;
    my $format = shift;
    my $module = shift;
    my $uid = shift;
    my $api = shift;
    my $search = shift;
    my $rows = shift;
    my $page = shift;
    my $sidx = shift;
    my $sord = shift;
    my %decoded_info=();
    #
    my $gibc = $properties->splitToTree(qr/\./, 'core');
    foreach my $key (keys %{$gibc}) {
	if ( $gibc->{$key}->{'name'} eq $host ) {
	    my $info = LWP::Simple::get("http://". $gibc->{$key}->{'addr'} .":". $gibc->{$key}->{'port'} ."/". $core ."/". $format ."/?e=1&m=". $module ."&cm=". $api ."&c=". $client ."&db=". $db ."&u=". $uid ."&_search=". $search ."&rows=". $rows ."&page=". $page ."&sidx=". $sidx ."&sord=". $sord ."");
	    $decoded_info{ $gibc->{$key}->{'name'} }{'result'} = $info;
	}
    }
    #
    return (\%decoded_info);
}
#
sub GetSrvStatSelArray {
    my $coreml = shift;
    my $format = shift;
    my $module = shift;
    my $uid = shift;
    my $state = shift;
    #
    my %decoded_info=();
    my $gibc = $properties->splitToTree(qr/\./, 'core');
    foreach my $key (keys %{$gibc}) {
	my $info = LWP::Simple::get("http://". $gibc->{$key}->{'addr'} .":". $gibc->{$key}->{'port'} ."/". $coreml ."/". $format ."/?e=1&m=". $module ."&u=". $uid ."&s=". $state ."");
	$decoded_info{ $gibc->{$key}->{'name'} }{'result'} = $info;
    }
    #
    return (\%decoded_info);
}
#
sub GetSrvSearchArray {
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
sub ExcIcingaCmd {
    my $node = shift;
    my $client = shift;
    my $core = shift;
    my $format = shift;
    my $module = shift;
    my $uid = shift;
    my $check = shift;
    #
    my %decoded_info=();
    my $gibc = $properties->splitToTree(qr/\./, 'core');
    my $out;
    foreach my $key (keys %{$gibc}) {
	if ( $gibc->{$key}->{'name'} eq $node ) {
	    my $info = LWP::Simple::get("http://". $gibc->{$key}->{'addr'} .":". $gibc->{$key}->{'port'} ."/". $core ."/". $format ."/?e=1&m=". $module ."&u=". $uid ."&cl=". $client ."&ch=". $check ."");
	    $decoded_info{ $gibc->{$key}->{'name'} }{'result'} = $info;
	}
    }
    #
    return (\%decoded_info);
}
#
sub ExcIcingaCmdWiCm {
    my $node = shift;
    my $client = shift;
    my $core = shift;
    my $format = shift;
    my $module = shift;
    my $uid = shift;
    my $check = shift;
    my $author = shift;
    my $comment = shift;
    #
    my %decoded_info=();
    my $gibc = $properties->splitToTree(qr/\./, 'core');
    my $out;
    foreach my $key (keys %{$gibc}) {
	if ( $gibc->{$key}->{'name'} eq $node ) {
	    my $info = LWP::Simple::get("http://". $gibc->{$key}->{'addr'} .":". $gibc->{$key}->{'port'} ."/". $core ."/". $format ."/?e=1&m=". $module ."&u=". $uid ."&cl=". $client ."&ch=". $check ."&ar=". $author ."&cm=". $comment ."");
	    $decoded_info{ $gibc->{$key}->{'name'} }{'result'} = $info;
	}
    }
    #
    return (\%decoded_info);
}
#
sub ExcIcingaCmdWiCmUd {
    my $node = shift;
    my $client = shift;
    my $core = shift;
    my $format = shift;
    my $module = shift;
    my $uid = shift;
    my $check = shift;
    my $author = shift;
    my $comment = shift;
    my $datestart = shift;
    my $dateend = shift;
    #
    my %decoded_info=();
    my $gibc = $properties->splitToTree(qr/\./, 'core');
    my $out;
    foreach my $key (keys %{$gibc}) {
	if ( $gibc->{$key}->{'name'} eq $node ) {
	    my $info = LWP::Simple::get("http://". $gibc->{$key}->{'addr'} .":". $gibc->{$key}->{'port'} ."/". $core ."/". $format ."/?e=1&m=". $module ."&u=". $uid ."&cl=". $client ."&ch=". $check ."&ar=". $author ."&cm=". $comment ."&ds=". $datestart ."&de=". $dateend ."");
	    $decoded_info{ $gibc->{$key}->{'name'} }{'result'} = $info;
	}
    }
    #
    return (\%decoded_info);
}
#
#
close ($CF);
#
1;
