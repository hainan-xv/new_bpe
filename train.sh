#!/bin/bash

dict=lexicon.txt
text=text

modeldir=output

mkdir -p $modeldir

#text | python3 -u process_corpus.py $modeldir/new_lexicon.txt. parse_options.sh
#
#cat $dict | awk '{printf("%s\t", $1); for(i=2;i<=NF;i++) printf("%s ", $i); print""}' | sed "s= $==g" > $modeldir/lexicon.txt
#../Phonetisaurus/install/bin/phonetisaurus-align --input=$modeldir/lexicon.txt --ofile=$modeldir/formatted.corpus --seq1_del=false
#
#cat $modeldir/formatted.corpus | python3 extract.py > $modeldir/new_lexicon.txt
#
#cat $text | python3 -u process_corpus.py $modeldir/new_lexicon.txt > $modeldir/text.processed
#
#./subword-nmt/subword_nmt/learn_bpe.py -s $num_bpes < $text > $modeldir/bpe_code.txt
#./subword-nmt/subword_nmt/learn_bpe_phonetic.py -s $num_bpes < $modeldir/text.processed > $modeldir/bpe_code_phonetic.txt

cat $dict | awk '{printf("%s\t",$1);for(i=2;i<=NF;i++) printf("%s ", $i); print("")}' > $dict.formatted

../Phonetisaurus/install/bin/phonetisaurus-train --lexicon $dict.formatted --seq2_del

mv train g2p_model
