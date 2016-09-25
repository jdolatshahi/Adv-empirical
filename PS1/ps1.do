
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
sum age
tab male
tab hiv2004

/* Q2: summary stats control tx */
sum age if under ==1 
sum age if under ==0 
sum age if any ==1 
sum age if any ==0 

sum educ2004 if under == 1 
sum educ2004 if under == 0 
sum educ2004 if any == 1 
sum educ2004 if any == 0 

tab2 hiv2004 any, row col 
tab2 hiv2004 under, row col 

/* Q3: differences in age, hiv, mar */
ttest educ2004, by(any)
ttest educ2004, by(under)

ttest age, by(any)
ttest age, by(under)

tab2 hiv2004 any, chi
tab2 hiv2004 under, chi

tab2 mar any, col chi
tab2 mar under, col chi

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

