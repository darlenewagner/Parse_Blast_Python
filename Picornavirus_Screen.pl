#!/usr/bin/perl -w
use strict;

# This perl script reads Blast output .csv files (one per sample) and counts 1 genome per first occurrence 
# of either Poliovirus, Enterovirus, Coxsackievirus, or Picornavirus. This is an "exclusive or"
# for i in $FOLDER; do for f in "$i"/Alignment_Results/*Blast-NT.csv; do if grep -li "Poliovirus" "$f"; then echo "Pol";  
# elif grep -li "Coxsackievirus" "$f" && grep -Li "Poliovirus" "$f"; then echo "Cox"; 
# elif grep -li "Enterovirus" "$f" && grep -Li "Poliovirus"; then echo "Ent"; fi; done; done
#

my ($polio, $entero, $coxsackie, $picorna, $parecho, $echo) = (0, 0, 0, 0, 0, 0);

while(<STDIN>)
{

  if(($polio == 1) || ($entero == 1) || ($coxsackie == 1) || ($picorna == 1) || ($parecho == 1) || ($echo == 1))
   {
      exit;
   }
  elsif($_ =~ /Poliovirus/i)
   {
       print $_;
       $polio = 1;
   }
  elsif($_ =~ /Enterovirus/i)
   {
      print $_;
      $entero = 1;
   }
  elsif($_ =~ /Coxsackievirus/i)
   {
       print $_;
       $coxsackie = 1;
   } 
  elsif($_ =~ /Picornavirus/i)
   {
       print $_;
       $picorna = 1;
   }
  elsif($_ =~ /Parechovirus/i)
   {
       print $_;
       $parecho = 1; 
   }
  elsif($echo =~ /Echovirus/i)
   {
       print $_;
       $echo = 1;
   }

}

exit;
