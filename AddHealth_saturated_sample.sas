/**********************************************************************************************
WEIGHT-RELATED BEHAVIORS AMONG ADOLESCENT SOCIAL NETWORKS
Created and updated by: Nhan La
Date: 2013/10/10
Summary: This program generates the saturated sample in waves 1 and 2 of AddHealth data.
It also runs several exploratory generalized estimating equation (GEE) model to initially
observe social contagion effects.

*Saturated sample. 
Small schools IDs:  001, 002, 003, 081, 088, 106, 007, 008, 115, 126, 028, 369, 194, 175.  
Large school IDs: 058 and 077.;
*Selection criteria:
- In both waves I and II. Those in only one wave are coded as missing.
- In saturated sample. This is to ensure availability data of friends. Those in core yet not saturated sample are excluded.
- Use only in-home variables (physical activity). This is to ensure availability of data in both waves. In-school variables are not used.;
**********************************************************************************************/

/**********************************************************************************************/
*Wave 1 saturate sample;

ods results=on;
ods listing;

libname satur 'D:\Add Health Data';
data w1att;
set satur.allwave1;
run;
data w1att;
set w1att;
nscid=input(scid,3.0);
drop scid;
rename nscid=scid;
if scid=001 or scid=002 or scid=003 or scid=081 or scid=088 or scid=106 or scid=007 or 
scid=008 or scid=115 or scid=126 or scid=028 or scid=369 or scid=194 or scid=175
	or scid=058 or scid=077;
run;

proc contents data=wave1;run;

data w1att;
set w1att;
keep scid sscid aid imonth iday iyear commid bio_sex core1 core2 smp01 smp07 smp08 smp09 smp12 
/*sec 1 general intro*/ h1gi1m h1gi1y h1gi4 h1gi6a h1gi6b h1gi6c h1gi6d h1gi6e h1gi8 h1gi9 /*race code*/ h1gi20 /*grade*/
/*sec 2 daily activities*/ h1da4 h1da5 h1da6 
/*sec 3 health*/ h1gh1 h1gh28 /*self-perception of weight*/ h1gh37 /*phx edu*/ h1gh50 /*bedtime*/ h1gh51 h1gh52 /*sleepquality*/ 
h1gh59a h1gh59b /*height*/ h1gh60 /*weight*/
/*sec 6 physical limitation-filter cases*/ h1pl8 /*only need once, don't delete*/
/*sec 16 with parents*/ h1wp2 /*hangoutwppl*/
/*sec 18 personality family*/ h1pf31 /*phxfit*/
/*sec 20 friends*/ 	h1mf6a h1mf7a h1mf8a h1mf9a h1mf10a /*delete var 2-5*/
					h1mf6b h1mf7b h1mf8b h1mf9b h1mf10b
					h1mf6c h1mf7c h1mf8c h1mf9c h1mf10c
					h1mf6d h1mf7d h1mf8d h1mf9d h1mf10d
					h1mf6e h1mf7e h1mf8e h1mf9e h1mf10e
					h1ff6a h1ff7a h1ff8a h1ff9a h1ff10a
					h1ff6b h1ff7b h1ff8b h1ff9b h1ff10b
					h1ff6c h1ff7c h1ff8c h1ff9c h1ff10c
					h1ff6d h1ff7d h1ff8d h1ff9d h1ff10d
					h1ff6e h1ff7e h1ff8e h1ff9e h1ff10e
/*sec 39 siblings*/ studsiba studsibb studsibc studsibd studsibe studsibf studsibg /*delete twin*/;
run;
proc sort data=w1att;
by aid;run;
/***********************************************************************************************/


/***********************************************************************************************/
*Wave 2 saturated sample;
libname satur2 'D:\Add Health Data\w2';
data w2att;set satur2.wave2;run; 
data w2att;set w2att;nscid2=input(scid2,3.0);drop scid2;rename nscid2=scid2;run;
data w2att;set w2att;
if scid2=001 or scid2=002 or scid2=003 or scid2=081 or scid2=088 or scid2=106 or scid2=007 or 
scid2=008 or scid2=115 or scid2=126 or scid2=028 or scid2=369 or scid2=194 or scid2=175
	or scid2=058 or scid2=077;
