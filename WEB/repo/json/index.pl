#!/usr/bin/perl
#
# Include Library Path
use FCGI;
use lib '/kSCproxy/MOD/html';
use lib '/kSCproxy/MOD/basic';
use lib '/kSCproxy/MOD/postgre';
# Include Library
use kSChtml;
use kSCbasic;
use kSCpostgre;
use strict;
use Data::Dumper;
#
my $request = FCGI::Request();
#
#
#
#
#
#
# Functions
#
sub SelectDashboardAll {
    my $uid = shift;
    my $sth = kSCpostgre::SelectDashboardAll($uid);
    my $out;
    while ( (my $tv1,my $tv2, my $tv3) = $sth->fetchrow_array()) {
	$out.="{\"TITLE\":\"". kSCbasic::EncodeHTML($tv1) ."\",\"DESC\":\"". kSCbasic::EncodeHTML($tv2) ."\",\"TARGET\":\"". kSCbasic::EncodeHTML($tv3) ."\"},";
    }
    $out = substr($out, 0, -1);
    print kSChtml::ContentType("json");
    print "[". $out ."]";
}
#
sub InsertDashboardAll {
    my $uid = shift;
    my $DashboardConfig = kSCbasic::GetDashboardConfig();
    #
    foreach my $key (keys %{$DashboardConfig}) {
        my @temp = split(";", $DashboardConfig->{$key});
	kSCpostgre::InsertRepository($uid,"DASHBOARD","STARTER",$temp[0],kSCbasic::EncodeHTML($temp[1]),$temp[2]);
    }
    # Execution
    print kSChtml::ContentType("json");
    print "{\"INSERT\":\"COMPLETE\"}";
}
#
sub DeleteDashboardAll {
    my $uid = shift;
    # USER,MODUL,KEY
    kSCpostgre::DeleteFromRepository($uid,"DASHBOARD","STARTER");
    # Execution
    print kSChtml::ContentType("json");
    print "{\"DELETE\":\"COMPLETE\"}";
}
#
sub DeleteRepoAll {
    my $uid = shift;
    # USER,MODUL,KEY
    kSCpostgre::DeleteAllRepository($uid);
    # Execution
    print kSChtml::ContentType("json");
    print "{\"DELETE\":\"COMPLETE\"}";
}
#
sub InsertUpdateConfig {
    my $uid = shift;
    my $mdl = shift;
    my $key = shift;
    my $val1 = shift;
    my $val2 = shift;
    my $val3 = shift;
    #
    kSCpostgre::InsertUpdateConfig($uid,$mdl,$key,$val1,$val2,$val3);
    # Execution
    print kSChtml::ContentType("json");
    print "{\"INSERT_UPDATE\":\"COMPLETE\"}";
}
#
sub SelectConfig {
    my $uid = shift;
    my $mdl = shift;
    my $base = kSCbasic::GetBasicConfig();
    my $sth = kSCpostgre::SelectFromRepository($uid,$mdl);
    my $out;
    if ($sth->rows > 0) {
	while ( (my $key,my $tv1,my $tv2, my $tv3) = $sth->fetchrow_array()) {
	    $out.="{\"KEY\":\"". $key ."\",\"ACTION\":\"". $tv1 ."\",\"DESC\":\"". kSCbasic::EncodeHTML($tv2) ."\"},";
	}
    } else {
	foreach my $key (keys %{$base}) {
	    $out.="{\"KEY\":\"". $base->{$key}->{'name'} ."\",\"ACTION\":\"". $base->{$key}->{'stat'} ."\",\"DESC\":\"". $base->{$key}->{'desc'} ."\"},";
	}
    }
    $out = substr($out, 0, -1);
    print kSChtml::ContentType("json");
    print "[". $out ."]";
}
#
sub UpdateModView {
    my $uid = shift;
    my $tky = shift;
    my $val1 = shift;
    kSCpostgre::InsertUpdateConfig($uid,"MODVIEW",$tky,$val1,"","");
    # Execution
    print kSChtml::ContentType("json");
    print "{\"MODVIEW_UPDATE\":\"COMPLETE\"}";
}
#
sub SelectModView {
    my $uid = shift;
    my $tky = shift;
    my $base = kSCbasic::GetModViewConfig();
    my $sth = kSCpostgre::SelectModView($uid,"MODVIEW",$tky);
    my $out;
    if ($sth->rows > 0) {
	while ( (my $tv1) = $sth->fetchrow_array()) {
	    $out.="{\"MODVIEW\":\"". $tv1 ."\"}";
	}
    } else {
	foreach my $key (keys %{$base}) {
	    if ($key eq $tky) {
		$out.="{\"MODVIEW\":\"". $base->{$key}->{'default'} ."\"}";
	    }
	}
    }
    #$out = substr($out, 0, -1);
    print kSChtml::ContentType("json");
    print $out;
}
#
#
#
#
#
#
#
# Output
#
# e = encoded, m = module
while($request->Accept() >= 0) {

if (kSCbasic::CheckUrlKeyValue("e","1","n") == 0) {
    if (kSCbasic::CheckUrlKeyValue("m","SelectDashboardAll","y") == 0) {
	SelectDashboardAll(kSCbasic::DecodeBase64u6(kSCbasic::GetUrlKeyValue("u")));
    } elsif (kSCbasic::CheckUrlKeyValue("m","InsertDashboardAll","y") == 0) {
	InsertDashboardAll(kSCbasic::DecodeBase64u6(kSCbasic::GetUrlKeyValue("u")));
    } elsif (kSCbasic::CheckUrlKeyValue("m","DeleteDashboardAll","y") == 0) {
	DeleteDashboardAll(kSCbasic::DecodeBase64u6(kSCbasic::GetUrlKeyValue("u")));
    } elsif (kSCbasic::CheckUrlKeyValue("m","DeleteRepoAll","y") == 0) {
	DeleteRepoAll(kSCbasic::DecodeBase64u6(kSCbasic::GetUrlKeyValue("u")));
    } elsif (kSCbasic::CheckUrlKeyValue("m","InsertUpdateConfig","y") == 0) {
	InsertUpdateConfig(kSCbasic::DecodeBase64u6(kSCbasic::GetUrlKeyValue("u")),kSCbasic::DecodeBase64u6(kSCbasic::GetUrlKeyValue("m2")),kSCbasic::DecodeBase64u6(kSCbasic::GetUrlKeyValue("k")),kSCbasic::DecodeBase64u6(kSCbasic::GetUrlKeyValue("v1")),kSCbasic::DecodeBase64u6(kSCbasic::GetUrlKeyValue("v2")),kSCbasic::DecodeBase64u6(kSCbasic::GetUrlKeyValue("v3")));
    } elsif (kSCbasic::CheckUrlKeyValue("m","UpdateModView","y") == 0) {
	UpdateModView(kSCbasic::DecodeBase64u6(kSCbasic::GetUrlKeyValue("u")),kSCbasic::DecodeBase64u6(kSCbasic::GetUrlKeyValue("k")),kSCbasic::DecodeBase64u6(kSCbasic::GetUrlKeyValue("v1")));
    } elsif (kSCbasic::CheckUrlKeyValue("m","SelectConfig","y") == 0) {
	SelectConfig(kSCbasic::DecodeBase64u6(kSCbasic::GetUrlKeyValue("u")),kSCbasic::DecodeBase64u6(kSCbasic::GetUrlKeyValue("m2")));
    } elsif (kSCbasic::CheckUrlKeyValue("m","SelectModView","y") == 0) {
	SelectModView(kSCbasic::DecodeBase64u6(kSCbasic::GetUrlKeyValue("u")),kSCbasic::DecodeBase64u6(kSCbasic::GetUrlKeyValue("k")));
    } else {
	my $out = kSChtml::ContentType("json");
	$out.= kSCbasic::ErrorMessage("json","1");
	print $out;
    }
} elsif (kSCbasic::CheckUrlKeyValue("e","0","n") == 0) {
    if (kSCbasic::CheckUrlKeyValue("m","SelectDashboardAll","n") == 0) {
	SelectDashboardAll(kSCbasic::GetUrlKeyValue("u"));
    } elsif (kSCbasic::CheckUrlKeyValue("m","InsertDashboardAll","n") == 0) {
	InsertDashboardAll(kSCbasic::GetUrlKeyValue("u"));
    } elsif (kSCbasic::CheckUrlKeyValue("m","DeleteDashboardAll","n") == 0) {
	DeleteDashboardAll(kSCbasic::GetUrlKeyValue("u"));
    } elsif (kSCbasic::CheckUrlKeyValue("m","DeleteRepoAll","n") == 0) {
	DeleteRepoAll(kSCbasic::GetUrlKeyValue("u"));
    } elsif (kSCbasic::CheckUrlKeyValue("m","InsertUpdateConfig","n") == 0) {
	InsertUpdateConfig(kSCbasic::GetUrlKeyValue("u"),kSCbasic::GetUrlKeyValue("m2"),kSCbasic::GetUrlKeyValue("k"),kSCbasic::GetUrlKeyValue("v1"),kSCbasic::GetUrlKeyValue("v2"),kSCbasic::GetUrlKeyValue("v3"));
    } elsif (kSCbasic::CheckUrlKeyValue("m","UpdateModView","n") == 0) {
	UpdateModView(kSCbasic::GetUrlKeyValue("u"),kSCbasic::GetUrlKeyValue("k"),kSCbasic::GetUrlKeyValue("v1"));
    } elsif (kSCbasic::CheckUrlKeyValue("m","SelectConfig","n") == 0) {
	SelectConfig(kSCbasic::GetUrlKeyValue("u"),kSCbasic::GetUrlKeyValue("m2"));
    } elsif (kSCbasic::CheckUrlKeyValue("m","SelectModView","n") == 0) {
	SelectModView(kSCbasic::GetUrlKeyValue("u"),kSCbasic::GetUrlKeyValue("k"));
    } else {
	my $out = kSChtml::ContentType("json");
	$out.= kSCbasic::ErrorMessage("json","2");
	print $out;
    }
} else {
    my $out = kSChtml::ContentType("json");
    $out.= kSCbasic::ErrorMessage("json","0");
    print $out;
}

}
#
# End
#
