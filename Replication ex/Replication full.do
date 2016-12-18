/* Jennifer Dolatshahi
 REPLICATION EXERCISE
 full do file
 December 19, 2016 */

clear all
prog drop _all
capture log close
set more off, permanently

global datadir "/Users/Jennifer/Documents/school/NYU Wagner/16-17/Advanced Empirical/Adv-empirical/Replication ex"
global results "/Users/Jennifer/Documents/school/NYU Wagner/16-17/Advanced Empirical/Adv-empirical/Replication ex"

log using "$results/log_replicationfull.smcl", replace
use "$datadir/usa_00005.dta", clear

order *, alpha
rename *, lower

/* IDENTIFY ELDEST CHILD - 1,964,278 */


/* # children, # adults per household */ 
qui bysort serial: egen adults = total(age >= 18)    
qui bysort serial: egen minors = total(age < 18)
qui bysort serial: gen hhsize = _N

save usa_edited.dta, replace 

/*
sort serial 
qui bysort serial: gen adult = _n if age >= 18



sort serial adult
qui by serial adult: gen child = _n if age < 18
qui by serial adult: egen minor = max(child) 

sort serial 
qui by serial: egen minors = max(minor)

drop child adult minor

replace minors = 0 if missing(minors)
replace adults = 0 if missing(adults)

qui by serial: gen hhsize = adults + minors */



/** KIDS DATASET **/

use usa_edited.dta, clear
keep if momloc >00 & stepmom == 0
save child.dta, replace

gen eldchild = .
gen eldage = .
gen child = .
replace child = 1 if momloc > 00 & stepmom == 0 
egen work = max(age*child), by(serial momloc)
replace eldage = work if child == 1 & age == work
replace eldchild = 1 if !missing(eldage) 
drop child work eldage 

//twins by age birthqtr 62, 149
qui bysort serial eldchild age birthqtr: gen twins = cond(_N == 1 , 0 , 1)

// twins just by age 107, 484

// qui bysort serial eldchild age: gen twinsage = cond(_N == 1, 0, 1) 

// just use twins

// eldest child & not allocated age, sex, relationship to hh, or birth quarter

gen famelig = . 
replace famelig = 1 if eldchild == 1 & qage == 0 & qsex == 0 & qrelate == 0 & qbirthmo == 0

rename (age sex momrule) =_c
label var age_c "Age of child"
label var sex_c "Sex of child"
label var momrule_c "Mom Rule for child"

gen serialpernum = string(serial, "%02.0f")+string(momloc, "%02.0f")

save childelig.dta, replace 

use childelig.dta, clear
keep if eldchild == 1

save childelig2.dta, replace

/* *  MUMS DATASET * */

use usa_edited.dta, clear

keep if chborn >= 2 & sex ==2 /* 1 or more children - 3,044,820  */

save mums.dta, replace


//________________________________________

/** FINAL SAMPLE **/
use mums.dta, clear

rename * , lower


// currently age 21 - 40; ever been married; 1st marriage 17 - 26; U.S. Born, including Amer. Samoa, Guam, PR, U.S. VI, Other US Posessions; white; not widow */
gen elig = .
replace elig = 1 if age >= 21 & age <= 40 & marst >= 1 & marst < 5 & agemarr >=17 & agemarr <= 26 & bpl >=1 & bpl <= 120 & race == 1

gen notallocated = .
replace notallocated = 1 if qage == 0 & qmarrno == 0 & qmarst == 0 & qagemarr == 0 & qchborn == 0 & qrelate == 0 & qsex == 0 


// MERGE IN CHILD SET
gen serialpernum = string(serial, "%02.0f")+string(pernum, "%02.0f")

merge 1:m serialpernum using childelig.dta 

merge 1:m serialpernum using childelig2.dta 

// tab elig famelig  708,738

tab elig famelig if notallocated == 1 /*   655, 849 ??? */

keep if elig == 1 & famelig == 1 & notallocated == 1


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

/* hh_poverty */ 
gen povertyline = .
replace povertyline = 1 if poverty <100
replace povertyline = 0 if poverty >= 100
label var povertyline "Poverty"

gen people=1

