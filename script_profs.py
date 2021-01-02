# Python code originally written by Tom Juzek (http://tsjuzek.com/blog/jobs_in_linguistics.html)
# Adapted by Rui Chaves 
# -*- coding: utf-8 -*-

import sys, re, os
reload(sys)

sys.setdefaultencoding('utf-8')

def main():	
    path = 'emails/'
    month_list = ["January", "February", "March", "April", "May", "June", "July", "August", "September", "October", "November", "December"]
    
    year_list = map(str,[m for m in range(1997,2021)])

    areas = ["Syntax","Semantics","Morphology","Phonetics","Phonology","Socio","Pragmatics","Comp Ling","Computational","Psycholing","Typology","Documentation", "Neuroling","Historical","Forensic"]

    for area in areas:
        output_file = open("jobs_" + area + ".txt","w+") 
        output_file.write("Jobs Month Year\n")
 
        for year  in year_list:
            for month  in month_list:
                counter = 0
                for filename in os.listdir(path):
                    if "-" in filename:
                        filename_elements = filename.split("-")                              
                        email_month = filename_elements[1].split(".")[0]                                    
                        email_year = filename_elements[0]
                        if (email_month == month) and (email_year == year):
                            input_file = open(path + filename, "r")
                            for line in input_file:						
                                if "Jobs: " in line:
                                    if ((area in line) and ("Prof" in line)):				    
                                        counter += 1
                            input_file.close()
		
                output_file.write(str(counter) + " " + month + " " + year + "\n")
	

        output_file.close()

# boilerplate
main()
