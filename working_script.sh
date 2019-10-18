#combine sample mcrAgene fastas into one fasta 
cat ./ref_sequences/mcr* > mcrA.fasta

#preform a muscle alignment on the fastas
./muscle -in ./ref_sequences/mcrA.fasta -out ./ref_sequences/mcrA.afa

#Execute hmmbuild on aligned fasta 
hmmbuild -o mcrA_hmmSummary.txt mcrA.hmm mcrA.afa

#Organize into single directory 
mkdir mcrA
mv mcrA* mcrA

#search proteommes for mcrAgene

mkdir mcrAmatches

for file in ./proteomes/proteom* 
do
hmmsearch ./mcrA.hmm $file > ./mcrAmatches/$file.out 
done

#counts number of genes in each file
for file in ./mcrAmatches/proteome_*.fasta.out
do
echo "$file" >> summary.file
echo "mcrAgene count"
grep ">>" $file | wc -l >> summary.file
done

 
