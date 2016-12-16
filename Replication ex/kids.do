/* KIDS DATASET */

clear all
prog drop _all
capture log close
set more off, permanently

cd "/Users/Jennifer/Documents/school/NYU Wagner/16-17/Advanced Empirical/Adv-empirical/Replication ex"

global datadir "/Users/Jennifer/Documents/school/NYU Wagner/16-17/Advanced Empirical/Adv-empirical/Replication ex"
global results "/Users/Jennifer/Documents/school/NYU Wagner/16-17/Advanced Empirical/Adv-empirical/Replication ex"

log using "$results/log_KIDS.smcl", replace
use "$datadir/child.dta", clear

/* FAM ELIG */ 

//twins
sort serial eldchild age birthqtr
qui by serial eldchild age birthqtr: gen twins = cond(_N == 1 , 0 , 1)

/* eldest child & not allocated age, sex, relationship to hh, or birth quarter, not twins */

gen famelig = . 
replace famelig = 1 if eldchild == 1 & twins ! = 1 & qage == 0 & qsex == 0 & qrelate == 0 & qbirthmo == 0 

rename age age_c 
label var age_c "Age of child"
rename sex sex_c
label var sex_c "Sex of child"

keep if famelig == 1

gen serialpernum = string(serial, "%02.0f")+string(momloc, "%02.0f")

save childelig.dta, replace 

