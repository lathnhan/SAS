/**********************************************************************************************
WEIGHT-RELATED BEHAVIORS AMONG ADOLESCENT SOCIAL NETWORKS
Created and updated by: Nhan La
Date: 2013/10/10
Summary: This program concatenates data management and exploratory analysis of AddHealth survey.
The study only used schools that collected social network data.

*Saturated sample. 
Small schools IDs:  001, 002, 003, 081, 088, 106, 007, 008, 115, 126, 028, 369, 194, 175.  
Large school IDs: 058 and 077.;
*Selection criteria:
- In both waves I and II. Those in only one wave are coded as missing.
- In saturated sample. This is to ensure availability data of friends. Those in core yet not saturated sample are excluded.
- Use only in-home variables (physical activity). This is to ensure availability of data in both waves. In-school variables are not used.;
**********************************************************************************************/

PROC IMPORT OUT= WORK.s58list DATAFILE= "D:\Dissertation\Analysis\Add health data\R data\s58comp.csv" DBMS=csv REPLACE;
     GETNAMES=NO;RUN;
data s58list;set s58list;rename var1=id;drop var2 var3;run;

proc sort data=s58list;by id;run;
proc sort data=w1;by id;run;
proc sort data=w2;by id;run;

data s58att;merge s58list(in=listx) w1 w2;by id;if listx=1;run;
proc freq data=s58att;table h1gi4*h1gi9;run;
data s58att;set s58att;keep id bio_sex;


****************************************s58 s58 s58 s58**************************************;

*wave 1;
data friend1;set w1;keep id scid w1mf_aid1-w1mf_aid5 w1ff_aid1-w1ff_aid5;
run;

data f1s58;set friend1;if scid=058 then output f1s58;run;
data f1s58;set f1s58;drop scid;run;
proc transpose data=f1s58 out=f1s58long;by id;run;
data f1s58long;set f1s58long;drop _label_ _name_;rename col1=alter;run;
data f1s58long;set f1s58long;if alter ne .;run;
data f1s58long2; set f1s58long; drop id; rename alter=id;run;
proc sort data=f1s58long nodupkey out=f1s58long3;by id;run;
proc sort data=f1s58long2 nodupkey;by id;run;
data f1s58long4;merge f1s58long2(in=long2x) f1s58long3(in=long3x);by id;long2=long2x;long3=long3x;run;
proc sort data=f1s58long4 nodupkey;by id;run;
proc sort data=f1s58long4;by long3;run; *0s are alters who are not egos;

*exclude dyadic nominations in which alters are not egos;

data f1s58long5;set f1s58long4; if alter=.; run;
data f1s58long5;set f1s58long5;drop alter long2 long3;rename id=alter;run;
data f1s58long5;set f1s58long5;label alter='alter';run;

proc sort data=f1s58long4;by alter;run;
proc sort data=f1s58long5;by alter;run;
data f1s58long6;merge f1s58long4 (in=long4x) f1s58long5 (in=long5x);by alter;long4=long4x;long5=long5x;run;

proc sort data=f1s58long6 nodupkey;by id alter;run;

data f1s58long6;set f1s58long6;if long4=1 and long5=1 then dropv=1;else dropv=0;run;
proc freq data=f1s58long6;table long4*long5;run;
proc freq data=f1s58long6;table long3;run;
data f1s58long7;set f1s58long6;if dropv=0;run;
data f1s58long7;set f1s58long7;if alter ne .;run;
data f1s58long7;set f1s58long7;if id ne .;run;
proc sort data=f1s58long7;by id;run;

*match with original dyadic nominations;
proc sort data=f1s58long7 nodupkey out=f1s58long8;by alter;run;
data f1s58long8;set f1s58long8;keep alter;run;
proc sort data=f1s58long;by alter;run;
data f1s58arc;merge f1s58long (in=longarcx) f1s58long8 (in=long8x);by alter;longarc=longarcx;long8=long8x;run;
proc freq data=f1s58arc;table longarc*long8;run;
data f1s58arc;set f1s58arc;if longarc=1 and long8=1;run;
proc sort data=f1s58arc nodupkey out=f1s58check;by id;run;


