#! /usr/bin/env bash

datasets='/Users/lkw/data-sets'

states="$datasets/misc/states.tab.gz"
fasta="$datasets/fasta/sample.fa"
cpg_bed="$datasets/bed/cpg.bed.gz"
sp1="$datasets/fastq/SP1.fq"
hamlet="$datasets/misc/hamlet.txt"
hg19genes="$datasets/bed/genes.hg19.bed.gz"
peaks="$datasets/bed/peaks.chr22.bed.gz"
lamina="$datasets/bed/lamina.bed"

# example script for highest pop
# answer_example=$(gzcat $states \
#        | grep -v '^#' \
#        | cut -f1,2 \
#        | sort -k2n \
#        | tail -n1 \
#        | cut -f1 \
#        | sed 's/"//g')

# echo "answer-example: $answer_example"

# Question 1 State with the lowest murders
answer_1=$(gzcat $states \
        | grep -v '^#' \
        | cut -f1,6 \
        | sort -k2n \
        | head -n1 \
        | cut -f1 \
        | sed 's/"//g')

echo "answer-1: $answer_1"

# Question 2 sequence records in the sample.fa file?
answer_2=$(grep '^>' $fasta \
        | wc -l)

echo "answer-2: $answer_2"

# Q3: How many unique CpG IDs are in cpg.bed.gz?
answer_3=$(gzcat $cpg_bed \
        | cut -f4 \
        | sort \
        | uniq \
        | wc -l )

echo "answer-3: $answer_3"

# Q4: How many sequence records are in the SP1.fq file?
answer_4=$(grep '@clu' $sp1 \
        | wc -l)

echo "answer-4: $answer_4"

# Q5: How many words are on lines containing the word bloody in
# hamlet.txt? (Hint: use wc to count words).
answer_5=$(grep -i 'bloody' $hamlet \
        | wc -w)

echo "answer_5: $answer_5"

# Q6: What is the length of the sequence in the first record of sample.fa?
# (Hint: use wc to count characters).
answer_6=$(head -2 $fasta | tail -1 | tr -d '\n' | wc -c)

echo "answer_6: $answer_6"
#alt solution: sed -n '2p' sample.fa | wc -c

# Q7: What is the name of the longest gene in genes.hg19.bed.gz?
answer_7=$(gzcat $hg19genes \ 
        | awk '{ print $4, $3 - $2 }' \
        | sort -k2nr \
        | head -n1 \
        | cut -f1 -d ' ' )

echo "answer_7: $answer_7"

# Q8: How many unique chromosomes are in genes.hg19.bed.gz?
answer_8=$(gzcat $hg19genes \
        | cut -f1 \
        | sort \
        | uniq \
        | wc -l)

echo "answer_8: $answer_8"

# Q9: How many intervals are associated with CTCF (not CTCFL) in
# peaks.chr22.bed.gz?
answer_9=$(gzcat $peaks \
        | grep -w "CTCF" \
        | wc -l )

echo "answer_9: $answer_9"

# Q10: On what chromosome is the largest interval in lamina.bed?
answer_10=$(awk '{print $1, $3-$2}' $lamina \
        | sort -k2nr \
        | head -n1 \
        | cut -f1 -d ' ')

echo "answer-10: $answer_10"
