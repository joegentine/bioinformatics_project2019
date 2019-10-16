for file in proteome_*
do
hmmsearch ../ref_sequences/mcrA.hmm $file > ./test/$file.out
done

