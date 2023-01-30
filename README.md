# Parse_Blast_Python
python scripts for reading blastn output and manipulating text files for blast databases

### How to retrieve blastn hit IDs from a fasta
``` perl Retrieve_Contigs_from_Hits_tsv.pl blastnSearchDB.fasta blastnIDs.hits.tsv > CorrectSequences.assembly.fasta ```

### How to count top blastn hits from poliovirus, enterovirus, etc.
``` perl Picornavirus_Breakdown.pl Pipeline_Samples_by_Date/BlastN_Results/ ```

