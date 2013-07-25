#!/usr/bin/perl
#
# Include Library Path
use FCGI;
use lib '/kSCproxy/MOD/html';
use lib '/kSCproxy/MOD/basic';
use lib '/kSCproxy/MOD/http';
# Include Library
use kSChtml;
use kSCbasic;
use kSChttp;
use warnings;
use strict;
use Data::Dumper;
#
my $request = FCGI::Request();
#
#
#
#
#
# Functions
#
sub ReCheck {
    #
    # Parameter
    my $checks = shift;
    $checks = substr($checks, 0, -1);
    my $uid = shift;
    my $out;
    #
    # Execution
    my @CL = split(';', $checks);
    foreach my $check (@CL) {
	my @c = split('@', $check);
	#
	# Exec Command
	my $exec = kSChttp::ExcIcingaCmd($c[1],kSCbasic::EncodeBase64u6($c[0]),"command","json","UmVDaGVjaw==KlU76T",$uid,kSCbasic::EncodeBase64u6($c[2]));
	foreach my $key (keys %{$exec}) {
	    my $data = $exec->{$key}->{'result'};
	    $data =~ s/{\"/{\"NODE\":\"$c[1]\",\"/g;
	    $out .= $data .",";
	}
    }
    $out = substr($out, 0, -1);
    #
    # Output
    print kSChtml::ContentType("json");
    print "[". $out ."]";
}
#
sub AckSvc {
    #
    # Parameter
    my $checks = shift;
    $checks = substr($checks, 0, -1);
    my $uid = shift;
    my $author = shift;
    my $comment = shift;
    my $out;
    #
    # Execution
    my @CL = split(';', $checks);
    foreach my $check (@CL) {
	my @c = split('@', $check);
	#
	# Exec Command
	my $exec = kSChttp::ExcIcingaCmdWiCm($c[1],kSCbasic::EncodeBase64u6($c[0]),"command","json","QWNrU3ZjKlrU87",$uid,kSCbasic::EncodeBase64u6($c[2]),$author,$comment);
	foreach my $key (keys %{$exec}) {
	    my $data = $exec->{$key}->{'result'};
	    $data =~ s/{\"/{\"NODE\":\"$c[1]\",\"/g;
	    $out .= $data .",";
	}
    }
    $out = substr($out, 0, -1);
    #
    # Output
    print kSChtml::ContentType("json");
    print "[". $out ."]";
}
#
sub RemAckSvc {
    #
    # Parameter
    my $checks = shift;
    $checks = substr($checks, 0, -1);
    my $uid = shift;
    my $out;
    #
    # Execution
    my @CL = split(';', $checks);
    foreach my $check (@CL) {
	my @c = split('@', $check);
	#
	# Exec Command
	my $exec = kSChttp::ExcIcingaCmdWiCm($c[1],kSCbasic::EncodeBase64u6($c[0]),"command","json","UmVtQWNrU3ZjKlU76T",$uid,kSCbasic::EncodeBase64u6($c[2]));
	foreach my $key (keys %{$exec}) {
	    my $data = $exec->{$key}->{'result'};
	    $data =~ s/{\"/{\"NODE\":\"$c[1]\",\"/g;
	    $out .= $data .",";
	}
    }
    $out = substr($out, 0, -1);
    #
    # Output
    print kSChtml::ContentType("json");
    print "[". $out ."]";
}
#
sub ComSvc {
    #
    # Parameter
    my $checks = shift;
    $checks = substr($checks, 0, -1);
    my $uid = shift;
    my $author = shift;
    my $comment = shift;
    my $out;
    #
    # Execution
    my @CL = split(';', $checks);
    foreach my $check (@CL) {
	my @c = split('@', $check);
	#
	# Exec Command
	my $exec = kSChttp::ExcIcingaCmdWiCm($c[1],kSCbasic::EncodeBase64u6($c[0]),"command","json","Q29tU3ZjKlrU87",$uid,kSCbasic::EncodeBase64u6($c[2]),$author,$comment);
	foreach my $key (keys %{$exec}) {
	    my $data = $exec->{$key}->{'result'};
	    $data =~ s/{\"/{\"NODE\":\"$c[1]\",\"/g;
	    $out .= $data .",";
	}
    }
    $out = substr($out, 0, -1);
    #
    # Output
    print kSChtml::ContentType("json");
    print "[". $out ."]";
}
#
sub DwntmSvc {
    #
    # Parameter
    my $checks = shift;
    $checks = substr($checks, 0, -1);
    my $uid = shift;
    my $author = shift;
    my $comment = shift;
    my $datestart = shift;
    my $dateend = shift;
    $datestart =~ s/%20/ /g;
    $dateend =~ s/%20/ /g;
    my $out;
    #
    # Execution
    my @CL = split(';', $checks);
    foreach my $check (@CL) {
	my @c = split('@', $check);
	#
	# Exec Command
	my $exec = kSChttp::ExcIcingaCmdWiCmUd($c[1],kSCbasic::EncodeBase64u6($c[0]),"command","json","RHdudG1TdmM=KlrU87",$uid,kSCbasic::EncodeBase64u6($c[2]),$author,$comment,kSCbasic::ConvertTs2Ut($datestart),kSCbasic::ConvertTs2Ut($dateend));
	foreach my $key (keys %{$exec}) {
	    my $data = $exec->{$key}->{'result'};
	    $data =~ s/{\"/{\"NODE\":\"$c[1]\",\"/g;
	    $out .= $data .",";
	}
    }
    $out = substr($out, 0, -1);
    #
    # Output
    print kSChtml::ContentType("json");
    print "[". $out ."]";
}
#
sub RemDwntmSvc {
    #
    # Parameter
    my $checks = shift;
    $checks = substr($checks, 0, -1);
    my $uid = shift;
    my $out;
    #
    # Execution
    my @CL = split(';', $checks);
    foreach my $check (@CL) {
	my @c = split('@', $check);
	#
	# Exec Command
	my $exec = kSChttp::ExcIcingaCmdWiCmUd($c[1],kSCbasic::EncodeBase64u6($c[0]),"command","json","UmVtRHdudG1TdmM=KlU76T",$uid,kSCbasic::EncodeBase64u6($c[2]));
	foreach my $key (keys %{$exec}) {
	    my $data = $exec->{$key}->{'result'};
	    $data =~ s/{\"/{\"NODE\":\"$c[1]\",\"/g;
	    $out .= $data .",";
	}
    }
    $out = substr($out, 0, -1);
    #
    # Output
    print kSChtml::ContentType("json");
    print "[". $out ."]";
}
#
sub DeacNotSvc {
    #
    # Parameter
    my $checks = shift;
    $checks = substr($checks, 0, -1);
    my $uid = shift;
    my $out;
    #
    # Execution
    my @CL = split(';', $checks);
    foreach my $check (@CL) {
	my @c = split('@', $check);
	#
	# Exec Command
	my $exec = kSChttp::ExcIcingaCmd($c[1],kSCbasic::EncodeBase64u6($c[0]),"command","json","RGVhY05vdFN2Yw==KlU76T",$uid,kSCbasic::EncodeBase64u6($c[2]));
	foreach my $key (keys %{$exec}) {
	    my $data = $exec->{$key}->{'result'};
	    $data =~ s/{\"/{\"NODE\":\"$c[1]\",\"/g;
	    $out .= $data .",";
	}
    }
    $out = substr($out, 0, -1);
    #
    # Output
    print kSChtml::ContentType("json");
    print "[". $out ."]";
}
#
sub AcNotSvc {
    #
    # Parameter
    my $checks = shift;
    $checks = substr($checks, 0, -1);
    my $uid = shift;
    my $out;
    #
    # Execution
    my @CL = split(';', $checks);
    foreach my $check (@CL) {
	my @c = split('@', $check);
	#
	# Exec Command
	my $exec = kSChttp::ExcIcingaCmd($c[1],kSCbasic::EncodeBase64u6($c[0]),"command","json","QWNOb3RTdmM=KlU76T",$uid,kSCbasic::EncodeBase64u6($c[2]));
	foreach my $key (keys %{$exec}) {
	    my $data = $exec->{$key}->{'result'};
	    $data =~ s/{\"/{\"NODE\":\"$c[1]\",\"/g;
	    $out .= $data .",";
	}
    }
    $out = substr($out, 0, -1);
    #
    # Output
    print kSChtml::ContentType("json");
    print "[". $out ."]";
}
#
#
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
    if (kSCbasic::CheckUrlKeyValue("m","ReCheck","y") == 0) {
	ReCheck(kSCbasic::DecodeBase64u6(kSCbasic::GetUrlKeyValue("c")),kSCbasic::GetUrlKeyValue("u"));
    } elsif (kSCbasic::CheckUrlKeyValue("m","AckSvc","y") == 0) {
	AckSvc(kSCbasic::DecodeBase64u6(kSCbasic::GetUrlKeyValue("c")),kSCbasic::GetUrlKeyValue("u"),kSCbasic::GetUrlKeyValue("ar"),kSCbasic::GetUrlKeyValue("cm"));
    } elsif (kSCbasic::CheckUrlKeyValue("m","RemAckSvc","y") == 0) {
	RemAckSvc(kSCbasic::DecodeBase64u6(kSCbasic::GetUrlKeyValue("c")),kSCbasic::GetUrlKeyValue("u"));
    } elsif (kSCbasic::CheckUrlKeyValue("m","ComSvc","y") == 0) {
	ComSvc(kSCbasic::DecodeBase64u6(kSCbasic::GetUrlKeyValue("c")),kSCbasic::GetUrlKeyValue("u"),kSCbasic::GetUrlKeyValue("ar"),kSCbasic::GetUrlKeyValue("cm"));
    } elsif (kSCbasic::CheckUrlKeyValue("m","DwntmSvc","y") == 0) {
	DwntmSvc(kSCbasic::DecodeBase64u6(kSCbasic::GetUrlKeyValue("c")),kSCbasic::GetUrlKeyValue("u"),kSCbasic::GetUrlKeyValue("ar"),kSCbasic::GetUrlKeyValue("cm"),kSCbasic::GetUrlKeyValue("ds"),kSCbasic::GetUrlKeyValue("de"));
    } elsif (kSCbasic::CheckUrlKeyValue("m","RemDwntmSvc","y") == 0) {
	RemDwntmSvc(kSCbasic::DecodeBase64u6(kSCbasic::GetUrlKeyValue("c")),kSCbasic::GetUrlKeyValue("u"));
    } elsif (kSCbasic::CheckUrlKeyValue("m","DeacNotSvc","y") == 0) {
	DeacNotSvc(kSCbasic::DecodeBase64u6(kSCbasic::GetUrlKeyValue("c")),kSCbasic::GetUrlKeyValue("u"));
    } elsif (kSCbasic::CheckUrlKeyValue("m","AcNotSvc","y") == 0) {
	AcNotSvc(kSCbasic::DecodeBase64u6(kSCbasic::GetUrlKeyValue("c")),kSCbasic::GetUrlKeyValue("u"));
    } else {
	my $out = kSChtml::ContentType("json");
	$out.= kSCbasic::ErrorMessage("json","1");
	print $out;
    }
} elsif (kSCbasic::CheckUrlKeyValue("e","0","n") == 0) {
    if (kSCbasic::CheckUrlKeyValue("m","ReCheck","n") == 0) {
	ReCheck(kSCbasic::GetUrlKeyValue("c"),kSCbasic::GetUrlKeyValue("u"));
    } elsif (kSCbasic::CheckUrlKeyValue("m","AckSvc","n") == 0) {
	AckSvc(kSCbasic::GetUrlKeyValue("c"),kSCbasic::GetUrlKeyValue("u"),kSCbasic::GetUrlKeyValue("ar"),kSCbasic::GetUrlKeyValue("cm"));
    } elsif (kSCbasic::CheckUrlKeyValue("m","RemAckSvc","n") == 0) {
	RemAckSvc(kSCbasic::GetUrlKeyValue("c"),kSCbasic::GetUrlKeyValue("u"));
    } elsif (kSCbasic::CheckUrlKeyValue("m","ComSvc","n") == 0) {
	ComSvc(kSCbasic::GetUrlKeyValue("c"),kSCbasic::GetUrlKeyValue("u"),kSCbasic::GetUrlKeyValue("ar"),kSCbasic::GetUrlKeyValue("cm"));
    } elsif (kSCbasic::CheckUrlKeyValue("m","DwntmSvc","n") == 0) {
	DwntmSvc(kSCbasic::GetUrlKeyValue("c"),kSCbasic::GetUrlKeyValue("u"),kSCbasic::GetUrlKeyValue("ar"),kSCbasic::GetUrlKeyValue("cm"),kSCbasic::GetUrlKeyValue("ds"),kSCbasic::GetUrlKeyValue("de"));
    } elsif (kSCbasic::CheckUrlKeyValue("m","RemDwntmSvc","n") == 0) {
	RemDwntmSvc(kSCbasic::GetUrlKeyValue("c"),kSCbasic::GetUrlKeyValue("u"));
    } elsif (kSCbasic::CheckUrlKeyValue("m","DeacNotSvc","n") == 0) {
	DeacNotSvc(kSCbasic::GetUrlKeyValue("c"),kSCbasic::GetUrlKeyValue("u"));
    } elsif (kSCbasic::CheckUrlKeyValue("m","AcNotSvc","n") == 0) {
	AcNotSvc(kSCbasic::GetUrlKeyValue("c"),kSCbasic::GetUrlKeyValue("u"));
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
