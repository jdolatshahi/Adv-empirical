
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

nnmatch re78 nonexptreat re74 re75, m(1) keep(nonexp.dta) replace /* -10475.37 */
ttest re78 if data_id == "Dehejia-Wahba Sample", by(treat)

gen id = _n
gen index = _n

preserve
rename * *_1m
rename id_1m id
save "treat", replace
restore

preserve
rename * *_0m
rename index_0m index
save "comparison", replace
restore

use "$datadir/nonexp.dta", clear

keep if nonexptreat == 1

merge m:1 id using "treat", ///
	keepusing(age_1m education_1m black_1m hispanic_1m married_1m nodegree_1m) ///
	keep(master match) nogen


merge m:1 index using "comparison", ///
	keepusing(age_0m education_0m black_0m hispanic_0m married_0m nodegree_0m) ///
	keep(master match) nogen

collapse (mean) re78-re75 km-dist re74_* re75_* education_*, by(id)


tw (lfit re74 re74_0) (sca re74_0 re74_1)
reg re74 re74_0
ttest re74 == re74_0

tw (lfit re75 re75_0) (sca re75 re75_0)
reg re75 re75_0
ttest re75 == re75_0

/* Q3 */
ttest education_1 == education_0
reg education_1 education_0
tw (lfit education_1 education_0) (sca education_1 education_0) 

/* Q4 */
use "$datadir/nsw_dw.dta", clear
gen nonexptreat = .
replace nonexptreat = 1 if data_id == "Dehejia-Wahba Sample" & treat == 1
replace nonexptreat = 0 if data_id == "PSID"

gen re74_2 = re74*re74
gen re75_2 = re75*re75
nnmatch re78 nonexptreat re74 re75 education black hispanic married re74_2 re75_2, m(1) keep(nonexp2.dta) replace /*  SATE -11653.45   SE 3990.061 */

use "$datadir/nonexp2.dta", clear
keep if nonexptreat==1
collapse re78-re75_2 km-re75_2_1m, by(id)

local colnames "re74 re75 education black hispanic married re74_sq re75_sq"

mat ttests = J(3,8,.)
mat colnames ttests = `colnames'
mat rownames ttests = Mean_treatment Mean_comparison SE

local i = 1
foreach var in re74 re75 education black hispanic married re74_2 re75_2 {
ttest `var' == `var'_0m

mat ttests[1,`i'] = round(r(mu_1), .001)
mat ttests[2,`i'] = round(r(mu_2), .001)
mat ttests[3,`i'] = round(r(se), .001)


local i = `i' + 1


}
mat li ttests
