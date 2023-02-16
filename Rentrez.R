#Part 1 
#Make a vector that contains 3 IDs 
ncbi_ids <- c("HQ433692.1","HQ433694.1","HQ433691.1")

#Loading libraries 
library(rentrez)  # you may need install.packages first

#Extracts indormation for IDs
Bburg<-entrez_fetch(db = "nuccore", id = ncbi_ids, rettype = "fasta")
print(Bburg)

#create object called sequences 
Sequences = strsplit(Bburg, "\n\n")
print(Sequences)

#Creating a data frame
Sequences<-unlist(Sequences)

#Separate the sequences from the headers 
header<-gsub("(^>.*sequence)\\n[ATCG].*","\\1",Sequences)
seq<-gsub("^>.*sequence\\n([ATCG].*)","\\1",Sequences)
Sequences<-data.frame(Name=header,Sequence=seq)

#Removing the newline characters from the sequences data frame using regular expressions
Sequences$Sequence=gsub("\n","",Sequences$Sequence)

#Outputting
write.csv(Sequences, "Sequences.csv")
