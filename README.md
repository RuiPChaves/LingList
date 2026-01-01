# LingList

To plot and tally LingList posts, download the data at http://listserv.linguistlist.org/pipermail/linglite/, decompress it to a folder named /email, run the python script 'script.py', and run the R file 'jobsgraph.r'. 

Example (this script is *not* optimized in any shape or form):

$ python3 script.py 0

The '0' corresponds to 'Professor' tallies. Run 'python3.9 script.py 1' for PostDoc tallies, python3.9 script.py 2 for the general tally.

Python code was orginally written by Tom Juzek (https://github.com/superpumpie/when_will_there_be_jobs) in 2017 for Python 2, and later adapted to Python 3 and expanded by Rui Chaves (2019-2025). All R code by Rui Chaves. 
  
Most job posts mention multiple specializations (e.g. Phonetics/Phonology, or Syntax/Semantics, or Computational [field]), which means that the jobs tallied here the number of opportunities, from the applicants' perspective, and are inflated relative to the true number of job positions. By default, the script counts only positions that mention "Professor". There are too many categories for colour-blind compatible palletes to handle, and therefore the areas with the least job posts are filtered out in the R file.
  
To tally all job posts, regardless of area, run:

$ bash raw_jobs.sh

This will generate a data file "raw_jobs.csv", which can be plotted via "raw_jobsgraph.r". The Bash code "raw_jobs.sh" extracts raw job post tallies, per year. Please note that some job posts announce multiple positions.
