#!/bin/bash

modeldir=output
text=text
outdir=bpe_out
num_bpes=4000

. parse_options.sh

mkdir -p $outdir

##cat $text | ./subword-nmt/subword_nmt/apply_bpe.py -c $modeldir/bpe_code.txt > $outdir/original.txt
##cat $text | sed "s= =\n=g" | grep . | sort | uniq > $outdir/words.txt

#phonetisaurus-apply --model g2p_model/model.fst --word_list $outdir/words.txt > $outdir/generated_lexicon.txt
#../Phonetisaurus/install/bin/phonetisaurus-align --input=$outdir/generated_lexicon.txt --ofile=$outdir/formatted.corpus --seq1_del=false
#cat $outdir/formatted.corpus | python3 extract.py > $outdir/new_lexicon.txt
#cat $text | python3 -u process_corpus.py $modeldir/new_lexicon.txt > $outdir/new_text.txt

#./subword-nmt/subword_nmt/learn_bpe_phonetic.py -s $num_bpes < $outdir/new_text.txt > $outdir/bpe_code_phonetic.txt
cat $text | python3 -u process_corpus.py $outdir/new_lexicon.txt | ./subword-nmt/subword_nmt/apply_bpe_phonetic.py -c $outdir/bpe_code_phonetic.txt > $outdir/new_bpe.txt

#cat $text | python3 -u process_corpus.py $modeldir/new_lexicon.txt | ./subword-nmt/subword_nmt/apply_bpe_phonetic.py -c $modeldir/bpe_code_phonetic.txt > $outdir/new_bpe.txt
#head $text | ./subword-nmt/subword_nmt/apply_bpe.py -c $dir/bpe_code_phonetic.txt
