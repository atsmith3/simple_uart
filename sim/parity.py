#!/usr/bin/python3

import sys


for i in list(range(2**9)):
  print(i)
  parity = 0
  print("{:09b}".format(i))
  for shift in range(9):
    bitmask = 1 << shift
    #print("{:09b}".format(bitmask))
    parity += (i & bitmask) >> shift
  parity = parity%2
  print(parity)

  parity_a = 0
  for shift in range(9):
    bitmask = 1 << shift
    #print("{:09b}".format(bitmask))
    parity_a ^= (i & bitmask) >> shift
  print(parity_a)

  if parity != parity_a:
    print("ERROR")
    sys.exit()
