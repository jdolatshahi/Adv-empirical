/* MUMS DATASET */

clear all
prog drop _all
capture log close
set more off, permanently

cd "/Users/Jennifer/Documents/school/NYU Wagner/16-17/Advanced Empirical/Adv-empirical/Replication ex"

global datadir "/Users/Jennifer/Documents/school/NYU Wagner/16-17/Advanced Empirical/Adv-empirical/Replication ex"
global results "/Users/Jennifer/Documents/school/NYU Wagner/16-17/Advanced Empirical/Adv-empirical/Replication ex"

log using "$results/log_MUMS.smcl", replace
use "$datadir/mums.dta", clear

/* ALLOCATED VAR */
/* currently age 21 - 40; ever been married; 1st marriage 17 - 26; U.S. Born, including Amer. Samoa, Guam, PR, U.S. VI, Other US Posessions; white; not widow */
gen elig = .
replace elig = 1 if age >= 21 & age <= 40 & marst >= 1 & marst < 5 & agemarr >=17 & agemarr <= 26 & bpl >=1 & bpl <= 120 & raced == 100

/* MERGE IN CHILD SET */
gen serialpernum = string(serial, "%02.0f")+string(pernum, "%02.0f")

merge 1:m serialpernum using childelig.dta 

// tab elig famelig = 661, 188!

keep if famelig == 1 & elig == 1

// TABLE 1 - DESCRIPTIVES //

/* first marriage ended */
gen firstend = 1 if marrno == 2
replace firstend = 1 if marrno == 1 & marst != 1
replace firstend = 0 if firstend == .
tabstat firstend, s(me sd)
label var firstend "First marriage ended"

/* agemarr relabel */
label var agemarr "Age at first marriage"

/* first girl */ 
gen girl1 = 1 if sex_c == 2
replace girl1 = 0 if sex_c == 1
label var girl1 "Firstborn girl"

/* chborn */ 
gen everborn = .
replace everborn = 0 if chborn <= 1 
else replace everborn = chborn-1
label var everborn "Children ever born"

/* age @ first birth */
gen agefb = age - age_c
label var agefb "Age at first birth"

/* educ yrs */ 
gen educyrs = . 
replace educyrs = 0 if higrade <= 3
else replace educyrs = higrade-3
label var educyrs "Years of education" 

/* urban */ 
gen urban = 1
replace urban = 0 if metarea == 0 
label var urban "Urban"

/* household standardized income */ 
gen standardizer = adults + 0.7*minors
replace standardizer = standardizer^0.7

gen stdhhinc = hhincome/standardizer
label var stdhhinc "Standardized Household Income"

/* poverty */ 
gen povertyline = .
replace povertyline = 1 if poverty <100
replace povertyline = 0 if poverty >= 100
label var povertyline "Poverty"

/* nonwoman income */ 
gen nwinc = hhincome - inctot
label var nwinc "Nonwoman income"

/* woman's income & earnings */
label var inctot "Woman's income"

label var incwage "Annual earnings" 

/* col 2 elig */ 
gen everborn2 = everborn
replace everborn2 = 9 if everborn == 9 | everborn == 10 | everborn == 11 | everborn == 12

gen inhh = .
replace inhh = 1 if everborn2 == nchild & age_c < 18
replace inhh = 0 if everborn2 != nchild
label var inhh "All Children Live in Household"

/* col 3 elig */ 
gen beforekid = agefb - agemarr
gen fiveyears = 1 if beforekid >= 0 & beforekid <= 5
replace fiveyears = 0 if missing(fiveyears)
label var fiveyears "1st Child Born Within 5 Years of 1st Marriage"

/* output table 1 */ 
estpost tabstat firstend agemarr everborn age educyrs urban stdhhinc povertyline nwinc inctot incwage, s(me sd) columns(statistics)
eststo evermar, title("Ever-Married with Children")
estpost tabstat firstend agemarr girl1 everborn agefb age educyrs urban stdhhinc povertyline nwinc inctot incwage if inhh == 1, s(me sd) columns(statistics)
eststo inhh, title("All Children Live in Household")
estpost tabstat firstend agemarr girl1 everborn agefb age educyrs urban stdhhinc povertyline nwinc inctot incwage if inhh == 1 & fiveyears == 1, s(me sd) columns(statistics)
eststo fiveyears, title("1st Child Born Within 5 Years of 1st Marriage")
esttab * , main(mean 2) aux(sd 2) label mtitles 

eststo clear


// TABLE 2 //
keep if inhh == 1 & fiveyears == 1
