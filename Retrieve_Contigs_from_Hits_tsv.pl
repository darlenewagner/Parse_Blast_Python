#!/usr/bin/perl -w
use strict;

#
# This script takes blastn output of raw assembly searches (tab-delimited) 
# and retrieves only the fasta records matching IDs from blastn hits
### Program to create .fasta input file: ###
# makeblastdb -dbtype nucl -in out_SPAdes3.15/i3015821199_S9.fasta -out out_SPAdes3.15/i3015821199_S9
#
### Program to produce IDs input file: ###
# blastn -query ../../reference_Human_Poliovirus_Sabin_2/AY184220.1.fasta -db out_SPAdes3.15/3015821227_S13 
# -evalue 1e-97 -outfmt '6 saccver' > out_SPAdes3.15/list_3015821227_S13.tsv
### Program to remove duplicates from IDs input: ###
# sort out_SPAdes3.15/list_3015821227_S13.tsv | uniq | wc -l
#

my $Fasta = $ARGV[0];
my $IDs = $ARGV[1];

open(FAS, $Fasta) || die "Can't find assembly.fasta file, $Fasta $!";
open(IDS, $IDs) || die "Can't find blastn output IDs file, $IDs $!";

my @Fasta = <FAS>;
my @IDs = <IDS>;

my $jj = 0;
my $hit = 0;

foreach(@Fasta)
{
  if($Fasta[$jj] =~ /^>/)
  {
      my $ii = 0;
      $hit = 0;      
      foreach(@IDs)
      {
       if($Fasta[$jj] =~ m/$IDs[$ii]/)
        {
	    print($Fasta[$jj]);
            $hit = 1;
      	 #  print($IDs[$ii], " = ", $Fasta[$jj]);
	 #  print($ii, " ", $jj, "\n");
        }
        $ii++;
       }
  }
  elsif(($Fasta[$jj] =~ /^(A|T|G|C|N)/i) && ($hit == 1))
  {
      print($Fasta[$jj]);
  }

  $jj++;
}
