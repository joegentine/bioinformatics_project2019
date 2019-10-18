#script to determine pH resistant methanogenic
#The directories in this script for hmmer and muscle programs should be specified before running the script. 
#The final outputs of the script are hsp_wmcra.out (proteomes of interest) and hsp_hits.out (summary table)


#combine sample mcrAgene fastas into one fasta 
cat ./ref_sequences/mcr* > ./ref_sequences/mcr_all.fasta
	

#preform a muscle alignment on the fastas
./muscle -in ./ref_sequences/mcr_all.fasta -out ./ref_sequences/mcr.afa
rm ./ref_sequences/mcr_all.fasta	

#Execute hmmbuild on aligned fasta 
./hmmer/bin/hmmbuild -o ./ref_sequences/mcr_hmmSummary.txt ./ref_sequences/mcr.hmm ./ref_sequences/mcr.afa
rm ./ref_sequences/mcr.afa

#make a directory for hsp hmmsearch output	

#search proteommes for hsp gene
cd proteomes

for file in proteome_*
 do
 ../hmmer/bin/hmmsearch ../ref_sequences/mcr.hmm $file > ./test/$file.out
 done

cd ..

rm ./ref_sequences/mcr.hmm  ./ref_sequences/mcr_hmmSummary.txt  

cd proteomes/test

rm ../../mcra_hits.out

#counts number of genes in each file 
for file in proteome_*
do 
mcrA_hits=$(grep ">>" $file | wc -l)
echo "$file , $mcrA_hits" >> ../../mcra_hits.out 
done

cd ../..
 
#combine sample mcrAgene fastas into one fasta 
cat ./ref_sequences/hsp* > ./ref_sequences/hsp_all.fasta
	

#preform a muscle alignment on the fastas
./muscle -in ./ref_sequences/hsp_all.fasta -out ./ref_sequences/hsp.afa
rm ./ref_sequences/hsp_all.fasta	

#Execute hmmbuild on aligned fasta 
./hmmer/bin/hmmbuild -o ./ref_sequences/hsp_hmmSummary.txt ./ref_sequences/hsp.hmm ./ref_sequences/hsp.afa
rm ./ref_sequences/hsp.afa

#make a directory for hsp hmmsearch output	

#search proteommes for hsp gene
cd proteomes

for file in proteome_*
 do
 ../hmmer/bin/hmmsearch ../ref_sequences/hsp.hmm $file > ./test2/$file.out
 done

cd ..

rm ./ref_sequences/hsp.hmm  ./ref_sequences/hsp_hmmSummary.txt  

cd proteomes/test2

rm ../../hsp_hits.out
rm ../../hsp_sorted.out
rm ../../hsp_wmcra.out

#counts number of genes in each file  
for file in proteome_*
do
hsp_hits=$(grep ">>" $file | wc -l)
mcra_hits=$(cat ../../mcra_hits.out | grep "$file" | cut -d , -f 2)
echo "$file , $mcra_hits , $hsp_hits" >> ../../hsp_hits.out
done

#Orders files by number of hits of the hsp gene. The readout is file name, number of mcrAgenes, number of hsp genes
cat ../../hsp_hits.out | sort -t , -k 3 -n -r > ../../hsp_sorted.out
 
cat ../../hsp_sorted.out | grep -v "0 ," > ../../hsp_wmcra.out
