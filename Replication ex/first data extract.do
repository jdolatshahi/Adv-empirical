* FIRST DATA EXTRACT - .do file from IPUMS - changed directory & .dat name

set more off

cd "/Users/Jennifer/Documents/school/NYU Wagner/16-17/Advanced Empirical/Replication ex"

clear
quietly infix                ///
  int     year      1-4      ///
  byte    datanum   5-6      ///
  double  serial    7-14     ///
  float   hhwt      15-24    ///
  byte    statefip  25-26    ///
  int     metarea   27-29    ///
  int     metaread  30-33    ///
  byte    gq        34-34    ///
  long    hhincome  35-41    ///
  int     pernum    42-45    ///
  float   perwt     46-55    ///
  byte    nchild    56-56    ///
  byte    eldch     57-58    ///
  byte    momloc    59-60    ///
  byte    sploc     61-62    ///
  byte    sex       63-63    ///
  int     age       64-66    ///
  byte    marst     67-67    ///
  byte    marrno    68-68    ///
  byte    agemarr   69-70    ///
  byte    chborn    71-72    ///
  byte    educ      73-74    ///
  int     educd     75-77    ///
  long    inctot    78-84    ///
  long    incwage   85-90    ///
  long    incwelfr  91-95    ///
  long    incother  96-100   ///
  int     poverty   101-103  ///
  using "first_data_extract.dat"

replace hhwt     = hhwt     / 100
replace perwt    = perwt    / 100

format serial   %8.0f
format hhwt     %10.2f
format perwt    %10.2f

label var year     `"Census year"'
label var datanum  `"Data set number"'
label var serial   `"Household serial number"'
label var hhwt     `"Household weight"'
label var statefip `"State (FIPS code)"'
label var metarea  `"Metropolitan area [general version]"'
label var metaread `"Metropolitan area [detailed version]"'
label var gq       `"Group quarters status"'
label var hhincome `"Total household income"'
label var pernum   `"Person number in sample unit"'
label var perwt    `"Person weight"'
label var nchild   `"Number of own children in the household"'
label var eldch    `"Age of eldest own child in household"'
label var momloc   `"Mother's location in the household"'
label var sploc    `"Spouse's location in household"'
label var sex      `"Sex"'
label var age      `"Age"'
label var marst    `"Marital status"'
label var marrno   `"Times married"'
label var agemarr  `"Age at first marriage"'
label var chborn   `"Children ever born"'
label var educ     `"Educational attainment [general version]"'
label var educd    `"Educational attainment [detailed version]"'
label var inctot   `"Total personal income"'
label var incwage  `"Wage and salary income"'
label var incwelfr `"Welfare (public assistance) income"'
label var incother `"Other income"'
label var poverty  `"Poverty status"'