keep scid2 sscid2 aid imonth2 iday2 iyear2 commid2 bio_sex2 core1_2 core2_2 smp01_2 smp07_2 smp08_2 smp09_2 smp11_2 
/*sec 1 general intro*/ h2gi1m h2gi1y h2gi9 /*grade*/
/*sec 2 daily activities*/ h2da4 h2da5 h2da6 
/*sec 3 health*/ h2gh1 h2gh30 /*self-perception of weight*/ h2gh34 /*phx edu*/ h2gh42 h2gh43 /*bedtime*/ h2gh44 h2gh45 /*sleepquality*/ 
h2gh52f h2gh52i /*height*/ h2gh53 /*weight*/
/*sec 16 with parents*/ h2wp2 /*hangoutwppl*/
/*sec 18 personality family*/ h2pf22 /*phxfit*/
/*sec 20 friends*/ 	h2mf1 h2mf3a h2mf11a h2mf12a h2mf13a h2mf14a h2mf15a /*del 4-9*/
						  h2mf3b h2mf11b h2mf12b h2mf13b h2mf14b h2mf15b
						  h2mf3c h2mf11c h2mf12c h2mf13c h2mf14c h2mf15c
						  h2mf3d h2mf11d h2mf12d h2mf13d h2mf14d h2mf15d
						         h2mf11e h2mf12e h2mf13e h2mf14e h2mf15e
					h2ff1 h2ff3a h2ff11a h2ff12a h2ff13a h2ff14a h2ff15a
						  h2ff3b h2ff11b h2ff12b h2ff13b h2ff14b h2ff15b
						  h2ff3c h2ff11c h2ff12c h2ff13c h2ff14c h2ff15c
						  h2ff3d h2ff11d h2ff12d h2ff13d h2ff14d h2ff15d
						         h2ff11e h2ff12e h2ff13e h2ff14e h2ff15e
/*sec 39 siblings*/ h2siba h2sibb h2sibc h2sibd h2sibe h2sibf h2sibg /*delete twin*/;
run;
/*sec 4 taught about exercise benefits: h1ts2*/ 
/*sec 6 physical limitation-filter cases: h1pl8*/

proc contents data=satur1 position;run;
proc contents data=satur2 position;run;
data w1att;set w1att;naid=input(aid,8.0);drop aid;rename naid=id;run;
data w2att;set w2att;naid=input(aid,8.0);drop aid;rename naid=id;run;
proc sort data=w1att;by id;run;
proc sort data=w2att;by id;run;
data w1w2att;merge w1att(in=w1attx) w2att(in=w2attx);by id;w1att=w1attx;w2att=w2attx;run;
proc freq data=w1w2att;table w1att*w2att;run;
data w1w2att;set w1w2att;if w1att=1 and w2att=1;drop w1att w2att;run;

/**********************************************************************************************/

/**********************************************************************************************/
*3. Run the GEE model;

data trial;
set w1w2att;
keep id h1da4 h1da5 h1da6 h2da4 h2da5 h2da6;
run;
data trial;
set trial;
w1pa=h1da4+h1da5+h1da6;
w2pa=h2da4+h2da5+h2da6;
keep id w1pa w2pa; 
run;
proc sort data=trial;by id;run;
proc sort data=w1w2friend2;by id;run;

data trial2;
merge trial (in=trialx) w1w2friend2 (in=friendx);
by id;
itrial=trialx;
ifriend=friendx;
run;
proc freq data=trial2;
table itrial;
run;
data trial2;
set trial2;
if itrial=1 and ifriend=1;
drop itrial ifriend;
run;

data trial3;
	set trial2;
	drop alter f_sex w2pa;
	rename id=alter w1pa=f_w1pa;
run;
proc sort data=trial2;
	by alter;
run;
proc sort data=trial3;
	by alter;
run;
data trial4;
	merge trial2 (in=trial2x) trial3 (in=trial3x);
	by alter;
	ftrial2=trial2x;
	ftrial3=trial3x;
run;

proc sort data=trial4 nodupkey;
	by id alter;
run;
data trial4;
set trial4;
if id ne .;
run;
data trial4;
set trial4;
drop ftrial2 ftrial3;
run;
proc means data=trial4;
var f_w1pa;
run;

data trial5;
	set trial4;
	drop alter f_sex w1pa f_w1pa;
	rename id=alter w2pa=f_w2pa;
