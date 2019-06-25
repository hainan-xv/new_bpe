#!/bin/bash

modeldir=output
text=text
outdir=bpe_out

num_bpes=4000
stage=1

. parse_options.sh

mkdir -p $outdir/$num_bpes

cat $text | sed "s= =\n=g" | grep . > $outdir/words.txt

if [ ! -f $outdir/new_text.txt ]; then
  phonetisaurus-apply --model g2p_model/model.fst --word_list $outdir/words.txt --lexicon lexicon.txt.formatted > $outdir/generated_lexicon.txt
  ../Phonetisaurus/install/bin/phonetisaurus-align --input=$outdir/generated_lexicon.txt --ofile=$outdir/formatted.corpus --seq1_del=false --seq2_del=false

  cat $outdir/formatted.corpus | python3 extract.py > $outdir/new_lexicon.txt
  cat $text | python3 -u process_corpus.py $outdir/new_lexicon.txt > $outdir/new_text.txt
fi

if [ $stage -le 1 ]; then
  ./subword-nmt/subword_nmt/learn_bpe_phonetic.py -s $num_bpes < $outdir/new_text.txt > $outdir/$num_bpes/bpe_code_phonetic.txt
  ./subword-nmt/subword_nmt/learn_bpe.py -s $num_bpes < $text > $outdir/$num_bpes/bpe_code.txt

  cat $text | python3 -u process_corpus.py $outdir/new_lexicon.txt | ./subword-nmt/subword_nmt/apply_bpe_phonetic.py -c $outdir/$num_bpes/bpe_code_phonetic.txt > $outdir/$num_bpes/new_bpe.txt
  cat $text | ./subword-nmt/subword_nmt/apply_bpe.py -c $outdir/$num_bpes/bpe_code.txt > $outdir/$num_bpes/old_bpe.txt
fi

if [ $stage -le 2 ]; then
  head -n 1000 $outdir/$num_bpes/new_bpe.txt > $outdir/$num_bpes/new_bpe.txt.head
  head -n 1000 $outdir/$num_bpes/old_bpe.txt > $outdir/$num_bpes/old_bpe.txt.head
fi