*wave 2;
data friend2;set w2;keep id scid2 w2mf_aid1-w2mf_aid5 w2ff_aid1-w2ff_aid5;
run;

data f2s58;set friend2;if scid2=058 then output f2s58;run;
data f2s58;set f2s58;drop scid;run;
proc transpose data=f2s58 out=f2s58long;by id;run;
data f2s58long;set f2s58long;drop _label_ _name_;rename col1=alter;run;
data f2s58long;set f2s58long;if alter ne .;run;
data f2s58long2; set f2s58long; drop id; rename alter=id;run;
proc sort data=f2s58long nodupkey out=f2s58long3;by id;run;
proc sort data=f2s58long2 nodupkey;by id;run;
data f2s58long4;merge f2s58long2(in=long2x) f2s58long3(in=long3x);by id;long2=long2x;long3=long3x;run;
proc sort data=f2s58long4 nodupkey;by id;run;
proc sort data=f2s58long4;by long3;run; *0s are alters who are not egos;

*exclude dyadic nominations in which alters are not egos;

data f2s58long5;set f2s58long4; if alter=.; run;
data f2s58long5;set f2s58long5;drop alter long2 long3;rename id=alter;run;
data f2s58long5;set f2s58long5;label alter='alter';run;

proc sort data=f2s58long4;by alter;run;
proc sort data=f2s58long5;by alter;run;
data f2s58long6;merge f2s58long4 (in=long4x) f2s58long5 (in=long5x);by alter;long4=long4x;long5=long5x;run;

proc sort data=f2s58long6 nodupkey;by id alter;run;

data f2s58long6;set f2s58long6;if long4=1 and long5=1 then dropv=1;else dropv=0;run;
proc freq data=f2s58long6;table long4*long5;run;
proc freq data=f2s58long6;table long3;run;
data f2s58long7;set f2s58long6;if dropv=0;run;
data f2s58long7;set f2s58long7;if alter ne .;run;
data f2s58long7;set f2s58long7;if id ne .;run;
proc sort data=f2s58long7;by id;run;

*match with original dyadic nominations;
proc sort data=f2s58long7 nodupkey out=f2s58long8;by alter;run;
data f2s58long8;set f2s58long8;keep alter;run;
proc sort data=f2s58long;by alter;run;
data f2s58arc;merge f2s58long (in=longarcx) f2s58long8 (in=long8x);by alter;longarc=longarcx;long8=long8x;run;
proc freq data=f2s58arc;table longarc*long8;run;
data f2s58arc;set f2s58arc;if longarc=1 and long8=1;run;
proc sort data=f2s58arc nodupkey out=f2s58check;by id;run;


*There are cases in which alters have matching egos who have connections with another alter that doesn't have matching ego. Those egos will be excluded,
thus creating extra unmatched case. Redo the program to check;

*wave 1;
data f1_s58long;set f1s58arc;drop longarc long8;run;
data f1_s58long2; set f1_s58long; drop id; rename alter=id;
data f1_s58long2; set f1_s58long2;label id='id';run;
proc sort data=f1_s58long nodupkey out=f1_s58long3;by id;run;
proc sort data=f1_s58long2 nodupkey;by id;run;
data f1_s58long4;merge f1_s58long2(in=long2x) f1_s58long3(in=long3x);by id;long2=long2x;long3=long3x;run;
proc sort data=f1_s58long4 nodupkey;by id;run;
proc sort data=f1_s58long4;by long3;run; *0s are alters who are not egos;

*exclude dyadic nominations in which alters are not egos;

data f1_s58long5;set f1_s58long4; if alter=.; run;
data f1_s58long5;set f1_s58long5;drop alter long2 long3;rename id=alter;run;
data f1_s58long5;set f1_s58long5;label alter='alter';run;

proc sort data=f1_s58long4;by alter;run;
proc sort data=f1_s58long5;by alter;run;
data f1_s58long6;merge f1_s58long4 (in=long4x) f1_s58long5 (in=long5x);by alter;long4=long4x;long5=long5x;run;

