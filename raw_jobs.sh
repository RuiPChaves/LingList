#!/bin/bash
egrep "[0-9]+, Jobs: " emails/*.txt | sed -E 's/emails\///' | sed -E 's/-.*//' | uniq -c | sed -E 's/ +//' > raw_jobs.csv