label define year_lbl 1850 `"1850"'
label define year_lbl 1860 `"1860"', add
label define year_lbl 1870 `"1870"', add
label define year_lbl 1880 `"1880"', add
label define year_lbl 1900 `"1900"', add
label define year_lbl 1910 `"1910"', add
label define year_lbl 1920 `"1920"', add
label define year_lbl 1930 `"1930"', add
label define year_lbl 1940 `"1940"', add
label define year_lbl 1950 `"1950"', add
label define year_lbl 1960 `"1960"', add
label define year_lbl 1970 `"1970"', add
label define year_lbl 1980 `"1980"', add
label define year_lbl 1990 `"1990"', add
label define year_lbl 2000 `"2000"', add
label define year_lbl 2001 `"2001"', add
label define year_lbl 2002 `"2002"', add
label define year_lbl 2003 `"2003"', add
label define year_lbl 2004 `"2004"', add
label define year_lbl 2005 `"2005"', add
label define year_lbl 2006 `"2006"', add
label define year_lbl 2007 `"2007"', add
label define year_lbl 2008 `"2008"', add
label define year_lbl 2009 `"2009"', add
label define year_lbl 2010 `"2010"', add
label define year_lbl 2011 `"2011"', add
label define year_lbl 2012 `"2012"', add
label define year_lbl 2013 `"2013"', add
label define year_lbl 2014 `"2014"', add
label values year year_lbl

label define statefip_lbl 01 `"Alabama"'
label define statefip_lbl 02 `"Alaska"', add
label define statefip_lbl 04 `"Arizona"', add
label define statefip_lbl 05 `"Arkansas"', add
label define statefip_lbl 06 `"California"', add
label define statefip_lbl 08 `"Colorado"', add
label define statefip_lbl 09 `"Connecticut"', add
label define statefip_lbl 10 `"Delaware"', add
label define statefip_lbl 11 `"District of Columbia"', add
label define statefip_lbl 12 `"Florida"', add
label define statefip_lbl 13 `"Georgia"', add
label define statefip_lbl 15 `"Hawaii"', add
label define statefip_lbl 16 `"Idaho"', add
label define statefip_lbl 17 `"Illinois"', add
label define statefip_lbl 18 `"Indiana"', add
label define statefip_lbl 19 `"Iowa"', add
label define statefip_lbl 20 `"Kansas"', add
label define statefip_lbl 21 `"Kentucky"', add
label define statefip_lbl 22 `"Louisiana"', add
label define statefip_lbl 23 `"Maine"', add
label define statefip_lbl 24 `"Maryland"', add
label define statefip_lbl 25 `"Massachusetts"', add
label define statefip_lbl 26 `"Michigan"', add
label define statefip_lbl 27 `"Minnesota"', add
label define statefip_lbl 28 `"Mississippi"', add
label define statefip_lbl 29 `"Missouri"', add
label define statefip_lbl 30 `"Montana"', add
label define statefip_lbl 31 `"Nebraska"', add
label define statefip_lbl 32 `"Nevada"', add
label define statefip_lbl 33 `"New Hampshire"', add
label define statefip_lbl 34 `"New Jersey"', add
label define statefip_lbl 35 `"New Mexico"', add
label define statefip_lbl 36 `"New York"', add
label define statefip_lbl 37 `"North Carolina"', add
label define statefip_lbl 38 `"North Dakota"', add
label define statefip_lbl 39 `"Ohio"', add
label define statefip_lbl 40 `"Oklahoma"', add
label define statefip_lbl 41 `"Oregon"', add
label define statefip_lbl 42 `"Pennsylvania"', add
label define statefip_lbl 44 `"Rhode Island"', add
label define statefip_lbl 45 `"South Carolina"', add
label define statefip_lbl 46 `"South Dakota"', add
label define statefip_lbl 47 `"Tennessee"', add
label define statefip_lbl 48 `"Texas"', add
label define statefip_lbl 49 `"Utah"', add
label define statefip_lbl 50 `"Vermont"', add
label define statefip_lbl 51 `"Virginia"', add
label define statefip_lbl 53 `"Washington"', add
label define statefip_lbl 54 `"West Virginia"', add
label define statefip_lbl 55 `"Wisconsin"', add
label define statefip_lbl 56 `"Wyoming"', add
label define statefip_lbl 61 `"Maine-New Hampshire-Vermont"', add
label define statefip_lbl 62 `"Massachusetts-Rhode Island"', add
label define statefip_lbl 63 `"Minnesota-Iowa-Missouri-Kansas-Nebraska-S.Dakota-N.Dakota"', add
label define statefip_lbl 64 `"Maryland-Delaware"', add
label define statefip_lbl 65 `"Montana-Idaho-Wyoming"', add
label define statefip_lbl 66 `"Utah-Nevada"', add
label define statefip_lbl 67 `"Arizona-New Mexico"', add
label define statefip_lbl 68 `"Alaska-Hawaii"', add
label define statefip_lbl 72 `"Puerto Rico"', add
label define statefip_lbl 97 `"Military/Mil. Reservation"', add
label define statefip_lbl 99 `"State not identified"', add
label values statefip statefip_lbl

label define metarea_lbl 000 `"Not identifiable or not in an MSA"'
label define metarea_lbl 004 `"Abilene, TX"', add
label define metarea_lbl 006 `"Aguadilla, PR"', add
label define metarea_lbl 008 `"Akron, OH"', add
label define metarea_lbl 012 `"Albany, GA"', add
label define metarea_lbl 016 `"Albany-Schenectady-Troy, NY"', add
label define metarea_lbl 020 `"Albuquerque, NM"', add
label define metarea_lbl 022 `"Alexandria, LA"', add
label define metarea_lbl 024 `"Allentown-Bethlehem-Easton, PA/NJ"', add
label define metarea_lbl 028 `"Altoona, PA"', add
label define metarea_lbl 032 `"Amarillo, TX"', add
label define metarea_lbl 038 `"Anchorage, AK"', add
label define metarea_lbl 040 `"Anderson, IN"', add
label define metarea_lbl 044 `"Ann Arbor, MI"', add
label define metarea_lbl 045 `"Anniston, AL"', add
label define metarea_lbl 046 `"Appleton-Oshkosh-Neenah, WI"', add
label define metarea_lbl 047 `"Arecibo, PR"', add
label define metarea_lbl 048 `"Asheville, NC"', add
label define metarea_lbl 050 `"Athens, GA"', add
label define metarea_lbl 052 `"Atlanta, GA"', add
label define metarea_lbl 056 `"Atlantic City, NJ"', add
label define metarea_lbl 058 `"Auburn-Opekika, AL"', add
label define metarea_lbl 060 `"Augusta-Aiken, GA/SC"', add
label define metarea_lbl 064 `"Austin, TX"', add
label define metarea_lbl 068 `"Bakersfield, CA"', add
label define metarea_lbl 072 `"Baltimore, MD"', add
label define metarea_lbl 073 `"Bangor, ME"', add
label define metarea_lbl 074 `"Barnstable-Yarmouth, MA"', add
label define metarea_lbl 076 `"Baton Rouge, LA"', add
label define metarea_lbl 078 `"Battle Creek, MI"', add
label define metarea_lbl 084 `"Beaumont-Port Arthur-Orange, TX"', add
label define metarea_lbl 086 `"Bellingham, WA"', add
label define metarea_lbl 087 `"Benton Harbor, MI"', add
label define metarea_lbl 088 `"Billings, MT"', add
label define metarea_lbl 092 `"Biloxi-Gulfport, MS"', add
label define metarea_lbl 096 `"Binghamton, NY"', add
label define metarea_lbl 100 `"Birmingham, AL"', add
label define metarea_lbl 102 `"Bloomington, IN"', add
label define metarea_lbl 104 `"Bloomington-Normal, IL"', add
label define metarea_lbl 108 `"Boise City, ID"', add
label define metarea_lbl 112 `"Boston, MA/NH"', add
label define metarea_lbl 114 `"Bradenton, FL"', add
label define metarea_lbl 115 `"Bremerton, WA"', add
label define metarea_lbl 116 `"Bridgeport, CT"', add
label define metarea_lbl 120 `"Brockton, MA"', add
label define metarea_lbl 124 `"Brownsville-Harlingen-San Benito, TX"', add
label define metarea_lbl 126 `"Bryan-College Station, TX"', add
label define metarea_lbl 128 `"Buffalo-Niagara Falls, NY"', add
label define metarea_lbl 130 `"Burlington, NC"', add
label define metarea_lbl 131 `"Burlington, VT"', add
label define metarea_lbl 132 `"Canton, OH"', add
label define metarea_lbl 133 `"Caguas, PR"', add
label define metarea_lbl 135 `"Casper, WY"', add
label define metarea_lbl 136 `"Cedar Rapids, IA"', add
label define metarea_lbl 140 `"Champaign-Urbana-Rantoul, IL"', add
label define metarea_lbl 144 `"Charleston-N. Charleston, SC"', add
label define metarea_lbl 148 `"Charleston, WV"', add
label define metarea_lbl 152 `"Charlotte-Gastonia-Rock Hill, NC/SC"', add
label define metarea_lbl 154 `"Charlottesville, VA"', add
label define metarea_lbl 156 `"Chattanooga, TN/GA"', add
label define metarea_lbl 158 `"Cheyenne, WY"', add
label define metarea_lbl 160 `"Chicago, IL"', add
label define metarea_lbl 162 `"Chico, CA"', add
label define metarea_lbl 164 `"Cincinnati-Hamilton, OH/KY/IN"', add
label define metarea_lbl 166 `"Clarksville- Hopkinsville, TN/KY"', add
label define metarea_lbl 168 `"Cleveland, OH"', add
label define metarea_lbl 172 `"Colorado Springs, CO"', add
label define metarea_lbl 174 `"Columbia, MO"', add
label define metarea_lbl 176 `"Columbia, SC"', add
label define metarea_lbl 180 `"Columbus, GA/AL"', add
label define metarea_lbl 184 `"Columbus, OH"', add
label define metarea_lbl 188 `"Corpus Christi, TX"', add
label define metarea_lbl 190 `"Cumberland, MD/WV"', add
label define metarea_lbl 192 `"Dallas-Fort Worth, TX"', add
label define metarea_lbl 193 `"Danbury, CT"', add
label define metarea_lbl 195 `"Danville, VA"', add
label define metarea_lbl 196 `"Davenport, IA - Rock Island-Moline, IL"', add
label define metarea_lbl 200 `"Dayton-Springfield, OH"', add
label define metarea_lbl 202 `"Daytona Beach, FL"', add
label define metarea_lbl 203 `"Decatur, AL"', add
label define metarea_lbl 204 `"Decatur, IL"', add
label define metarea_lbl 208 `"Denver-Boulder, CO"', add
label define metarea_lbl 212 `"Des Moines, IA"', add
label define metarea_lbl 216 `"Detroit, MI"', add
label define metarea_lbl 218 `"Dothan, AL"', add
label define metarea_lbl 219 `"Dover, DE"', add
label define metarea_lbl 220 `"Dubuque, IA"', add
label define metarea_lbl 224 `"Duluth-Superior, MN/WI"', add
label define metarea_lbl 228 `"Dutchess Co., NY"', add
label define metarea_lbl 229 `"Eau Claire, WI"', add
label define metarea_lbl 231 `"El Paso, TX"', add
label define metarea_lbl 232 `"Elkhart-Goshen, IN"', add
label define metarea_lbl 233 `"Elmira, NY"', add
label define metarea_lbl 234 `"Enid, OK"', add
label define metarea_lbl 236 `"Erie, PA"', add
label define metarea_lbl 240 `"Eugene-Springfield, OR"', add
label define metarea_lbl 244 `"Evansville, IN/KY"', add
label define metarea_lbl 252 `"Fargo-Morehead, ND/MN"', add
label define metarea_lbl 256 `"Fayetteville, NC"', add
label define metarea_lbl 258 `"Fayetteville-Springdale, AR"', add
label define metarea_lbl 260 `"Fitchburg-Leominster, MA"', add
label define metarea_lbl 262 `"Flagstaff, AZ/UT"', add
label define metarea_lbl 264 `"Flint, MI"', add
label define metarea_lbl 265 `"Florence, AL"', add
label define metarea_lbl 266 `"Florence, SC"', add
label define metarea_lbl 267 `"Fort Collins-Loveland, CO"', add
label define metarea_lbl 268 `"Fort Lauderdale-Hollywood-Pompano Beach, FL"', add
label define metarea_lbl 270 `"Fort Myers-Cape Coral, FL"', add
label define metarea_lbl 271 `"Fort Pierce, FL"', add
label define metarea_lbl 272 `"Fort Smith, AR/OK"', add
label define metarea_lbl 275 `"Fort Walton Beach, FL"', add
label define metarea_lbl 276 `"Fort Wayne, IN"', add
label define metarea_lbl 284 `"Fresno, CA"', add
label define metarea_lbl 288 `"Gadsden, AL"', add
label define metarea_lbl 290 `"Gainesville, FL"', add
label define metarea_lbl 292 `"Galveston-Texas City, TX"', add
label define metarea_lbl 297 `"Glens Falls, NY"', add
label define metarea_lbl 298 `"Goldsboro, NC"', add
label define metarea_lbl 299 `"Grand Forks, ND"', add
label define metarea_lbl 300 `"Grand Rapids, MI"', add
label define metarea_lbl 301 `"Grand Junction, CO"', add
label define metarea_lbl 304 `"Great Falls, MT"', add
label define metarea_lbl 306 `"Greeley, CO"', add
label define metarea_lbl 308 `"Green Bay, WI"', add
label define metarea_lbl 312 `"Greensboro-Winston Salem-High Point, NC"', add
label define metarea_lbl 315 `"Greenville, NC"', add
label define metarea_lbl 316 `"Greenville-Spartenburg-Anderson, SC"', add
label define metarea_lbl 318 `"Hagerstown, MD"', add
label define metarea_lbl 320 `"Hamilton-Middleton, OH"', add
label define metarea_lbl 324 `"Harrisburg-Lebanon--Carlisle, PA"', add
label define metarea_lbl 328 `"Hartford-Bristol-Middleton- New Britain, CT"', add
label define metarea_lbl 329 `"Hickory-Morgantown, NC"', add
label define metarea_lbl 330 `"Hattiesburg, MS"', add
label define metarea_lbl 332 `"Honolulu, HI"', add
label define metarea_lbl 335 `"Houma-Thibodoux, LA"', add
label define metarea_lbl 336 `"Houston-Brazoria, TX"', add
label define metarea_lbl 340 `"Huntington-Ashland, WV/KY/OH"', add
label define metarea_lbl 344 `"Huntsville, AL"', add
label define metarea_lbl 348 `"Indianapolis, IN"', add
label define metarea_lbl 350 `"Iowa City, IA"', add
label define metarea_lbl 352 `"Jackson, MI"', add
label define metarea_lbl 356 `"Jackson, MS"', add
label define metarea_lbl 358 `"Jackson, TN"', add
label define metarea_lbl 359 `"Jacksonville, FL"', add
label define metarea_lbl 360 `"Jacksonville, NC"', add
label define metarea_lbl 361 `"Jamestown-Dunkirk, NY"', add
label define metarea_lbl 362 `"Janesville-Beloit, WI"', add
label define metarea_lbl 366 `"Johnson City-Kingsport--Bristol, TN/VA"', add
label define metarea_lbl 368 `"Johnstown, PA"', add
label define metarea_lbl 371 `"Joplin, MO"', add
label define metarea_lbl 372 `"Kalamazoo-Portage, MI"', add
label define metarea_lbl 374 `"Kankakee, IL"', add
label define metarea_lbl 376 `"Kansas City, MO/KS"', add
label define metarea_lbl 380 `"Kenosha, WI"', add
label define metarea_lbl 381 `"Kileen-Temple, TX"', add
label define metarea_lbl 384 `"Knoxville, TN"', add
label define metarea_lbl 385 `"Kokomo, IN"', add
label define metarea_lbl 387 `"LaCrosse, WI"', add
label define metarea_lbl 388 `"Lafayette, LA"', add
label define metarea_lbl 392 `"Lafayette-W. Lafayette, IN"', add
label define metarea_lbl 396 `"Lake Charles, LA"', add
label define metarea_lbl 398 `"Lakeland-Winterhaven, FL"', add
label define metarea_lbl 400 `"Lancaster, PA"', add
label define metarea_lbl 404 `"Lansing-E. Lansing, MI"', add
label define metarea_lbl 408 `"Laredo, TX"', add
label define metarea_lbl 410 `"Las Cruces, NM"', add
label define metarea_lbl 412 `"Las Vegas, NV"', add
label define metarea_lbl 415 `"Lawrence, KS"', add
label define metarea_lbl 420 `"Lawton, OK"', add
label define metarea_lbl 424 `"Lewiston-Auburn, ME"', add
label define metarea_lbl 428 `"Lexington-Fayette, KY"', add
label define metarea_lbl 432 `"Lima, OH"', add
label define metarea_lbl 436 `"Lincoln, NE"', add
label define metarea_lbl 440 `"Little Rock-N. Little Rock, AR"', add
label define metarea_lbl 441 `"Long Branch-Asbury Park, NJ"', add
label define metarea_lbl 442 `"Longview-Marshall, TX"', add
label define metarea_lbl 444 `"Lorain-Elyria, OH"', add
label define metarea_lbl 448 `"Los Angeles-Long Beach, CA"', add
label define metarea_lbl 452 `"Louisville, KY/IN"', add
label define metarea_lbl 460 `"Lubbock, TX"', add
label define metarea_lbl 464 `"Lynchburg, VA"', add
label define metarea_lbl 468 `"Macon-Warner Robins, GA"', add
label define metarea_lbl 472 `"Madison, WI"', add
label define metarea_lbl 476 `"Manchester, NH"', add
label define metarea_lbl 480 `"Mansfield, OH"', add
label define metarea_lbl 484 `"Mayaguez, PR"', add
label define metarea_lbl 488 `"McAllen-Edinburg-Pharr-Mission, TX"', add
label define metarea_lbl 489 `"Medford, OR"', add
label define metarea_lbl 490 `"Melbourne-Titusville-Cocoa-Palm Bay, FL"', add
label define metarea_lbl 492 `"Memphis, TN/AR/MS"', add
label define metarea_lbl 494 `"Merced, CA"', add
label define metarea_lbl 500 `"Miami-Hialeah, FL"', add
label define metarea_lbl 504 `"Midland, TX"', add
label define metarea_lbl 508 `"Milwaukee, WI"', add
label define metarea_lbl 512 `"Minneapolis-St. Paul, MN"', add
label define metarea_lbl 514 `"Missoula, MT"', add
label define metarea_lbl 516 `"Mobile, AL"', add
label define metarea_lbl 517 `"Modesto, CA"', add
label define metarea_lbl 519 `"Monmouth-Ocean, NJ"', add
label define metarea_lbl 520 `"Monroe, LA"', add
label define metarea_lbl 524 `"Montgomery, AL"', add
label define metarea_lbl 528 `"Muncie, IN"', add
label define metarea_lbl 532 `"Muskegon-Norton Shores-Muskegon Heights, MI"', add
label define metarea_lbl 533 `"Myrtle Beach, SC"', add
label define metarea_lbl 534 `"Naples, FL"', add
label define metarea_lbl 535 `"Nashua, NH"', add
label define metarea_lbl 536 `"Nashville, TN"', add
label define metarea_lbl 540 `"New Bedford, MA"', add
label define metarea_lbl 546 `"New Brunswick-Perth Amboy-Sayreville, NJ"', add
label define metarea_lbl 548 `"New Haven-Meriden, CT"', add
label define metarea_lbl 552 `"New London-Norwich, CT/RI"', add
label define metarea_lbl 556 `"New Orleans, LA"', add
label define metarea_lbl 560 `"New York, NY-Northeastern NJ"', add
label define metarea_lbl 564 `"Newark, OH"', add
label define metarea_lbl 566 `"Newburgh-Middletown, NY"', add
label define metarea_lbl 572 `"Norfolk-VA Beach--Newport News, VA"', add
label define metarea_lbl 576 `"Norwalk, CT"', add
label define metarea_lbl 579 `"Ocala, FL"', add
label define metarea_lbl 580 `"Odessa, TX"', add
label define metarea_lbl 588 `"Oklahoma City, OK"', add
label define metarea_lbl 591 `"Olympia, WA"', add
label define metarea_lbl 592 `"Omaha, NE/IA"', add
label define metarea_lbl 595 `"Orange, NY"', add
label define metarea_lbl 596 `"Orlando, FL"', add
label define metarea_lbl 599 `"Owensboro, KY"', add
label define metarea_lbl 601 `"Panama City, FL"', add
label define metarea_lbl 602 `"Parkersburg-Marietta,WV/OH"', add
label define metarea_lbl 603 `"Pascagoula-Moss Point, MS"', add
label define metarea_lbl 608 `"Pensacola, FL"', add
label define metarea_lbl 612 `"Peoria, IL"', add
label define metarea_lbl 616 `"Philadelphia, PA/NJ"', add
label define metarea_lbl 620 `"Phoenix, AZ"', add
label define metarea_lbl 628 `"Pittsburgh, PA"', add
label define metarea_lbl 632 `"Pittsfield, MA"', add
label define metarea_lbl 636 `"Ponce, PR"', add
label define metarea_lbl 640 `"Portland, ME"', add
label define metarea_lbl 644 `"Portland, OR/WA"', add
label define metarea_lbl 645 `"Portsmouth-Dover--Rochester, NH/ME"', add
label define metarea_lbl 646 `"Poughkeepsie, NY"', add
label define metarea_lbl 648 `"Providence-Fall River-Pawtucket, MA/RI"', add
label define metarea_lbl 652 `"Provo-Orem, UT"', add
label define metarea_lbl 656 `"Pueblo, CO"', add
label define metarea_lbl 658 `"Punta Gorda, FL"', add
label define metarea_lbl 660 `"Racine, WI"', add
label define metarea_lbl 664 `"Raleigh-Durham, NC"', add
label define metarea_lbl 666 `"Rapid City, SD"', add
label define metarea_lbl 668 `"Reading, PA"', add
label define metarea_lbl 669 `"Redding, CA"', add
label define metarea_lbl 672 `"Reno, NV"', add
label define metarea_lbl 674 `"Richland-Kennewick-Pasco, WA"', add
label define metarea_lbl 676 `"Richmond-Petersburg, VA"', add
label define metarea_lbl 678 `"Riverside-San Bernardino, CA"', add
label define metarea_lbl 680 `"Roanoke, VA"', add
label define metarea_lbl 682 `"Rochester, MN"', add
label define metarea_lbl 684 `"Rochester, NY"', add
label define metarea_lbl 688 `"Rockford, IL"', add
label define metarea_lbl 689 `"Rocky Mount, NC"', add
label define metarea_lbl 692 `"Sacramento, CA"', add
label define metarea_lbl 696 `"Saginaw-Bay City-Midland, MI"', add
label define metarea_lbl 698 `"St. Cloud, MN"', add
label define metarea_lbl 700 `"St. Joseph, MO"', add
label define metarea_lbl 704 `"St. Louis, MO/IL"', add
label define metarea_lbl 708 `"Salem, OR"', add
label define metarea_lbl 712 `"Salinas-Sea Side-Monterey, CA"', add
label define metarea_lbl 714 `"Salisbury-Concord, NC"', add
label define metarea_lbl 716 `"Salt Lake City-Ogden, UT"', add
label define metarea_lbl 720 `"San Angelo, TX"', add
label define metarea_lbl 724 `"San Antonio, TX"', add
label define metarea_lbl 732 `"San Diego, CA"', add
label define metarea_lbl 736 `"San Francisco-Oakland-Vallejo, CA"', add
label define metarea_lbl 740 `"San Jose, CA"', add
label define metarea_lbl 744 `"San Juan-Bayamon, PR"', add
label define metarea_lbl 746 `"San Luis Obispo-Atascad-P Robles, CA"', add
label define metarea_lbl 747 `"Santa Barbara-Santa Maria-Lompoc, CA"', add
label define metarea_lbl 748 `"Santa Cruz, CA"', add
label define metarea_lbl 749 `"Santa Fe, NM"', add
label define metarea_lbl 750 `"Santa Rosa-Petaluma, CA"', add
label define metarea_lbl 751 `"Sarasota, FL"', add
label define metarea_lbl 752 `"Savannah, GA"', add
label define metarea_lbl 756 `"Scranton-Wilkes-Barre, PA"', add
label define metarea_lbl 760 `"Seattle-Everett, WA"', add
label define metarea_lbl 761 `"Sharon, PA"', add
label define metarea_lbl 762 `"Sheboygan, WI"', add
label define metarea_lbl 764 `"Sherman-Davidson, TX"', add
label define metarea_lbl 768 `"Shreveport, LA"', add
label define metarea_lbl 772 `"Sioux City, IA/NE"', add
label define metarea_lbl 776 `"Sioux Falls, SD"', add
label define metarea_lbl 780 `"South Bend-Mishawaka, IN"', add
label define metarea_lbl 784 `"Spokane, WA"', add
label define metarea_lbl 788 `"Springfield, IL"', add
label define metarea_lbl 792 `"Springfield, MO"', add
label define metarea_lbl 800 `"Springfield-Holyoke-Chicopee, MA"', add
label define metarea_lbl 804 `"Stamford, CT"', add
label define metarea_lbl 805 `"State College, PA"', add
label define metarea_lbl 808 `"Steubenville-Weirton,OH/WV"', add
label define metarea_lbl 812 `"Stockton, CA"', add
label define metarea_lbl 814 `"Sumter, SC"', add
label define metarea_lbl 816 `"Syracuse, NY"', add
label define metarea_lbl 820 `"Tacoma, WA"', add
label define metarea_lbl 824 `"Tallahassee, FL"', add
label define metarea_lbl 828 `"Tampa-St. Petersburg-Clearwater, FL"', add
label define metarea_lbl 832 `"Terre Haute, IN"', add
label define metarea_lbl 836 `"Texarkana, TX/AR"', add
label define metarea_lbl 840 `"Toledo, OH/MI"', add
label define metarea_lbl 844 `"Topeka, KS"', add
label define metarea_lbl 848 `"Trenton, NJ"', add
label define metarea_lbl 852 `"Tucson, AZ"', add
label define metarea_lbl 856 `"Tulsa, OK"', add
label define metarea_lbl 860 `"Tuscaloosa, AL"', add
label define metarea_lbl 864 `"Tyler, TX"', add
label define metarea_lbl 868 `"Utica-Rome, NY"', add
label define metarea_lbl 873 `"Ventura-Oxnard-Simi Valley, CA"', add
label define metarea_lbl 875 `"Victoria, TX"', add
label define metarea_lbl 876 `"Vineland-Milville-Bridgetown, NJ"', add
label define metarea_lbl 878 `"Visalia-Tulare-Porterville, CA"', add
label define metarea_lbl 880 `"Waco, TX"', add
label define metarea_lbl 884 `"Washington, DC/MD/VA"', add
label define metarea_lbl 888 `"Waterbury, CT"', add
label define metarea_lbl 892 `"Waterloo-Cedar Falls, IA"', add
label define metarea_lbl 894 `"Wausau, WI"', add
label define metarea_lbl 896 `"West Palm Beach-Boca Raton-Delray Beach, FL"', add
label define metarea_lbl 900 `"Wheeling, WV/OH"', add
label define metarea_lbl 904 `"Wichita, KS"', add
label define metarea_lbl 908 `"Wichita Falls, TX"', add
label define metarea_lbl 914 `"Williamsport, PA"', add
label define metarea_lbl 916 `"Wilmington, DE/NJ/MD"', add
label define metarea_lbl 920 `"Wilmington, NC"', add
label define metarea_lbl 924 `"Worcester, MA"', add
label define metarea_lbl 926 `"Yakima, WA"', add
label define metarea_lbl 927 `"Yolo, CA"', add
label define metarea_lbl 928 `"York, PA"', add
label define metarea_lbl 932 `"Youngstown-Warren, OH/PA"', add
label define metarea_lbl 934 `"Yuba City, CA"', add
label define metarea_lbl 936 `"Yuma, AZ"', add
label values metarea metarea_lbl

label define metaread_lbl 0000 `"Not identifiable or not in an MSA"'
label define metaread_lbl 0040 `"Abilene, TX"', add
label define metaread_lbl 0060 `"Aguadilla, PR"', add
label define metaread_lbl 0080 `"Akron, OH"', add
label define metaread_lbl 0120 `"Albany, GA"', add
label define metaread_lbl 0160 `"Albany-Schenectady-Troy, NY"', add
label define metaread_lbl 0200 `"Albuquerque, NM"', add
label define metaread_lbl 0220 `"Alexandria, LA"', add
label define metaread_lbl 0240 `"Allentown-Bethlehem-Easton, PA/NJ"', add
label define metaread_lbl 0280 `"Altoona, PA"', add
label define metaread_lbl 0320 `"Amarillo, TX"', add
label define metaread_lbl 0380 `"Anchorage, AK"', add
label define metaread_lbl 0400 `"Anderson, IN"', add
label define metaread_lbl 0440 `"Ann Arbor, MI"', add
label define metaread_lbl 0450 `"Anniston, AL"', add
label define metaread_lbl 0460 `"Appleton-Oshkosh-Neenah, WI"', add
label define metaread_lbl 0470 `"Arecibo, PR"', add
label define metaread_lbl 0480 `"Asheville, NC"', add
label define metaread_lbl 0500 `"Athens, GA"', add
label define metaread_lbl 0520 `"Atlanta, GA"', add
label define metaread_lbl 0560 `"Atlantic City, NJ"', add
label define metaread_lbl 0580 `"Auburn-Opelika, AL"', add
label define metaread_lbl 0600 `"Augusta-Aiken, GA/SC"', add
label define metaread_lbl 0640 `"Austin, TX"', add
label define metaread_lbl 0680 `"Bakersfield, CA"', add
label define metaread_lbl 0720 `"Baltimore, MD"', add
label define metaread_lbl 0730 `"Bangor, ME"', add
label define metaread_lbl 0740 `"Barnstable-Yarmouth, MA"', add
label define metaread_lbl 0760 `"Baton Rouge, LA"', add
label define metaread_lbl 0780 `"Battle Creek, MI"', add
label define metaread_lbl 0840 `"Beaumont-Port Arthur-Orange, TX"', add
label define metaread_lbl 0860 `"Bellingham, WA"', add
label define metaread_lbl 0870 `"Benton Harbor, MI"', add
label define metaread_lbl 0880 `"Billings, MT"', add
label define metaread_lbl 0920 `"Biloxi-Gulfport, MS"', add
label define metaread_lbl 0960 `"Binghamton, NY"', add
label define metaread_lbl 1000 `"Birmingham, AL"', add
label define metaread_lbl 1010 `"Bismarck, ND"', add
label define metaread_lbl 1020 `"Bloomington, IN"', add
label define metaread_lbl 1040 `"Bloomington-Normal, IL"', add
label define metaread_lbl 1080 `"Boise City, ID"', add
label define metaread_lbl 1120 `"Boston, MA"', add
label define metaread_lbl 1121 `"Lawrence-Haverhill, MA/NH"', add
label define metaread_lbl 1122 `"Lowell, MA/NH"', add
label define metaread_lbl 1123 `"Salem-Gloucester, MA"', add
label define metaread_lbl 1140 `"Bradenton, FL"', add
label define metaread_lbl 1150 `"Bremerton, WA"', add
label define metaread_lbl 1160 `"Bridgeport, CT"', add
label define metaread_lbl 1200 `"Brockton, MA"', add
label define metaread_lbl 1240 `"Brownsville-Harlingen-San Benito, TX"', add
label define metaread_lbl 1260 `"Bryan-College Station, TX"', add
label define metaread_lbl 1280 `"Buffalo-Niagara Falls, NY"', add
label define metaread_lbl 1281 `"Niagara Falls, NY"', add
label define metaread_lbl 1300 `"Burlington, NC"', add
label define metaread_lbl 1310 `"Burlington, VT"', add
label define metaread_lbl 1320 `"Canton, OH"', add
label define metaread_lbl 1330 `"Caguas, PR"', add
label define metaread_lbl 1350 `"Casper, WY"', add
label define metaread_lbl 1360 `"Cedar Rapids, IA"', add
label define metaread_lbl 1400 `"Champaign-Urbana-Rantoul, IL"', add
label define metaread_lbl 1440 `"Charleston-N. Charleston, SC"', add
label define metaread_lbl 1480 `"Charleston, WV"', add
label define metaread_lbl 1520 `"Charlotte-Gastonia-Rock Hill, SC"', add
label define metaread_lbl 1521 `"Rock Hill, SC"', add
label define metaread_lbl 1540 `"Charlottesville, VA"', add
label define metaread_lbl 1560 `"Chattanooga, TN/GA"', add
label define metaread_lbl 1580 `"Cheyenne, WY"', add
label define metaread_lbl 1600 `"Chicago-Gary-Lake, IL"', add
label define metaread_lbl 1601 `"Aurora-Elgin, IL"', add
label define metaread_lbl 1602 `"Gary-Hammond-East Chicago, IN"', add
label define metaread_lbl 1603 `"Joliet, IL"', add
label define metaread_lbl 1604 `"Lake County, IL"', add
label define metaread_lbl 1620 `"Chico, CA"', add
label define metaread_lbl 1640 `"Cincinnati, OH/KY/IN"', add
label define metaread_lbl 1660 `"Clarksville-Hopkinsville, TN/KY"', add
label define metaread_lbl 1680 `"Cleveland, OH"', add
label define metaread_lbl 1720 `"Colorado Springs, CO"', add
label define metaread_lbl 1740 `"Columbia, MO"', add
label define metaread_lbl 1760 `"Columbia, SC"', add
label define metaread_lbl 1800 `"Columbus, GA/AL"', add
label define metaread_lbl 1840 `"Columbus, OH"', add
label define metaread_lbl 1880 `"Corpus Christi, TX"', add
label define metaread_lbl 1900 `"Cumberland, MD/WV"', add
label define metaread_lbl 1920 `"Dallas-Fort Worth, TX"', add
label define metaread_lbl 1921 `"Fort Worth-Arlington, TX"', add
label define metaread_lbl 1930 `"Danbury, CT"', add
label define metaread_lbl 1950 `"Danville, VA"', add
label define metaread_lbl 1960 `"Davenport, IA - Rock Island-Moline, IL"', add
label define metaread_lbl 2000 `"Dayton-Springfield, OH"', add
label define metaread_lbl 2001 `"Springfield, OH"', add
label define metaread_lbl 2020 `"Daytona Beach, FL"', add
label define metaread_lbl 2030 `"Decatur, AL"', add
label define metaread_lbl 2040 `"Decatur, IL"', add
label define metaread_lbl 2080 `"Denver-Boulder-Longmont, CO"', add
label define metaread_lbl 2081 `"Boulder-Longmont, CO"', add
label define metaread_lbl 2120 `"Des Moines, IA"', add
label define metaread_lbl 2121 `"Polk, IA"', add
label define metaread_lbl 2160 `"Detroit, MI"', add
label define metaread_lbl 2180 `"Dothan, AL"', add
label define metaread_lbl 2190 `"Dover, DE"', add
label define metaread_lbl 2200 `"Dubuque, IA"', add
label define metaread_lbl 2240 `"Duluth-Superior, MN/WI"', add
label define metaread_lbl 2281 `"Dutchess Co., NY"', add
label define metaread_lbl 2290 `"Eau Claire, WI"', add
label define metaread_lbl 2310 `"El Paso, TX"', add
label define metaread_lbl 2320 `"Elkhart-Goshen, IN"', add
label define metaread_lbl 2330 `"Elmira, NY"', add
label define metaread_lbl 2340 `"Enid, OK"', add
label define metaread_lbl 2360 `"Erie, PA"', add
label define metaread_lbl 2400 `"Eugene-Springfield, OR"', add
label define metaread_lbl 2440 `"Evansville, IN/KY"', add
label define metaread_lbl 2520 `"Fargo-Morehead, ND/MN"', add
label define metaread_lbl 2560 `"Fayetteville, NC"', add
label define metaread_lbl 2580 `"Fayetteville-Springdale, AR"', add
label define metaread_lbl 2600 `"Fitchburg-Leominster, MA"', add
label define metaread_lbl 2620 `"Flagstaff, AZ/UT"', add
label define metaread_lbl 2640 `"Flint, MI"', add
label define metaread_lbl 2650 `"Florence, AL"', add
label define metaread_lbl 2660 `"Florence, SC"', add
label define metaread_lbl 2670 `"Fort Collins-Loveland, CO"', add
label define metaread_lbl 2680 `"Fort Lauderdale-Hollywood-Pompano Beach, FL"', add
label define metaread_lbl 2700 `"Fort Myers-Cape Coral, FL"', add
label define metaread_lbl 2710 `"Fort Pierce, FL"', add
label define metaread_lbl 2720 `"Fort Smith, AR/OK"', add
label define metaread_lbl 2750 `"Fort Walton Beach, FL"', add
label define metaread_lbl 2760 `"Fort Wayne, IN"', add
label define metaread_lbl 2840 `"Fresno, CA"', add
label define metaread_lbl 2880 `"Gadsden, AL"', add
label define metaread_lbl 2900 `"Gainesville, FL"', add
label define metaread_lbl 2920 `"Galveston-Texas City, TX"', add
label define metaread_lbl 2970 `"Glens Falls, NY"', add
label define metaread_lbl 2980 `"Goldsboro, NC"', add
label define metaread_lbl 2990 `"Grand Forks, ND/MN"', add
label define metaread_lbl 3000 `"Grand Rapids, MI"', add
label define metaread_lbl 3010 `"Grand Junction, CO"', add
label define metaread_lbl 3040 `"Great Falls, MT"', add
label define metaread_lbl 3060 `"Greeley, CO"', add
label define metaread_lbl 3080 `"Green Bay, WI"', add
label define metaread_lbl 3120 `"Greensboro-Winston Salem-High Point, NC"', add
label define metaread_lbl 3121 `"Winston-Salem, NC"', add
label define metaread_lbl 3150 `"Greenville, NC"', add
label define metaread_lbl 3160 `"Greenville-Spartenburg-Anderson, SC"', add
label define metaread_lbl 3161 `"Anderson, SC"', add
label define metaread_lbl 3180 `"Hagerstown, MD"', add
label define metaread_lbl 3200 `"Hamilton-Middleton, OH"', add
label define metaread_lbl 3240 `"Harrisburg-Lebanon-Carlisle, PA"', add
label define metaread_lbl 3280 `"Hartford-Bristol-Middleton-New Britain, CT"', add
label define metaread_lbl 3281 `"Bristol, CT"', add
label define metaread_lbl 3282 `"Middletown, CT"', add
label define metaread_lbl 3283 `"New Britain, CT"', add
label define metaread_lbl 3290 `"Hickory-Morgantown, NC"', add
label define metaread_lbl 3300 `"Hattiesburg, MS"', add
label define metaread_lbl 3320 `"Honolulu, HI"', add
label define metaread_lbl 3350 `"Houma-Thibodoux, LA"', add
label define metaread_lbl 3360 `"Houston-Brazoria, TX"', add
label define metaread_lbl 3361 `"Brazoria, TX"', add
label define metaread_lbl 3400 `"Huntington-Ashland, WV/KY/OH"', add
label define metaread_lbl 3440 `"Huntsville, AL"', add
label define metaread_lbl 3480 `"Indianapolis, IN"', add
label define metaread_lbl 3500 `"Iowa City, IA"', add
label define metaread_lbl 3520 `"Jackson, MI"', add
label define metaread_lbl 3560 `"Jackson, MS"', add
label define metaread_lbl 3580 `"Jackson, TN"', add
label define metaread_lbl 3590 `"Jacksonville, FL"', add
label define metaread_lbl 3600 `"Jacksonville, NC"', add
label define metaread_lbl 3610 `"Jamestown-Dunkirk, NY"', add
label define metaread_lbl 3620 `"Janesville-Beloit, WI"', add
label define metaread_lbl 3660 `"Johnson City-Kingsport-Bristol, TN/VA"', add
label define metaread_lbl 3680 `"Johnstown, PA"', add
label define metaread_lbl 3710 `"Joplin, MO"', add
label define metaread_lbl 3720 `"Kalamazoo-Portage, MI"', add
label define metaread_lbl 3740 `"Kankakee, IL"', add
label define metaread_lbl 3760 `"Kansas City, MO/KS"', add
label define metaread_lbl 3800 `"Kenosha, WI"', add
label define metaread_lbl 3810 `"Kileen-Temple, TX"', add
label define metaread_lbl 3840 `"Knoxville, TN"', add
label define metaread_lbl 3850 `"Kokomo, IN"', add
label define metaread_lbl 3870 `"LaCrosse, WI"', add
label define metaread_lbl 3880 `"Lafayette, LA"', add
label define metaread_lbl 3920 `"Lafayette-W. Lafayette, IN"', add
label define metaread_lbl 3960 `"Lake Charles, LA"', add
label define metaread_lbl 3980 `"Lakeland-Winterhaven, FL"', add
label define metaread_lbl 4000 `"Lancaster, PA"', add
label define metaread_lbl 4040 `"Lansing-E. Lansing, MI"', add
label define metaread_lbl 4080 `"Laredo, TX"', add
label define metaread_lbl 4100 `"Las Cruces, NM"', add
label define metaread_lbl 4120 `"Las Vegas, NV"', add
label define metaread_lbl 4150 `"Lawrence, KS"', add
label define metaread_lbl 4200 `"Lawton, OK"', add
label define metaread_lbl 4240 `"Lewiston-Auburn, ME"', add
label define metaread_lbl 4280 `"Lexington-Fayette, KY"', add
label define metaread_lbl 4320 `"Lima, OH"', add
label define metaread_lbl 4360 `"Lincoln, NE"', add
label define metaread_lbl 4400 `"Little Rock-N. Little Rock, AR"', add
label define metaread_lbl 4410 `"Long Branch-Asbury Park, NJ"', add
label define metaread_lbl 4420 `"Longview-Marshall, TX"', add
label define metaread_lbl 4440 `"Lorain-Elyria, OH"', add
label define metaread_lbl 4480 `"Los Angeles-Long Beach, CA"', add
label define metaread_lbl 4481 `"Anaheim-Santa Ana-Garden Grove, CA"', add
label define metaread_lbl 4482 `"Orange County, CA"', add
label define metaread_lbl 4520 `"Louisville, KY/IN"', add
label define metaread_lbl 4600 `"Lubbock, TX"', add
label define metaread_lbl 4640 `"Lynchburg, VA"', add
label define metaread_lbl 4680 `"Macon-Warner Robins, GA"', add
label define metaread_lbl 4720 `"Madison, WI"', add
label define metaread_lbl 4760 `"Manchester, NH"', add
label define metaread_lbl 4800 `"Mansfield, OH"', add
label define metaread_lbl 4840 `"Mayaguez, PR"', add
label define metaread_lbl 4880 `"McAllen-Edinburg-Pharr-Mission, TX"', add
label define metaread_lbl 4890 `"Medford, OR"', add
label define metaread_lbl 4900 `"Melbourne-Titusville-Cocoa-Palm Bay, FL"', add
label define metaread_lbl 4920 `"Memphis, TN/AR/MS"', add
label define metaread_lbl 4940 `"Merced, CA"', add
label define metaread_lbl 5000 `"Miami-Hialeah, FL"', add
label define metaread_lbl 5040 `"Midland, TX"', add
label define metaread_lbl 5080 `"Milwaukee, WI"', add
label define metaread_lbl 5120 `"Minneapolis-St. Paul, MN"', add
label define metaread_lbl 5140 `"Missoula, MT"', add
label define metaread_lbl 5160 `"Mobile, AL"', add
label define metaread_lbl 5170 `"Modesto, CA"', add
label define metaread_lbl 5190 `"Monmouth-Ocean, NJ"', add
label define metaread_lbl 5200 `"Monroe, LA"', add
label define metaread_lbl 5240 `"Montgomery, AL"', add
label define metaread_lbl 5280 `"Muncie, IN"', add
label define metaread_lbl 5320 `"Muskegon-Norton Shores-Muskegon Heights, MI"', add
label define metaread_lbl 5330 `"Myrtle Beach, SC"', add
label define metaread_lbl 5340 `"Naples, FL"', add
label define metaread_lbl 5350 `"Nashua, NH"', add
label define metaread_lbl 5360 `"Nashville, TN"', add
label define metaread_lbl 5400 `"New Bedford, MA"', add
label define metaread_lbl 5460 `"New Brunswick-Perth Amboy-Sayreville, NJ"', add
label define metaread_lbl 5480 `"New Haven-Meriden, CT"', add
label define metaread_lbl 5481 `"Meriden"', add
label define metaread_lbl 5482 `"New Haven, CT"', add
label define metaread_lbl 5520 `"New London-Norwich, CT/RI"', add
label define metaread_lbl 5560 `"New Orleans, LA"', add
label define metaread_lbl 5600 `"New York, NY-Northeastern NJ"', add
label define metaread_lbl 5601 `"Nassau Co, NY"', add
label define metaread_lbl 5602 `"Bergen-Passaic, NJ"', add
label define metaread_lbl 5603 `"Jersey City, NJ"', add
label define metaread_lbl 5604 `"Middlesex-Somerset-Hunterdon, NJ"', add
label define metaread_lbl 5605 `"Newark, NJ"', add
label define metaread_lbl 5640 `"Newark, OH"', add
label define metaread_lbl 5660 `"Newburgh-Middletown, NY"', add
label define metaread_lbl 5720 `"Norfolk-VA Beach-Newport News, VA"', add
label define metaread_lbl 5721 `"Newport News-Hampton"', add
label define metaread_lbl 5722 `"Norfolk- VA Beach-Portsmouth"', add
label define metaread_lbl 5760 `"Norwalk, CT"', add
label define metaread_lbl 5790 `"Ocala, FL"', add
label define metaread_lbl 5800 `"Odessa, TX"', add
label define metaread_lbl 5880 `"Oklahoma City, OK"', add
label define metaread_lbl 5910 `"Olympia, WA"', add
label define metaread_lbl 5920 `"Omaha, NE/IA"', add
label define metaread_lbl 5950 `"Orange, NY"', add
label define metaread_lbl 5960 `"Orlando, FL"', add
label define metaread_lbl 5990 `"Owensboro, KY"', add
label define metaread_lbl 6010 `"Panama City, FL"', add
label define metaread_lbl 6020 `"Parkersburg-Marietta,WV/OH"', add
label define metaread_lbl 6030 `"Pascagoula-Moss Point, MS"', add
label define metaread_lbl 6080 `"Pensacola, FL"', add
label define metaread_lbl 6120 `"Peoria, IL"', add
label define metaread_lbl 6160 `"Philadelphia, PA/NJ"', add
label define metaread_lbl 6200 `"Phoenix, AZ"', add
label define metaread_lbl 6240 `"Pine Bluff, AR"', add
label define metaread_lbl 6280 `"Pittsburgh-Beaver Valley, PA"', add
label define metaread_lbl 6281 `"Beaver County, PA"', add
label define metaread_lbl 6320 `"Pittsfield, MA"', add
label define metaread_lbl 6360 `"Ponce, PR"', add
label define metaread_lbl 6400 `"Portland, ME"', add
label define metaread_lbl 6440 `"Portland-Vancouver, OR"', add
label define metaread_lbl 6441 `"Vancouver, WA"', add
label define metaread_lbl 6450 `"Portsmouth-Dover-Rochester, NH/ME"', add
label define metaread_lbl 6460 `"Poughkeepsie, NY"', add
label define metaread_lbl 6480 `"Providence-Fall River-Pawtucket, MA/RI"', add
label define metaread_lbl 6481 `"Fall River, MA/RI"', add
label define metaread_lbl 6482 `"Pawtuckett-Woonsocket-Attleboro, RI/MA"', add
label define metaread_lbl 6520 `"Provo-Orem, UT"', add
label define metaread_lbl 6560 `"Pueblo, CO"', add
label define metaread_lbl 6580 `"Punta Gorda, FL"', add
label define metaread_lbl 6600 `"Racine, WI"', add
label define metaread_lbl 6640 `"Raleigh-Durham, NC"', add
label define metaread_lbl 6641 `"Durham, NC"', add
label define metaread_lbl 6660 `"Rapid City, SD"', add
label define metaread_lbl 6680 `"Reading, PA"', add
label define metaread_lbl 6690 `"Redding, CA"', add
label define metaread_lbl 6720 `"Reno, NV"', add
label define metaread_lbl 6740 `"Richland-Kennewick-Pasco, WA"', add
label define metaread_lbl 6760 `"Richmond-Petersburg, VA"', add
label define metaread_lbl 6761 `"Petersburg-Colonial Heights, VA"', add
label define metaread_lbl 6780 `"Riverside-San Bernardino, CA"', add
label define metaread_lbl 6781 `"San Bernardino, CA"', add
label define metaread_lbl 6800 `"Roanoke, VA"', add
label define metaread_lbl 6820 `"Rochester, MN"', add
label define metaread_lbl 6840 `"Rochester, NY"', add
label define metaread_lbl 6880 `"Rockford, IL"', add
label define metaread_lbl 6895 `"Rocky Mount, NC"', add
label define metaread_lbl 6920 `"Sacramento, CA"', add
label define metaread_lbl 6960 `"Saginaw-Bay City-Midland, MI"', add
label define metaread_lbl 6961 `"Bay City, MI"', add
label define metaread_lbl 6980 `"St. Cloud, MN"', add
label define metaread_lbl 7000 `"St. Joseph, MO"', add
label define metaread_lbl 7040 `"St. Louis, MO/IL"', add
label define metaread_lbl 7080 `"Salem, OR"', add
label define metaread_lbl 7120 `"Salinas-Sea Side-Monterey, CA"', add
label define metaread_lbl 7140 `"Salisbury-Concord, NC"', add
label define metaread_lbl 7160 `"Salt Lake City-Ogden, UT"', add
label define metaread_lbl 7161 `"Ogden"', add
label define metaread_lbl 7200 `"San Angelo, TX"', add
label define metaread_lbl 7240 `"San Antonio, TX"', add
label define metaread_lbl 7320 `"San Diego, CA"', add
label define metaread_lbl 7360 `"San Francisco-Oakland-Vallejo, CA"', add
label define metaread_lbl 7361 `"Oakland, CA"', add
label define metaread_lbl 7362 `"Vallejo-Fairfield-Napa, CA"', add
label define metaread_lbl 7400 `"San Jose, CA"', add
label define metaread_lbl 7440 `"San Juan-Bayamon, PR"', add
label define metaread_lbl 7460 `"San Luis Obispo-Atascad-P Robles, CA"', add
label define metaread_lbl 7470 `"Santa Barbara-Santa Maria-Lompoc, CA"', add
label define metaread_lbl 7480 `"Santa Cruz, CA"', add
label define metaread_lbl 7490 `"Santa Fe, NM"', add
label define metaread_lbl 7500 `"Santa Rosa-Petaluma, CA"', add
label define metaread_lbl 7510 `"Sarasota, FL"', add
label define metaread_lbl 7520 `"Savannah, GA"', add
label define metaread_lbl 7560 `"Scranton-Wilkes-Barre, PA"', add
label define metaread_lbl 7561 `"Wilkes-Barre-Hazelton, PA"', add
label define metaread_lbl 7600 `"Seattle-Everett, WA"', add
label define metaread_lbl 7610 `"Sharon, PA"', add
label define metaread_lbl 7620 `"Sheboygan, WI"', add
label define metaread_lbl 7640 `"Sherman-Denison, TX"', add
label define metaread_lbl 7680 `"Shreveport, LA"', add
label define metaread_lbl 7720 `"Sioux City, IA/NE"', add
label define metaread_lbl 7760 `"Sioux Falls, SD"', add
label define metaread_lbl 7800 `"South Bend-Mishawaka, IN"', add
label define metaread_lbl 7840 `"Spokane, WA"', add
label define metaread_lbl 7880 `"Springfield, IL"', add
label define metaread_lbl 7920 `"Springfield, MO"', add
label define metaread_lbl 8000 `"Springfield-Holyoke-Chicopee, MA"', add
label define metaread_lbl 8040 `"Stamford, CT"', add
label define metaread_lbl 8050 `"State College, PA"', add
label define metaread_lbl 8080 `"Steubenville-Weirton,OH/WV"', add
label define metaread_lbl 8120 `"Stockton, CA"', add
label define metaread_lbl 8140 `"Sumter, SC"', add
label define metaread_lbl 8160 `"Syracuse, NY"', add
label define metaread_lbl 8200 `"Tacoma, WA"', add
label define metaread_lbl 8240 `"Tallahassee, FL"', add
label define metaread_lbl 8280 `"Tampa-St. Petersburg-Clearwater, FL"', add
label define metaread_lbl 8320 `"Terre Haute, IN"', add
label define metaread_lbl 8360 `"Texarkana, TX/AR"', add
label define metaread_lbl 8400 `"Toledo, OH/MI"', add
label define metaread_lbl 8440 `"Topeka, KS"', add
label define metaread_lbl 8480 `"Trenton, NJ"', add
label define metaread_lbl 8520 `"Tucson, AZ"', add
label define metaread_lbl 8560 `"Tulsa, OK"', add
label define metaread_lbl 8600 `"Tuscaloosa, AL"', add
label define metaread_lbl 8640 `"Tyler, TX"', add
label define metaread_lbl 8680 `"Utica-Rome, NY"', add
label define metaread_lbl 8730 `"Ventura-Oxnard-Simi Valley, CA"', add
label define metaread_lbl 8750 `"Victoria, TX"', add
label define metaread_lbl 8760 `"Vineland-Milville-Bridgetown, NJ"', add
label define metaread_lbl 8780 `"Visalia-Tulare-Porterville, CA"', add
label define metaread_lbl 8800 `"Waco, TX"', add
label define metaread_lbl 8840 `"Washington, DC/MD/VA"', add
label define metaread_lbl 8880 `"Waterbury, CT"', add
label define metaread_lbl 8920 `"Waterloo-Cedar Falls, IA"', add
label define metaread_lbl 8940 `"Wausau, WI"', add
label define metaread_lbl 8960 `"West Palm Beach-Boca Raton-Delray Beach, FL"', add
label define metaread_lbl 9000 `"Wheeling, WV/OH"', add
label define metaread_lbl 9040 `"Wichita, KS"', add
label define metaread_lbl 9080 `"Wichita Falls, TX"', add
label define metaread_lbl 9140 `"Williamsport, PA"', add
label define metaread_lbl 9160 `"Wilmington, DE/NJ/MD"', add
label define metaread_lbl 9200 `"Wilmington, NC"', add
label define metaread_lbl 9240 `"Worcester, MA"', add
label define metaread_lbl 9260 `"Yakima, WA"', add
label define metaread_lbl 9270 `"Yolo, CA"', add
label define metaread_lbl 9280 `"York, PA"', add
label define metaread_lbl 9320 `"Youngstown-Warren, OH/PA"', add
label define metaread_lbl 9340 `"Yuba City, CA"', add
label define metaread_lbl 9360 `"Yuma, AZ"', add
label values metaread metaread_lbl

label define gq_lbl 0 `"Vacant unit"'
label define gq_lbl 1 `"Households under 1970 definition"', add
label define gq_lbl 2 `"Additional households under 1990 definition"', add
label define gq_lbl 3 `"Group quarters--Institutions"', add
label define gq_lbl 4 `"Other group quarters"', add
label define gq_lbl 5 `"Additional households under 2000 definition"', add
label define gq_lbl 6 `"Fragment"', add
label values gq gq_lbl

