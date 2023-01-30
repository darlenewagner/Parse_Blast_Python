#!/usr/bin/perl -w
use strict;
use warnings;

#
# This perl script reads Blast output .csv files (one per sample) and counts 1 genome per first occurrence 
# of either Poliovirus, Enterovirus, Coxsackievirus, Picornavirus, Parechovirus, or Echovirus. This is an "exclusive or"
# For multiple input .csv files, the script tallies first occurence of corresponding virus, incrementing 1 per file
#

my ($polio, $entero, $coxsackie, $picorna, $parecho, $echo) = (0, 0, 0, 0, 0, 0);
my ($prePolio, $preEntero, $preCoxsackie, $prePicorna, $preParecho, $preEcho) = (0, 0, 0, 0, 0, 0);

my $directory = shift;

opendir(DIR, $directory) or die "Unable to open $directory $!";
my @Files = grep { ( /.+-Blast-NT\.csv/ ) && "$directory/$_" } readdir(DIR);
closedir(DIR);  

print($directory, "\n");

my $f = 0;

foreach my $file_name ( @Files ) {
    
    $file_name = $directory.$file_name;
    
    open (FILE, $file_name) or die "Could not open file '$file_name' $!";

    #print($file_name, "\n");
    
    while(<FILE>) {
	 
    if($_ =~ /Poliovirus/i)
       {
       #print $_;
       $prePolio = $polio;
       $polio++;
       last;
       }
    elsif($_ =~ /Enterovirus/i)
       {
        #print $_;
        $preEntero = $entero;
        $entero++;
        last;
       }
    elsif($_ =~ /Coxsackievirus/i)
       {
        #print $_;
        $preCoxsackie = $coxsackie;
        $coxsackie++;
        last;
       } 
    elsif($_ =~ /Picornavirus/i)
       {
        #print $_;
        $prePicorna = $picorna;
        $picorna++;
        last;
       }
    elsif($_ =~ /Parechovirus/i)
       {
         #print $_;
         $preParecho = $parecho;
         $parecho++;
         last; 
       }
    elsif($_ =~ /Echovirus/i)
       {
         #print $_;
         $preEcho = $echo;
         $echo++;
         last;
       }
    $f++;
   }

    close(FILE);

}

print("Poliovirus\t".$polio."\nEnterovirus\t".$entero."\nCoxsackievirus\t".$coxsackie."\nPicornavirus\t".$picorna."\nParechovirus\t".$parecho."\nEchovirus\t".$echo."\n");

exit;
