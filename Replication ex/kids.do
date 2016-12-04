/* KIDS DATASET */

clear all
prog drop _all
capture log close
set more off, permanently

global datadir "/Users/Jennifer/Documents/school/NYU Wagner/16-17/Advanced Empirical/Adv-empirical/Replication ex"
global results "/Users/Jennifer/Documents/school/NYU Wagner/16-17/Advanced Empirical/Adv-empirical/Replication ex"

log using "$results/log_KIDS.smcl", replace
use "$datadir/child.dta", clear

/* FAM ELIG */ 
/* eldest child & not allocated age, sex, relationship to hh, or birth quarter */
gen famelig = . 
replace famelig = 1 if eldchild == 1 & qage == 0 & qsex == 0 & qrelate == 0 & qbirthmo == 0 

gen serialpernum = string(serial, "%02.0f")+string(momloc, "%02.0f")

save child.dta, replace 

/* RESHAPE NEED TO FIGURE OUT WHICH VARS TO PUT IN*/ 
reshape wide ANCESTR1 - famelig, i(serial) j(pernum)
