/** 
Jennifer Dolatshahi
Adv Empirical PS 2 
November 2, 2016 **/

clear all
prog drop _all
capture log close
set more off, permanently

global datadir "/Users/Jennifer/Documents/school/NYU Wagner/16-17/Advanced Empirical/Adv-empirical/PS2"
global results "/Users/Jennifer/Documents/school/NYU Wagner/16-17/Advanced Empirical/Adv-empirical/PS2"

log using "$results/log_PS2.smcl", replace
use "$datadir/generateddata_20120221_sub.dta", clear

order *, alpha 

/* Summary stats */
estpost tabstat lnYearly_gva manshare manufacturing_total allmanufacturing labor_reg_besley_flex2, s(mean sd) columns(statistics)
eststo fullsample, title("Full Sample")
estpost tabstat lnYearly_gva manshare manufacturing_total allmanufacturing labor_reg_besley_flex2 if post==0, s(mean sd) columns(statistics)
eststo r57, title("Round 57")
estpost tabstat lnYearly_gva manshare manufacturing_total allmanufacturing labor_reg_besley_flex2 if post==1, s(mean sd) columns(statistics)
eststo r63, title("Round 63")
estpost ttest lnYearly_gva Total_worker, by(post)
eststo ttests, title("Mean differences")
esttab * using tables.rtf, replace cells(mean(pattern(1 1 1 0) fmt(3)) sd(pattern(1 1 1 0) par) b(pattern(0 0 1) nostar fmt(3))) label title(Summary statistics) mtitles nonumbers nostar varwidth(25)
eststo clear

/* check growth rate */
sum lnYearly_gva if post == 1
gen lnm63 = r(mean)
sum lnYearly_gva if post == 0
gen lnm57 = r(mean)
di (lnm63 - lnm57)/lnm57

sum Total_worker if post ==1
gen m63w = r(mean)
sum Total_worker if post == 0 
gen m57w = r(mean)
di(m63w - m57w)/m57w

/* reduced form regs */
gen labor_post = labor_reg*post
label var labor_post "labor_reg X Round 63"
eststo Round57: reg lnYearly_gva labor_reg if post == 0, r
eststo Round63: reg lnYearly_gva labor_reg if post == 1, r
eststo Fullsample: reg lnYearly_gva labor_reg post, r
eststo Interaction: reg lnYearly_gva labor_reg post labor_post, r
eststo Fullsample_FE: xi: reg lnYearly_gva labor_reg post i.state i.NIC_io, r
eststo Interaction_FE: xi: reg lnYearly_gva labor_reg post labor_post i.state i.NIC_io, r
esttab * using tables.rtf, append b(3) se(3) varwidth(25) modelwidth(15) label mtitles title(Reduced Form Regressions)
eststo clear

/* main regs */
eststo mainreg: reg lnYearly_gva allmanu manu_post post, r
eststo model2: reg lnYearly_gva allmanu manu_post post labor_reg, r
eststo model3: reg lnYearly_gva allmanu manu_post post labor_reg labor_post, r
eststo modelFE: xi: reg lnYearly_gva allmanu manu_post post labor_reg labor_post i.state i.NIC_io, r
esttab * using tables.rtf, append b(3) se(3) varwidth(25) modelwidth(15) label mtitles title(Main Regression)
eststo clear

/* IV regs ivreg y (x = z), first */ 
eststo: ivreg lnYearly_gva (allmanu = labor_reg), r first
eststo: xi: ivreg lnYearly_gva i.state (allmanu = labor_reg), r first
eststo: xi: ivreg lnYearly_gva (manu_post = labor_post) i.state i.NIC_io labor_reg allmanu post , r first
esttab * using tables.rtf, append b(3) se(3) varwidth(25) modelwidth(15) label mtitles title(IV Regression)
eststo clear

