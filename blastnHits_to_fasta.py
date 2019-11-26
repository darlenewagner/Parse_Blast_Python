#!/usr/bin/python

import sys
import os
import os.path
import argparse
import re
import string
import logging
import warnings

## simpleFastaStats.py takes a single fasta-formatted DNA/RNA text file and
## outputs contig count, average contig length, N50 contig lengths, maximum contig length, and cumulative contig length

## Function: A closure for file extension checking
def ext_check(expected_ext, openner):
        def extension(filename):
                if not filename.lower().endswith(expected_ext):
                        raise ValueError()
                return openner(filename)
        return extension

## Function: Filename extractor from filepath
def getIsolateID(filePathString):
    splitStr = re.split(pattern='/', string=filePathString)
    fileNameIdx = len(splitStr) - 1
    isolateString = re.split(pattern='\.', string=splitStr[fileNameIdx])
    if(len(isolateString[0]) < 10):
        isolateString = re.split(pattern='\.', string=splitStr[0])
    return isolateString[0]

parser = argparse.ArgumentParser(description='output multifasta file of sequences aligned to blastn query', usage="blastnHits_to_fasta.py filepath/blastout.txt")

parser.add_argument("filename",type=ext_check('.txt', argparse.FileType('r')))

#parser.add_argument("--minLength", '-min', default='500', type=int)

#parser.add_argument("--format", default='brief', type = lambda s : s.lower(), choices=['tsv', 'csv', 'brief', 'verbose', 'verbose_tsv', 'c', 's', 'b', 'v', 'vt'])

args = parser.parse_args()

## call function to extract filename/isolate from inFilePath
inFileName = getIsolateID(args.filename.name)

## Open input file
filehandle = open(args.filename.name, 'r')

inAlign = 0

for line in filehandle:
        if(re.search(r'^>\s', line)):
                #print(line.rstrip(), end='')
                heading = line.rstrip()
                #print(">", end='')
                #print(heading[2:len(heading)-2])
        elif(re.search(r'Strand=', line)):
                if(re.search(r'Plus/Plus', line)):
                       print('>' + heading[2:len(heading)-2] + '+')
                else:
                       print('>' + heading[2:len(heading)-2] + '-')
        elif(re.search(r'^Sbjct', line)):
                nucleotides = line.split('  ')
                print(nucleotides[2])
