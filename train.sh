#!/bin/bash

dict=lexicon.txt
text=text

modeldir=output
num_bpes=4000

. parse_options.sh

mkdir -p $modeldir

cat $dict | awk '{printf("%s\t", $1); for(i=2;i<=NF;i++) printf("%s ", $i); print""}' | sed "s= $==g" > $modrldir/lexicon.txt
../Phonetisaurus/install/bin/phonetisaurus-align --input=$modrldir/lexicon.txt --ofile=$modeldir/formatted.corpus --seq1_del=false

cat $modeldir/formatted.corpus | python3 extract.py > $modeldir/new_lexicon.txt

cat $text | python3 -u process_corpus.py $modeldir/new_lexicon.txt > $modeldir/text.processed

./subword-nmt/subword_nmt/learn_bpe.py -s $num_bpes < $text > $modeldir/bpe_code.txt
./subword-nmt/subword_nmt/learn_bpe_phonetic.py -s $num_bpes < $modeldir/text.processed > $modeldir/bpe_code_phonetic.txt

#cat $text | ./subword-nmt/subword_nmt/apply_bpe.py -c $dir/bpe_code.txt > $dir/original.txt
#echo
#cat $dir/text.processed | ./subword-nmt/subword_nmt/apply_bpe_phonetic.py -c $dir/bpe_code_phonetic.txt > $dir/new_bpe.txt
#head $text | ./subword-nmt/subword_nmt/apply_bpe.py -c $dir/bpe_code_phonetic.txt
