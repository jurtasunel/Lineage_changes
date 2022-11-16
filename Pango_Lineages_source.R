### Libraries.
library(RMariaDB) # package DBI-based for connection to MySQL.
library(DBI) # package for R-Databases communication.
library(seqinr) # package for handling fasta files into R.
library(readODS) # package to read ods libreoffice files into R.
library(lubridate) # Deal with date format.
library(seqinr)
library(gmailr) # Documetation: https://gmailr.r-lib.org/

### VARIABLES.
# Define constants for log into MySQL and access the NVRL_FLU database.
USER <- "NVRL"
PSW <- "Abm@Hs4#6xj3"
DB_NAME <- "Pango_Lineages"
HOST <- "localhost"
# Define global variable for MySQL connection.
con_sql = NULL;

### FUNCTIONS.
# Connect to MySQL Database.
db_connect <- function(){
  con_sql <<- dbConnect(RMariaDB::MariaDB(),
                        user = USER,
                        password = PSW,
                        dbname = DB_NAME,
                        host = HOST);
}
# Disconnect from MySQL Database. 
db_disconnect <- function(){
  dbDisconnect(con_sql);
}

# Read the fasta file and metadata files.
fasta_path = "/home/gabriel/Desktop/Jose/Projects/Lineage_changes/Data/gisaid_hcov-19_2022_11_11_12.fasta"
fasta_file <- read.fasta(fasta_path, as.string = TRUE, forceDNAtolower = FALSE, set.attributes = FALSE)
metadata_path = "/home/gabriel/Desktop/Jose/Projects/Lineage_changes/Data/gisaid_hcov-19_2022_11_11_12.tsv"
metadata_file <- read.table(metadata_path,  sep = '\t', header = TRUE, stringsAsFactors = FALSE)
subdate_path = "/home/gabriel/Desktop/Jose/Projects/Lineage_changes/Data/gisaid_hcov-19_2022_11_11_12(1).tsv"
subdate_file <- read.table(subdate_path,  sep = '\t', header = TRUE, stringsAsFactors = FALSE)
# Change names of Lineages and fasta IDs.
metadata_file$Lineage <- gsub(" (marker override based on Emerging Variants AA substitutions)", "", metadata_file$Lineage, fixed = TRUE)
for (i in 1:length(fasta_file)) {names(fasta_file)[i] <- unlist(strsplit(names(fasta_file)[i], "|", fixed = TRUE))[2]}




