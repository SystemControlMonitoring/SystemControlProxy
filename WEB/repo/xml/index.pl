#!/usr/bin/perl
#
# Include Library Path
use FCGI;
use lib '/kSCcore/MOD/html';
use lib '/kSCcore/MOD/basic';
use lib '/kSCcore/MOD/postgre';
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
    print kSChtml::ContentType("xml");
    print "<dashboard>";
    while ( (my $tv1,my $tv2, my $tv3) = $sth->fetchrow_array()) {
	print "<link>\n";
	print "   <title>". kSCbasic::EncodeXML($tv1) ."</title>\n";
	print "   <desc>". kSCbasic::EncodeXML($tv2) ."</desc>\n";
	print "   <target>". kSCbasic::EncodeXML($tv3) ."</target>\n";
	print "</link>\n";
    }
    print "</dashboard>";
}
#
sub InsertDashboardAll {
    my $uid = shift;
    # USER,MODUL,KEY,VALUE1,VALUE2,VALUE3
    my $DashboardConfig = kSCbasic::GetDashboardConfig();
    #
    foreach my $key (keys %{$DashboardConfig}) {
	my @temp = split(";", $DashboardConfig->{$key});
	kSCpostgre::InsertRepository($uid,"DASHBOARD","STARTER",$temp[0],kSCbasic::EncodeXML($temp[1]),$temp[2]);
    }
    # Execution
    print kSChtml::ContentType("xml");
    print "<insert>COMPLETE</insert>";
}
#
sub DeleteDashboardAll {
    my $uid = shift;
    # USER,MODUL,KEY
    kSCpostgre::DeleteFromRepository($uid,"DASHBOARD","STARTER");
    # Execution
    print kSChtml::ContentType("xml");
    print "<delete>COMPLETE</delete>";
}
#
sub GetConfig {
    # Beispiel Funktion
    my $config = kSCbasic::GetDashboardConfig();
    print kSChtml::ContentType("text");
    foreach my $key (keys %{$config}) {
	print $config->{$key} ."\n";
    }
}
#
sub DeleteRepoAll {
    my $uid = shift;
    # USER,MODUL,KEY
    kSCpostgre::DeleteAllRepository($uid);
    # Execution
    print kSChtml::ContentType("xml");
    print "<delete>COMPLETE</delete>";
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
    print kSChtml::ContentType("xml");
    print "<delete>INSERT_UPDATE</delete>";
}
#
sub SelectConfig {
    my $uid = shift;
    my $mdl = shift;
    my $base = kSCbasic::GetBasicConfig();
    my $sth = kSCpostgre::SelectFromRepository($uid,$mdl);
    print kSChtml::ContentType("xml");
    print "<config>\n";
    if ($sth->rows > 0) {
	while ( (my $key,my $tv1,my $tv2, my $tv3) = $sth->fetchrow_array()) {
	    print "   <para>\n";
	    print "      <key>". $key ."</key>\n";
	    print "      <action>". $tv1 ."</action>\n";
	    print "      <desc>". kSCbasic::EncodeXML($tv2) ."</desc>\n";
	    print "   </para>\n";
	}
    } else {
	foreach my $key (keys %{$base}) {
	    print "   <para>\n";
	    print "      <key>". $base->{$key}->{'name'} ."</key>\n";
	    print "      <action>". $base->{$key}->{'stat'} ."</action>\n";
	    print "      <desc>". kSCbasic::EncodeXML($base->{$key}->{'desc'}) ."</desc>\n";
	    print "   </para>\n";
	}
    }
    print "</config>\n";
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
    } elsif (kSCbasic::CheckUrlKeyValue("m","SelectConfig","y") == 0) {
	SelectConfig(kSCbasic::DecodeBase64u6(kSCbasic::GetUrlKeyValue("u")),kSCbasic::DecodeBase64u6(kSCbasic::GetUrlKeyValue("m2")));
    } else {
	my $out = kSChtml::ContentType("xml");
	$out.= kSCbasic::ErrorMessage("xml","1");
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
    } elsif (kSCbasic::CheckUrlKeyValue("m","SelectConfig","n") == 0) {
	SelectConfig(kSCbasic::GetUrlKeyValue("u"),kSCbasic::GetUrlKeyValue("m2"));
    } else {
	my $out = kSChtml::ContentType("xml");
	$out.= kSCbasic::ErrorMessage("xml","2");
	print $out;
    }
} else {
    my $out = kSChtml::ContentType("xml");
    $out.= kSCbasic::ErrorMessage("xml","0");
    print $out;
}

}
#
# End
#
