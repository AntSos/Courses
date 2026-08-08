# Write tests.tsv to a new .csv file analysis.csv, retain all columns in tests.tsv with the following updates.
# Read the file.
file <- read.delim("tests.tsv", header=T)
# Convert the gender column from a numeric representation to a textual representation.
# Gender code vector.
gender <- c("0" = "Unanswered",
             "1" = "Male",
             "2" = "Female",
            "3" = "Other"
            )
# Use gender vector to change the value in gender files column.
file$gender <- gender[as.character(file$gender)]
# Add extroversion column, sum E1, E2 and E3 values and divide by 15, then round to 2 digits.
file$extroversion <- round(rowSums(file[,c("E1", "E2", "E3")], na.rm=TRUE) / 15, digits=2)
# Add neuroticism column, sum N1, N2 and N3 values and divide by 15, then round to 2 digits.
file$neuroticism <- round(rowSums(file[,c("N1", "N2", "N3")], na.rm=TRUE) / 15, digits=2)
# Add agreeableness column, sum A1, A2 and A3 values and divide by 15, then round to 2 digits.
file$agreeableness <- round(rowSums(file[,c("A1", "A2", "A3")], na.rm=TRUE) / 15, digits=2)
# Add conscientiousness column, sum C1, C2 and C3 values and divide by 15, then round to 2 digits.
file$conscientiousness <- round(rowSums(file[,c("C1", "C2", "C3")], na.rm=TRUE) / 15, digits=2)
# Add openness column, sum C1, C2 and C3 values and divide by 15, then round to 2 digits.
file$openness <- round(rowSums(file[,c("O1", "O2", "O3")], na.rm=TRUE) / 15, digits=2)
# Write analysis.csv file.
write.csv(file, "analysis.csv")