proc sort data=f1_s58long6 nodupkey;by id alter;run;

data f1_s58long6;set f1_s58long6;if long4=1 and long5=1 then dropv=1;else dropv=0;run;
proc freq data=f1_s58long6;table long4*long5;run;
proc freq data=f1_s58long6;table long3;run;
data f1_s58long7;set f1_s58long6;if dropv=0;run;
data f1_s58long7;set f1_s58long7;if alter ne .;run;
data f1_s58long7;set f1_s58long7;if id ne .;run;
proc sort data=f1_s58long7;by id;run;

*match with original dyadic nominations;


data f1_s58long8;set f1_s58long7;keep alter;run;
proc sort data=f1_s58long8 nodupkey;by alter;run;

proc sort data=f1_s58long;by alter;run;
data f1_s58arc;merge f1_s58long (in=longarcx) f1_s58long8 (in=long8x);by alter;longarc=longarcx;long8=long8x;run;
proc freq data=f1_s58arc;table longarc*long8;run;
data f1_s58arc;set f1_s58arc;if longarc=1 and long8=1;run;
proc sort data=f1_s58arc nodupkey out=f1_s58check;by id;run;

*wave 2;
data f2_s58long;set f2s58arc;drop longarc long8;run;
data f2_s58long2; set f2_s58long; drop id; rename alter=id;run;
proc sort data=f2_s58long nodupkey out=f2_s58long3;by id;run;
proc sort data=f2_s58long2 nodupkey;by id;run;
data f2_s58long4;merge f2_s58long2(in=long2x) f2_s58long3(in=long3x);by id;long2=long2x;long3=long3x;run;
proc sort data=f2_s58long4 nodupkey;by id;run;
proc sort data=f2_s58long4;by long3;run; *0s are alters who are not egos;

*exclude dyadic nominations in which alters are not egos;

data f2_s58long5;set f2_s58long4; if alter=.; run;
data f2_s58long5;set f2_s58long5;drop alter long2 long3;rename id=alter;run;
data f2_s58long5;set f2_s58long5;label alter='alter';run;

proc sort data=f2_s58long4;by alter;run;
proc sort data=f2_s58long5;by alter;run;
data f2_s58long6;merge f2_s58long4 (in=long4x) f2_s58long5 (in=long5x);by alter;long4=long4x;long5=long5x;run;

proc sort data=f2_s58long6 nodupkey;by id alter;run;

data f2_s58long6;set f2_s58long6;if long4=1 and long5=1 then dropv=1;else dropv=0;run;
proc freq data=f2_s58long6;table long4*long5;run;
proc freq data=f2_s58long6;table long3;run;
data f2_s58long7;set f2_s58long6;if dropv=0;run;
data f2_s58long7;set f2_s58long7;if alter ne .;run;
data f2_s58long7;set f2_s58long7;if id ne .;run;
proc sort data=f2_s58long7;by id;run;

*match with original dyadic nominations;
proc sort data=f2_s58long7 nodupkey out=f2_s58long8;by alter;run;
data f2_s58long8;set f2_s58long8;keep alter;run;
proc sort data=f2_s58long;by alter;run;
data f2_s58arc;merge f2_s58long (in=longarcx) f2_s58long8 (in=long8x);by alter;longarc=longarcx;long8=long8x;run;
proc freq data=f2_s58arc;table longarc*long8;run;
data f2_s58arc;set f2_s58arc;if longarc=1 and long8=1;run;
proc sort data=f2_s58arc nodupkey out=f2_s58check;by id;run;

*composition change;
data f1s58arc2;set f1s58arc;drop id longarc long8;rename alter=id;run;
data f1s58arc2;set f1s58arc2;label id='id';run;
proc sort data=f1s58arc nodupkey out=f1s58arc3;by id;run;
proc sort data=f1s58arc2 nodupkey;by id;run;
data f1s58arc4;merge f1s58arc3 (in=arc3x) f1s58arc2 (in=arc2x);arc3=arc3x;arc2=arc2x;run;
proc freq data=f1s58arc4;table arc2*arc3;run;

