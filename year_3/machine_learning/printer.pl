#!/usr/bin/perl -w

$string='age,sex,height,weight,QRSduration,P-Rinterval,Q-Tinterval,Tinterval,Pinterval,QRS,T,P,QRST,J,Heartrate';
@chanels = ('DI','DII', 'DIII', 'AVR','AVL','AVF','V1','V2','V3','V4','V5','V6');
@attrs=('Qwave','Rwave','Swave','RPRIMEwave','SPRIMEwave','NumberOfintrinsicDeflections','ExistenceOfRaggedRwave','ExistenceOfDiphasicDerivationOfRWave','ExistenceOfRaggedPWave','ExistenceOfDiphasicDerivationOfPWave','ExistenceOfRaggedTWave','ExistenceOfDiphasicDerivationOfTWave');
@calculations=('JJwave','Qwave','Rwave','Swave','RPRIMEwave','SPRIMEwave','Pwave','Twave','QRSA','QRSTA');

for $channel (@chanels){
	for $attr(@attrs){
		$string .= ",$channel-$attr";
	}
}

for $channel (@chanels){
	for $calc(@calculations){
		$string .= ",$channel"."Amplitude01MilivoltOf$calc";
	}
}
$string .= ',class';

foreach (@ARGV){
	if ( $_ eq 'tf' ){ titlesfile(); }
	elsif ($_ eq 'wp'){ wekaparams(); }
	else{
		print "Usage : printer.pl [tf for titles file | wp for wekaparams]\n"
	}
}

sub titlesfile{
	open(MYFILE,'>titles');
	print MYFILE $string."\n" ;
	close(MYFILE);
}

sub wekaparams{
	our $string ;
	@arr = split(/,/, $string);
	print '@relation HeartDiseasesDB'."\n";
	foreach (@arr){
		print '@attribute '."$_ real\n" if $_ ne 'class' ;
	}
	print '@attribute class {1,2,3,4,5,6,7,8,9,10,14,15,16}'."\n";
	print '@data'."\n";
}
