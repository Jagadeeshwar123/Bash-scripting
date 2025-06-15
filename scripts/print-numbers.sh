#!/bin/bash


echo "printing numbers from 1 to 100 which are divisible by 3 & 5 and not 15"
  for ((i = 1; i<100; i++))
  do
    if (( (i % 3 ==0 || i % 5 ==0) && i % 15 !=0))
    then
      echo $i
    fi
  done