label define nchild_lbl 0 `"0 children present"'
label define nchild_lbl 1 `"1 child present"', add
label define nchild_lbl 2 `"2"', add
label define nchild_lbl 3 `"3"', add
label define nchild_lbl 4 `"4"', add
label define nchild_lbl 5 `"5"', add
label define nchild_lbl 6 `"6"', add
label define nchild_lbl 7 `"7"', add
label define nchild_lbl 8 `"8"', add
label define nchild_lbl 9 `"9+"', add
label values nchild nchild_lbl

label define eldch_lbl 00 `"Less than 1 year old"'
label define eldch_lbl 01 `"1"', add
label define eldch_lbl 02 `"2"', add
label define eldch_lbl 03 `"3"', add
label define eldch_lbl 04 `"4"', add
label define eldch_lbl 05 `"5"', add
label define eldch_lbl 06 `"6"', add
label define eldch_lbl 07 `"7"', add
label define eldch_lbl 08 `"8"', add
label define eldch_lbl 09 `"9"', add
label define eldch_lbl 10 `"10"', add
label define eldch_lbl 11 `"11"', add
label define eldch_lbl 12 `"12"', add
label define eldch_lbl 13 `"13"', add
label define eldch_lbl 14 `"14"', add
label define eldch_lbl 15 `"15"', add
label define eldch_lbl 16 `"16"', add
label define eldch_lbl 17 `"17"', add
label define eldch_lbl 18 `"18"', add
label define eldch_lbl 19 `"19"', add
label define eldch_lbl 20 `"20"', add
label define eldch_lbl 21 `"21"', add
label define eldch_lbl 22 `"22"', add
label define eldch_lbl 23 `"23"', add
label define eldch_lbl 24 `"24"', add
label define eldch_lbl 25 `"25"', add
label define eldch_lbl 26 `"26"', add
label define eldch_lbl 27 `"27"', add
label define eldch_lbl 28 `"28"', add
label define eldch_lbl 29 `"29"', add
label define eldch_lbl 30 `"30"', add
label define eldch_lbl 31 `"31"', add
label define eldch_lbl 32 `"32"', add
label define eldch_lbl 33 `"33"', add
label define eldch_lbl 34 `"34"', add
label define eldch_lbl 35 `"35"', add
label define eldch_lbl 36 `"36"', add
label define eldch_lbl 37 `"37"', add
label define eldch_lbl 38 `"38"', add
label define eldch_lbl 39 `"39"', add
label define eldch_lbl 40 `"40"', add
label define eldch_lbl 41 `"41"', add
label define eldch_lbl 42 `"42"', add
label define eldch_lbl 43 `"43"', add
label define eldch_lbl 44 `"44"', add
label define eldch_lbl 45 `"45"', add
label define eldch_lbl 46 `"46"', add
label define eldch_lbl 47 `"47"', add
label define eldch_lbl 48 `"48"', add
label define eldch_lbl 49 `"49"', add
label define eldch_lbl 50 `"50"', add
label define eldch_lbl 51 `"51"', add
label define eldch_lbl 52 `"52"', add
label define eldch_lbl 53 `"53"', add
label define eldch_lbl 54 `"54"', add
label define eldch_lbl 55 `"55"', add
label define eldch_lbl 56 `"56"', add
label define eldch_lbl 57 `"57"', add
label define eldch_lbl 58 `"58"', add
label define eldch_lbl 59 `"59"', add
label define eldch_lbl 60 `"60"', add
label define eldch_lbl 61 `"61"', add
label define eldch_lbl 62 `"62"', add
label define eldch_lbl 63 `"63"', add
label define eldch_lbl 64 `"64"', add
label define eldch_lbl 65 `"65"', add
label define eldch_lbl 66 `"66"', add
label define eldch_lbl 67 `"67"', add
label define eldch_lbl 68 `"68"', add
label define eldch_lbl 69 `"69"', add
label define eldch_lbl 70 `"70"', add
label define eldch_lbl 71 `"71"', add
label define eldch_lbl 72 `"72"', add
label define eldch_lbl 73 `"73"', add
label define eldch_lbl 74 `"74"', add
label define eldch_lbl 75 `"75"', add
label define eldch_lbl 76 `"76"', add
label define eldch_lbl 77 `"77"', add
label define eldch_lbl 78 `"78"', add
label define eldch_lbl 79 `"79"', add
label define eldch_lbl 80 `"80"', add
label define eldch_lbl 81 `"81"', add
label define eldch_lbl 82 `"82"', add
label define eldch_lbl 83 `"83"', add
label define eldch_lbl 84 `"84"', add
label define eldch_lbl 85 `"85"', add
label define eldch_lbl 86 `"86"', add
label define eldch_lbl 87 `"87"', add
label define eldch_lbl 88 `"88"', add
label define eldch_lbl 89 `"89"', add
label define eldch_lbl 90 `"90"', add
label define eldch_lbl 91 `"91"', add
label define eldch_lbl 92 `"92"', add
label define eldch_lbl 93 `"93"', add
label define eldch_lbl 94 `"94"', add
label define eldch_lbl 95 `"95"', add
label define eldch_lbl 96 `"96"', add
label define eldch_lbl 97 `"97"', add
label define eldch_lbl 98 `"98"', add
label define eldch_lbl 99 `"N/A"', add
label values eldch eldch_lbl

