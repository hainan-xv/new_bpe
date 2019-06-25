#!/bin/bash

dict=lexicon.txt
text=text

modeldir=g2p_model

cat $dict | awk '{printf("%s\t",$1);for(i=2;i<=NF;i++) printf("%s ", $i); print("")}' > $dict.formatted

#../Phonetisaurus/install/bin/phonetisaurus-train --lexicon $dict.formatted
../Phonetisaurus/install/bin/phonetisaurus-train --lexicon $dict.formatted --seq2_del

mv train $modeldir
