#!/usr/bin/python3

import sys
import argparse

parser = argparse.ArgumentParser(description='args.')
parser.add_argument('--no_sil_phone', dest='no_sil_phone', action='store_true',
                                            help='no sil')
args = parser.parse_args()

for line in sys.stdin:
#  letter_str = " "
#  phone_str = " "
  letter_str = ""
  phone_str = ""
  for pair in line.strip().split():
    letter, phone = pair.split("}")
#    if args.no_sil_phone and phone == "_": # a silence
#      letter_str += "#"
#      phone_str  += "#"
    letter_str += letter + " "
    phone_str  += phone  + " "

#  letter_str = letter_str.replace(" #", "")
#  phone_str = phone_str.replace(" #", "")
      
  whole_letter = letter_str.replace(" ","").replace("|","")
  print (whole_letter + "\t" + letter_str.replace("|","").strip())
#  print (whole_letter, "\t", letter_str.replace("|",""), "\t", phone_str)
