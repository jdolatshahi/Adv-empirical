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

rename * , lower

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
label define girlboy 1 "Girl" 0 "Boy"
label value girl1 girlboy

/* chborn */ 
gen everborn = .
replace everborn = 0 if chborn <= 1 
else replace everborn = chborn - 1
label var everborn "Children ever born"

/* age @ first birth */
gen agefb = age - age_c
label var agefb "Age at first birth"

/* educ yrs */ 
gen educyrs = . 
replace educyrs = higrade - 3
replace educyrs = 0 if higrade < = 3 & higrade > 0
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
esttab * using replication.rtf, replace main(mean 2) aux(sd 2) label mtitles 

eststo clear

// TABLE 2 //
keep if inhh == 1 & fiveyears == 1
gen divorce = . 
replace divorce = 1 if marst == 3 | marst == 4 | marrno ==2 
replace divorce = 0 if missing(divorce)
label define divorce 1 "Ever-divorced" 0 "Never-divorced"
label val divorce divorce
label var divorce Divorce

/* unadjusted */
qui {
eststo overall: reg divorce girl1
eststo educ1: reg divorce girl1 if educyrs < 12
eststo educ2: reg divorce girl1 if educyrs == 12
eststo educ3: reg divorce girl1 if educyrs >= 13 & educyrs <= 15
eststo educ4: reg divorce girl1 if educyrs >= 16
eststo firstmar1: reg divorce girl1 if agemarr <20
eststo firstmar2: reg divorce girl1 if agemarr >= 20
eststo agebirth1: reg divorce girl1 if agefb <22
eststo agebirth2: reg divorce girl1 if agefb >=22
}
esttab * using tables.rtf, replace b(2) scalars(F N) mtitles
eststo clear

/* adjusted */
gen age2 = age*age
gen agemarr2 = agemarr*agemarr
gen agefb2 = agefb*agefb
gen educyrs2 = educyrs*educyrs
gen ageeduc = age*educyrs
gen marreduc = agemarr*educyrs
gen fbeduc = agefb*educyrs


qui {
eststo overall: qui reg divorce girl1 age2 agemarr2 agefb2 educyrs2 ageeduc marreduc fbeduc i.bpl i.statefip i.metarea
test girl1
estadd scalar F_test = r(F)

eststo educ1: qui reg divorce girl1 age2 agemarr2 agefb2 educyrs2 ageeduc marreduc fbeduc i.bpl i.statefip i.metarea if educyrs < 12
test girl1
estadd scalar F_test = r(F)

eststo educ1: reg divorce girl1 age2 agemarr2 agefb2 educyrs2 ageeduc marreduc fbeduc i.bpl i.statefip i.metarea if educyrs < 12
test girl1
estadd scalar F_test = r(F) 

eststo educ2: reg divorce girl1 age2 agemarr2 agefb2 educyrs2 ageeduc marreduc fbeduc i.bpl i.statefip i.metarea if educyrs == 12
test girl1
estadd scalar F_test = r(F) 

eststo educ3: reg divorce girl1 age2 agemarr2 agefb2 educyrs2 ageeduc marreduc fbeduc i.bpl i.statefip i.metarea if educyrs >= 13 & educyrs <= 15
test girl1
estadd scalar F_test = r(F) 

eststo educ4: reg divorce girl1 age2 agemarr2 agefb2 educyrs2 ageeduc marreduc fbeduc i.bpl i.statefip i.metarea if educyrs >= 16
test girl1 
estadd scalar F_test = r(F) 

eststo firstmar1: reg divorce girl1 age2 agemarr2 agefb2 educyrs2 ageeduc marreduc fbeduc i.bpl i.statefip i.metarea if agemarr <20
test girl1 
estadd scalar F_test = r(F) 

eststo firstmar2: reg divorce girl1 age2 agemarr2 agefb2 educyrs2 ageeduc marreduc fbeduc i.bpl i.statefip i.metarea if agemarr >= 20
test girl1
estadd scalar F_test = r(F) 

eststo agebirth1: reg divorce girl1 age2 agemarr2 agefb2 educyrs2 ageeduc marreduc fbeduc i.bpl i.statefip i.metarea if agefb <22
test girl1
estadd scalar F_test = r(F) 

eststo agebirth2: reg divorce girl1 age2 agemarr2 agefb2 educyrs2 ageeduc marreduc fbeduc i.bpl i.statefip i.metarea if agefb >=22
test girl1
estadd scalar F_test = r(F) 
}
esttab * using tables.rtf, append b(3) scalars(F_test N) keep(girl1) not nonum mtitles

