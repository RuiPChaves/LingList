# Python2 code originally written by Tom Juzek (http://tsjuzek.com/blog/jobs_in_linguistics.html)
# Adapted and revised to Python3 by Rui Chaves 
import re
import os
import sys
path = 'emails/'

#########################################################
print('Arguments: 0 (Professor, default), 1 (Postdoc), or 2 (General).')


try:
    case = int(sys.argv[1])
except:
    case = 0

##################### search type ########################

# Search for 'Professor' jobs (some rare posts mention "open-rank" but not "Professor", 
# while others use "Faculty" instead), and tiny minority in the single digits uses "Professeure"
if (case == 0):
    print('Professor tally')
    pattern2 = re.compile(r'prof(ess(or|eure))?|open-?rank|faculty (at|position)|faculty[:punct:]',re.I)

# Search for 'Postoc' jobs 
elif (case == 1):
    print('PostDoc tally')
    pattern2 = re.compile(r'\b[pP]ost ?[Dd]oc')

# Search for any jobs regardless of rank
elif (case == 2):
    print('General tally')
    pattern2 = re.compile(r' ')
######################################################################


month_list = ["January", "February", "March", "April", "May", "June", "July", "August", "September", "October", "November", "December"]   
year_list = [str(m) for m in range(1997,2023)]
areas = ["Syntax","Semantics","Morphology","Phonetics","Phonology","Socio","Pragmatics","Comp Ling","Computational","Natural Language Processing","Psycholing","Typology","Documentation", "Neuroling","Historical","Forensic","quisition"]
# Both "Acquisition" and "Aquisition" appear in posts

pattern = re.compile('^[0-9]+')
matching_files = [f for f in os.listdir('emails/') if pattern.match(f)]

output_file = open("jobs"+str(case)+".csv","w+") 
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
            output_file.write(str(counter) + "," + month[0:3] + "," + year + "," + area + "\n")

output_file.close()
