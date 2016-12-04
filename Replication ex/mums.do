/* MUMS DATASET */

clear all
prog drop _all
capture log close
set more off, permanently

global datadir "/Users/Jennifer/Documents/school/NYU Wagner/16-17/Advanced Empirical/Adv-empirical/Replication ex"
global results "/Users/Jennifer/Documents/school/NYU Wagner/16-17/Advanced Empirical/Adv-empirical/Replication ex"

log using "$results/log_MUMS.smcl", replace
use "$datadir/mums.dta", clear

/* ALLOCATED VAR */
/* currently age 21 - 40; ever been married; 1st marriage 17 - 26; U.S. Born, including Amer. Samoa, Guam, PR, U.S. VI, Other US Posessions; white; not widow */
gen elig = .
replace elig = 1 if age >= 21 & age <= 40 & marst >= 1 & marst < 5 & agemarr >=17 & agemarr <= 26 & bpl >=1 & bpl <= 120 & race == 1

/* MERGE IN CHILD SET */
gen serialpernum = string(serial, "%02.0f")+string(pernum, "%02.0f")

/* how do you make new age sex vars for kids?? */
merge 1:m serialpernum using child.dta 
