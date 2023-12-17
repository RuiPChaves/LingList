#!/bin/bash
egrep ", +Jobs: " emails/*.txt | sed -E 's/emails\///' | sed -E 's/-.*//' | uniq -c | sed -E 's/ +//' > raw_jobs.csv


