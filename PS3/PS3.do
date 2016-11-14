/** 
Jennifer Dolatshahi
Adv Empirical PS 3 
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

/* Q3 */
eststo model_15_85: reg dpass win if vote >=15 & vote <=85
eststo model_2_95: reg dpass win if vote >=5 & vote <=95
eststo model_30_70: reg dpass win if vote >=30 & vote <=70
eststo model_40_60: reg dpass win if vote >=40 & vote <=60
esttab * using tables3.rtf, replace b(3) se(3) varwidth(25) modelwidth(15) scalar(r2) label mtitles title(Impact of GM status on pass rates - dpass)
eststo clear

/* Q4 */
eststo model_15_85: reg passrate2 win if vote >=15 & vote <=85
eststo model_2_95: reg passrate2 win if vote >=5 & vote <=95
eststo model_30_70: reg passrate2 win if vote >=30 & vote <=70
eststo model_40_60: reg passrate2 win if vote >=40 & vote <=60
esttab * using tables3.rtf, append b(3) se(3) varwidth(25) modelwidth(15) scalar(r2) label mtitles title(Impact of GM status on pass rates - passrate2)
eststo clear

/* RD */

ssc install rd, replace
rd passrate2 vote, gr z0(50) mbw(100)
rd dpass vote, gr z0(50) mbw(100) 

/* Q5 */
reg passrate0 win
graph tw (sca passrate0 vote if vote < 50) (sca passrate0 vote if vote >=50), xline(50) || lpolyci passrate0 vote if vote <50 & vote >=40, bwidth(1)|| lpolyci passrate0 vote if vote >=50 & vote <=60, bwidth(1)


"Change in pass rate between years 0 and 2") xtitle("vote share") legend(off) xline(50) || lpolyci passrate0 vote if vote <50 & vote >=40, bwidth(1)|| lpolyci dpass vote if vote >=50 & vote <=60, bwidth(1)
