
/** loop create new tx to randomize in same proportion of orig randomization. store statistics into new var. 
or store just a conditional whether it is above or below a cut off value and have tab running at each loop **/ 
/** PART VIII BONUS **/
/* Q18: */
estpost ttest got, by(any) /* diff =  -.4493691 */

clear all
prog drop _all
use "$datadir/hivdata_elig.dta", clear

set seed 12345
gen rannum = uniform()
sort rannum
gen grp = .
replace grp = 0 in 1/618
replace grp = 1 in 619/2812

forvalues i = 1/2812 {
estpost ttest got, by(grp)
if abs(e(b)) > abs(-.4493691) {
gen grtdiff = 1
}
else {
gen grtdiff = 0
}
end

/** DON'T USE OLD CODE **/
/** PART 1 **/
/* Q1 */
estpost tabstat age male hiv2004, s(mean sd) columns(statistics) 
esttab using tables.rtf, replace main(mean 2) aux(sd 2) unstack label nostar onecell title(Summary statistics)

/* Q2: summary stats control tx */
estpost tabstat age educ2004 hiv2004, by(any) s(mean sd max min count) nototal column(statistics)
esttab using tables.rtf, append main(mean) aux(sd) nostar unstack noobs label title(Summary statistics by receiving any incentive)

estpost tabstat age educ2004 hiv2004, by(under) s(mean sd max min count) nototal column(statistics)
esttab using tables.rtf, append main(mean) aux(sd) nostar unstack noobs label title(Summary statistics by distance under 1.5 km)

/* Q3: differences in age, hiv, mar */
estpost ttest educ2004 age hiv2004 mar, by(any)
esttab * using tables.rtf, replace main(b) aux(se) wide label mtitles("Mean diff") title(t-test of differences by receiving any incentive) varwidth(30)

estpost ttest educ2004 age hiv2004 mar, by(under)
esttab using tables.rtf, append se wide label mtitles("Mean diff") title(t-test of differences by distance under 1.5km) varwidth(30)

/* Q7: group means comparison */
ttest got, by(any) /* -0.4494 same as original OLS but negative. 
Going from 1 to 0 decrease the probability of receiving a test by .45 */


