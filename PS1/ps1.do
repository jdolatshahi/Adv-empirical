
/** Adv Empirical PS 1 
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

/** loop create new tx to randomize in same proportion of orig randomization. store statistics into new var. 
or store just a conditional whether it is above or below a cut off value and have tab running at each loop **/ 
/** PART VIII BONUS **/
/* Q18: */
estpost ttest got, by(any) /* diff =  -.4493691 */

clear all
prog drop _all
use "$datadir/hivdata_elig.dta", clear

set seed 12345
gen rannum = uniform()
sort rannum
gen grp = .
replace grp = 0 in 1/618
replace grp = 1 in 619/2812

forvalues i = 1/2812 {
estpost ttest got, by(grp)
if abs(e(b)) > abs(-.4493691) {
gen grtdiff = 1
}
else {
gen grtdiff = 0
}
end

/** DON'T USE OLD CODE **/
/** PART 1 **/
/* Q1 */
estpost tabstat age male hiv2004, s(mean sd) columns(statistics) 
esttab using tables.rtf, replace main(mean 2) aux(sd 2) unstack label nostar onecell title(Summary statistics)

/* Q2: summary stats control tx */
estpost tabstat age educ2004 hiv2004, by(any) s(mean sd max min count) nototal column(statistics)
esttab using tables.rtf, append main(mean) aux(sd) nostar unstack noobs label title(Summary statistics by receiving any incentive)

estpost tabstat age educ2004 hiv2004, by(under) s(mean sd max min count) nototal column(statistics)
esttab using tables.rtf, append main(mean) aux(sd) nostar unstack noobs label title(Summary statistics by distance under 1.5 km)

/* Q3: differences in age, hiv, mar */
estpost ttest educ2004 age hiv2004 mar, by(any)
esttab * using tables.rtf, replace main(b) aux(se) wide label mtitles("Mean diff") title(t-test of differences by receiving any incentive) varwidth(30)

estpost ttest educ2004 age hiv2004 mar, by(under)
esttab using tables.rtf, append se wide label mtitles("Mean diff") title(t-test of differences by distance under 1.5km) varwidth(30)

/* Q7: group means comparison */
ttest got, by(any) /* -0.4494 same as original OLS but negative. 
Going from 1 to 0 decrease the probability of receiving a test by .45 */


