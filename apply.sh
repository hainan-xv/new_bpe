#!/bin/bash

modeldir=output
text=text
outdir=bpe_out

num_bpes=400

. parse_options.sh

mkdir -p $outdir

cat $text | sed "s= =\n=g" | grep . > $outdir/words.txt

phonetisaurus-apply --model g2p_model/model.fst --word_list $outdir/words.txt --lexicon lexicon.txt.formatted > $outdir/generated_lexicon.txt
../Phonetisaurus/install/bin/phonetisaurus-align --input=$outdir/generated_lexicon.txt --ofile=$outdir/formatted.corpus --seq1_del=false --seq2_del=false

cat $outdir/formatted.corpus | python3 extract.py > $outdir/new_lexicon.txt
cat $text | python3 -u process_corpus.py $outdir/new_lexicon.txt > $outdir/new_text.txt

./subword-nmt/subword_nmt/learn_bpe_phonetic.py -s $num_bpes < $outdir/new_text.txt > $outdir/bpe_code_phonetic.txt
./subword-nmt/subword_nmt/learn_bpe.py -s $num_bpes < $text > $outdir/bpe_code.txt

cat $text | python3 -u process_corpus.py $outdir/new_lexicon.txt | ./subword-nmt/subword_nmt/apply_bpe_phonetic.py -c $outdir/bpe_code_phonetic.txt > $outdir/new_bpe.txt
cat $text | ./subword-nmt/subword_nmt/apply_bpe.py -c $outdir/bpe_code.txt > $outdir/old_bpe.txt

