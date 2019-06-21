#!/usr/bin/python3

import sys
import argparse

parser = argparse.ArgumentParser(description='args.')
parser.add_argument('lexicon', type=str,
                                            help='lexicon')

args = parser.parse_args()

# getting dictionary
lexicon = {}
map_file = open(args.lexicon)
for line in map_file:
  word, pronunciation = line.strip().split("\t")
  word = word.strip()
  if word not in lexicon.keys(): # only takes the first, most common pronunciation
    lexicon[word] = pronunciation
#  print(word, pronunciation)
# print (lexicon)

for line in sys.stdin:
  this_line_out = ""
  for word in line.strip().split():
    pronun = lexicon.get(word, "")
    if pronun != "":
      this_line_out += pronun + "\t"
#      this_line_out += pronun + " </w>\t"
  print (this_line_out.strip())
