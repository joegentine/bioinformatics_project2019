for file in proteome_*
do 
echo "$file" >> proteomoe_search.out 
../../hmmer/bin/hmmsearch ../ref_sequences/mcrA.hmm $file | head -n 25 >> proteome_search.out 
done 
