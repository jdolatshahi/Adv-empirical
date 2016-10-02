
clear all
prog drop _all
capture log close
set more off, permanently

global datadir "/Users/Jennifer/Documents/school/NYU Wagner/16-17/Advanced Empirical/Adv-empirical/PS1"
global results "/Users/Jennifer/Documents/school/NYU Wagner/16-17/Advanced Empirical/Adv-empirical/PS1"

log using "$results/log_PS1.smcl", replace
use "$datadir/Thornton HIV Testing Data.dta", clear

/* if need main sample = 2812 */
count if hiv2004 != -1 & !missing(hiv2004) & !missing(age) & !missing(zone) & !missing(any) 
gen elig = .
replace elig = 1 if hiv2004 != -1 & !missing(hiv2004) & !missing(age) & !missing(zone) & !missing(any)
replace elig = 0 if elig == .
tab elig

keep if elig ==1 
save hivdata_elig, replace

/** BEGIN ANALYSIS HERE **/
clear all
prog drop _all
capture log close
set more off, permanently

global datadir "/Users/Jennifer/Documents/school/NYU Wagner/16-17/Advanced Empirical/Adv-empirical/PS1"
global results "/Users/Jennifer/Documents/school/NYU Wagner/16-17/Advanced Empirical/Adv-empirical/PS1"

log using "$results/log_PS1.smcl", replace
use "$datadir/hivdata_elig.dta", clear

/** PART 1 **/
/* Q1 */
estpost tabstat age male hiv2004, s(mean sd) columns(statistics) 
esttab using tables.rtf, replace main(mean) aux(sd) unstack label nostar onecell title(Summary statistics)

/* Q2: summary stats control tx */
estpost tabstat age educ2004 hiv2004, by(any) s(mean sd max min count) nototal column(statistics)
esttab using tables.rtf, append main(mean) aux(sd) nostar unstack noobs label title(Summary statistics by receiving any incentive)

estpost tabstat age educ2004 hiv2004, by(under) s(mean sd max min count) nototal column(statistics)
esttab using tables.rtf, append main(mean) aux(sd) nostar unstack noobs label title(Summary statistics by distance under 1.5 km)

/* Q3: differences in age, hiv, mar */

estpost ttest educ2004 age hiv2004 mar, by(any)
esttab using tables.rtf, append wide label mtitles("Mean diff") title(t-test of differences by receiving any incentive) varwidth(30)

estpost ttest educ2004 age hiv2004 mar, by(under)
esttab using tables.rtf, append wide label mtitles("Mean diff") title(t-test of differences by distance under 1.5km) varwidth(30)

/** PART 2 **/
/* Q4&5: graphs */
gen pct_got = got*100
graph bar pct_got, over(any) ytitle("Percent") b1title("Received any incentive")

graph bar pct_got, over(Ti) ytitle("Percent who got HIV results") b1title("Amount of financial incentive")

/** PART 3 **/
/* Q6: OLS regression */
reg got any /* b = 0.4494 and it is signiticant at the p < 0.001 level. */

reg got any age male educ2004 mar 
/* The estimate of b does not change (b = 0.4495) and is still highly sig. OVERT or COVERT BIAS? */

/* Q7: group means comparison */
ttest got, by(any) /* -0.4494 same as original OLS but negative. 
Going from 1 to 0 decrease the probability of receiving a test by .45 */

/* Q8: OLS by incentive amt */
reg got Ti /* b = 0.0016 and is highly sig p < 0.001 */
reg got Ti age male educ2004 mar /* b = 0.0016 and highly sig, no change with controls*/


/** PART 4 **/
/* Q10: heterogenous effects */
gen anymale = any*male
reg got any male anymale 
/* d = 0.009 and is not sig. so no interaction effect. c = -0.15 and not sig. */

/* Q11 */
gen anyedu = any*educ2004
reg got any educ2004 anyedu
/* d = 0.001 and is not sig. */

/** PART 6 RANDOM SUBSAMPLE **/
/* Q14: RANDOM SAMPLE INDICATOR */
generate random = runiform()
sort random
generate insample = _n <= 1000 

keep if insample ==1
save randomhiv, replace

clear all
prog drop _all
use "$datadir/randomhiv.dta", clear

reg got any /* b = 0.4546 and is sig. nearly same as above. */


/** PART 7 SAMPLE SIZE **/
clear all
prog drop _all
use "$datadir/hivdata_elig.dta", clear

sum any 
oneway numcond any, tab

/* put 0 & 1 because want delta = 1. very similar answers for sampsi or power */
power twomeans 0 1, power(0.8) a(0.05) sd1(2.4164268) sd2(2.1662179)
sampsi 0 1, power(0.8) alpha(0.05) sd1(2.4164268) sd2(2.1662179)

power twomeans 0 1, power(0.9) a(0.05) sd1(2.4164268) sd2(2.1662179)
sampsi 0 1, power(0.9) alpha(0.05) sd1(2.4164268) sd2(2.1662179)

