
/** 
Jennifer Dolatshahi
Adv Empirical PS 1 
October 12, 2016 **/

clear all
prog drop _all
capture log close
set more off, permanently

global datadir "/Users/Jennifer/Documents/school/NYU Wagner/16-17/Advanced Empirical/Adv-empirical/PS1"
global results "/Users/Jennifer/Documents/school/NYU Wagner/16-17/Advanced Empirical/Adv-empirical/PS1"

log using "$results/log_PS1.smcl", replace
use "$datadir/Thornton HIV Testing Data.dta", clear

/* main sample = 2812 */
count if hiv2004 != -1 & !missing(hiv2004) & !missing(age) & !missing(zone) & !missing(any) 
gen elig = .
replace elig = 1 if hiv2004 != -1 & !missing(hiv2004) & !missing(age) & !missing(zone) & !missing(any)
replace elig = 0 if elig == .
tab elig

keep if elig ==1 
save hivdata_elig, replace

clear all
prog drop _all
use "$datadir/hivdata_elig.dta", clear

label var male "Male"

label define txct 1 "Treatment" 0 "Control"
label values any txct
label values under txct

/* summary stats */ 
estpost tabstat age male educ2004 hiv2004, s(mean sd) columns(statistics) 
eststo fullsample, title("Full sample")
estpost tabstat age male educ2004 hiv2004, by(any) s(mean sd max min count) nototal column(statistics)
eststo any, title("Any")
estpost tabstat age male educ2004 hiv2004, by(under) s(mean sd max min count) nototal column(statistics)
eststo under, title("Under")
esttab * using tables2.rtf, replace wide main(mean 2) aux(sd 2) label title(Summary statistics) mtitles nonumbers nostar
eststo clear

/* ttests */
estpost ttest educ2004 age hiv2004 mar, by(any)
eststo any, title("Mean differences Any")
estpost ttest educ2004 age hiv2004 mar, by(under)
eststo under, title("Mean differences Under")
esttab * using tables2.rtf, append b(2) se(2) label mtitles title(t-tests of differences)
eststo clear

/* ttest got by any */
estpost ttest got, by(any)
eststo any2, title("Mean diff Got by Any")
esttab using tables2.rtf, append b(2) se(2) label mtitles title(t-test of differences Got by Any)
eststo clear

/* Q4&5: graphs */

gen pct_got = got*100
graph bar pct_got, over(any) ytitle("Percent learning HIV status") b1title("Received any incentive") blabel(bar, format(%12.2f))

gen Tidollar = Ti/100
graph bar pct_got, over(Tidollar) ytitle("Percent learning HIV status") b1title("Amount of financial incentive in dollars") blabel(bar, format(%12.2f))

/* Q6: OLS regression*/ 

eststo: reg got any, r
eststo: reg got any age male educ2004 mar, r 
esttab using tables2.rtf, append b(2) se(%7.2f) varwidth(28) modelwidth(15) label scalar(r2) title(OLS Regression of Any Incentive Received)
eststo clear

/* Q8: OLS by incentive amt*/
eststo: reg got tinc, r
eststo: reg got tinc age male educ2004 mar, r
esttab using tables2.rtf, append b(3) se(3) varwidth(30) modelwidth(15) label scalar(r2) title(OLS Regression of Amount of Incentive Received)
eststo clear

/* Q10 & 11: heterogenous effects */
gen anymale = any*male
label var anymale "Any x Male"
eststo: reg got any male anymale, r

gen anyedu = any*educ2004
label var anyedu "Any x Education"
eststo: reg got any educ2004 anyedu, r
esttab using tables2.rtf, append b(2) se(2) varwidth(30) modelwidth(15) label scalar(r2) title(Heterogenous Effects Models)
eststo clear

/* Q14: RANDOM SAMPLE INDICATOR */
generate random = runiform()
sort random
generate insample = _n <= 1000 

keep if insample ==1
save randomhiv, replace

clear all
prog drop _all
use "$datadir/randomhiv.dta", clear

eststo: reg got any, r
esttab using tables2.rtf, append b(2) se(2) varwidth(28) modelwidth(15) label title(OLS Regression of Random Subsample) 
eststo clear

/** PART 7 SAMPLE SIZE **/
clear all
prog drop _all
use "$datadir/hivdata_elig.dta", clear
sum any 
oneway numcond any, tab

sampsi 0 1, power(0.8) alpha(0.05) sd1(1.9174987) sd2(1.8848715)

sampsi 0 1, power(0.9) alpha(0.05) sd1(1.9174987) sd2(1.8848715)

/* Q17: cluster */
loneway numcond site
quietly sampsi 0 1, power(0.8) alpha(0.05) sd1(1.9174987) sd2(1.8848715)
sampclus, obsclus(40) rho(0.07897)

quietly sampsi 0 1, power(0.9) alpha(0.05) sd1(1.9174987) sd2(1.8848715)
sampclus, obsclus(40) rho(0.07897)

capture log close 
