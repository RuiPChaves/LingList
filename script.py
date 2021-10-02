# Python2 code originally written by Tom Juzek (http://tsjuzek.com/blog/jobs_in_linguistics.html)
# Adapted and revised to Python3 by Rui Chaves 
import re
import os
path = 'emails/'

month_list = ["January", "February", "March", "April", "May", "June", "July", "August", "September", "October", "November", "December"]   
year_list = [str(m) for m in range(1997,2022)]
areas = ["Syntax","Semantics","Morphology","Phonetics","Phonology","Socio","Pragmatics","Comp Ling","Computational","Psycholing","Typology","Documentation", "Neuroling","Historical","Forensic"]

pattern = re.compile('^[0-9]+')
matching_files = [f for f in os.listdir('emails/') if pattern.match(f)]

pattern2 = re.compile(' ')
#pattern2 = re.compile('Prof(essor)')
#pattern2 = re.compile('Post ?[Dd]oc')

for area in areas:
    output_file = open("jobs_" + area + ".txt","w+") 
    output_file.write("Jobs Month Year\n")
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
            output_file.write(str(counter) + " " + month + " " + year + "\n")
    output_file.close()