data f2s58arc2;set f2s58arc;drop id longarc long8;rename alter=id;run;
data f2s58arc2;set f2s58arc2;label id='id';run;
proc sort data=f2s58arc nodupkey out=f2s58arc3;by id;run;
proc sort data=f2s58arc2 nodupkey;by id;run;
data f2s58arc4;merge f2s58arc3 (in=arc3x) f2s58arc2 (in=arc2x);arc3=arc3x;arc2=arc2x;run;
proc freq data=f2s58arc4;table arc2*arc3;run;

proc sort data=f1s58arc;by id;run;
proc sort data=f2s58arc;by id;run;
data f1s58comp;set f1s58arc;keep id;run;
proc sort data=f1s58comp nodupkey;by id;run;
data f2s58comp;set f2s58arc;keep id;run;
proc sort data=f2s58comp nodupkey;by id;run;
data s58comp;merge f1s58comp (in=f1compx) f2s58comp (in=f2compx);by id;f1comp=f1compx;f2comp=f2compx;run;
data s58comp;set s58comp;char_w1comp = put(w1comp, 3.);drop w1comp;rename char_w1comp=w1comp; 
char_w2comp = put(w2comp, 3.);drop w2comp;rename char_w2comp=w2comp;run;
data s58comp;set s58comp;if f1comp=1 and f2comp=1 then w1comp=1;if f1comp=1 and f2comp=1 then w2comp=2;
if f1comp=0 and f2comp=1 then w1comp=1.5;if f1comp=0 and f2comp=1 then w2comp=2;
if f1comp=1 and f2comp=0 then w1comp=1;if f1comp=1 and f2comp=0 then w2comp=1.5;run;
data s58comp;set s58comp;comp= 'c' || '(' || w1comp || ',' || w2comp || ')' || ',';run;
data s58compchange;set s58comp;keep comp;run;
data s58list;set s58comp;keep id;run;
data f1s58arc;set f1s58arc;keep id alter;run;
data f2s58arc;set f2s58arc;keep id alter;run;




PROC EXPORT DATA= WORK.s58list OUTFILE= "D:\Dissertation\Analysis\Add health data\Big schools\s58list.csv" 
DBMS=csv REPLACE;RUN;
PROC EXPORT DATA= WORK.f1s58arc OUTFILE= "D:\Dissertation\Analysis\Add health data\Big schools\f1s58.csv" 
DBMS=csv REPLACE;RUN;
PROC EXPORT DATA= WORK.f2s58arc OUTFILE= "D:\Dissertation\Analysis\Add health data\Big schools\f2s58.csv" 
DBMS=csv REPLACE;RUN;
PROC EXPORT DATA= WORK.s58compchange OUTFILE= "D:\Dissertation\Analysis\Add health data\Big schools\s58compchange.txt" 
DBMS=tab REPLACE;RUN;


****************************************s77 s77 s77 s77**************************************;

*wave 1;
data f1s77;set friend1;if scid=077 then output f1s77;run;
data f1s77;set f1s77;drop scid;run;
proc transpose data=f1s77 out=f1s77long;by id;run;
data f1s77long;set f1s77long;drop _label_ _name_;rename col1=alter;run;
data f1s77long;set f1s77long;if alter ne .;run;
data f1s77long2; set f1s77long; drop id; rename alter=id;run;
proc sort data=f1s77long nodupkey out=f1s77long3;by id;run;
proc sort data=f1s77long2 nodupkey;by id;run;
data f1s77long4;merge f1s77long2(in=long2x) f1s77long3(in=long3x);by id;long2=long2x;long3=long3x;run;
proc sort data=f1s77long4 nodupkey;by id;run;
proc sort data=f1s77long4;by long3;run; *0s are alters who are not egos;

*exclude dyadic nominations in which alters are not egos;

data f1s77long5;set f1s77long4; if alter=.; run;
data f1s77long5;set f1s77long5;drop alter long2 long3;rename id=alter;run;
data f1s77long5;set f1s77long5;label alter='alter';run;

