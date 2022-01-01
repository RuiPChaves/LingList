# LingList
To plot and tally LingList posts, download the data at http://listserv.linguistlist.org/pipermail/linglite/ and decompressed it into an /email folder.

Python code was orginally written by Tom Juzek (http://tsjuzek.com/blog/jobs_in_linguistics.html) for Python 2 (2017), and later adapted to Python 3 and expanded by Rui Chaves (2019-2021). All R code by Rui Chaves. 

* To tally (Professor or Postdoc) job posts per area use "script.py" to generate a data file "jobs.csv", which can be plotted via "jobsgraph.r".
  This script is not optimized in any shape or form.
  
  Most job posts mention multiple specializations (e.g. Phonetics/Phonology, or Syntax/Semantics, or Computational [field]), which means that the jobs tallied here the number of opportunities, from the applicants' perspective, and are inflated relative to the true number of job positions. By default, the script counts only positions that mention "Professor". To perform other searches, the regular expression code must be edited (edit line 9). 
There are too many categories for colour-blind compatible palletes to handle, and therefore the areas with the least job posts are filtered out in the R file.
  

* To tally all job posts, regardless of area, use "raw_jobs.sh" to generate a data file "raw_jobs.csv", which can be plotted via "raw_jobsgraph.r".
  The Bash code "raw_jobs.sh" extracts raw job post tallies, per year, avoiding the inflation described above