gen poverty_hh=0
replace poverty_hh=172*hhincome/6310 if adults==1 & minors==0 
replace poverty_hh=172*hhincome/8547 if adults==1 & minors==1 
replace poverty_hh=172*hhincome/9990 if adults==1 & minors==2 
replace poverty_hh=172*hhincome/12619 if adults==1 & minors==3 
replace poverty_hh=172*hhincome/14572 if adults==1 & minors==4 
replace poverty_hh=172*hhincome/16259 if adults==1 & minors==5 
replace poverty_hh=172*hhincome/17828 if adults==1 & minors>=6 
replace poverty_hh=172*hhincome/8303 if adults==2 & minors==0 
replace poverty_hh=172*hhincome/9981 if adults==2 & minors==1 
replace poverty_hh=172*hhincome/12575 if adults==2 & minors==2 
replace poverty_hh=172*hhincome/14798 if adults==2 & minors==3 
replace poverty_hh=172*hhincome/16569 if adults==2 & minors==4 
replace poverty_hh=172*hhincome/18558 if adults==2 & minors==5 
replace poverty_hh=172*hhincome/20403 if adults==2 & minors>=6 
replace poverty_hh=172*hhincome/9699 if adults==3 & minors==0 
replace poverty_hh=172*hhincome/12999 if adults==3 & minors==1 
replace poverty_hh=172*hhincome/15169 if adults==3 & minors==2 
replace poverty_hh=172*hhincome/17092 if adults==3 & minors==3 
replace poverty_hh=172*hhincome/19224 if adults==3 & minors==4 
replace poverty_hh=172*hhincome/21084 if adults==3 & minors==5 
replace poverty_hh=172*hhincome/25089 if adults==3 & minors>=6 
replace poverty_hh=172*hhincome/12790 if adults==4 & minors==0 
replace poverty_hh=172*hhincome/15648 if adults==4 & minors==1 
replace poverty_hh=172*hhincome/17444 if adults==4 & minors==2 
replace poverty_hh=172*hhincome/19794 if adults==4 & minors==3 
replace poverty_hh=172*hhincome/21738 if adults==4 & minors==4 
replace poverty_hh=172*hhincome/25719 if adults==4 & minors>=5 
replace poverty_hh=172*hhincome/15424 if adults==5 & minors==0 
replace poverty_hh=172*hhincome/17811 if adults==5 & minors==1 
replace poverty_hh=172*hhincome/20101 if adults==5 & minors==2 
replace poverty_hh=172*hhincome/22253 if adults==5 & minors==3 
replace poverty_hh=172*hhincome/26415 if adults==5 & minors>=4 
replace poverty_hh=172*hhincome/17740 if adults==6 & minors==0 
replace poverty_hh=172*hhincome/20540 if adults==6 & minors==1 
replace poverty_hh=172*hhincome/22617 if adults==6 & minors==2 
replace poverty_hh=172*hhincome/26921 if adults==6 & minors>=3 
replace poverty_hh=172*hhincome/20412 if adults==7 & minors==0 
replace poverty_hh=172*hhincome/23031 if adults==7 & minors==1 
replace poverty_hh=172*hhincome/27229 if adults==7 & minors>=2 
replace poverty_hh=172*hhincome/22830 if adults==8 & minors==0 
replace poverty_hh=172*hhincome/27596 if adults==8 & minors>=1 
replace poverty_hh=172*hhincome/27463 if adults>=9 & minors>=0
replace poverty_hh = poverty_hh/100

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
estpost tabstat firstend agemarr everborn age educyrs urban stdhhinc poverty_hh nwinc inctot incwage, s(me sd) columns(statistics)
eststo evermar, title("Ever-Married with Children")
estpost tabstat firstend agemarr girl1 everborn agefb age educyrs urban stdhhinc poverty_hh nwinc inctot incwage if inhh == 1 & twins != 1, s(me sd) columns(statistics)
eststo inhh, title("All Children Live in Household")
estpost tabstat firstend agemarr girl1 everborn agefb age educyrs urban stdhhinc poverty_hh nwinc inctot incwage if inhh == 1 & fiveyears == 1 & twins !=1, s(me sd) columns(statistics)
eststo fiveyears, title("1st Child Born Within 5 Years of 1st Marriage")
esttab * ., replace main(mean 2) aux(sd 2) label mtitles 

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
esttab * using tables.rtf, replace b(2) scalars(F N) mtitles label
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
esttab * using tables.rtf, append b(3) scalars(F_test N) keep(girl1) not nonum mtitles label

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

esttab `storelist' using tables.rtf, append b(3) se(3) keep(divorce) nostar noobs nonum label mtitles(`yvar') title(OLS)
eststo clear 

/* wald col 2 */
// test - ivregress 2sls stdhhinc (div = girl1), vce(r)

foreach yvar of varlist stdhhinc povertyline nwinc inctot incwage employed uhrswork wkswork1 {
qui ivregress 2sls `yvar' (divorce = girl1), vce(r) first
eststo `yvar'

local storelist = "`storelist' `yvar'"
}