proc sort data=f1s77long4;by alter;run;
proc sort data=f1s77long5;by alter;run;
data f1s77long6;merge f1s77long4 (in=long4x) f1s77long5 (in=long5x);by alter;long4=long4x;long5=long5x;run;

proc sort data=f1s77long6 nodupkey;by id alter;run;

data f1s77long6;set f1s77long6;if long4=1 and long5=1 then dropv=1;else dropv=0;run;
proc freq data=f1s77long6;table long4*long5;run;
proc freq data=f1s77long6;table long3;run;
data f1s77long7;set f1s77long6;if dropv=0;run;
data f1s77long7;set f1s77long7;if alter ne .;run;
data f1s77long7;set f1s77long7;if id ne .;run;
proc sort data=f1s77long7;by id;run;

*match with original dyadic nominations;
proc sort data=f1s77long7 nodupkey out=f1s77long8;by alter;run;
data f1s77long8;set f1s77long8;keep alter;run;
proc sort data=f1s77long;by alter;run;
data f1s77arc;merge f1s77long (in=longarcx) f1s77long8 (in=long8x);by alter;longarc=longarcx;long8=long8x;run;
proc freq data=f1s77arc;table longarc*long8;run;
data f1s77arc;set f1s77arc;if longarc=1 and long8=1;run;
proc sort data=f1s77arc nodupkey out=f1s77check;by id;run;


*wave 2;
data friend2;set w2;keep id scid2 w2mf_aid1-w2mf_aid5 w2ff_aid1-w2ff_aid5;
run;

data f2s77;set friend2;if scid2=077 then output f2s77;run;
data f2s77;set f2s77;drop scid;run;
proc transpose data=f2s77 out=f2s77long;by id;run;
data f2s77long;set f2s77long;drop _label_ _name_;rename col1=alter;run;
data f2s77long;set f2s77long;if alter ne .;run;
data f2s77long2; set f2s77long; drop id; rename alter=id;run;
proc sort data=f2s77long nodupkey out=f2s77long3;by id;run;
proc sort data=f2s77long2 nodupkey;by id;run;
data f2s77long4;merge f2s77long2(in=long2x) f2s77long3(in=long3x);by id;long2=long2x;long3=long3x;run;
proc sort data=f2s77long4 nodupkey;by id;run;
proc sort data=f2s77long4;by long3;run; *0s are alters who are not egos;

*exclude dyadic nominations in which alters are not egos;

data f2s77long5;set f2s77long4; if alter=.; run;
data f2s77long5;set f2s77long5;drop alter long2 long3;rename id=alter;run;
data f2s77long5;set f2s77long5;label alter='alter';run;

proc sort data=f2s77long4;by alter;run;
proc sort data=f2s77long5;by alter;run;
data f2s77long6;merge f2s77long4 (in=long4x) f2s77long5 (in=long5x);by alter;long4=long4x;long5=long5x;run;

proc sort data=f2s77long6 nodupkey;by id alter;run;

data f2s77long6;set f2s77long6;if long4=1 and long5=1 then dropv=1;else dropv=0;run;
proc freq data=f2s77long6;table long4*long5;run;
proc freq data=f2s77long6;table long3;run;
data f2s77long7;set f2s77long6;if dropv=0;run;
data f2s77long7;set f2s77long7;if alter ne .;run;
data f2s77long7;set f2s77long7;if id ne .;run;
proc sort data=f2s77long7;by id;run;

*match with original dyadic nominations;
proc sort data=f2s77long7 nodupkey out=f2s77long8;by alter;run;
data f2s77long8;set f2s77long8;keep alter;run;
proc sort data=f2s77long;by alter;run;
data f2s77arc;merge f2s77long (in=longarcx) f2s77long8 (in=long8x);by alter;longarc=longarcx;long8=long8x;run;
proc freq data=f2s77arc;table longarc*long8;run;
data f2s77arc;set f2s77arc;if longarc=1 and long8=1;run;
proc sort data=f2s77arc nodupkey out=f2s77check;by id;run;


