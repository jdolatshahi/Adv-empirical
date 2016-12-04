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

/** RUN ONE OR THE OTHER, NOT BOTH */ 
/* MUMS DATASET  8, 298, 300 */
/* ever born children - don't actually need sex */
gen mum = .
replace mum = 1 if chborn >= 2 & sex ==2 /* 1 or more children - 3,044,820  */
keep if mum == 1
save mums.dta, replace

/* KIDS DATASET 3,917,651 */
gen child = .
replace child = 1 if momloc >00
keep if child == 1 
save child.dta, replace

/* SPOUSE DATASET ?????*/






/* delete families w/ eldest child allocated */
summarize pernum
forval i = 1/`r(max)' {
	gen elig = 1 if qage == 0 | qsex == 0 | qrelate == 0 | qbirthmo == 0
	egen famelig = 1 if (eldchild == `i') & (elig == `i'), by(serial)
	replace famelig = 1 
}

/* notallocated dummy to show eligible dataset */
gen notallocated = .
replace notallocated = 1 if qage == 0 | qmarrno == 0 | qmarst == 0 | qagemarr == 0 | qchborn == 0 | qrelate == 0 | qsex == 0 

gen notalloceldest = .
replace notallocated = 1 if eldchild == 1 & (qage == 0 | qsex == 0 | qrelate == 0 | qbirthmo == 0 


if momloc == 00 

/* remove widows */
keep if marst != 5




/* NOTES */
clear all 
prog drop _all
use "$datadir/usa_00005.dta", clear

gen spouse = .
replace spouse = 1 if for each serial  
 
for each serial
spouse = 1 
if sploc[i] = pernum

/* needed?? creates ID of household # and code of person in household 01-04 */
gen prsncode = string(serial, "%02.0f")+string(pernum, "%02.0f")

/* nope */
for each i in serial
gen mum = 1
if momloc = pernum


/* EXAMPLE */
 forval i = 1 / `r(max)' { 
          replace ischild = (fatherm == `i') | (motherm == `i')
          #delimit ;   
          qui by family (ischild), sort:
          replace ownchild =
          cond(motherm[_N] == `i', mchild[_N], fchild[_N])
 	  if person == `i' & ischild[_N] ; 
          #delimit cr 
}
drop spouse
gen spouse = .
summarize pernum

forvalues i = 1 / `r(max)' {
	by serial (pernum), sort:
	replace spouse = (sploc == `i')
}
{
by serial (spouse), sort:
replace mumspouse =  
cond(mum[sploc[`i'] == 
if pernum == `i' & spouse[_N]
