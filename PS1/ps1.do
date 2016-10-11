
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

clear all
prog drop _all
use "$datadir/hivdata_elig.dta", clear

label var male "Male" /* so label not gender */

label define txct 1 "Treatment" 0 "Control"
label values any txct
label values under txct

/* alternative for tables 1-3 * ALSO NEED DIFF IN MEANS AND SE OF MEAN DIFF */ 
estpost tabstat age male educ2004 hiv2004, s(mean sd) columns(statistics) 
eststo fullsample, title("Full sample")
estpost tabstat age male educ2004 hiv2004, by(any) s(mean sd max min count) nototal column(statistics)
eststo any, title("Any")
estpost tabstat age male educ2004 hiv2004, by(under) s(mean sd max min count) nototal column(statistics)
eststo under, title("Under")
esttab * using tables2.rtf, replace wide main(mean) aux(sd) label title(Summary statistics) mtitles nonumbers nostar
eststo clear

/* ttests */
estpost ttest educ2004 age hiv2004 mar, by(any)
eststo any, title("Mean differences Any")
estpost ttest educ2004 age hiv2004 mar, by(under)
eststo under, title("Mean differences Under")
estpost ttest got, by(any)
eststo any, title("Mean diff Got by Any")
esttab * using tables2.rtf, append se label mtitles title(t-tests of differences)
eststo clear

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
esttab using tables2.rtf, append se 
esttab * using tables.rtf, replace main(b) aux(se) wide label mtitles("Mean diff") title(t-test of differences by receiving any incentive) varwidth(30)

estpost ttest educ2004 age hiv2004 mar, by(under)
esttab using tables.rtf, append se wide label mtitles("Mean diff") title(t-test of differences by distance under 1.5km) varwidth(30)

/** PART 2 **/
/* Q4&5: graphs */

gen pct_got = got*100
graph bar pct_got, over(any) ytitle("Percent") b1title("Received any incentive") blabel(bar, format(%12.2f))

gen Tidollar = Ti/100
graph bar pct_got, over(Tidollar) ytitle("Percent who got HIV results") b1title("Amount of financial incentive in Kwacha") blabel(bar, format(%12.2f))

/** PART 3 **/
/* Q6: OLS regression -- CHECK SEs*/ 

eststo: reg got any, r /* b = 0.4494 and it is signiticant at the p < 0.001 level. */
eststo: reg got any age male educ2004 mar, r /* The estimate of b does not change (b = 0.4495) and is still highly sig. OVERT or COVERT BIAS? */
esttab using tables2.rtf, append se(%7.2f) varwidth(28) modelwidth(15) label scalar(r2) title(OLS Regression of Any Incentive Received)
eststo clear

/* Q7: group means comparison */
ttest got, by(any) /* -0.4494 same as original OLS but negative. 
Going from 1 to 0 decrease the probability of receiving a test by .45 */

/* Q8: OLS by incentive amt -- ALWAYS USE ROBUST SE*/
eststo: reg got Ti, r /* b = 0.0016 and is highly sig p < 0.001 */
eststo: reg got Ti age male educ2004 mar, r /* b = 0.0016 and highly sig, no change with controls*/
esttab using tables2.rtf, append se varwidth(30) modelwidth(15) label scalar(r2) title(OLS Regression of Amount of Incentive Received)
eststo clear

/** PART 4 **/
/* Q10 & 11: heterogenous effects */
gen anymale = any*male
label var anymale "Any x Male"
eststo: reg got any male anymale, robust

gen anyedu = any*educ2004
label var anyedu "Any x Education"
eststo: reg got any educ2004 anyedu, robust /* d = 0.001 and is not sig. */
esttab using tables2.rtf, append se varwidth(30) modelwidth(15) label scalar(r2) title(Heterogenous Effects Models)
eststo clear

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

eststo: reg got any, robust /* b = 0.4546 and is sig. nearly same as above. */
esttab using tables2.rtf, append se varwidth(28) modelwidth(15) label title(OLS Regression of Random Subsample) 
eststo clear

/** PART 7 SAMPLE SIZE **/
clear all
prog drop _all
use "$datadir/hivdata_elig.dta", clear
sum any 
oneway numcond any, tab

/* Q16:
put 0 & 1 because want delta = 1. very similar answers for sampsi or power */
power twomeans 0 1, power(0.8) a(0.05) sd1(2.4164268) sd2(2.1662179)
sampsi 0 1, power(0.8) alpha(0.05) sd1(2.4164268) sd2(2.1662179)

power twomeans 0 1, power(0.9) a(0.05) sd1(2.4164268) sd2(2.1662179)
sampsi 0 1, power(0.9) alpha(0.05) sd1(2.4164268) sd2(2.1662179)

/* Q17: cluster */
loneway numcond site
quietly sampsi 0 1, power(0.8) alpha(0.05) sd1(2.4164268) sd2(2.1662179)
sampclus, obsclus(40) rho(0.07897)

quietly sampsi 0 1, power(0.9) alpha(0.05) sd1(2.4164268) sd2(2.1662179)
sampclus, obsclus(40) rho(0.07897)

/** PART VIII BONUS **/
/* Q18: */
ttest got, by(any)

/** loop create new tx to randomize in same proportion of orig randomization. store statistics into new var. 
or store just a conditional whether it is above or below a cut off value and have tab running at each loop **/ 
