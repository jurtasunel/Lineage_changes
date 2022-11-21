### This script requires an existing folder named Data with four files in it:
### 1- A GISAID fasta file terminated in .fasta or .fas
### 2- A GISAID patient status metadata tsv renamed with the tag A.tsv
### 3- A GSAID dates and locations metadata tsv renamed with the tag B.tsv
### 4- A GSAID metadata file that is downloaded as a .tar file, extracted and terminates in "metadata.tsv"

### Libraries.
library(RMariaDB) # package DBI-based for connection to MySQL.
library(DBI) # package for R-Databases communication.
library(seqinr) # package for handling fasta files into R.
library(readODS) # package to read ods libreoffice files into R.
library(lubridate) # Deal with date format.
library(seqinr)
library(gmailr) # Documetation: https://gmailr.r-lib.org/

### VARIABLES.
# Define constants for log into MySQL and access the Pango_Lineages database.
USER <- "XXXx"
PSW <- "XXXX"
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
datapath = "/home/gabriel/Desktop/Jose/Projects/Lineage_changes/Data/"
fasta_path = paste0(datapath, list.files(datapath, ".fas"))
fasta_file <- read.fasta(fasta_path, as.string = TRUE, forceDNAtolower = FALSE, set.attributes = FALSE)
metadata_path = paste0(datapath, list.files(datapath, "A.tsv"))
metadata_file <- read.table(metadata_path,  sep = "\t", header = TRUE, stringsAsFactors = FALSE)
subdate_path = paste0(datapath, list.files(datapath, "B.tsv"))
subdate_file <- read.table(subdate_path,  sep = "\t", header = TRUE, stringsAsFactors = FALSE)
sublab_path = paste0(datapath, list.files(datapath, "metadata.tsv"))
sublab_file <- read.table(sublab_path, sep = "\t", header = TRUE, stringsAsFactors = FALSE, quote = "£")
# Change names of Lineages and fasta IDs.
metadata_file$Lineage <- gsub(" (marker override based on Emerging Variants AA substitutions)", "", metadata_file$Lineage, fixed = TRUE)
for (i in 1:length(fasta_file)) {names(fasta_file)[i] <- unlist(strsplit(names(fasta_file)[i], "|", fixed = TRUE))[2]}



