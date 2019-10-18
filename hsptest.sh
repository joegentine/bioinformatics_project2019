#combine sample mcrAgene fastas into one fasta 
cat ./ref_sequences/hsp* > ./ref_sequences/hsp_all.fasta
	

#preform a muscle alignment on the fastas
../muscle -in ./ref_sequences/hsp_all.fasta -out ./ref_sequences/hsp.afa
rm ./ref_sequences/hsp_all.fasta	

#Execute hmmbuild on aligned fasta 
hmmbuild -o ./ref_sequences/hsp_hmmSummary.txt ./ref_sequences/hsp.hmm ./ref_sequences/hsp.afa
rm ./ref_sequences/hsp.afa

#make a directory for hsp hmmsearch output	

#search proteommes for hsp gene
cd proteomes

for file in proteome_*
 do
 hmmsearch ../ref_sequences/hsp.hmm $file >> ./test2/$file.out
 done

cd ..

rm ./ref_sequences/hsp.hmm  ./ref_sequences/hsp_hmmSummary.txt  

cd proteomes/test2

#counts number of genes in each file 
for file in proteome_*
do 
echo "$file" >> ../../tempfile.out
grep ">>" $file | wc -l >> ../../tempfile.out 
done 
