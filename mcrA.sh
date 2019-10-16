cat mcr* > mcrA.fasta

./muscle -in ./bioinformatics_project2019/ref_sequences/mcrAgene.fasta -out ./bioinformatics_project2019/ref_sequences/mcrA.afa

hmmbuild -o mcrA_hmmSummary.txt mcrA.hmm mcrA.afa

mkdir mcrA
mv mcrA* mcrA

hmmsearch ./ref_sequences/mcrA/mcrA.hmm ./proteomes/proteome_1
