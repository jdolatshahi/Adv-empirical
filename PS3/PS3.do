/** 
Jennifer Dolatshahi
Adv Empirical PS 2 
November 16, 2016 **/

clear all
prog drop _all
capture log close
set more off, permanently

global datadir "/Users/Jennifer/Documents/school/NYU Wagner/16-17/Advanced Empirical/Adv-empirical/PS3"
global results "/Users/Jennifer/Documents/school/NYU Wagner/16-17/Advanced Empirical/Adv-empirical/PS3"

log using "$results/log_PS3.smcl", replace
use "$datadir/PS 3 - Clark.dta", clear

/* scatterplot quadratic fit */
graph tw (sca dpass vote if vote < 50) (sca dpass vote if vote >= 50), ytitle("Change in pass rate between years 0 and 2") xtitle("vote share") legend(off) xline(50) || qfitci dpass vote if vote <50 || qfitci dpass vote if vote >=50, stdp

/* scatterplot cubic fit */
graph tw (sca dpass vote if vote < 50) (sca dpass vote if vote >= 50), ytitle("Change in pass rate between years 0 and 2") xtitle("vote share") legend(off) xline(50) || lpolyci dpass vote if vote <50, degree(3) || lpolyci dpass vote if vote >=50, degree(3)

/* scatter local poly */
graph tw (sca dpass vote if vote < 50) (sca dpass vote if vote >= 50), ytitle("Change in pass rate between years 0 and 2") xtitle("vote share") legend(off) xline(50) || lpoly dpass vote if vote <50 & vote >=40, bwidth(1) lc(black) lwi(thick) || lpoly dpass vote if vote >=50 & vote <=60, bwidth(1) lc(black) lwi(thick)

/* scatter local poly w/ CI */
graph tw (sca dpass vote if vote < 50) (sca dpass vote if vote >= 50), ytitle("Change in pass rate between years 0 and 2") xtitle("vote share") legend(off) xline(50) || lpolyci dpass vote if vote <50 & vote >=40, bwidth(1)|| lpolyci dpass vote if vote >=50 & vote <=60, bwidth(1)
