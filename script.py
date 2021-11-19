# Python2 code originally written by Tom Juzek (http://tsjuzek.com/blog/jobs_in_linguistics.html)
# Adapted and revised to Python3 by Rui Chaves 
import re
import os
path = 'emails/'

##################### Select your search type ########################
# Search for 'Professor' jobs (some rare posts mention "open-rank" but not "Professor", others use "Faculty" instead)
pattern2 = re.compile(r'([pP]rof(essor)?)|([Oo]pen(-)?[rR]ank)|(Faculty (at|[Pp]osition))|(Faculty[[:punct:]])')

# Search for 'Postoc' jobs
#pattern2 = re.compile(r'\b[pP]ost ?[Dd]oc')
######################################################################




month_list = ["January", "February", "March", "April", "May", "June", "July", "August", "September", "October", "November", "December"]   
year_list = [str(m) for m in range(1997,2022)]
areas = ["Syntax","Semantics","Morphology","Phonetics","Phonology","Socio","Pragmatics","Comp Ling","Computational","Natural Language Processing","Psycholing","Typology","Documentation", "Neuroling","Historical","Forensic","quisition"]
# Both "Acquisition" and "Aquisition" appear in posts

pattern = re.compile('^[0-9]+')
matching_files = [f for f in os.listdir('emails/') if pattern.match(f)]

output_file = open("jobs.csv","w+") 
output_file.write("Jobs,Month,Year,Area\n")

for area in areas:
    for year in year_list:
        for month  in month_list:
            counter = 0
            for filename in matching_files:                
                filename_elements = filename.split("-")                              
                email_month = filename_elements[1].split(".")[0]                                    
                email_year = filename_elements[0]
                if (email_month == month) and (email_year == year):
                    input_file = open(path + filename,"r",encoding = "ISO-8859-1")
                    for line in input_file:
                        if "Jobs: " in line:                                    
                            if ((area.lower() in line.lower()) and re.search(pattern2,line)):
                                counter += 1
                    input_file.close()
            output_file.write(str(counter) + "," + month + "," + year + "," + area + "\n")

output_file.close()
