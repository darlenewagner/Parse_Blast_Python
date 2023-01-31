# Parse_Blast_Python
Python and perl scripts for reading blastn output and manipulating text files for blast databases

### How to retrieve blastn hit IDs from a fasta
``` perl Retrieve_Contigs_from_Hits_tsv.pl blastnSearchDB.fasta blastnIDs.hits.tsv > CorrectSequences.assembly.fasta ```

### How to count top blastn hits from poliovirus, enterovirus, etc.
#### Script 1. Generic counts embedded in a bash loop
``` for f in Polio_Sequencing_Project/Results/*-Blast-NT.csv; do perl $HOME/Parse_Blast_Python/Picornavirus_Screen.pl < "$f" | cut -f1; done | wc -l ```
#### Script 2. Phyletic categorization count
``` perl Picornavirus_Breakdown.pl Pipeline_Samples_by_Date/BlastN_Results/ ```