*composition change;
data f1s77arc2;set f1s77arc;drop id longarc long8;rename alter=id;run;
data f1s77arc2;set f1s77arc2;label id='id';run;
proc sort data=f1s77arc nodupkey out=f1s77arc3;by id;run;
proc sort data=f1s77arc2 nodupkey;by id;run;
data f1s77arc4;merge f1s77arc3 (in=arc3x) f1s77arc2 (in=arc2x);arc3=arc3x;arc2=arc2x;run;
proc freq data=f1s77arc4;table arc2*arc3;run;

data f2s77arc2;set f2s77arc;drop id longarc long8;rename alter=id;run;
data f2s77arc2;set f2s77arc2;label id='id';run;
proc sort data=f2s77arc nodupkey out=f2s77arc3;by id;run;
proc sort data=f2s77arc2 nodupkey;by id;run;
data f2s77arc4;merge f2s77arc3 (in=arc3x) f2s77arc2 (in=arc2x);arc3=arc3x;arc2=arc2x;run;
proc freq data=f2s77arc4;table arc2*arc3;run;

proc sort data=f1s77arc;by id;run;
proc sort data=f2s77arc;by id;run;
data f1s77comp;set f1s77arc;keep id;run;
proc sort data=f1s77comp nodupkey;by id;run;
data f2s77comp;set f2s77arc;keep id;run;
proc sort data=f2s77comp nodupkey;by id;run;
data s77comp;merge f1s77comp (in=f1compx) f2s77comp (in=f2compx);by id;f1comp=f1compx;f2comp=f2compx;run;
data s77comp;set s77comp;char_w1comp = put(w1comp, 3.);drop w1comp;rename char_w1comp=w1comp; 
char_w2comp = put(w2comp, 3.);drop w2comp;rename char_w2comp=w2comp;run;
data s77comp;set s77comp;if f1comp=1 and f2comp=1 then w1comp=1;if f1comp=1 and f2comp=1 then w2comp=2;
if f1comp=0 and f2comp=1 then w1comp=1.5;if f1comp=0 and f2comp=1 then w2comp=2;
if f1comp=1 and f2comp=0 then w1comp=1;if f1comp=1 and f2comp=0 then w2comp=1.5;run;
data s77comp;set s77comp;comp= 'c' || '(' || w1comp || ',' || w2comp || ')' || ',';run;
data s77compchange;set s77comp;keep comp;run;
data s77list;set s77comp;keep id;run;
data f1s77arc;set f1s77arc;keep id alter;run;
data f2s77arc;set f2s77arc;keep id alter;run;

PROC EXPORT DATA= WORK.s77list OUTFILE= "D:\Dissertation\Analysis\Add health data\Big schools\s77list.xls" 
DBMS=xls REPLACE;RUN;
PROC EXPORT DATA= WORK.f1s77arc OUTFILE= "D:\Dissertation\Analysis\Add health data\Big schools\f1s77.csv" 
DBMS=csv REPLACE;RUN;
PROC EXPORT DATA= WORK.f2s77arc OUTFILE= "D:\Dissertation\Analysis\Add health data\Big schools\f2s77.csv" 
DBMS=csv REPLACE;RUN;
PROC EXPORT DATA= WORK.s77compchange OUTFILE= "D:\Dissertation\Analysis\Add health data\Big schools\s77compchange.txt" 
DBMS=tab REPLACE;RUN;


PROC IMPORT OUT= WORK.f1s58 DATAFILE= "D:\Dissertation\Analysis\Add health data\Big schools\f1s58.csv" DBMS=csv REPLACE;
     GETNAMES=NO;RUN;
data f1s58;set f1s58;extra='i';
id=trim(extra)||var1;
alter=trim(extra) || var2;run;
data f1s58;set f1s58;drop var1 var2 var3;tie=1;run;
PROC EXPORT DATA= WORK.f1s58 OUTFILE= "D:\Dissertation\Analysis\Add health data\Big schools\f1s58.csv" 
DBMS=csv REPLACE;RUN;