eststo clear

// TABLE 3 DIFFERENCES IN MEANS //

estpost tabstat agemarr girl1 everborn agefb age educyrs urban, by(divorce) s(me sd) columns(statistics)
eststo divorce, title("By Divorce Status") 
estpost tabstat divorce agemarr everborn agefb age educyrs urban, by(girl1) s(me sd) columns(statistics)
eststo girl1, title("By Firstborn Sex")
esttab * using tables.rtf, append main(mean 3) aux(sd 3) unstack label mtitles nonum

eststo clear

eststo am: reg agemarr div, r
eststo girl: reg girl1 div, r
eststo everborn: reg everborn div, r
eststo fb: reg agefb div, r
eststo age: reg age div, r
eststo educ: reg educyrs div, r
eststo urb: reg urban div, r
esttab * using tables.rtf, append b(3) se(3) noobs nocons nonum label title(Mean diffs for table 3)
eststo clear

eststo div: reg div girl, r
eststo am: reg agemarr girl, r
eststo everborn: reg everborn girl, r
eststo fb: reg agefb girl, r
eststo age: reg age girl, r /* reverse sign */
eststo educ: reg educyrs girl, r
eststo urb: reg urban girl, r
esttab * using tables.rtf, append b(3) se(3) noobs nocons nonum label title(Mean diffs for table 3 firstborn)
eststo clear

// TABLE 4 //
gen employed = 1 if empstat == 1
replace employed = 0 if empstat == 2 | empstat == 3
label var employed "Working for pay"
label define yesno 1 "Yes" 0 "No"
label val employed yesno 

/* OLS col 1 */
foreach yvar of varlist stdhhinc povertyline nwinc inctot incwage employed uhrswork wkswork1 {
qui reg `yvar' divorce age2 agemarr2 agefb2 educyrs2 ageeduc marreduc fbeduc i.bpl i.statefip i.metarea, r
eststo `yvar'

local storelist = "`storelist' `yvar'"

}

esttab `storelist' using tables.rtf, append b(3) se(3) keep(divorce) nostar noobs nonum label mtitles title(OLS)

/* wald col 2 */
// test - ivregress 2sls stdhhinc (div = girl1), vce(r)

foreach yvar of varlist stdhhinc povertyline nwinc inctot incwage employed uhrswork wkswork1 {
qui ivregress 2sls `yvar' (divorce = girl1), vce(r) first
eststo `yvar'

local storelist = "`storelist' `yvar'"
}

esttab `storelist' using tables.rtf, append b(3) se(3) noobs nostar nonum label mtitles title(WALD)
eststo clear

/* 2sls col 3 */
// test - ivregress 2sls stdhhinc age2 agemarr2 agefb2 educyrs2 ageeduc marreduc fbeduc i.bpl i.statefip i.metarea (div = girl1), vce(r) 

foreach yvar of varlist stdhhinc povertyline nwinc inctot incwage employed uhrswork wkswork1 {
qui ivregress 2sls `yvar' age2 agemarr2 agefb2 educyrs2 ageeduc marreduc fbeduc i.bpl i.statefip i.metarea (divorce = girl1), vce(r)
eststo `yvar'

local storelist = "`storelist' `yvar'"
}

esttab `storelist' using tables.rtf, append b(3) se(3) keep(divorce) nostar noobs nonum label mtitles title(TSLS)
eststo clear

/* 2sls col4 use everborn & new var*/ 
age2 agemarr2 agefb2 educyrs2 ageeduc marreduc fbeduc i.bpl i.statefip i.metarea

/* new marital status var */
gen mar = 1 if marst == 1 | marst == 2 
gen mar1 = 1 if marrno == 2
gen mar2 = 1 if mar == 1 & mar1 == 1
replace mar2 = 0 if missing(mar2)
label var mar2 "Currently married, 2+ marriages"
label val mar2 yesno
drop mar mar1

foreach yvar of varlist stdhhinc povertyline nwinc inctot incwage employed uhrswork wkswork1 {
qui ivregress 2sls `yvar' everborn mar2 age2 agemarr2 agefb2 educyrs2 ageeduc marreduc fbeduc i.bpl i.statefip i.metarea (divorce = girl1), vce(r)
eststo `yvar'

local storelist = "`storelist' `yvar'"
}

esttab `storelist' using tables.rtf, append b(3) se(3) keep(divorce) nostar noobs nonum label mtitles title(TSLS4)
eststo clear

