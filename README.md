# LingList

To plot and tally LingList posts, download the data at http://listserv.linguistlist.org/pipermail/linglite/, decompress it to a folder named /email, run the python script, and run the R file. 

This script is *not* optimized in any shape or form.

Python code was orginally written by Tom Juzek (https://github.com/superpumpie/when_will_there_be_jobs) in 2017 for Python 2, and later adapted to Python 3 and expanded by Rui Chaves (2019-2021). All R code by Rui Chaves. 

* To tally job posts per area use "script.py" to generate a data file which can be plotted via "jobsgraph.r". The script defaults to 'Professor' tallies (i.e. "python3.6 script.py"), but computes 'Postdoc' tallies if "1" is passed as an argument (i.e. "python3.9 script.py 1"), and general tallies (regardless of rank) with "2" as argument (i.e. "python3.9 script.py 2"). 
  
  Most job posts mention multiple specializations (e.g. Phonetics/Phonology, or Syntax/Semantics, or Computational [field]), which means that the jobs tallied here the number of opportunities, from the applicants' perspective, and are inflated relative to the true number of job positions. By default, the script counts only positions that mention "Professor". There are too many categories for colour-blind compatible palletes to handle, and therefore the areas with the least job posts are filtered out in the R file.
  
* To tally all job posts, regardless of area, use "raw_jobs.sh" to generate a data file "raw_jobs.csv", which can be plotted via "raw_jobsgraph.r".
  The Bash code "raw_jobs.sh" extracts raw job post tallies, per year, avoiding the inflation described above.
