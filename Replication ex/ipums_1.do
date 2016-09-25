/* REPLICATION EXERCISE FIRST .DO
ipums_1 working data set */

clear all
prog drop _all
capture log close
set more off, permanently

global datadir "/Users/Jennifer/Documents/school/NYU Wagner/16-17/Advanced Empirical/Replication ex"
global results "/Users/Jennifer/Documents/school/NYU Wagner/16-17/Advanced Empirical/Replication ex"

log using "$results/log_ipums_1.smcl", replace
use "$datadir/ipums_1.dta", clear

order *, alpha

keep if sex == "female" & 
