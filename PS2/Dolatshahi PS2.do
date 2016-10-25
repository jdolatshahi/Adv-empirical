
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
esttab * using tables.rtf, replace cells(mean(pattern(1 1 1 0) fmt(2)) sd(pattern(1 1 1 0) par) b(pattern(0 0 1) nostar fmt(2))) label title(Summary statistics) mtitles nonumbers nostar varwidth(25)
eststo clear

/* check growth rate */
tabstat lnYearly_gva, by(post)
di (12.81555 - 12.40027)/5

tabstat Total_worker, by(post)
di (60.41097 - 12.74296)/5 

/* reduced form regs */
gen labor_post = labor_reg*post
label var labor_post "labor_reg X Round 63"
eststo Round57: reg labor_reg lnYearly_gva if post == 0, r
eststo Round63: reg labor_reg lnYearly_gva if post == 1, r
eststo Fullsample: reg labor_reg lnYearly_gva post, r
eststo Interaction: reg labor_reg lnYearly_gva post labor_post, r
eststo Fullsample_FE: xi: reg labor_reg lnYearly_gva post i.state i.NIC_io, r
eststo Interaction_FE: xi: reg labor_reg lnYearly_gva post i.state i.NIC_io, r
esttab * , append b(3) se(3) varwidth(25) modelwidth(15) label mtitles title(Reduced Form Regressions)
eststo clear