PROC IMPORT OUT= WORK.f2s58 DATAFILE= "D:\Dissertation\Analysis\Add health data\Big schools\f2s58.csv" DBMS=csv REPLACE;
     GETNAMES=NO;RUN;
data f2s58;set f2s58;extra='i';
id=trim(extra)||var1;
alter=trim(extra) || var2;run;
data f2s58;set f2s58;drop var1 var2 var3;tie=1;run;
PROC EXPORT DATA= WORK.f2s58 OUTFILE= "D:\Dissertation\Analysis\Add health data\Big schools\f2s58.csv" 
DBMS=csv REPLACE;RUN;

PROC IMPORT OUT= WORK.s58list DATAFILE= "D:\Dissertation\Analysis\Add health data\Big schools\s58list.csv" DBMS=csv REPLACE;
     GETNAMES=NO;RUN;
data s58list;set s58list;idi=trim(var1)||'_';run;
data s58list;set s58list;keep idi;run;
PROC EXPORT DATA= WORK.s58list OUTFILE= "D:\Dissertation\Analysis\Add health data\Big schools\s58list.csv" 
DBMS=csv REPLACE;RUN;




PROC IMPORT OUT= WORK.f1s77 DATAFILE= "D:\Dissertation\Analysis\Add health data\Big schools\f1s77.csv" DBMS=csv REPLACE;
     GETNAMES=NO;RUN;
data f1s77;set f1s77;id=trim(var1) || '_';
alter=trim(var2) || '_';run;
data f1s77;set f1s77;drop var1 var2 var3;tie=1;run;


PROC EXPORT DATA= WORK.f1s77 OUTFILE= "D:\Dissertation\Analysis\Add health data\Big schools\f1s77.csv" 
DBMS=csv REPLACE;RUN;

PROC IMPORT OUT= WORK.f2s77 DATAFILE= "D:\Dissertation\Analysis\Add health data\Big schools\f2s77.csv" DBMS=csv REPLACE;
     GETNAMES=NO;RUN;
data f2s77;set f2s77;id=trim(var1) || '_';
alter=trim(var2) || '_';run;
data f2s77;set f2s77;drop var1 var2 var3;tie=1;run;


PROC EXPORT DATA= WORK.f2s77 OUTFILE= "D:\Dissertation\Analysis\Add health data\Big schools\f2s77.csv" 
DBMS=csv REPLACE;RUN;

PROC IMPORT OUT= WORK.s77list DATAFILE= "D:\Dissertation\Analysis\Add health data\Big schools\s77list.csv" DBMS=csv REPLACE;
     GETNAMES=NO;RUN;
data s77list;set s77list;id=trim(var1) || '_';
data s77list;set s77list;drop var1;run;
PROC EXPORT DATA= WORK.s77list OUTFILE= "D:\Dissertation\Analysis\Add health data\Big schools\s77list.csv" 
DBMS=csv REPLACE;RUN;


PROC IMPORT OUT=WORK.f1s58 DATAFILE="D:\Dissertation\Analysis\Add health data\Big schools\Arclist store\f1s58.csv" DBMS=csv REPLACE;GETNAMES=NO;RUN;
PROC IMPORT OUT=WORK.f2s58 DATAFILE="D:\Dissertation\Analysis\Add health data\Big schools\Arclist store\f2s58.csv" DBMS=csv REPLACE;GETNAMES=NO;RUN;

data f1s58list1;set f1s58;drop var1 var3;rename var2=var1;run;
data f1s58list2;set f1s58;keep var1;run;
proc sort data=f1s58list1;by var1;run;
proc sort data=f1s58list2;by var1;run;
data f1s58list;merge f1s58list1 (in=list1x) f1s58list2 (in=list2x);by var1;list1=list1x;list2=list2x;run;
proc sort data=f1s58list nodupkey;by var1;run;
proc freq data=f1s58list;table list1*list2;run;
data f1s58list;set f1s58list;keep var1;run;

