/* Jennifer Dolatshahi
 REPLICATION EXERCISE
 full do file
 December 19, 2016 */

clear all
prog drop _all
capture log close
set more off, permanently

global datadir "/Users/Jennifer/Documents/school/NYU Wagner/16-17/Advanced Empirical/Adv-empirical/Replication ex"
global results "/Users/Jennifer/Documents/school/NYU Wagner/16-17/Advanced Empirical/Adv-empirical/Replication ex"

log using "$results/log_replicationfull.smcl", replace
use "$datadir/usa_00005.dta", clear

order *, alpha

/* IDENTIFY ELDEST CHILD - use this. 1,970,592 */

gen eldchild = .
gen eldage = .
gen child = .
summarize pernum
forvalues i = 1/`r(max)' {
	replace child = 1 if momloc > 00 | poploc > 00
	egen work = max(age*child), by(serial)
	replace eldage = work if child == 1 & age == work
	replace eldchild = 1 if !missing(eldage) 
	drop child work eldage

}




/* # children, # adults per household */ 
sort serial 
qui by serial: gen adult = _n if age >= 18
qui by serial: egen adults = max(adult)

sort serial adult
qui by serial adult: gen child = _n if age < 18
qui by serial adult: egen minor = max(child) 

sort serial 
qui by serial: egen minors = max(minor)

drop child adult minor

replace minors = 0 if missing(minors)
replace adults = 0 if missing(adults)

qui by serial: gen hhsize = adults + minors

save usa_edited, replace 


/** KIDS DATASET **/

gen child = .
replace child = 1 if momloc >00
keep if child == 1 
save child.dta, replace


//twins by age birthqtr 65, 803
sort serial eldchild age birthqtr
qui by serial eldchild age birthqtr: gen twins = cond(_N == 1 , 0 , 1)

// twins just by age 109, 384
sort serial eldchild age
qui by serial eldchild age: gen twinsage = cond(_N == 1, 0, 1) 

// eldest child & not allocated age, sex, relationship to hh, or birth quarter, not twins 

gen famelig = . 
replace famelig = 1 if eldchild == 1 & qage == 0 & qsex == 0 & qrelate == 0 & qbirthmo == 0 & stepmom == 0 

rename age age_c 
label var age_c "Age of child"
rename sex sex_c
label var sex_c "Sex of child"
rename momrule momrule_c
label var momrule_c "Mom Rule for child"

keep if famelig == 1

gen serialpernum = string(serial, "%02.0f")+string(momloc, "%02.0f")

save childelig.dta, replace 

/* *  MUMS DATASET * */

use usa_edited.dta, clear

gen mum = .
replace mum = 1 if chborn >= 2 & sex ==2 /* 1 or more children - 3,044,820  */
keep if mum == 1
save mums.dta, replace

// start mums
use mums.dta, clear