label define sex_lbl 1 `"Male"'
label define sex_lbl 2 `"Female"', add
label values sex sex_lbl

label define age_lbl 000 `"Less than 1 year old"'
label define age_lbl 001 `"1"', add
label define age_lbl 002 `"2"', add
label define age_lbl 003 `"3"', add
label define age_lbl 004 `"4"', add
label define age_lbl 005 `"5"', add
label define age_lbl 006 `"6"', add
label define age_lbl 007 `"7"', add
label define age_lbl 008 `"8"', add
label define age_lbl 009 `"9"', add
label define age_lbl 010 `"10"', add
label define age_lbl 011 `"11"', add
label define age_lbl 012 `"12"', add
label define age_lbl 013 `"13"', add
label define age_lbl 014 `"14"', add
label define age_lbl 015 `"15"', add
label define age_lbl 016 `"16"', add
label define age_lbl 017 `"17"', add
label define age_lbl 018 `"18"', add
label define age_lbl 019 `"19"', add
label define age_lbl 020 `"20"', add
label define age_lbl 021 `"21"', add
label define age_lbl 022 `"22"', add
label define age_lbl 023 `"23"', add
label define age_lbl 024 `"24"', add
label define age_lbl 025 `"25"', add
label define age_lbl 026 `"26"', add
label define age_lbl 027 `"27"', add
label define age_lbl 028 `"28"', add
label define age_lbl 029 `"29"', add
label define age_lbl 030 `"30"', add
label define age_lbl 031 `"31"', add
label define age_lbl 032 `"32"', add
label define age_lbl 033 `"33"', add
label define age_lbl 034 `"34"', add
label define age_lbl 035 `"35"', add
label define age_lbl 036 `"36"', add
label define age_lbl 037 `"37"', add
label define age_lbl 038 `"38"', add
label define age_lbl 039 `"39"', add
label define age_lbl 040 `"40"', add
label define age_lbl 041 `"41"', add
label define age_lbl 042 `"42"', add
label define age_lbl 043 `"43"', add
label define age_lbl 044 `"44"', add
label define age_lbl 045 `"45"', add
label define age_lbl 046 `"46"', add
label define age_lbl 047 `"47"', add
label define age_lbl 048 `"48"', add
label define age_lbl 049 `"49"', add
label define age_lbl 050 `"50"', add
label define age_lbl 051 `"51"', add
label define age_lbl 052 `"52"', add
label define age_lbl 053 `"53"', add
label define age_lbl 054 `"54"', add
label define age_lbl 055 `"55"', add
label define age_lbl 056 `"56"', add
label define age_lbl 057 `"57"', add
label define age_lbl 058 `"58"', add
label define age_lbl 059 `"59"', add
label define age_lbl 060 `"60"', add
label define age_lbl 061 `"61"', add
label define age_lbl 062 `"62"', add
label define age_lbl 063 `"63"', add
label define age_lbl 064 `"64"', add
label define age_lbl 065 `"65"', add
label define age_lbl 066 `"66"', add
label define age_lbl 067 `"67"', add
label define age_lbl 068 `"68"', add
label define age_lbl 069 `"69"', add
label define age_lbl 070 `"70"', add
label define age_lbl 071 `"71"', add
label define age_lbl 072 `"72"', add
label define age_lbl 073 `"73"', add
label define age_lbl 074 `"74"', add
label define age_lbl 075 `"75"', add
label define age_lbl 076 `"76"', add
label define age_lbl 077 `"77"', add
label define age_lbl 078 `"78"', add
label define age_lbl 079 `"79"', add
label define age_lbl 080 `"80"', add
label define age_lbl 081 `"81"', add
label define age_lbl 082 `"82"', add
label define age_lbl 083 `"83"', add
label define age_lbl 084 `"84"', add
label define age_lbl 085 `"85"', add
label define age_lbl 086 `"86"', add
label define age_lbl 087 `"87"', add
label define age_lbl 088 `"88"', add
label define age_lbl 089 `"89"', add
label define age_lbl 090 `"90 (90+ in 1980 and 1990)"', add
label define age_lbl 091 `"91"', add
label define age_lbl 092 `"92"', add
label define age_lbl 093 `"93"', add
label define age_lbl 094 `"94"', add
label define age_lbl 095 `"95"', add
label define age_lbl 096 `"96"', add
label define age_lbl 097 `"97"', add
label define age_lbl 098 `"98"', add
label define age_lbl 099 `"99"', add
label define age_lbl 100 `"100 (100+ in 1960-1970)"', add
label define age_lbl 101 `"101"', add
label define age_lbl 102 `"102"', add
label define age_lbl 103 `"103"', add
label define age_lbl 104 `"104"', add
label define age_lbl 105 `"105"', add
label define age_lbl 106 `"106"', add
label define age_lbl 107 `"107"', add
label define age_lbl 108 `"108"', add
label define age_lbl 109 `"109"', add
label define age_lbl 110 `"110"', add
label define age_lbl 111 `"111"', add
label define age_lbl 112 `"112 (112+ in the 1980 internal data)"', add
label define age_lbl 113 `"113"', add
label define age_lbl 114 `"114"', add
label define age_lbl 115 `"115 (115+ in the 1990 internal data)"', add
label define age_lbl 116 `"116"', add
label define age_lbl 117 `"117"', add
label define age_lbl 118 `"118"', add
label define age_lbl 119 `"119"', add
label define age_lbl 120 `"120"', add
label define age_lbl 121 `"121"', add
label define age_lbl 122 `"122"', add
label define age_lbl 123 `"123"', add
label define age_lbl 124 `"124"', add
label define age_lbl 125 `"125"', add
label define age_lbl 126 `"126"', add
label define age_lbl 129 `"129"', add
label define age_lbl 130 `"130"', add
label define age_lbl 135 `"135"', add
label values age age_lbl