esttab `storelist' using tables.rtf, append b(3) se(3) noobs nostar nonum label mtitles(`yvar') title(WALD)
eststo clear

/* 2sls col 3 */
// test - ivregress 2sls stdhhinc age2 agemarr2 agefb2 educyrs2 ageeduc marreduc fbeduc i.bpl i.statefip i.metarea (div = girl1), vce(r) 

foreach yvar of varlist stdhhinc povertyline nwinc inctot incwage employed uhrswork wkswork1 {
qui ivregress 2sls `yvar' age2 agemarr2 agefb2 educyrs2 ageeduc marreduc fbeduc i.bpl i.statefip i.metarea (divorce = girl1), vce(r)
eststo `yvar'

local storelist = "`storelist' `yvar'"
}

esttab `storelist' using tables.rtf, append b(3) se(3) keep(divorce) nostar noobs nonum label mtitles(`yvar') title(TSLS)
eststo clear

/* 2sls col4 use everborn & new var*/ 
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

esttab `storelist' using tables.rtf, append b(3) se(3) keep(divorce) nostar noobs nonum label mtitles(`yvar') title(TSLS4)
eststo clear

//TABLE 5 //
/* col 2 OLS */
foreach yvar of varlist stdhhinc povertyline nwinc inctot incwage employed uhrswork wkswork1 {
qui reg `yvar' divorce age2 agemarr2 agefb2 educyrs2 ageeduc marreduc fbeduc i.bpl i.statefip i.metarea if age_c < 12, r
eststo `yvar'

local storelist = "`storelist' `yvar'"

}

esttab `storelist' using tables.rtf, append b(3) se(3) scalar(F_test) keep(divorce) nostar nonum label mtitles(`yvar') title(OLS <12)
eststo clear

/* col 3 OLS */

foreach yvar of varlist stdhhinc povertyline nwinc inctot incwage employed uhrswork wkswork1 {
qui reg `yvar' divorce age2 agemarr2 agefb2 educyrs2 ageeduc marreduc fbeduc i.bpl i.statefip i.metarea if age_c >= 12, r
eststo `yvar'

local storelist = "`storelist' `yvar'"

}

esttab `storelist' using tables.rtf, append label b(3) se(3) keep(divorce) nostar mtitles(`yvar') title(OLS 12+)
eststo clear

/* col 2 TSLS */
//test - ivregress 2sls stdhhinc age2 agemarr2 agefb2 educyrs2 ageeduc marreduc fbeduc i.bpl i.statefip i.metarea (divorce = girl1) if age_c <12 , vce(r) first

foreach yvar of varlist stdhhinc povertyline nwinc inctot incwage employed uhrswork wkswork1 {
qui ivregress 2sls `yvar' age2 agemarr2 agefb2 educyrs2 ageeduc marreduc fbeduc i.bpl i.statefip i.metarea (divorce = girl1) if age_c <12, vce(r)
eststo `yvar'

local storelist = "`storelist' `yvar'"
}

esttab `storelist' using tables.rtf, append b(3) se(3) keep(divorce) nostar nonum label mtitles(`yvar') title(TSLS <12)
eststo clear

/* F-stat */
qui reg divorce girl1 age2 agemarr2 agefb2 educyrs2 ageeduc marreduc fbeduc i.bpl i.statefip i.metarea if age_c <12, r
test girl1 /** 13.37 **/

/* col 3 TSLS */
// test ivregress 2sls stdhhinc age2 agemarr2 agefb2 educyrs2 ageeduc marreduc fbeduc i.bpl i.statefip i.metarea (divorce = girl1) if age_c >=12, vce(r) first

foreach yvar of varlist stdhhinc povertyline nwinc inctot incwage employed uhrswork wkswork1 {
qui ivregress 2sls `yvar' age2 agemarr2 agefb2 educyrs2 ageeduc marreduc fbeduc i.bpl i.statefip i.metarea (divorce = girl1) if age_c >=12, vce(r)
eststo `yvar'

local storelist = "`storelist' `yvar'"
}

esttab `storelist' using tables.rtf, append b(3) se(3) keep(divorce) nostar nonum label mtitles(`yvar') title(TSLS 12+)
eststo clear

/* F-stat */
qui reg divorce girl1 age2 agemarr2 agefb2 educyrs2 ageeduc marreduc fbeduc i.bpl i.statefip i.metarea if age_c >=12, r
test girl1 /** 27.67 **/
