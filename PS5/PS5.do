/* Jennifer Dolatshahi
PS 5 - DinD
December 19, 2016 */ 

clear all
prog drop _all
capture log close
set more off, permanently

cd "/Users/Jennifer/Documents/school/NYU Wagner/16-17/Advanced Empirical/Adv-empirical/PS5"

global datadir "/Users/Jennifer/Documents/school/NYU Wagner/16-17/Advanced Empirical/Adv-empirical/PS5"
global results "/Users/Jennifer/Documents/school/NYU Wagner/16-17/Advanced Empirical/Adv-empirical/PS5"

log using "$results/log_PS5.smcl", replace
use "$datadir/DinD_ex.dta", clear

// egen meanpa = mean(fte) if nj == 0, by(after)
// egen meannj = mean(fte) if nj == 1, by(after)
// graph tw (li meanpa after) (li meannj after), ytitle(FTE) legend(label(1 "PA") label(2 "NJ"))

// q1 
ttest dfte, by(nj)
oneway dfte nj, tab

// q2 - Q4
eststo Q2: reg dfte nj
eststo Q2_r: reg dfte nj, r
eststo Q3: reg fte nj after njafter
eststo Q3_r: reg fte nj after njafter, r
eststo Q4_cluster: reg fte nj after njafter, vce(cluster sheet)
esttab * using tables5.rtf, replace b(3) se(3) mtitles label title(Regression models of difference-in-differences)
eststo clear

