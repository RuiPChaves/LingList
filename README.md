# LingList
LingList posts tally.

Analysis of the LingLite posts at http://listserv.linguistlist.org/pipermail/linglite/ (which must be downloaded and decompressed into an /email folder)

* Tally (Professor or Postdoc) job posts per area

  Most job posts mention multiple specializations (e.g. Phonetics/Phonology, or Syntax/Semantics, or Computational [field]), which means that the jobs tallied here the number of opportunities from applicants' perspective, which are inflated relative to the true number of job positions.
  
  Python code "script.py" was orginally written by Tom Juzek (http://tsjuzek.com/blog/jobs_in_linguistics.html) for Python 2 (2017), later adapted to Python 3 and expanded by Rui Chaves (2019-2021). By default, the script counts only positions that mention "Professor". To perform other searches, code must be edited. 
  This script is not optimized in any shape or form.
  After running "script.py", a data file "jobs.csv" is generated, which can be analyzed and plotted via "jobsgraph.r"


* Tall all job posts, regardless of area 
  The Bash code "raw_jobs.sh" extracts raw job post tallies, per year, avoiding the inflation described above. This creates "raw_jobs.csv" and can be plotted via "raw_jobsgraph.r".

All R code by Rui Chaves.