label define marst_lbl 1 `"Married, spouse present"'
label define marst_lbl 2 `"Married, spouse absent"', add
label define marst_lbl 3 `"Separated"', add
label define marst_lbl 4 `"Divorced"', add
label define marst_lbl 5 `"Widowed"', add
label define marst_lbl 6 `"Never married/single"', add
label values marst marst_lbl

label define marrno_lbl 0 `"Not Applicable"'
label define marrno_lbl 1 `"Married once"', add
label define marrno_lbl 2 `"Married twice (or more)"', add
label define marrno_lbl 3 `"Married thrice (or more)"', add
label define marrno_lbl 4 `"Four times"', add
label define marrno_lbl 5 `"Five times"', add
label define marrno_lbl 6 `"Six times"', add
label define marrno_lbl 7 `"Unknown"', add
label define marrno_lbl 8 `"Illegible"', add
label define marrno_lbl 9 `"Missing"', add
label values marrno marrno_lbl

label define agemarr_lbl 00 `"N/A and missing"'
label define agemarr_lbl 12 `"12 years old"', add
label define agemarr_lbl 13 `"13"', add
label define agemarr_lbl 14 `"14"', add
label define agemarr_lbl 15 `"15"', add
label define agemarr_lbl 16 `"16"', add
label define agemarr_lbl 17 `"17"', add
label define agemarr_lbl 18 `"18"', add
label define agemarr_lbl 19 `"19"', add
label define agemarr_lbl 20 `"20"', add
label define agemarr_lbl 21 `"21"', add
label define agemarr_lbl 22 `"22"', add
label define agemarr_lbl 23 `"23"', add
label define agemarr_lbl 24 `"24"', add
label define agemarr_lbl 25 `"25"', add
label define agemarr_lbl 26 `"26"', add
label define agemarr_lbl 27 `"27"', add
label define agemarr_lbl 28 `"28"', add
label define agemarr_lbl 29 `"29"', add
label define agemarr_lbl 30 `"30"', add
label define agemarr_lbl 31 `"31"', add
label define agemarr_lbl 32 `"32"', add
label define agemarr_lbl 33 `"33"', add
label define agemarr_lbl 34 `"34"', add
label define agemarr_lbl 35 `"35"', add
label define agemarr_lbl 36 `"36"', add
label define agemarr_lbl 37 `"37"', add
label define agemarr_lbl 38 `"38"', add
label define agemarr_lbl 39 `"39"', add
label define agemarr_lbl 40 `"40"', add
label define agemarr_lbl 41 `"41"', add
label define agemarr_lbl 42 `"42"', add
label define agemarr_lbl 43 `"43"', add
label define agemarr_lbl 44 `"44"', add
label define agemarr_lbl 45 `"45"', add
label define agemarr_lbl 46 `"46"', add
label define agemarr_lbl 47 `"47"', add
label define agemarr_lbl 48 `"48"', add
label define agemarr_lbl 49 `"49"', add
label define agemarr_lbl 50 `"50"', add
label define agemarr_lbl 51 `"51"', add
label define agemarr_lbl 52 `"52"', add
label define agemarr_lbl 53 `"53"', add
label define agemarr_lbl 54 `"54"', add
label define agemarr_lbl 55 `"55"', add
label define agemarr_lbl 56 `"56"', add
label define agemarr_lbl 57 `"57"', add
label define agemarr_lbl 58 `"58"', add
label define agemarr_lbl 59 `"59"', add
label define agemarr_lbl 60 `"60"', add
label define agemarr_lbl 61 `"61"', add
label define agemarr_lbl 62 `"62"', add
label define agemarr_lbl 63 `"63"', add
label define agemarr_lbl 64 `"64"', add
label define agemarr_lbl 65 `"65"', add
label define agemarr_lbl 66 `"66"', add
label define agemarr_lbl 67 `"67"', add
label define agemarr_lbl 68 `"68"', add
label define agemarr_lbl 69 `"69"', add
label define agemarr_lbl 70 `"70"', add
label define agemarr_lbl 71 `"71"', add
label define agemarr_lbl 72 `"72"', add
label define agemarr_lbl 73 `"73"', add
label define agemarr_lbl 74 `"74"', add
label define agemarr_lbl 75 `"75"', add
label define agemarr_lbl 76 `"76"', add
label define agemarr_lbl 77 `"77"', add
label define agemarr_lbl 78 `"78"', add
label define agemarr_lbl 79 `"79"', add
label define agemarr_lbl 80 `"80"', add
label define agemarr_lbl 81 `"81"', add
label define agemarr_lbl 82 `"82"', add
label define agemarr_lbl 83 `"83"', add
label define agemarr_lbl 84 `"84"', add
label define agemarr_lbl 85 `"85"', add
label define agemarr_lbl 86 `"86"', add
label define agemarr_lbl 87 `"87"', add
label define agemarr_lbl 88 `"88"', add
label define agemarr_lbl 89 `"89"', add
label define agemarr_lbl 90 `"90"', add
label define agemarr_lbl 91 `"91"', add
label define agemarr_lbl 92 `"92"', add
label define agemarr_lbl 93 `"93"', add
label define agemarr_lbl 94 `"94"', add
label define agemarr_lbl 95 `"95"', add
label define agemarr_lbl 96 `"96"', add
label define agemarr_lbl 97 `"97"', add
label define agemarr_lbl 98 `"98"', add
label define agemarr_lbl 99 `"99+"', add
label values agemarr agemarr_lbl

label define chborn_lbl 00 `"N/A"'
label define chborn_lbl 01 `"No children"', add
label define chborn_lbl 02 `"1 child"', add
label define chborn_lbl 03 `"2 children"', add
label define chborn_lbl 04 `"3"', add
label define chborn_lbl 05 `"4"', add
label define chborn_lbl 06 `"5"', add
label define chborn_lbl 07 `"6"', add
label define chborn_lbl 08 `"7"', add
label define chborn_lbl 09 `"8"', add
label define chborn_lbl 10 `"9"', add
label define chborn_lbl 11 `"10"', add
label define chborn_lbl 12 `"11"', add
label define chborn_lbl 13 `"12 (12+ 1960-1990)"', add
label define chborn_lbl 14 `"13"', add
label define chborn_lbl 15 `"14"', add
label define chborn_lbl 16 `"15"', add
label define chborn_lbl 17 `"16"', add
label define chborn_lbl 18 `"17"', add
label define chborn_lbl 19 `"18"', add
label define chborn_lbl 20 `"19"', add
label define chborn_lbl 21 `"20"', add
label define chborn_lbl 22 `"21"', add
label define chborn_lbl 23 `"22"', add
label define chborn_lbl 24 `"23"', add
label define chborn_lbl 25 `"24"', add
label define chborn_lbl 26 `"25 (25+ 1950)"', add
label define chborn_lbl 27 `"26"', add
label define chborn_lbl 28 `"27"', add
label define chborn_lbl 29 `"28"', add
label define chborn_lbl 30 `"29"', add
label define chborn_lbl 31 `"30"', add
label define chborn_lbl 32 `"31"', add
label define chborn_lbl 33 `"32"', add
label define chborn_lbl 34 `"33"', add
label define chborn_lbl 35 `"34"', add
label define chborn_lbl 36 `"35"', add
label define chborn_lbl 37 `"36"', add
label define chborn_lbl 38 `"37"', add
label define chborn_lbl 39 `"38"', add
label define chborn_lbl 40 `"39"', add
label define chborn_lbl 41 `"40"', add
label define chborn_lbl 42 `"41"', add
label define chborn_lbl 43 `"42"', add
label define chborn_lbl 44 `"43"', add
label define chborn_lbl 45 `"44"', add
label define chborn_lbl 46 `"45"', add
label define chborn_lbl 47 `"46"', add
label define chborn_lbl 48 `"47"', add
label define chborn_lbl 49 `"48"', add
label define chborn_lbl 50 `"49"', add
label define chborn_lbl 51 `"50"', add
label define chborn_lbl 52 `"51"', add
label define chborn_lbl 53 `"52"', add
label define chborn_lbl 54 `"53"', add
label define chborn_lbl 55 `"54"', add
label define chborn_lbl 56 `"55"', add
label define chborn_lbl 57 `"56"', add
label define chborn_lbl 58 `"57"', add
label define chborn_lbl 61 `"60"', add
label define chborn_lbl 87 `"87"', add
label values chborn chborn_lbl