run;
proc sort data=trial4;
	by alter;
run;
proc sort data=trial5;
	by alter;
run;
data trial6;
	merge trial4 trial5;
	by alter;
run;
proc sort data=trial6 nodupkey;
	by id alter;
run;
data trial7;
set trial6;
if id ne .;
run;

data trial7;
set trial7;
if f_w1pa=. and f_w2pa=. then _missing=1;
else if f_w1pa=. then _missing=2;
else if f_w2pa=. then _missing=3;
else _missing=0;
run;
proc freq data=trial7;
table _missing;run;
data trial8;
set trial7;
drop _missing;
if f_w1pa ne .;
run;

proc sort data=trial8;by id;run;
proc sort data=w1w2att;by id;run;

data w1w2att1;
merge trial8(in=ftrialx) w1w2att(in=fsaturx);
by id;
ffriend=ftrialx;
fsample=fsaturx;
run;
proc freq data=w1w2att1;
table ffriend*fsample;
run;
data w1w2att2;
set w1w2att1;
if ffriend=1 and fsample=1;
run;
data w1w2att2;
set w1w2att2;
if w2pa ge 5 then w2pa_cat=1;
if w2pa < 5 then w2pa_cat=0;
if w1pa ge 5 then w1pa_cat=1;
if w1pa < 5 then w1pa_cat=0;
if f_w2pa ge 5 then f_w2pa_cat=1;
if f_w2pa < 5 then f_w2pa_cat=0;
if f_w1pa ge 5 then f_w1pa_cat=1;
if f_w1pa < 5 then f_w1pa_cat=0;
run;

proc means data=w1w2att2;
var w1pa w2pa f_w1pa f_w2pa;
run;
proc freq data=w1w2att2;
table w1pa_cat w2pa_cat f_w1pa_cat f_w2pa_cat;
run;

data 'D:\ntl125\Extracts\Network data\Reserved\w1w2att';
set w1w2att2;run;

data geodesics2;
set geodesics1;
rename alter=w1alter;
run;
proc sort data=geodesics2;by id;run;
proc sort data=w1w2att2;by id;run;
data contagion1;
merge geodesics2(in=geox) w1w2att2(in=attx);
by id;
fgeo=geox;
fatt=attx;
run;
proc freq data=contagion1;
table fgeo*fatt;
run;
data contagion1;
set contagion1;
if fgeo=1 and fatt=1;
run;
proc sort data=contagion1;by id distance;run;

proc means data=w1w2att2;
var w1pa w2pa f_w1pa f_w2pa;run;
proc freq data=w1w2att2;
table bio_sex race h1gi20;run;
proc freq data=w1w2att2;
table w1pa_cat w2pa_cat f_w1pa_cat f_w2pa_cat;
run;
proc means data=w1w2att2;var age;run;

data w1w2att2;
set w1w2att2;
if h1gi4=1 then race=11;else race=h1gi9;run;
data w1w2att2;set w1w2att2;if race=3 then race=5;run;
data w1w2att2;set w1w2att2;if race=11 then race=3;run;
data w1w2att2;set w1w2att2;age=iyear-h1gi1y;run; 
proc sort data=w1w2att2;by scid;run;
data w1w2att3;set w1w2att2;by scid;if first.scid then dum_scid + 1;run;
proc freq data=w1w2att3;table dum_scid;run;
data w1w2att3 (DROP = i);
set w1w2att3;
array A {*} dum_scid1-dum_scid16;
do i = 1 TO 16;
A(i) = (dum_scid=i);
end;
run;

proc freq data=w1w2att3;table dum_scid1-dum_scid16;run;

proc genmod data=w1w2att3 descending;
class id f_w2pa_cat w1pa_cat f_w1pa_cat;
model w2pa_cat = f_w2pa_cat w1pa_cat f_w1pa_cat/link=log type3;
repeated subject=id/type=ind;
run;

proc genmod data=w1w2att3;
class id dum_scid1;
model w2pa = f_w2pa_cat w1pa_cat f_w1pa_cat dum_scid1/link=logit type3;
repeated subject=id/type=ind;
run;

w2pa_cat = f_w2pa_cat w1pa_cat f_w1pa_cat; 

