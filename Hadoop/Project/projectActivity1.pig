-- Load input file from HDFS
inputFile = LOAD 'hdfs:///user/anup/Input' USING PigStorage('\t')  AS (characters,dialogues) ;
-- Filter out first two lines
ranked = RANK inputFile;
OnlyDialogues = FILTER ranked BY (rank_inputFile > 2);
-- Group data using the character column
grpd = GROUP inputFile BY characters;
-- Count the occurence of each group (Reduce)
totalCount = FOREACH grpd GENERATE $0 AS name, COUNT($1) AS no_of_lines;
result= ORDER totalCount BY no_of_lines DESC; 
rmf hdfs:///user/anup/output_files/pigOutput;
-- Store the result in HDFS
STORE result INTO 'hdfs:///user/anup/output_files/pigOutput';
