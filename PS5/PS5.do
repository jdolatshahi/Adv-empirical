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

// q1 

label var nj "NJ"
label define nj 0 "PA" 1 "NJ"
label values nj nj

tabstat dfte, by(nj) s(me sem) columns(statistics)

estpost ttest dfte, by(nj)
eststo tt, title("Difference in means")
esttab * using tables5.rtf, replace cell("mu_1(label(Mean_PA) fmt(3)) mu_2(label(Mean_NJ) fmt(3)) b(label(Mean_diff) fmt(3)) se(label(SE) fmt(3))") nomtitles title("Means and difference of means for change in fte")
eststo clear

// q2 - Q4
eststo Q2: reg dfte nj
eststo Q2_r: reg dfte nj, r
eststo Q3: reg fte nj after njafter
eststo Q3_r: reg fte nj after njafter, r
eststo Q4_cluster: reg fte nj after njafter, vce(cluster sheet)
esttab * using tables5.rtf, append b(3) se(3) mtitles label title(Regression models of difference-in-differences)
eststo clear

// Q5
eststo: xtreg fte nj after njafter, fe
esttab * using tables5.rtf, replace b(3) se(3) mtitles label title(Fixed effects regression)
eststo clear

// Q8 
use safesave_slim_data.dta, clear

rename * , lower

egen meantika = mean(loanbal) if tika == 1, by(trend)
label var meantika "Tikapara/Kalyanpur"

egen meange = mean(loanbal) if ge == 1, by(trend)
label var meange "Geneva, Comparison"

egen meantikamy = mean(loanbal) if tika == 1, by(monthyear)
egen meangemy = mean(loanbal) if ge == 1, by(monthyear)

label define mths 5 "June 1990" 10 "November 1999" 15 "April 2000" 20 "Sept 2000"
label value trend mths

// Mean loan balances pre and post interest rate increase by treatment and comparison groups
tw (sca meantika trend, connect(l)) (sca meange trend, connect(l)), xline(13) ytitle(Mean loan balance) xtitle(Months since Feb 1990)
// Fitted values of mean loan balances pre and post interest rate increase by treatment and comparison groups
tw (lfit meantika trend if trend < 13) (lfit meange trend if trend < 13) (lfit meange trend if trend >= 13) (lfit meantika trend if trend >= 13), xline(13) ytitle(Mean loan balance) xtitle(Months since Feb 1990) legend(off) 

// regs 
label define tika 1 "Treatment, Tikapara+Kalyanpur" 0 "Comparison, Geneva"
label val tika tika 

gen post = 1 if trend >= 13
replace post = 0 if missing(post)

gen tikatrend = tika*trend
gen trendpost = trend*post
eststo Parallel_test: reg loanbal trend tika tikatrend if post == 0, r
eststo Within_comparison: reg loanbal trend post trendpost if tika == 0, r
eststo Parallel_controls: reg loanbal trend tika tikatrend nage tinpr if post == 0, r
esttab * using tables5.rtf, append b(3) se(3) mtitles label 
eststo clear

