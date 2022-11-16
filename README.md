# Lineage_changes

By running the Pango_Lineages.sh, this set of scripts produces a report on csv format with the lineages that have canged on the last update of pangolin.
Pango_Lineages.sh calls pangolin_update.sh to update pangolinf first, then initializes conda and finally calls Pango_Lineages.R to do the rest of the analysis. It then finishes moving the resulting report "Lineage_change_DATE.csv" to a Reports folder. 
Pango_Lineages.R uses the constants that exist on the Pango_Lineages_source.R and sends an email with the "Lineage_change_DATE.csv" attached.
In order to find the input files, Pango_Lineages_source.R requires the input files in specific format specified on the header of the script.
This scripts work by updating a mysql database with only one table. The structure of that database is on the Pango_Lineages_DB.txt file.