data all;
set all;
pairing+1;
if first.aid then pairing=1;
run;
data allwave;
set all;run;
proc means data=allwave;
var w1pa w2pa f_w1pa f_w2pa;
run;
data allwavecnt; set allwave;run;proc sort data=allwavecnt;by scid;run;
data allwavecnt;
   set allwavecnt;
   by scid;
   if first.scid then serial_num + 1;
run;
data allwavedum (DROP = i);
     set allwavecnt;
array A {*} scid_1-scid_101; 
do i = 1 TO 101;
     A(i) = (serial_num=i);
end;
run;
proc freq data=allwavedum;
table scid_1-scid_101;
run;


proc genmod data=allwavedum;
class aid scid_1-scid_100;
model w2pa = f_w2pa w1pa f_w1pa scid_1-scid_100/link=identity type3;
repeated subject=aid/type=ind covb corrw;
run;

proc genmod data=allwavedum;
class aid scid_1-scid_100;
model w2pa_cat = f_w2pa w1pa f_w1pa scid_1-scid_100/link=log type3;
repeated subject=aid/type=ind covb corrw;
run;


proc genmod data=trial8;
class aid scid_1-scid_101;
model w2pa = f_w2pa/dist=poisson link=log type3;
repeated subject=aid/type=ind;
run;

data trial8;
set trial8;
if w2pa ge 7 then w2pa_cat=1;
else w2pa_cat=0;
run;
data trial8;set trial8;drop w2pa_cat;run;proc sort data=trial8;by aid;run;
proc freq data=trial8;
table w2pa_cat;run;
proc genmod data=trial8;
class aid;
model w2pa_cat = f_w2pa/link=log type3;
repeated subject=aid/type=ind;run;

data trialwide; set trial8;by aid;
f_aidtest=f_aid;run;proc sort data=trialwide;by aid;run;
data trialwide1; set trialwide;by aid;
KEEP aid w1pa w2pa f_aid1-f_aid10 f_w1pa1-f_w1pa10 f_w2pa1-f_w2pa10;
RETAIN f_aid1-f_aid10 f_w1pa1-f_w1pa10 f_w2pa1-f_w2pa10;

  ARRAY friend(1:10) f_aid1-f_aid10;
  ARRAY fw1pa(1:10) f_w1pa1-f_w1pa10;
  ARRAY fw2pa(1:10) f_w2pa1-f_w2pa10;

  IF first.aid THEN
  DO;
    DO i = 1 to 10 ;
      friend(i)=.;
	  fw1pa(i)=.;
	  fw2pa(i)=.;
    END;
  END;
      friend(f_aidtest)=f_aid;
	  fw1pa(f_aidtest)=f_w1pa;
	  fw2pa(f_aidtest)=f_w2pa;
  IF last.aid THEN OUTPUT ;
RUN;

proc transpose data=trialwide out=trialwide1 prefix=f_w1pa;
   by aid;
   var f_w1pa;
run;
proc transpose data=trialwide out=trialwide2 prefix=f_w2pa;
   by aid;
   var f_w2pa;
run;
proc transpose data=trialwide out=trialwide3 prefix=f_aid;
   by aid;
   var f_aid;
run;
data trialwide4;
    merge  trialwide1(drop=_name_) trialwide2(drop=_name_) trialwide3(drop=_name_);
    by aid;
run;

proc sort data=trial8;by aid;run;
proc sort data=satur;by aid;run;
data all;
merge trial8(in=ftrialx) satur(in=fsaturx);
by aid;
ffriend=ftrialx;
fsample=fsaturx;
run;
proc freq data=all;
table ffriend*fsample;
run;
data all;
set all;
if w1pa ne .;
run;
data all;
set all;
if w2pa ge 7 then w2pa_cat=1;
else w2pa_cat=0;
run;

proc sort data=trial8;
by aid;
run;
data trialcnt;
set trial8;
by aid;
cnt+1;
if first.aid then cnt=1;
run;
proc sort data=trialcnt;
by aid descending cnt;
run;
data trialcnt2;
set trialcnt; 
by aid; 
retain totcnt; 
if first.aid then totcnt=cnt; 
output; 
run; 

proc freq data=trialcnt2;
table totcnt; 
run;
proc freq data=satur;
table fr_flag fr_flag2;run;