label define educ_lbl 00 `"N/A or no schooling"'
label define educ_lbl 01 `"Nursery school to grade 4"', add
label define educ_lbl 02 `"Grade 5, 6, 7, or 8"', add
label define educ_lbl 03 `"Grade 9"', add
label define educ_lbl 04 `"Grade 10"', add
label define educ_lbl 05 `"Grade 11"', add
label define educ_lbl 06 `"Grade 12"', add
label define educ_lbl 07 `"1 year of college"', add
label define educ_lbl 08 `"2 years of college"', add
label define educ_lbl 09 `"3 years of college"', add
label define educ_lbl 10 `"4 years of college"', add
label define educ_lbl 11 `"5+ years of college"', add
label values educ educ_lbl

label define educd_lbl 000 `"N/A or no schooling"'
label define educd_lbl 001 `"N/A"', add
label define educd_lbl 002 `"No schooling completed"', add
label define educd_lbl 010 `"Nursery school to grade 4"', add
label define educd_lbl 011 `"Nursery school, preschool"', add
label define educd_lbl 012 `"Kindergarten"', add
label define educd_lbl 013 `"Grade 1, 2, 3, or 4"', add
label define educd_lbl 014 `"Grade 1"', add
label define educd_lbl 015 `"Grade 2"', add
label define educd_lbl 016 `"Grade 3"', add
label define educd_lbl 017 `"Grade 4"', add
label define educd_lbl 020 `"Grade 5, 6, 7, or 8"', add
label define educd_lbl 021 `"Grade 5 or 6"', add
label define educd_lbl 022 `"Grade 5"', add
label define educd_lbl 023 `"Grade 6"', add
label define educd_lbl 024 `"Grade 7 or 8"', add
label define educd_lbl 025 `"Grade 7"', add
label define educd_lbl 026 `"Grade 8"', add
label define educd_lbl 030 `"Grade 9"', add
label define educd_lbl 040 `"Grade 10"', add
label define educd_lbl 050 `"Grade 11"', add
label define educd_lbl 060 `"Grade 12"', add
label define educd_lbl 061 `"12th grade, no diploma"', add
label define educd_lbl 062 `"High school graduate or GED"', add
label define educd_lbl 063 `"Regular high school diploma"', add
label define educd_lbl 064 `"GED or alternative credential"', add
label define educd_lbl 065 `"Some college, but less than 1 year"', add
label define educd_lbl 070 `"1 year of college"', add
label define educd_lbl 071 `"1 or more years of college credit, no degree"', add
label define educd_lbl 080 `"2 years of college"', add
label define educd_lbl 081 `"Associate's degree, type not specified"', add
label define educd_lbl 082 `"Associate's degree, occupational program"', add
label define educd_lbl 083 `"Associate's degree, academic program"', add
label define educd_lbl 090 `"3 years of college"', add
label define educd_lbl 100 `"4 years of college"', add
label define educd_lbl 101 `"Bachelor's degree"', add
label define educd_lbl 110 `"5+ years of college"', add
label define educd_lbl 111 `"6 years of college (6+ in 1960-1970)"', add
label define educd_lbl 112 `"7 years of college"', add
label define educd_lbl 113 `"8+ years of college"', add
label define educd_lbl 114 `"Master's degree"', add
label define educd_lbl 115 `"Professional degree beyond a bachelor's degree"', add
label define educd_lbl 116 `"Doctoral degree"', add
label define educd_lbl 999 `"Missing"', add
label values educd educd_lbl

save ipums_1.dta