data f2s58list1;set f2s58;drop var1 var3;rename var2=var1;run;
data f2s58list2;set f2s58;keep var1;run;
proc sort data=f2s58list1;by var1;run;
proc sort data=f2s58list2;by var1;run;
data f2s58list;merge f2s58list1 (in=list1x) f2s58list2 (in=list2x);by var1;list1=list1x;list2=list2x;run;
proc sort data=f2s58list nodupkey;by var1;run;
proc freq data=f2s58list;table list1*list2;run;
data f2s58list;set f2s58list;keep var1;run;

data s58list;
merge f1s58list (in=f1x) f2s58list (in=f2x);by var1;f1=f1x;f2=f2x;run;
proc freq data=s58list;table f1*f2;run;
proc sort data=s58list nodupkey;by var1;run;

PROC EXPORT DATA= WORK.s58list OUTFILE= "D:\Dissertation\Analysis\Add health data\Big schools\Arclist store\s58list.csv" 
DBMS=csv REPLACE;RUN;

data s58compchange;
set s58list;
if f1=0 then comp1=1.5;else comp1=1;
if f2=0 then comp2=1.5;else comp2=2;
run;
data s58compchange;
set s58compchange;
comp= 'c'||'('||comp1||','||comp2||')'||',';
run;
data s58compchange;set s58compchange;keep comp;run;
PROC EXPORT DATA= WORK.s58compchange OUTFILE= "D:\Dissertation\Analysis\Add health data\Big schools\Arclist store\s58compchange.txt" 
DBMS=tab REPLACE;RUN;


*******************************77 77 77******************************;

PROC IMPORT OUT=WORK.f1s77 DATAFILE="D:\Dissertation\Analysis\Add health data\Big schools\Arclist store\f1s77.csv" DBMS=csv REPLACE;GETNAMES=NO;RUN;
PROC IMPORT OUT=WORK.f2s77 DATAFILE="D:\Dissertation\Analysis\Add health data\Big schools\Arclist store\f2s77.csv" DBMS=csv REPLACE;GETNAMES=NO;RUN;

data f1s77list1;set f1s77;drop var1 var3;rename var2=var1;run;
data f1s77list2;set f1s77;keep var1;run;
proc sort data=f1s77list1;by var1;run;
proc sort data=f1s77list2;by var1;run;
data f1s77list;merge f1s77list1 (in=list1x) f1s77list2 (in=list2x);by var1;list1=list1x;list2=list2x;run;
proc sort data=f1s77list nodupkey;by var1;run;
proc freq data=f1s77list;table list1*list2;run;
data f1s77list;set f1s77list;keep var1;run;

data f2s77list1;set f2s77;drop var1 var3;rename var2=var1;run;
data f2s77list2;set f2s77;keep var1;run;
proc sort data=f2s77list1;by var1;run;
proc sort data=f2s77list2;by var1;run;
data f2s77list;merge f2s77list1 (in=list1x) f2s77list2 (in=list2x);by var1;list1=list1x;list2=list2x;run;
proc sort data=f2s77list nodupkey;by var1;run;
proc freq data=f2s77list;table list1*list2;run;
data f2s77list;set f2s77list;keep var1;run;

data s77list;
merge f1s77list (in=f1x) f2s77list (in=f2x);by var1;f1=f1x;f2=f2x;run;
proc freq data=s77list;table f1*f2;run;
proc sort data=s77list nodupkey;by var1;run;

PROC EXPORT DATA= WORK.s77list OUTFILE= "D:\Dissertation\Analysis\Add health data\Big schools\Arclist store\s77list.csv" 
DBMS=csv REPLACE;RUN;

data s77compchange;
set s77list;
if f1=0 then comp1=1.5;else comp1=1;
if f2=0 then comp2=1.5;else comp2=2;
run;
data s77compchange;
set s77compchange;
comp= 'c'||'('||comp1||','||comp2||')'||',';
run;
data s77compchange;set s77compchange;keep comp;run;
PROC EXPORT DATA= WORK.s77compchange OUTFILE= "D:\Dissertation\Analysis\Add health data\Big schools\Arclist store\s77compchange.txt" 
DBMS=tab REPLACE;RUN;





