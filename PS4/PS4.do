
/** 
Jennifer Dolatshahi
Adv Empirical PS 4 
December 3, 2016 **/

clear all
prog drop _all
capture log close
set more off, permanently

global datadir "/Users/Jennifer/Documents/school/NYU Wagner/16-17/Advanced Empirical/Adv-empirical/PS4"
global results "/Users/Jennifer/Documents/school/NYU Wagner/16-17/Advanced Empirical/Adv-empirical/PS4"

log using "$results/log_PS4.smcl", replace
use "$datadir/nsw_dw.dta", clear

ssc install psmatch2
/* can run psgraph and pstest as post hoc tests */

/* Q1 covariates */
estpost tabstat age education black hispanic married nodegree if data_id == "Dehejia-Wahba Sample", by(treat) s(me sem) columns(statistics)
eststo exp, title("Experimental sample")
estpost tabstat age education black hispanic married nodegree if data_id == "PSID", by(treat) s(me sem) columns(statistics)
eststo psid, title("PSID")
esttab * using tables4.rtf, replace main(mean 2) aux(semean 2) unstack label mtitles title(Covariates for the experimental sample and non-experimental control group)
eststo clear


gen nonexptreat = .
replace nonexptreat = 1 if data_id == "Dehejia-Wahba Sample" & treat == 1
replace nonexptreat = 0 if data_id == "PSID"

estpost ttest age education black hispanic married nodegree if data_id == "Dehejia-Wahba Sample", by(treat)
eststo dehejia, title("Experimental Comparison")
estpost ttest age education black hispanic married nodegree, by(nonexptreat)
eststo nonexperimental, title("Non-experimental Comparison")
esttab * using tables4.rtf, append b(2) se(2) label mtitles title(Mean differences for the experimental and non-experimental comparisons)
eststo clear 

/* Q2 */
ssc install nnmatch

nnmatch re78 nonexptreat re74 re75, m(1) keep(nonexp.dta) /* -10375.37 */
nnmatch re78 treat re74 re75, m(1) keep(exp.dta) /* -9380.339 */

