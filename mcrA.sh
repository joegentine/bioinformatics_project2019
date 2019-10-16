#combine sample mcrAgene fastas into one fasta 
cat mcr* > mcrA.fasta

#preform a muscle alignment on the fastas
./muscle -in ./bioinformatics_project2019/ref_sequences/mcrAgene.fasta -out ./bioinformatics_project2019/ref_sequences/mcrA.afa

#Execute hmmbuild on aligned fasta 
hmmbuild -o mcrA_hmmSummary.txt mcrA.hmm mcrA.afa

#Organize into single directory 
mkdir mcrA
mv mcrA* mcrA

#search proteommes for mcrAgene
hmmsearch ./ref_sequences/mcrA/mcrA.hmm ./proteomes/proteome_1
