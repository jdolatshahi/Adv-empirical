/* REPLICATION EXERCISE
   full working data set */

clear all
prog drop _all
capture log close
set more off, permanently

global datadir "/Users/Jennifer/Documents/school/NYU Wagner/16-17/Advanced Empirical/Adv-empirical/Replication ex"
global results "/Users/Jennifer/Documents/school/NYU Wagner/16-17/Advanced Empirical/Adv-empirical/Replication ex"

log using "$results/log_replication.smcl", replace
use "$datadir/usa_00005.dta", clear

order *, alpha

/* needed?? creates ID of household # and code of person in household 01-04 */
gen prsncode = string(serial, "%02.0f")+string(pernum, "%02.0f")
