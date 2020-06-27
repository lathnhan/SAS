/**********************************************************************************************
YOUTH GROUP HOMES
Created and updated by: Nhan La
Date: 2012/12/06
Summary: This program performs analysis of group home outcomes at individual level
**********************************************************************************************/


libname des 'D:\Academics\Group homes\Data check';

/*Initial exploration, create TFA variable*/
data des.tracker;
set des.tracker;
run;
proc print data=des.tracker;
run;
proc contents data=des.tracker;
run;

data des.tracker;
set des.tracker;
if agencyid=3 or agencyid=5 or agencyid=15 then TFA=1;
else if agencyid=2 or agencyid=29 or agencyid=30 or agencyid=31 then TFA=2;
else TFA=3;
run;

proc print data=des.tracker;
var tfa;
run;

data des.tracker;
set des.tracker;
label tfa='Teaching Family Status';
run;

proc format;
value TFA
  1='Fully Teaching Family' 2='Partially Teaching Family' 3='Non-Teaching Family';
run;
data des.tracker;
set des.tracker;
format tfa TFA;
run;
proc freq data=des.tracker;
table tfa;
run;
/*** Basic demographics**/
/*Select cases*/
data temp;
set des.tracker; 
if tfa=3 then tfafp=.;  /*Full vs. partiall*/
else tfafp = tfa;
run;
data temp;
set des.tracker;
if tfa = 1 then tfatn=1;
if tfa = 2 then tfatn=1;
if tfa = 3 then tfatn=2;  /*teaching vs. non-teaching*/
run;
proc freq data=temp;
table tfafp tfatn;
run;

proc freq data=temp;
table gender*licenselevel / chisq list;/*Gender*/
run;


/*Gender*/
data trackertemp;
set des.tracker;

proc freq data=trackertemp;
table gender*licenselevel / chisq;
run;

/*Race*/
data trackertemp; 
set trackertemp;
racegrp=.;
if race=5 then racegrp=1;
else if race=1 or race=2 or race=3 or race=4 or race=6 or race=7 then racegrp=2;
run;
proc freq data=trackertemp;
table racegrp*licenselevel / chisq;
run;

proc freq data=temp;
table racegrp*licenselevel / chisq;
run;


/*Compare full vs. non*/
data temp;
set temp;
racegrp=.;
if race=5 then racegrp=1;
else if race=1 or race=2 or race=3 or race=4 or race=6 or race=7 then racegrp=2;
run;

proc freq data=temp;
table racegrp*tfa / chisq;
run;


/*Age*/
/*Which date should be used at the other end*/
data trackertemp;
set trackertemp;
age = (ikint1-date_of_birth)/365.25;
run;
proc print data=des.tracker;
var ikint1 date_of_birth age;
run;

proc anova data=trackertemp;
class licenselevel;
model age=licenselevel;
means licenselevel;
run;


proc glm data=temp;
class licenselevel;
model age=licenselevel;
means licenselevel;
run;
quit;

/*Compare Full vs. partially*/
data temp;
set temp;
age = (ikint1-date_of_birth)/365.25;
run;
proc ttest data=temp;
class tfa;
var age;
run;

/*Compare full vs. non*/
data temp;
set temp;
age = (ikint1-date_of_birth)/365.25;
run;
proc ttest data=temp;
class tfa;
var age;
run;


/*2. Merge Tracker and SDQWIDE files*/
proc sort data=des.tracker;
  by kidid;
run;

proc sort data=des.sdqwide;
  by kidid;
run;

data des.merge;
  merge des.tracker des.sdqwide;
  by kidid;
run;

/*Select cases*/
/*Full vs. partiall*/
data temp;
set des.merge;
if tfa=3 then do;
tfa=.;
end;
run;
/*Full vs. non*/
data temp;
set des.merge;
if tfa=2 then do;
tfa=.;
end;
run;

data temp;
set des.merge;
run;

/*SDQICS descriptive statistics*/
proc glm data=temp;
class tfa;
model pag_sdqemotion_1=tfa;
means tfa;
run;
quit;
proc glm data=temp;
class tfa;
model pag_sdqconduct_1=tfa;
means tfa;
run;
quit;
proc glm data=temp;
class tfa;
model pag_sdqhyper_1=tfa;
means tfa;
run;
quit;
proc glm data=temp;
class tfa;
model pag_sdqpeer_1=tfa;
means tfa;
run;
quit;
proc glm data=temp;
class tfa;
model pag_sdqprosoc_1=tfa;
means tfa;
run;
quit;
proc glm data=temp;
class tfa;
model pag_sdqebdtot_1=tfa;
means tfa;
run;
quit;

/*SDQ - licenselevel*/

proc glm data=temp;
class licenselevel;
model pag_sdqemotion_1=licenselevel;
means licenselevel;
run;
quit;
proc glm data=temp;
class licenselevel;
model pag_sdqconduct_1=licenselevel;
means licenselevel;
run;
quit;
proc glm data=temp;
class licenselevel;
model pag_sdqhyper_1=licenselevel;
means licenselevel;
run;
quit;
proc glm data=temp;
class licenselevel;
model pag_sdqpeer_1=licenselevel;
means licenselevel;
run;
quit;
proc glm data=temp;
class licenselevel;
model pag_sdqprosoc_1=licenselevel;
means licenselevel;
run;
quit;
proc glm data=temp;
class licenselevel;
model pag_sdqebdtot_1=licenselevel;
means licenselevel;
run;
quit;

/*Composite measure for SDQ and relevant statistics*/

data temp;
set temp;
m_sdq=mean(pag_sdqemotion_1, pag_sdqconduct_1, pag_sdqhyper_1, pag_sdqpeer_1, pag_sdqprosoc_1, pag_sdqebdtot_1);
run;

data temp;
set temp;
if tfa=1 or tfa=2 then TFA1=1;
if tfa=3 then TFA1=2;
run;

proc corr data=temp alpha nomiss;
title 'sdq correlation matrix';
var pag_sdqemotion_1 pag_sdqconduct_1 pag_sdqhyper_1 pag_sdqpeer_1 pag_sdqebdtot_1;
run;

/*Remove pag_sdqprosoc_1 to obtain higher cronbach's alpha coeff*/

/*Select cases*/
/*Full vs. partiall*/
data temp;
set des.merge;
if tfa=3 then do;
tfa=.;
end;
run;
/*Full vs. non*/
data temp;
set des.merge;
if tfa=2 then do;
tfa=.;
end;
run;
proc anova data=temp;
title 'analysis of sdq composite';
class tfa;
model m_sdq=tfa;
means tfa;
run;

proc ttest data=temp;
title 'sdq composite by combined tfa';
class tfa;
var m_sdq;
run;

proc anova data=temp;
title 'analysis of sdq composite';
class licenselevel;
model m_sdq=licenselevel;
means licenselevel;
run;



/*Prior placement*/
proc print data=des.pag;
var pag_agencyid;
run;

data des.pag;
set des.pag;
if pag_agencyid=3 or pag_agencyid=5 or pag_agencyid=15 then TFA=1;
else if pag_agencyid=2 or pag_agencyid=29 or pag_agencyid=30 or pag_agencyid=31 then TFA=2;
else TFA=3;
run;
proc freq data=des.pag;
table tfa;
run;
proc freq data=des.pag;
table pag_19a*tfa pag_19b*tfa pag_19c*tfa pag_19d*tfa pag_19e*tfa pag_19f*tfa pag_19g*tfa pag_19h*tfa pag_19i*tfa pag_19j*tfa pag_19k*tfa pag_19l*tfa/ chisq;
run;

proc freq data=temp;
table (pag_19a pag_19b pag_19c pag_19d pag_19e pag_19f pag_19g pag_19h pag_19i pag_19j pag_19k pag_19l)*licenselevel / chisq;
run;

proc anova data=des.pag;
class tfa;
model pag_19d=tfa;
means tfa;
run;
proc freq data=des.pag;
table pag_19d*tfa/chisq;
run;


/*Youth and staff skills*/

proc print data=des.ho;
var agencyid ho_s1a1;
run;

data des.ho;
set des.ho;
if agencyid=3 or agencyid=5 or agencyid=15 then TFA=1;
else if agencyid=2 or agencyid=29 or agencyid=30 or agencyid=31 then TFA=2;
else TFA=3;
run;


/*Create a variable that counts the times data were collected for each home*/

proc sort data=des.ho;
by homeid;
run;

data des.desc;
	set des.ho;
	count+1;
	by homeid;
	if first.homeid then count=1;
run;


/*Create mean values for each observation*/

proc sort data=des.desc;
by homeid count;
run;

data des.meanrating;

	set des.desc;
	by homeid count;

	array ratingvars ho_s1a1 ho_s1a2 ho_s1a3 ho_s1b1 ho_s1b2 ho_s1b3 ho_s2a1_s1 ho_s2a2_s1 ho_s2a3_s1 ho_s2a4_s1 ho_s2b1_s1 ho_s2b2_s1 ho_s2b3_s1 ho_s2b4_s1 ho_s2b5_s1
					  ho_s2b6_s1 ho_s2b7_s1 ho_s2b8_s1 ho_s3a1 ho_s3a2 ho_s3a3 ho_s3b1 ho_s3c1 ho_s3c2 ho_s3c3 ho_s3c4 ho_s3c5 ho_s4a1-ho_s4a6 ho_s4b1-ho_s4b2
					  ho_s4c1-ho_s4c5 tfa;	
	array ret1vars ret1var1-ret1var41;

	array ret2vars ret2var1-ret2var41;

retain ret1vars ret2vars ratingcount;

drop 	count
		ho_s1a1 ho_s1a2 ho_s1a3 ho_s1b1 ho_s1b2 ho_s1b3 ho_s2a1_s1 ho_s2a2_s1 ho_s2a3_s1 ho_s2a4_s1 ho_s2b1_s1 ho_s2b2_s1 ho_s2b3_s1 ho_s2b4_s1 ho_s2b5_s1
					  ho_s2b6_s1 ho_s2b7_s1 ho_s2b8_s1 ho_s3a1 ho_s3a2 ho_s3a3 ho_s3b1 ho_s3c1 ho_s3c2 ho_s3c3 ho_s3c4 ho_s3c5 ho_s4a1-ho_s4a6 ho_s4b1-ho_s4b2
					  ho_s4c1-ho_s4c5 tfa
 		ret1var1-ret1var41
 		ret2var1-ret2var41
 		ratingcount;

array ratingmean mho_s1a1 mho_s1a2 mho_s1a3 mho_s1b1 mho_s1b2 mho_s1b3 mho_s2a1_s1 mho_s2a2_s1 mho_s2a3_s1 mho_s2a4_s1 mho_s2b1_s1 mho_s2b2_s1 mho_s2b3_s1 mho_s2b4_s1 mho_s2b5_s1
			mho_s2b6_s1 mho_s2b7_s1 mho_s2b8_s1 mho_s3a1 mho_s3a2 mho_s3a3 mho_s3b1 mho_s3c1 mho_s3c2 mho_s3c3 mho_s3c4 mho_s3c5 mho_s4a1-mho_s4a6 mho_s4b1-mho_s4b2
					  mho_s4c1-mho_s4c5 mtfa;

if first.homeid=1 then do;
 do over ret1vars;
 ret1vars=.;
 ret2vars=.;
 end;
 ratingcount=0;
 end;

ratingcount=ratingcount+1;

if ratingcount=1 then do over ret1vars;
 	ret1vars=ratingvars;
 	end;
else if ratingcount=2 then do over ret2vars;
	ret2vars=ratingvars;
	end;

if last.homeid=1 then do;
 do over ratingmean;
 ratingmean=mean(ret1vars,ret2vars);
 end;
output;
end;

run;

proc print;
run;

/*Youth skills*/
proc means data=des.meanrating;
 class mtfa;
 var mho_s1a1;
 run;

proc means data=des.meanrating;
 class mtfa;
 var mho_s1a2;
 run;
proc means data=des.meanrating;
 class mtfa;
 var mho_s1a3;
 run;

proc means data=des.meanrating;
 class mtfa;
 var mho_s1b1;
 run;
proc means data=des.meanrating;
 class mtfa;
 var mho_s1b2;
 run;
proc means data=des.meanrating;
 class mtfa;
 var mho_s1b3;
 run;
/*Youth skills - licenselevel*/
proc means data=des.meanrating;
 class licenselevel;
 var mho_s1a1;
 run;

proc means data=des.meanrating;
 class licenselevel;
 var mho_s1a2;
 run;
proc means data=des.meanrating;
 class licenselevel;
 var mho_s1a3;
 run;

proc means data=des.meanrating;
 class licenselevel;
 var mho_s1b1;
 run;
proc means data=des.meanrating;
 class licenselevel;
 var mho_s1b2;
 run;
proc means data=des.meanrating;
 class licenselevel;
 var mho_s1b3;
 run;

 /*Staff skills*/
proc means data=des.meanrating;
 class mtfa;
 var MHO_S2A1_s1;
run;
proc means data=des.meanrating;
 class mtfa;
 var MHO_S2A2_s1;
run;
proc means data=des.meanrating;
 class mtfa;
 var MHO_S2A3_s1;
run;
proc means data=des.meanrating;
 class mtfa;
 var MHO_S2A4_s1;
run;
proc means data=des.meanrating;
 class mtfa;
 var MHO_S2B1_s1;
run;
proc means data=des.meanrating;
 class mtfa;
 var MHO_S2B2_s1;
run;
proc means data=des.meanrating;
 class mtfa;
 var MHO_S2B3_s1;
run;
proc means data=des.meanrating;
 class mtfa;
 var MHO_S2B4_s1;
run;
proc means data=des.meanrating;
 class mtfa;
 var MHO_S2B5_s1;
run;
proc means data=des.meanrating;
 class mtfa;
 var MHO_S2B6_s1;
run;
proc means data=des.meanrating;
 class mtfa;
 var MHO_S2B7_s1;
run;
proc means data=des.meanrating;
 class mtfa;
 var MHO_S2B8_s1;
run;

/*Staff skills - license levels*/
proc means data=des.meanrating;
 class licenselevel;
 var MHO_S2A1_s1;
run;
proc means data=des.meanrating;
 class licenselevel;
 var MHO_S2A2_s1;
run;
proc means data=des.meanrating;
 class licenselevel;
 var MHO_S2A3_s1;
run;
proc means data=des.meanrating;
 class licenselevel;
 var MHO_S2A4_s1;
run;
proc means data=des.meanrating;
 class licenselevel;
 var MHO_S2B1_s1;
run;
proc means data=des.meanrating;
 class licenselevel;
 var MHO_S2B2_s1;
run;
proc means data=des.meanrating;
 class licenselevel;
 var MHO_S2B3_s1;
run;

/*Structure and system*/

proc means data=des.meanrating;
 class mtfa;
 var mho_s3a1;
run;
proc means data=des.meanrating;
 class mtfa;
 var mho_s3a2;
run;
proc means data=des.meanrating;
 class mtfa;
 var mho_s3a3;
run;
proc means data=des.meanrating;
 class mtfa;
 var mho_s3b1;
run;
proc means data=des.meanrating;
 class mtfa;
 var mho_s3c1;
run;
proc means data=des.meanrating;
 class mtfa;
 var mho_s3c2;
run;
proc means data=des.meanrating;
 class mtfa;
 var mho_s3c3;
run;
proc means data=des.meanrating;
 class mtfa;
 var mho_s3c4;
run;
proc means data=des.meanrating;
 class mtfa;
 var mho_s3c5;
run;
proc means data=des.meanrating;
 class mtfa;
 var mho_s4a1;
run;
proc means data=des.meanrating;
 class mtfa;
 var mho_s4a2;
run;
proc means data=des.meanrating;
 class mtfa;
 var mho_s4a3;
run;
proc means data=des.meanrating;
 class mtfa;
 var mho_s4a4;
run;
proc means data=des.meanrating;
 class mtfa;
 var mho_s4a5;
run;
proc means data=des.meanrating;
 class mtfa;
 var mho_s4a6;
run;
proc means data=des.meanrating;
 class mtfa;
 var mho_s4b1;
run;
proc means data=des.meanrating;
 class mtfa;
 var mho_s4b2;
run;
proc means data=des.meanrating;
 class mtfa;
 var mho_s4c1;
run;
proc means data=des.meanrating;
 class mtfa;
 var mho_s4c2;
run;
proc means data=des.meanrating;
 class mtfa;
 var mho_s4c3;
run;
proc means data=des.meanrating;
 class mtfa;
 var mho_s4c4;
run;
proc means data=des.meanrating;
 class mtfa;
 var mho_s4c5;
run;


/*Structure and system - licenselevel*/

proc means data=des.meanrating;
 class licenselevel;
 var mho_s3a1;
run;
proc means data=des.meanrating;
 class licenselevel;
 var mho_s3a2;
run;
proc means data=des.meanrating;
 class licenselevel;
 var mho_s3a3;
run;
proc means data=des.meanrating;
 class licenselevel;
 var mho_s3b1;
run;
proc means data=des.meanrating;
 class licenselevel;
 var mho_s3c1;
run;
proc means data=des.meanrating;
 class licenselevel;
 var mho_s3c2;
run;
proc means data=des.meanrating;
 class licenselevel;
 var mho_s3c3;
run;
proc means data=des.meanrating;
 class licenselevel;
 var mho_s3c4;
run;
proc means data=des.meanrating;
 class licenselevel;
 var mho_s3c5;
run;
proc means data=des.meanrating;
 class licenselevel;
 var mho_s4a1;
run;
proc means data=des.meanrating;
 class licenselevel;
 var mho_s4a2;
run;
proc means data=des.meanrating;
 class licenselevel;
 var mho_s4a3;
run;
proc means data=des.meanrating;
 class licenselevel;
 var mho_s4a4;
run;
proc means data=des.meanrating;
 class licenselevel;
 var mho_s4a5;
run;
proc means data=des.meanrating;
 class licenselevel;
 var mho_s4a6;
run;
proc means data=des.meanrating;
 class licenselevel;
 var mho_s4b1;
run;
proc means data=des.meanrating;
 class licenselevel;
 var mho_s4b2;
run;
proc means data=des.meanrating;
 class licenselevel;
 var mho_s4c1;
run;
proc means data=des.meanrating;
 class licenselevel;
 var mho_s4c2;
run;
proc means data=des.meanrating;
 class licenselevel;
 var mho_s4c3;
run;
proc means data=des.meanrating;
 class licenselevel;
 var mho_s4c4;
run;
proc means data=des.meanrating;
 class licenselevel;
 var mho_s4c5;
run;


/*Composite measure and statistics for youth skills, staff skills, and home characteristics*/


data des.meanrating;
set des.meanrating;
if mtfa=1 or mtfa=2 then TFA1=1;
if mtfa=3 then tfa1=2;
run;

data des.meanrating;
set des.meanrating;
m_socskill=mean(mho_s1a1, mho_s1a2, mho_s1a3);
m_progskill=mean(mho_s1b1, mho_s1b2, mho_s1b3);
m_behav_s1=mean(mho_s2a1_s1, mho_s2a2_s1, mho_s2a3_s1, mho_s2a4_s1);
m_teach_s1=mean(mho_s2b1_s1, mho_s2b2_s1, mho_s2b3_s1);
m_sysdec=mean(mho_s3a1, mho_s3a2, mho_s3a3);
m_sysmov=mean(mho_s3c1, mho_s3c2, mho_s3c3, mho_s3c4, mho_s3c5);
m_ho_atmo=mean(mho_s4a1, mho_s4a2, mho_s4a3, mho_s4a4, mho_s4a5, mho_s4a6);
m_ho_envi=mean(mho_s4b1, mho_s4b2);
m_ho_safe=mean(mho_s4c1, mho_s4c2, mho_s4c3, mho_s4c4, mho_s4c5);
run;

data des.meanrating;
set des.meanrating;
m_yskill=mean(mho_s1a1, mho_s1a2, mho_s1a3, mho_s1b1, mho_s1b2, mho_s1b3);
m_skill_s1=mean(mho_s2a1_s1, mho_s2a2_s1, mho_s2a3_s1, mho_s2a4_s1, mho_s2b1_s1, mho_s2b2_s1, mho_s2b3_s1);
m_sys=mean(mho_s3a1, mho_s3a2, mho_s3a3, mho_s3b1, mho_s3c1, mho_s3c2, mho_s3c3, mho_s3c4, mho_s3c5);
m_ho=mean(mho_s4a1, mho_s4a2, mho_s4a3, mho_s4a4, mho_s4a5, mho_s4a6, mho_s4b1, mho_s4b2, mho_s4c1, mho_s4c2, mho_s4c3, mho_s4c4, mho_s4c5);
run;

data temp;
set des.meanrating;
run;

/*Correlation matrix*/

proc corr data=temp alpha;
title 'youth skill correlation matrix';
var mho_s1a1 mho_s1a2 mho_s1a3 mho_s1b1 mho_s1b2 mho_s1b3;
run;
proc corr data=temp;
title 'youth skill composite correlation matrix';
var m_socskill m_progskill;
run;

proc corr data=temp alpha;
title 'staff 1 skill correlation matrix';
var mho_s2a1_s1 mho_s2a2_s1 mho_s2a3_s1 mho_s2a4_s1 mho_s2b1_s1 mho_s2b2_s1 mho_s2b3_s1;
run;
proc corr data=temp;
title 'staff 1 skill composite correlation matrix';
var m_behav_s1 m_teach_s1;
run;

proc corr data=temp alpha;
title 'structure and system correlation matrix';
var mho_s3a1 mho_s3a2 mho_s3a3 mho_s3b1 mho_s3c1-mho_s3c5;
run;
proc corr data=temp;
title 'structure and system composite correlation matrix';
var m_sysdec mho_s3b1 m_sysmov;
run;

proc corr data=temp alpha;
title 'home characteristic correlation matrix';
var mho_s4a1-mho_s4a6 mho_s4b1-mho_s4b2 mho_s4c1-mho_s4c5;
run;
proc corr data=temp;
title 'home composite correlation matrix';
var m_ho_atmo m_ho_envi m_ho_safe;
run;

proc corr data=temp;
title 'composite measures correlation matrix';
var m_yskill m_skill_s1 m_sys m_ho;
run;

/*ANOVA*/

/*Select cases*/
/*Full vs. partiall*/
data temp;
set des.meanrating;
if mtfa=3 then do;
mtfa=.;
end;
run;
/*Full vs. non*/
data temp;
set des.meanrating;
if mtfa=2 then do;
mtfa=.;
end;
run;


/*Youth skill*/
proc anova data=temp;
title 'social skill composite';
class mtfa;
model m_socskill=mtfa;
means mtfa;
run;
proc anova data=temp;
title 'program understanding composite';
class mtfa;
model m_progskill=mtfa;
means mtfa;
run;

proc anova data=temp;
title 'youth skill composite';
class mtfa;
model m_yskill=mtfa;
means mtfa;
run;

/*Youth skill - pairwise comparison*/
proc ttest data=temp;
title 'social skill composite';
class mtfa;
var m_socskill;
run;
proc ttest data=temp;
title 'program understanding composite';
class mtfa;
var m_progskill;
run;

proc ttest data=temp;
title 'youth skill composite';
class mtfa;
var m_yskill;
run;

/*Youth skill - licenselevel*/
proc anova data=temp;
title 'social skill composite';
class licenselevel;
model m_socskill=licenselevel;
means licenselevel;
run;
proc anova data=temp;
title 'program understanding composite';
class licenselevel;
model m_progskill=licenselevel;
means licenselevel;
run;

proc anova data=temp;
title 'youth skill composite';
class licenselevel;
model m_yskill=licenselevel;
means licenselevel;
run;

/*Staff skill*/
proc anova data=temp;
title 'staff 1 behavior composite';
class mtfa;
model m_behav_s1=mtfa;
means mtfa;
run;

proc anova data=temp;
title 'staff 1 teach composite';
class mtfa;
model m_teach_s1=mtfa;
means mtfa;
run;

proc anova data=temp;
title 'staff 1 skill composite';
class mtfa;
model m_skill_s1=mtfa;
means mtfa;
run;
/*Staff skill - pairwise comparison*/
proc ttest data=temp;
title 'staff 1 behavior composite';
class mtfa;
var m_behav_s1;
run;

proc ttest data=temp;
title 'staff 1 teach composite';
class mtfa;
var m_teach_s1;
run;

proc ttest data=temp;
title 'staff 1 skill composite';
class mtfa;
var m_skill_s1;
run;

/*Staff skills - licenselevel*/
proc anova data=temp;
title 'staff 1 behavior composite';
class licenselevel;
model m_behav_s1=licenselevel;
means licenselevel;
run;

proc anova data=temp;
title 'staff 1 teach composite';
class licenselevel;
model m_teach_s1=licenselevel;
means licenselevel;
run;

proc anova data=temp;
title 'staff 1 skill composite';
class licenselevel;
model m_skill_s1=licenselevel;
means licenselevel;
run;

/*Structure and system*/
proc anova data=temp;
title 'system decision making composite';
class mtfa;
model m_sysdec=mtfa;
means mtfa;
run;

proc anova data=temp;
title 'peer leadership';
class mtfa;
model mho_s3b1=mtfa;
means mtfa;
run;

proc anova data=temp;
title 'system motivation composite';
class mtfa;
model m_sysmov=mtfa;
means mtfa;
run;

proc anova data=temp;
title 'structure and system composite';
class mtfa;
model m_sys=mtfa;
means mtfa;
run;

/*Structure and system - pairwise comparison*/
proc ttest data=temp;
title 'system decision making composite';
class mtfa;
var m_sysdec;
run;

proc ttest data=temp;
title 'peer leadership';
class mtfa;
var mho_s3b1;
run;

proc ttest data=temp;
title 'system motivation composite';
class mtfa;
var m_sysmov;
run;

proc ttest data=temp;
title 'structure and system composite';
class mtfa;
var m_sys;
run;

/*Structure and system - licenselevel*/
proc anova data=temp;
title 'system decision making composite';
class licenselevel;
model m_sysdec=licenselevel;
means licenselevel;
run;

proc anova data=temp;
title 'peer leadership';
class licenselevel;
model mho_s3b1=licenselevel;
means licenselevel;
run;

proc anova data=temp;
title 'system motivation composite';
class licenselevel;
model m_sysmov=licenselevel;
means licenselevel;
run;

proc anova data=temp;
title 'structure and system composite';
class licenselevel;
model m_sys=licenselevel;
means licenselevel;
run;

/*Home characteristics*/
proc anova data=temp;
title 'home atmosphere composite';
class mtfa;
model m_ho_atmo=mtfa;
means mtfa;
run;

proc anova data=temp;
title 'home environment composite';
class mtfa;
model m_ho_envi=mtfa;
means mtfa;
run;

proc anova data=temp;
title 'home safety composite';
class mtfa;
model m_ho_safe=mtfa;
means mtfa;
run;

proc anova data=temp;
title 'home characteristics composite';
class mtfa;
model m_ho=mtfa;
means mtfa;
run;

/*Home characteristics - pairwise comparison*/
proc ttest data=temp;
title 'home atmosphere composite';
class mtfa;
var m_ho_atmo;
run;

proc ttest data=temp;
title 'home environment composite';
class mtfa;
var m_ho_envi;
run;

proc ttest data=temp;
title 'home safety composite';
class mtfa;
var m_ho_safe;
run;

proc ttest data=temp;
title 'home characteristics composite';
class mtfa;
var m_ho;
run;


/*Home characteristics - licenselevel*/
proc anova data=temp;
title 'home atmosphere composite';
class licenselevel;
model m_ho_atmo=licenselevel;
means licenselevel;
run;

proc anova data=temp;
title 'home environment composite';
class licenselevel;
model m_ho_envi=licenselevel;
means licenselevel;
run;

proc anova data=temp;
title 'home safety composite';
class licenselevel;
model m_ho_safe=licenselevel;
means licenselevel;
run;

proc anova data=temp;
title 'home characteristics composite';
class licenselevel;
model m_ho=licenselevel;
means licenselevel;
run;

/*Combine fully accredited with partially accredited*/

/*Youth skill*/
proc ttest data=temp;
title 'social skill by combined tfa';
class tfa1;
var m_socskill;
run;
proc ttest data=temp;
title 'program understanding by combined tfa';
class tfa1;
var m_progskill;
run;
proc ttest data=temp;
title 'youth skill by combined tfa';
class tfa1;
var m_yskill;
run;

/*Staff skill*/

proc ttest data=temp;
title 'staff 1 behavior composite';
class tfa1;
var m_behav_s1;
run;
proc ttest data=temp;
title 'staff 1 teach composite';
class tfa1;
var m_teach_s1;
run;
proc ttest data=temp;
title 'staff 1 skill composite';
class tfa1;
var m_skill_s1;
run;

/*Structure and system*/
proc ttest data=temp;
title 'system decision making composite';
class tfa1;
var m_sysdec;
run;
proc ttest data=temp;
title 'peer leadership';
class tfa1;
var mho_s3b1;
run;
proc ttest data=temp;
title 'system motivation composite';
class tfa1;
var m_sysmov;
run;
proc ttest data=temp;
title 'structure and system composite';
class tfa1;
var m_sys;
run;

/*Home characteristics*/
proc ttest data=temp;
title 'home atmosphere composite';
class tfa1;
var m_ho_atmo;
run;
proc ttest data=temp;
title 'home environment composite';
class tfa1;
var m_ho_envi;
run;
proc ttest data=temp;
title 'home safety composite';
class tfa1;
var m_ho_safe;
run;
proc ttest data=temp;
title 'home characteristic composite';
class tfa1;
var m_ho;
run;

proc means data=temp;
var m_ho_safe safety;
run;
proc means data=temp;
var mho_s4c1-mho_s4c5;
run;


/* kess is coding starting here - code teaching family and license level */
proc print data=des.tracker;
run;

data des.meanrating;
set des.meanrating;
if homeid=19 then licenselevel=3;
if homeid=20 then licenselevel=3;
if homeid=21 then licenselevel=3;
if homeid=22 then licenselevel=3;
if homeid=73 then licenselevel=3;
if homeid=52 then licenselevel=3;
if homeid=45 then licenselevel=3;
if homeid=46 then licenselevel=1;
if homeid=47 then licenselevel=3;
if homeid=48 then licenselevel=2;
if homeid=49 then licenselevel=2;
if homeid=32 then licenselevel=2;
if homeid=64 then licenselevel=1;
if homeid=65 then licenselevel=1;
if homeid=66 then licenselevel=1;
if homeid=67 then licenselevel=1;
if homeid=68 then licenselevel=1;
if homeid=94 then licenselevel=1;
if homeid=33 then licenselevel=2;
if homeid=34 then licenselevel=3;
if homeid=35 then licenselevel=3;
if homeid=50 then licenselevel=2;
if homeid=51 then licenselevel=2;
if homeid=58 then licenselevel=3;
if homeid=59 then licenselevel=3;
if homeid=60 then licenselevel=3;
if homeid=61 then licenselevel=3;
if homeid=74 then licenselevel=3;
if homeid=75 then licenselevel=3;
if homeid=24 then licenselevel=3;
if homeid=25 then licenselevel=3;
if homeid=26 then licenselevel=3;
if homeid=27 then licenselevel=3;
if homeid=53 then licenselevel=1;
if homeid=54 then licenselevel=1;
if homeid=55 then licenselevel=1;
if homeid=56 then licenselevel=1;
if homeid=62 then licenselevel=1;
if homeid=63 then licenselevel=2;
if homeid=69 then licenselevel=2;
if homeid=70 then licenselevel=2;
if homeid=71 then licenselevel=2;
if homeid=72 then licenselevel=2;
if homeid=84 then licenselevel=1;
if homeid=85 then licenselevel=1;
if homeid=86 then licenselevel=1;
if homeid=88 then licenselevel=1;
if homeid=89 then licenselevel=1;
if homeid=90 then licenselevel=1;

if licenselevel=. then do;
   if homeid=70 then licenselevel=2;
   if homeid=50 then licenselevel=2;   
   if homeid=75 then licenselevel=3;
   if homeid=88 then licenselevel=1;
   if homeid=24 then licenselevel=3;
   if homeid=68 then licenselevel=1;   
   if homeid=85 then licenselevel=1;
   if homeid=93 then licenselevel=1;
   if homeid=69 then licenselevel=2;
   if homeid=85 then licenselevel=1;
   if homeid=94 then licenselevel=1;
end;
run;

data temp;
set des.meanrating;
run;
/* teaching family code goes as such
2=official teaching family sponsored site
1=wannabee teaching family/ teaching family affiliate
0=not teaching family */

***fix missing on license levels****;

libname abcd 'D:\Academics\Group homes\Data';


data ratetemp;
set des.meanrating;
m_socskill=mean(mho_s1a1, mho_s1a2, mho_s1a3);
m_progskill=mean(mho_s1b1, mho_s1b2, mho_s1b3);
m_behav_s1=mean(mho_s2a1_s1, mho_s2a2_s1, mho_s2a3_s1, mho_s2a4_s1);
m_teach_s1=mean(mho_s2b1_s1, mho_s2b2_s1, mho_s2b3_s1);
m_sysdec=mean(mho_s3a1, mho_s3a2, mho_s3a3);
m_sysmov=mean(mho_s3c1, mho_s3c2, mho_s3c3, mho_s3c4, mho_s3c5);
m_ho_atmo=mean(mho_s4a1, mho_s4a2, mho_s4a3, mho_s4a4, mho_s4a5, mho_s4a6);
m_ho_envi=mean(mho_s4b1, mho_s4b2);
m_ho_safe=mean(mho_s4c1, mho_s4c2, mho_s4c3, mho_s4c4, mho_s4c5);
run;

data ratetemp;
set ratetemp;
m_yskill=mean(mho_s1a1, mho_s1a2, mho_s1a3, mho_s1b1, mho_s1b2, mho_s1b3);
m_skill_s1=mean(mho_s2a1_s1, mho_s2a2_s1, mho_s2a3_s1, mho_s2a4_s1, mho_s2b1_s1, mho_s2b2_s1, mho_s2b3_s1);
m_sys=mean(mho_s3a1, mho_s3a2, mho_s3a3, mho_s3b1, mho_s3c1, mho_s3c2, mho_s3c3, mho_s3c4, mho_s3c5);
m_ho=mean(mho_s4a1, mho_s4a2, mho_s4a3, mho_s4a4, mho_s4a5, mho_s4a6, mho_s4b1, mho_s4b2, mho_s4c1, mho_s4c2, mho_s4c3, mho_s4c4, mho_s4c5);
run;

data hotemp;
set des.meanrating;
run;

proc contents data=ratetemp;
run;

proc freq data=hotemp;
table mtfa;
run;

data hotemp;
set hotemp;
rename mtfa=TFA;
run;


/*Estimate intraclass correlation coefficients*/



/*Count the data points for youths*/

data sdqtemp;
set des.sdqwide;
n = N(isics_sdqemotion_1, isics_sdqemotion_2, isics_sdqemotion_3, isics_sdqemotion_4, isics_sdqemotion_5, isics_sdqemotion_6, isics_sdqemotion_7, isics_sdqemotion_8);
proc print data=sdqtemp;
run;
proc freq data=sdqtemp;
table n;
run;

data sdqtemp;
set sdqtemp;
n = N(isics_sdqconduct_1, isics_sdqconduct_2, isics_sdqconduct_3, isics_sdqconduct_4, isics_sdqconduct_5, isics_sdqconduct_6, isics_sdqconduct_7, isics_sdqconduct_8);
proc freq data=temp;
table n;
run;

data sdqtemp;
set sdqtemp;
n = N(isics_sdqhyper_1, isics_sdqhyper_2, isics_sdqhyper_3, isics_sdqhyper_4, isics_sdqhyper_5, isics_sdqhyper_6, isics_sdqhyper_7, isics_sdqhyper_8);
proc freq data=temp;
table n;
run;

data sdqtemp;
set sdqtemp;
n = N(isics_sdqpeer_1, isics_sdqpeer_2, isics_sdqpeer_3, isics_sdqpeer_4, isics_sdqpeer_5, isics_sdqpeer_6, isics_sdqpeer_7, isics_sdqpeer_8);
proc freq data=temp;
table n;
run;

data sdqtemp;
set sdqtemp;
n = N(isics_sdqprosoc_1, isics_sdqprosoc_2, isics_sdqprosoc_3, isics_sdqprosoc_4, isics_sdqprosoc_5, isics_sdqprosoc_6, isics_sdqprosoc_7, isics_sdqprosoc_8);
proc freq data=temp;
table n;
run;

data sdqtemp;
set sdqtemp;
n = N(isics_sdqebdtot_1, isics_sdqebdtot_2, isics_sdqebdtot_3, isics_sdqebdtot_4, isics_sdqebdtot_5, isics_sdqebdtot_6, isics_sdqebdtot_7, isics_sdqebdtot_8);
proc freq data=sdqtemp;
table n;
run;


/*Calculate the difference between last data collection and baseline*/

data sdqtemp;
	set sdqtemp;

	array emotion{8} isics_sdqemotion_1 - isics_sdqemotion_8;   
	do i  = 2 to 8;   /* ignore date 1 and process the rest of the dates */
	if emotion{i} ne . then emotion_diff = emotion{i} - isics_sdqemotion_1;  
	end;

	array conduct{8} isics_sdqconduct_1 - isics_sdqconduct_8;   
	do i  = 2 to 8;   
	if conduct{i} ne . then conduct_diff = conduct{i} - isics_sdqconduct_1;  
	end;

	array hyper{8} isics_sdqhyper_1 - isics_sdqhyper_8;   
	do i  = 2 to 8;   
	if hyper{i} ne . then hyper_diff = hyper{i} - isics_sdqhyper_1;  
	end;

	array peer{8} isics_sdqpeer_1 - isics_sdqpeer_8;   
	do i  = 2 to 8;   
	if peer{i} ne . then peer_diff = peer{i} - isics_sdqpeer_1;  
	end;

	array prosoc{8} isics_sdqprosoc_1 - isics_sdqprosoc_8;
	do i  = 2 to 8;   
	if prosoc{i} ne . then prosoc_diff = prosoc{i} - isics_sdqprosoc_1;  
	end;

	array ebdtot{8} isics_sdqebdtot_1 - isics_sdqebdtot_8;
	do i  = 2 to 8;
	if ebdtot{i} ne . then ebdtot_diff = ebdtot{i} - isics_sdqebdtot_1;  
	end;
run;

proc means data=sdqtemp;
var emotion_diff conduct_diff hyper_diff peer_diff prosoc_diff ebdtot_diff;
run;

proc freq data=temp;
table emotion_diff conduct_diff hyper_diff peer_diff prosoc_diff ebdtot_diff;
run;

proc sort data=sdqtemp;
by n;
run;

/*Estimates on new wide data set*/

/*Create new variables*/

data ghtemp;
set des.ghwide;
n_tot = N(isics_sdqebdtot_1, isics_sdqebdtot_2, isics_sdqebdtot_3, isics_sdqebdtot_4, isics_sdqebdtot_5, isics_sdqebdtot_6, isics_sdqebdtot_7);
run;

proc freq data=ghtemp;
table n_tot;
run;

data ghtemp;
set ghtemp;
array sdqebdtot{7} isics_sdqebdtot_1 - isics_sdqebdtot_7;   
	do i  = 2 to 7;   
	if sdqebdtot{i} ne . then diff_last_1 = sdqebdtot{i} - isics_sdqebdtot_1; /*differences b/w last in-home and first in-home sdq*/  
	end;

	do i = 1 to 7;
	if sdqebdtot{i} ne . then diff_last_pre = sdqebdtot{i} - pag_sdqebdtot_1; /*differences b/w last in-home and pre-admission*/
	end;

	do i=1 to 7;
	if sdqebdtot{i} ne . then last_sdqebdtot = sdqebdtot{i}; /*last in-home sdq*/
	end;
run;

data ghtemp;
set ghtemp;
diff_pre_1=isics_sdqebdtot_1 - pag_sdqebdtot_1; /*differences b/w first in-home and pre-admission*/
run;

/*Drop background kids*/
data ghtemp;
set ghtemp;
if pag_sdqebdtot_1 ne .;
run; 

proc means data=ghtemp;
var last_sdqebdtot pag_sdqebdtot_1 diff_last_1 diff_last_pre diff_pre_1;
run; 

proc freq data=ghtemp;
table isics_sdqebdtot_1;
run;

proc sort data=ghtemp;
by kidid;
run;

data tfatemp;
set des.tracker;
keep kidid tfa;
run;

proc sort data=tfatemp;
by kidid;
run;

data ghtemp1;
merge ghtemp (in=fromghx) tfatemp (in=fromtfax);
by kidid;
fromgh=fromghx;
fromtfa=fromtfax;
run;

proc freq data=ghtemp1;
table tfa;
run;

data ghtemp1;
set ghtemp1;
if fromgh=1;
run;



proc anova data=ghtemp1;
title 'difference between last and first in-home SDQ by TF model';
class tfa;
model diff_last_1=tfa;
means tfa;
run;

proc anova data=ghtemp1;
title 'difference between last and first in-home SDQ by TF model';
class tfa;
model diff_last_pre=tfa;
means tfa;
run;

proc anova data=ghtemp1;
title 'difference between last and first in-home SDQ by TF model';
class tfa;
model diff_pre_1=tfa;
means tfa;
run;

/*Compare TF and non-TF models*/
data ghtemp1;
set ghtemp1;
if tfa = 1 or tfa = 2 then tfa1 = 1;
if tfa=3 then tfa1 = 2;
run;

proc ttest data=ghtemp1;
title 'last first TF non-TF';
class tfa1;
var diff_last_1;
run;

proc ttest data=ghtemp1;
title 'last pre TF non-TF';
class tfa1;
var diff_last_pre;
run;

proc ttest data=ghtemp1;
title 'first pre TF non-TF';
class tfa1;
var diff_pre_1;
run;


/*Compare fully and partially TF model*/

data ghtemp1;
set temp1;
tfa_2 = tfa;
run;

data ghtemp1;
set temp1;
if tfa_2 = 3 then tfa_2 = .;
run;


proc ttest data=ghtemp1;
title 'last first full partial';
class tfa_2;
var diff_last_1;
run;

proc ttest data=ghtemp1;
title 'last pre full partial';
class tfa_2;
var diff_last_pre;
run;

proc ttest data=ghtemp1;
title 'first pre full partial';
class tfa_2;
var diff_pre_1;
run;


/*Association between TF model and license level*/
proc freq data=ghtemp1;
tables tfa*licenselevel/ chisq;
run;


/*Create time measure*/

data sdqtemp;
set sdqtemp;
array tpaglast{8} isics_dateinterview_1 - isics_dateinterview_8;   
	do i  = 1 to 8;   
	if tpaglast{i} ne . then t_last_pag = tpaglast{i} - pag_dateinterview_1; /*differences b/w last in-home and PAG time*/  
	end;
	do i = 2 to 8;
	if tpaglast{i} ne . then t_last_1st = tpaglast{i} - isics_dateinterview_1; /*differences b/w last in-home and first in-home time*/
	end;
run;

proc sort data=sdqtemp;
by kidid;
run;

/*Print data with specific value range*/
proc print data=sdqtemp (where=(t_last_pag<0));
var t_last_pag;
run;

proc freq data=sdqtemp (where=(t_last_pag<0));
table t_last_pag / missprint missing;
run;

proc print data=sdqtemp (where=(t_last_1st<0));
var t_last_1st;
run;
proc freq data=sdqtemp (where=(t_last_1st<0));
table t_last_1st / missprint;
run;

data sdqtemp;
set sdqtemp;
if pag_dateinterview_1 =. then delete;
run;

/*Not necessary*/
data sdqtemp;
set sdqtemp;
if t_last_pag < 0 then t_last_pag = t_last_pag*(-1);
run; /**/


data sdqtemp;
set sdqtemp;
tlastpag = t_last_pag/30;
tlast1st = t_last_1st/30;
run;

proc means data=sdqtemp;
var tlastpag tlast1st;
run;

proc freq data=sdqtemp;
table tlast1st;
run;

data sdqtemp;
set sdqtemp;
keep kidid pag_dateinterview_1 isics_dateinterview_1 tlastpag tlast1st;
run;

proc sort data=sdqtemp;
by kidid;
run;
proc sort data=ghtemp1;
by kidid;
run;

data ghwide1;
merge ghtemp1 (in=fromghx) sdqtemp (in=fromsdqx);
by kidid;
fromgh=fromghx;
fromsdq=fromsdqx;
run;

data ghwide1;
set ghwide1;
if fromgh=1;
run;

/*Relationship b/w change of in-home sdq and duration*/
proc corr data=ghwide1;
var tlast1st diff_last_1;
run;

proc gplot data=ghwide1;
plot diff_last_1*tlast1st;
run;

proc reg data=ghwide1;
model diff_last_1 = tlast1st;
run;

/*Adding the observational data*/

proc print data=des.ghwide1;
var tfa;
run;

proc print data=des.ho_meanrating;
var mtfa;
run;

data des.ho_meanrating;
set des.ho_meanrating;
rename mtfa=tfa;
run;

data ho_meanrating;
set des.ho_meanrating;
run;

proc sort data=ghwide1;
by homeid;
run;
proc sort data=ho_meanrating;
by homeid;
run;

data model;
merge ghwide1 ho_meanrating;
by homeid;
run;

proc print data=model;
var homeid m_yskill m_skill_s1 m_sys m_ho;
run;

/*Relationship b/w change of in-home sdq and observational data*/;
data model;
set des.model;
run;

proc means data=model;
var tlastpag tlast1st;
run;

proc univariate data=model;
var diff_last_1;
histogram;
run;

proc corr data=model;
var diff_last_1 m_ho;
run;

proc gplot data=ghwide1;
plot diff_last_1*tlast1st;
run;

proc reg data=model;
model diff_last_1 = m_yskill;
run;

proc reg data=model;
model diff_last_1 = m_skill_s1;
run;

proc reg data=model;
model diff_last_1 = m_sys;
run;

proc reg data=model;
model diff_last_1 = m_ho;
run;

proc reg data=model;
model diff_last_1 = tfa1 m_yskill m_skill_s1 m_sys m_ho;
run;


data model;
set model;
if tfa = 1 or tfa = 2 then tfa1=1;
if tfa = 3 then tfa1=2;
run;

data model;
set model;
if tfa1=1 then tfa2=1;
if tfa1=2 then tfa2=0;
run;

data model;
set model;
if tfa1=2 then tfa3=1;
if tfa1=1 then tfa3=0;
run;


proc freq data=model;
table tfa1;
run;

proc means data=model;
var last_sdqebdtot;
run;

proc reg data=model;
model last_sdqebdtot = tfa2 pag_sdqebdtot_1;
run;

proc reg data=model;
model last_sdqebdtot = tfa1 pag_sdqebdtot_1;
run;

proc reg data=model;
model last_sdqebdtot = pag_sdqebdtot_1 m_yskill m_skill_s1 m_sys m_ho;
run;

proc reg data=model;
model last_sdqebdtot = tfa1 pag_sdqebdtot_1 m_yskill m_skill_s1 m_sys m_ho;
run;

proc reg data=model;
model diff_last_pre = tlastpag tfa1 m_yskill m_skill_s1 m_sys m_ho;
run;


data ghwtemp;
set des.ghwide;
if agencyid=3 or agencyid=5 or agencyid=15 then TFA=1;
else if agencyid=2 or agencyid=29 or agencyid=30 or agencyid=31 then TFA=2;
else TFA=3;
run;

data ghwtemp;
set ghwtemp;
if tfa = 1 then tfatn=1;
if tfa = 2 then tfatn=1;
if tfa = 3 then tfatn=2;  /*teaching vs. non-teaching*/
run;

proc anova data=ghwtemp;
class licenselevel;
model pag_sdqebdtot_1=licenselevel;
means licenselevel;
run;

data ghwtemp;
set ghwtemp;
array sdqebdtot{7} isics_sdqebdtot_1 - isics_sdqebdtot_7;   
	do i=1 to 7;
	if sdqebdtot{i} ne . then last_sdqebdtot = sdqebdtot{i}; /*last in-home sdq*/
	end;
run;
proc anova data=ghwtemp (where=(pag_sdqebdtot_1 ne .));
class licenselevel;
model last_sdqebdtot=licenselevel;
means licenselevel;
run;
proc anova data=ghwtemp (where=(pag_sdqebdtot_1 ne .));
class licenselevel;
model isics_sdqebdtot_1=licenselevel;
means licenselevel;
run;

proc ttest data=ghwtemp (where=(pag_sdqebdtot_1 ne .));
class tfatn;
var isics_sdqebdtot_1;
run;

data ghwtemp;
set ghwtemp;
int1 =  licenselevel*tfatn;
run;


proc reg data=ghwtemp (where=(pag_sdqebdtot_1 ne .));
model last_sdqebdtot = tfatn licenselevel int1;
run;



libname model 'D:\Academics\Group homes\Data check';

data temp;
set model.model;
run;

data temp;
set temp;
if tfa = 1 or tfa = 2 then tfatn=1;
if tfa = 3 then tfatn=0;
run;
proc freq data=temp;
table tfatn*licenselevel/chisq;
run;
data temp;
set temp;
int1 =  licenselevel*tfatn;
run;

proc reg data=temp;
model last_sdqebdtot = pag_sdqebdtot_1 licenselevel; 
run;

proc reg data=temp;
model last_sdqebdtot = licenselevel pag_sdqebdtot_1 m_socskill m_progskill m_behav_s1 m_teach_s1 m_sysdec m_sysmov m_ho_atmo m_ho_envi m_ho_safe;
run;

proc print data=temp;
run;

proc reg data=temp;
model last_sdqebdtot = licenselevel pag_sdqebdtot_1 m_yskill m_skill_s1 m_sys m_ho; 
run;

proc reg data=temp;
model last_sdqebdtot = licenselevel pag_sdqebdtot_1 tfatn m_yskill m_skill_s1 m_sys m_ho; 
run;

proc reg data=temp;
model last_sdqebdtot = licenselevel pag_sdqebdtot_1 tfatn m_yskill m_skill_s1 m_sys m_ho;
run;

proc freq data=temp;
table tfatn*licenselevel/chisq;
run;


data mergetemp;
set model.merge;
run;

data mergetemp;
set mergetemp;
if race=5 then racegp=1;
if race ne 5 and race ne . then racegp=0;
run;

data mergetemp;
set mergetemp;
if tfa=1 or tfa=2 then tfm=1;
if tfa=3 then tfm=0;
run;

proc freq data=mergetemp;
table tfm;
run;

proc ttest data=mergetemp (where=(pag_sdqebdtot_1 ne .));
class tfm;
var age;
run;

data sdqtemp;
set model.sdqwide;
run;

proc means data=sdqtemp (where=(pag_sdqebdtot_1 ne .));
var pag_sdqebdtot_1;
run;

data ghtemp;
set model.ghwide;
run;
proc means data=ghtemp (where=(pag_sdqebdtot_1 ne .));
var pag_sdqebdtot_1;
run;

proc sort data=sdqtemp;
by kidid;
run;
proc sort data=ghtemp;
by kidid;
run;

data sdqmerge;
merge ghtemp (in=fromghx) sdqtemp (in=fromsdqx);
by kidid;
fromgh=fromghx;
fromsdq=fromsdqx;
run;

data sdqmerge;
set sdqmerge;
if pag_sdqebdtot_1 ne .;
run;

proc print data=sdqmerge (where=(fromgh=0 and fromsdq=1));
var kidid fromgh fromsdq;
run;


data sdqwide;
set model.sdqwide;
run;
data ghwide;
set model.ghwide;
run;

proc means data=sdqwide (where=(pag_sdqebdtot_1 ne .));
var pag_sdqebdtot_1;
run;

proc means data=ghwide (where=(pag_sdqebdtot_1 ne .));
var pag_sdqebdtot_1;
run;

/*March 31*/

data sdq;
set model.sdqwide;
run;

proc contents data=sdq;
run;

data sdq;
set sdq;
array sdqebdtot{8} isics_sdqebdtot_1 - isics_sdqebdtot_8;   
	do i=1 to 8;
	if sdqebdtot{i} ne . then last_sdqebdtot = sdqebdtot{i}; /*last in-home sdq*/
	end;
run;

data sdq;
set sdq;
keep kidid pag_sdqebdtot_1 isics_sdqebdtot_1 last_sdqebdtot;
run;

data tracker;
set model.tracker;
run;

proc contents data=tracker;
run;

data tracker;
set tracker;
age = (ikint1-date_of_birth)/365.25;
run;

data tracker;
set tracker;
keep kidid homeid gender race age tfa licenselevel;
run;

/*Create mean values for home observation - DONE*/

data ho;
set ho;
socskill=mean(mho_s1a1, mho_s1a2, mho_s1a3);
progskill=mean(mho_s1b1, mho_s1b2, mho_s1b3);
behav_s1=mean(mho_s2a1_s1, mho_s2a2_s1, mho_s2a3_s1, mho_s2a4_s1);
teach_s1=mean(mho_s2b1_s1, mho_s2b2_s1, mho_s2b3_s1);
sysdec=mean(mho_s3a1, mho_s3a2, mho_s3a3);
sysmov=mean(mho_s3c1, mho_s3c2, mho_s3c3, mho_s3c4, mho_s3c5);
ho_atmo=mean(mho_s4a1, mho_s4a2, mho_s4a3, mho_s4a4, mho_s4a5, mho_s4a6);
ho_envi=mean(mho_s4b1, mho_s4b2);
ho_safe=mean(mho_s4c1, mho_s4c2, mho_s4c3, mho_s4c4, mho_s4c5);
run;

data ho;
set ho;
m_yskill=mean(mho_s1a1, mho_s1a2, mho_s1a3, mho_s1b1, mho_s1b2, mho_s1b3);
m_s1skill=mean(mho_s2a1_s1, mho_s2a2_s1, mho_s2a3_s1, mho_s2a4_s1, mho_s2b1_s1, mho_s2b2_s1, mho_s2b3_s1);
m_system=mean(mho_s3a1, mho_s3a2, mho_s3a3, mho_s3b1, mho_s3c1, mho_s3c2, mho_s3c3, mho_s3c4, mho_s3c5);
m_envi=mean(mho_s4a1, mho_s4a2, mho_s4a3, mho_s4a4, mho_s4a5, mho_s4a6, mho_s4b1, mho_s4b2, mho_s4c1, mho_s4c2, mho_s4c3, mho_s4c4, mho_s4c5);
run;

data ho;
set ho;
keep homeid 
socskill mho_s1a1 mho_s1a2 mho_s1a3
progskill mho_s1b1 mho_s1b2 mho_s1b3
behav_s1 mho_s2a1_s1 mho_s2a2_s1 mho_s2a3_s1 mho_s2a4_s1
teach_s1 mho_s2b1_s1 mho_s2b2_s1 mho_s2b3_s1
sysdec mho_s3a1 mho_s3a2 mho_s3a3
sysmov mho_s3c1 mho_s3c2 mho_s3c3 mho_s3c4 mho_s3c5
ho_atmo mho_s4a1 mho_s4a2 mho_s4a3 mho_s4a4 mho_s4a5 mho_s4a6
ho_envi mho_s4b1 mho_s4b2
ho_safe mho_s4c1 mho_s4c2 mho_s4c3 mho_s4c4 mho_s4c5

m_yskill m_s1skill m_system m_envi;
run;

proc sort data=sdq;
by kidid;
run;
proc sort data=tracker;
by kidid;
run;

data model;
merge sdq (in=fromsdqx) tracker (in=fromtrx);
by kidid;
fromsdq=fromsdqx;
fromtracker=fromtrx;
run;

proc print data=model (where=(fromsdq ne fromtracker));
var fromsdq fromtracker;
run;

proc sort data=model;
by homeid;
run;

proc sort data=ho;
by homeid;
run;

data model1;
merge model (in=frommdlx) ho (in=fromhox);
by homeid;
frommodel=frommdlx;
fromho=fromhox;
run;
proc print data=model1 (where=(frommodel ne fromho));
var frommodel fromho;
run;

data model1;
set model1;
if tfa =1 or tfa=2 then tfm=1;
if tfa = 3 then tfm=0;
run;

data model1; 
set model1;
if race=5 then racenew=1;
if race=1 or race=2 or race=3 or race=4 or race=6 or race=7 then racenew=0;
run;

data model;
set model.model;
run;

data model;
set model;
lastpre= pag_sdqebdtot_1 - last_sdqebdtot; /*will do it*/
run;

proc ttest data=model;
var lastpre;
class tfm;
run;

proc reg data=model (where=(pag_sdqebdtot_1 ne .));
model lastpre = tfm;
run;
proc reg data=model (where=(pag_sdqebdtot_1 ne .));
model lastpre = licenselevel;
by tfm;
run;
proc reg data=model (where=(pag_sdqebdtot_1 ne .));
model lastpre = age;
by tfm;
run;
proc reg data=model (where=(pag_sdqebdtot_1 ne .));
model lastpre = race;
by tfm;
run;
proc reg data=model (where=(pag_sdqebdtot_1 ne .));
model lastpre = gender;
by tfm;
run;
proc reg data=model (where=(pag_sdqebdtot_1 ne .));
model lastpre = mho_s1a1;
by tfm;
run;
proc reg data=model (where=(pag_sdqebdtot_1 ne .));
model lastpre = mho_s1a2;
by tfm;
run;
proc reg data=model (where=(pag_sdqebdtot_1 ne .));
model lastpre = mho_s1a3;
by tfm;
run;
proc reg data=model (where=(pag_sdqebdtot_1 ne .));
model lastpre = mho_s1b1;
by tfm;
run;
proc reg data=model (where=(pag_sdqebdtot_1 ne .));
model lastpre = mho_s1b2;
by tfm;
run;
proc reg data=model (where=(pag_sdqebdtot_1 ne .));
model lastpre = mho_s1b3;
by tfm;
run;
proc reg data=model (where=(pag_sdqebdtot_1 ne .));
model lastpre = mho_s2a1_s1;
by tfm;
run;
proc reg data=model (where=(pag_sdqebdtot_1 ne .));
model lastpre = mho_s2a2_s1;
by tfm;
run;
proc reg data=model (where=(pag_sdqebdtot_1 ne .));
model lastpre = mho_s2a3_s1;
by tfm;
run;
proc reg data=model (where=(pag_sdqebdtot_1 ne .));
model lastpre = mho_s2a4_s1;
by tfm;
run;
proc reg data=model (where=(pag_sdqebdtot_1 ne .));
model lastpre = mho_s2b1_s1;
by tfm;
run;
proc reg data=model (where=(pag_sdqebdtot_1 ne .));
model lastpre = mho_s2b2_s1;
by tfm;
run;
proc reg data=model (where=(pag_sdqebdtot_1 ne .));
model lastpre = mho_s2b3_s1;
by tfm;
run;
proc reg data=model (where=(pag_sdqebdtot_1 ne .));
model lastpre = mho_s3a1;
by tfm;
run;
proc reg data=model (where=(pag_sdqebdtot_1 ne .));
model lastpre = mho_s3a2;
by tfm;
run;
proc reg data=model (where=(pag_sdqebdtot_1 ne .));
model lastpre = mho_s3a3;
by tfm;
run;
proc reg data=model (where=(pag_sdqebdtot_1 ne .));
model lastpre = mho_s3c1;
by tfm;
run;
proc reg data=model (where=(pag_sdqebdtot_1 ne .));
model lastpre = mho_s3c2;
by tfm;
run;
proc reg data=model (where=(pag_sdqebdtot_1 ne .));
model lastpre = mho_s3c3;
by tfm;
run;
proc reg data=model (where=(pag_sdqebdtot_1 ne .));
model lastpre = mho_s3c4;
by tfm;
run;
proc reg data=model (where=(pag_sdqebdtot_1 ne .));
model lastpre = mho_s3c5;
by tfm;
run;
proc reg data=model (where=(pag_sdqebdtot_1 ne .));
model lastpre = mho_s4a1;
by tfm;
run;
proc reg data=model (where=(pag_sdqebdtot_1 ne .));
model lastpre = mho_s4a2;
by tfm;
run;
proc reg data=model (where=(pag_sdqebdtot_1 ne .));
model lastpre = mho_s4a3;
by tfm;
run;
proc reg data=model (where=(pag_sdqebdtot_1 ne .));
model lastpre = mho_s4a4;
by tfm;
run;
proc reg data=model (where=(pag_sdqebdtot_1 ne .));
model lastpre = mho_s4a5;
by tfm;
run;
proc reg data=model (where=(pag_sdqebdtot_1 ne .));
model lastpre = mho_s4a6;
by tfm;
run;
proc reg data=model (where=(pag_sdqebdtot_1 ne .));
model lastpre = mho_s4b1;
by tfm;
run;
proc reg data=model (where=(pag_sdqebdtot_1 ne .));
model lastpre = mho_s4b2;
by tfm;
run;
proc reg data=model (where=(pag_sdqebdtot_1 ne .));
model lastpre = mho_s4c1;
by tfm;
run;
proc reg data=model (where=(pag_sdqebdtot_1 ne .));
model lastpre = mho_s4c2;
by tfm;
run;
proc reg data=model (where=(pag_sdqebdtot_1 ne .));
model lastpre = mho_s4c3;
by tfm;
run;
proc reg data=model (where=(pag_sdqebdtot_1 ne .));
model lastpre = mho_s4c4;
by tfm;
run;
proc reg data=model (where=(pag_sdqebdtot_1 ne .));
model lastpre = mho_s4c5;
by tfm;
run;
proc reg data=model (where=(pag_sdqebdtot_1 ne .));
model lastpre = m_yskill;
by tfm;
run;
proc reg data=model (where=(pag_sdqebdtot_1 ne .));
model lastpre = m_s1skill;
by tfm;
run;
proc reg data=model (where=(pag_sdqebdtot_1 ne .));
model lastpre = m_system;
by tfm;
run;
proc reg data=model (where=(pag_sdqebdtot_1 ne .));
model lastpre = m_envi;
by tfm;
run;
proc reg data=model (where=(pag_sdqebdtot_1 ne .));
model lastpre = licenselevel m_yskill m_s1skill m_system m_envi age gender race;
by tfm;
run;



proc REG data=model;
model lastpre = age gender race;
run;

socskill mho_s1a1 mho_s1a2 mho_s1a3
progskill mho_s1b1 mho_s1b2 mho_s1b3
behav_s1 mho_s2a1_s1 mho_s2a2_s1 mho_s2a3_s1 mho_s2a4_s1
teach_s1 mho_s2b1_s1 mho_s2b2_s1 mho_s2b3_s1
sysdec mho_s3a1 mho_s3a2 mho_s3a3
sysmov mho_s3c1 mho_s3c2 mho_s3c3 mho_s3c4 mho_s3c5
ho_atmo mho_s4a1 mho_s4a2 mho_s4a3 mho_s4a4 mho_s4a5 mho_s4a6
ho_envi mho_s4b1 mho_s4b2
ho_safe mho_s4c1 mho_s4c2 mho_s4c3 mho_s4c4 mho_s4c5

m_yskill m_s1skill m_system m_envi;


data model;
set model.model;
run;

data model;
set model;
sdqdich = pag_sdqebdtot_1-last_sdqebdtot;
run;

data model;
set model;
if sdqdich < 0 then sdqdicho = 0;
if sdqdich > 0 then sdqdicho = 1;
run;
data model;
set model;
if sdqdich=. then sdqdicho=.;
run;
proc means data=model;
var sdqdich;
run;
proc freq data=model;
table sdqdicho*tfm / chisq;
run;

data model;
set model;
if tfa = 1 then tfm1=1;
if tfa = 3 then tfm1=0;
run;

proc sort data=model;
by tfm;
run;

proc logistic descending data=model;
model sdqdicho = tfm;
run;

proc logistic descending data=model;
model sdqdicho = licenselevel;
by tfm;
run;
proc logistic descending data=model;
model sdqdicho= age;
by tfm;
run;
proc logistic descending data=model;
model sdqdicho= race;
by tfm;
run;
proc logistic descending data=model;
model sdqdicho= gender;
by tfm;
run;
proc logistic descending data=model;
model sdqdicho= mho_s1a1;
by tfm;
run;
proc logistic descending data=model;
model sdqdicho= mho_s1a2;
by tfm;
run;
proc logistic descending data=model;
model sdqdicho= mho_s1a3;
by tfm;
run;
proc logistic descending data=model;
model sdqdicho= mho_s1b1;
by tfm;
run;
proc logistic descending data=model;
model sdqdicho= mho_s1b2;
by tfm;
run;
proc logistic descending data=model;
model sdqdicho= mho_s1b3;
by tfm;
run;
proc logistic descending data=model;
model sdqdicho= mho_s2a1_s1;
by tfm;
run;
proc logistic descending data=model;
model sdqdicho= mho_s2a2_s1;
by tfm;
run;
proc logistic descending data=model;
model sdqdicho= mho_s2a3_s1;
by tfm;
run;
proc logistic descending data=model;
model sdqdicho= mho_s2a4_s1;
by tfm;
run;
proc logistic descending data=model;
model sdqdicho= mho_s2b1_s1;
by tfm;
run;
proc logistic descending data=model;
model sdqdicho= mho_s2b2_s1;
by tfm;
run;
proc logistic descending data=model;
model sdqdicho= mho_s2b3_s1;
by tfm;
run;
proc logistic descending data=model;
model sdqdicho= mho_s3a1;
by tfm;
run;
proc logistic descending data=model;
model sdqdicho= mho_s3a2;
by tfm;
run;
proc logistic descending data=model;
model sdqdicho= mho_s3a3;
by tfm;
run;
proc logistic descending data=model;
model sdqdicho= mho_s3c1;
by tfm;
run;
proc logistic descending data=model;
model sdqdicho= mho_s3c2;
by tfm;
run;
proc logistic descending data=model;
model sdqdicho= mho_s3c3;
by tfm;
run;
proc logistic descending data=model;
model sdqdicho= mho_s3c4;
by tfm;
run;
proc logistic descending data=model;
model sdqdicho= mho_s3c5;
by tfm;
run;
proc logistic descending data=model;
model sdqdicho= mho_s4a1;
by tfm;
run;
proc logistic descending data=model;
model sdqdicho= mho_s4a2;
by tfm;
run;
proc logistic descending data=model;
model sdqdicho= mho_s4a3;
by tfm;
run;
proc logistic descending data=model;
model sdqdicho= mho_s4a4;
by tfm;
run;
proc logistic descending data=model;
model sdqdicho= mho_s4a5;
by tfm;
run;
proc logistic descending data=model;
model sdqdicho= mho_s4a6;
by tfm;
run;
proc logistic descending data=model;
model sdqdicho= mho_s4b1;
by tfm;
run;
proc logistic descending data=model;
model sdqdicho= mho_s4b2;
by tfm;
run;
proc logistic descending data=model;
model sdqdicho= mho_s4c1;
by tfm;
run;
proc logistic descending data=model;
model sdqdicho= mho_s4c2;
by tfm;
run;
proc logistic descending data=model;
model sdqdicho= mho_s4c3;
by tfm;
run;
proc logistic descending data=model;
model sdqdicho= mho_s4c4;
by tfm;
run;
proc logistic descending data=model;
model sdqdicho= mho_s4c5;
by tfm;
run;

proc logistic descending data=model;
model sdqdicho= m_yskill;
by tfm;
run;
proc logistic descending data=model;
model sdqdicho= m_s1skill;
by tfm;
run;
proc logistic descending data=model;
model sdqdicho= m_system;
by tfm;
run;
proc logistic descending data=model;
model sdqdicho= m_envi;
by tfm;
run;

proc logistic descending data=model;
model sdqdicho = m_yskill m_s1skill m_system m_envi age gender race;
by tfm;
run;

proc freq data=model;
table tfm;
run;
proc sort data=model;
by tfm;
run;

libname model 'D:\Academics\Group homes\Data';
data model;
set model.model;
run;
libname ryan 'D:\Academics\Group homes\Data\Ryan';
data sdqwave;
set ryan.sdqwaves_042512;
run;

proc means data=sdq (where=(pag_sdqebdtot_1 ne .));
var sdqtot_lastgh;
run;
proc freq data=sdq (where=(pag_sdqebdtot_1 ne .));
table tfa2 tfm;
run;
proc ttest data=sdq (where=(pag_sdqebdtot_1 ne .));
var sdqtot_lastgh;
class tfa2;
run;
proc reg data=sdq (where=(pag_sdqebdtot_1 ne .));
model sdqtot_lastgh = tfa2 pag_sdqebdtot_1;
run;
data sdq (where=(pag_sdqebdtot_1 ne .));
set sdq;
if sdqtot_lastgh >= pag_sdqebdtot_1 then sdqimp = 0;
if sdqtot_lastgh < pag_sdqebdtot_1 then sdqimp = 1;
run;
proc freq data=sdq;
table sdqimp;
run;
proc sort data=sdq;
by licenselevel;
run;

proc logistic descending data=sdq;
model sdqimp = tfa2 licenselevel / alpha = 0.1;
run;

proc contents data=ryan.pregh_042512;
run;
proc sort data=sdq;
by tfa2;
run;
proc means data=sdq;
var sdqtot_lastgh pag_sdqebdtot_1;
by tfa2;
run;

data sdq;
set sdq;
diff = pag_sdqebdtot_1 - sdqtot_lastgh;
run;
proc sort data=sdq;
by tfa2;
run;
proc ttest data=sdq;
var diff;
by tfa2;

/*Check for the difference in sample size and examine results using post-discharge outcomes*/
/*Maintain vs. loss of gains*/
/*Pre-admission vs. post-discharge*/
/*Last in-home vs. post-discharge*/

libname check 'D:\Academics\Group homes\Data reserved';

data ghwide;
set check.ghwide012012;
run;
data sdqwide;
set check.sdqwide;
run;

proc freq data=sdq (where=(pag_sdqebdtot_1 ne .));
table tfa2;
run;

data sdq;
set sdq;
array pre{6} pag_sdqemotion_1 pag_sdqconduct_1 pag_sdqhyper_1 pag_sdqpeer_1 pag_sdqprosoc_1 pag_sdqebdtot_1;
	do i  = 1 to 6;   
	if pre{i} = . then check=0;
	if pre{i} ne . then check =1;
end;
run;


/*Difference between samples of sdqwide and Ryan's*/
/*Betwween Ghwide and Sdqwave*/
proc sort data=ghwide;
by kidid;
run;
proc sort data=sdqwave;
by kidid;
run;
data ghwide;
set ghwide;
keep kidid tfa2 pag_sdqebdtot_1;
run;
data sdqwave;
set sdqwave;
keep kidid tfa2 pag_sdqebdtot_1;
run;
data ghwide;
set ghwide;
rename pag_sdqebdtot_1 = pag_gh;
run;
data sdqwave;
set sdqwave;
rename pag_sdqebdtot_1=pag_sdq;
run;
data check1;
merge ghwide (in=fromghx) sdqwave (in=fromsdqx);
by kidid;
fromgh=fromghx;
fromsdq=fromsdqx;
run;
proc freq data=check1;
table fromsdq fromgh;
run;
proc print data=check1 (where=(pag_sdq ne . and fromgh=0));
var kidid pag_sdq;
run;
data retain1;
set check1;
if fromgh=0;
run;
data retain1;
set retain1;
if pag_sdq ne .;
run;

/*Intermediate check*/
proc sort data=retain1;
by kidid;
run;
proc sort data=sdqwide;
by kidid;
run;
data intcheck;
merge retain1 (in=fromrtnx) sdqwide (in=fromwidex);
by kidid;
fromrtn=fromrtnx;
fromwide=fromwidex;
run;
proc freq data=intcheck;
table fromrtn fromwide;
run;
proc print data=intcheck (where=(fromrtn=1));
var pag_sdqebdtot_1 pag_sdq;
run;
data intcheck;
set intcheck;
sdqcheck = pag_sdqebdtot_1 - pag_sdq;
run;
proc freq data=intcheck;
table sdqcheck;
run; 

/*Intermediate check 2*/
proc sort data=sdqwave;
by kidid;
run;
proc sort data=sdqwide;
by kidid;
run;
data intcheck2;
merge sdqwave (in=fromwavex) sdqwide (in=fromwidex);
by kidid;
fromwave=fromwavex;
fromwide=fromwidex;
run;
data intcheck2;
set intcheck2;
if pag_sdq = pag_sdqebdtot_1 then intcheck=0;
if pag_sdq ne pag_sdqebdtot_1 then intcheck=1;
run;
proc freq data = intcheck2;
table intcheck;
run; /*Done - Sdqwave and Sdqwide seem to be the same, whereas something happens with Ghwide that makes its size smaller*/

/*Use Sdqwave file to examine post-discharge outcomes*/
proc freq data=sdqwave;
table subject_type tfa2;
run;
data sdqwave;
set sdqwave;
sdqratio = (sdqtot_lastgh - pag_sdqebdtot_1) / pag_sdqebdtot_1;
run;
proc sort data=sdqwave;
by tfa2;
run;
proc means data=sdqwave;
var sdqratio;
by tfa2;
run;
data sdqwave;
set sdqwave;
sdqdif = sdqtot_lastgh - pag_sdqebdtot_1;
run;
proc means data=sdqwave;
var sdqdif;
by tfa2;
run;
data sdqwave;
set sdqwave;
sdqratio = sdqdif/pag_sdqebdtot_1;
run;
proc ttest data=sdqwave;
var sdqratio;
class tfa2;
run;
proc print data=sdqwave (where=(sdqratio > 0));
var sdqratio;
run;
data sdqwave;
set sdqwave;
sdqproduct = sdqratio * sdqdif;
run;
data sdqwave;
set sdqwave;
if sdqproduct >= 0 then sdqres = 1;
if sdqproduct < 0 then sdqres =0;
run;
proc freq data = sdqwave (where = (pag_sdqebdtot_1 ne .));
table sdqres;
run;
proc means data=sdqwave;
var sdqratio;
by tfa2;
run; /*Interesting result that the pecentage of change in teaching homes is actually adverse, while the contrary is true for non-teaching homes*/

data sdqwave;
set sdqwave;
if pd_sdqebdtot_1 >= pag_sdqebdtot_1 then pddif = 0;
if pd_sdqebdtot_1 < pag_sdqebdtot_1 then pddif = 1;
run;
data sdqwave;
set sdqwave;
pddifcont = pag_sdqebdtot_1- pd_sdqebdtot_1;
run;
proc means data = sdqwave;
var pd_sdqebdtot_1;
run;
proc means data=sdqwave (where = (pag_sdqebdtot_1 ne .));
var pddifcont;
by tfa2;
run;

proc reg data=sdqwave;
model pd_sdqebdtot_1 = pag_sdqebdtot_1 tfa2;
run;
proc logistic descending data=sdqwave;
model pddif = tfa2;
run;
proc freq data=sdqwave (where = (pag_sdqebdtot_1 ne .));
table pddif*tfa2 / chisq;
run;

/*Add on observational measures*/
libname a 'D:\Academics\Group homes\Data';
data homerate;
set a.ho_meanrating;
run;
data tracker;
set a.tracker;
run;
proc contents data=homerate;
run;
proc contents data=tracker;
run;
proc means data=tracker;
var age;
run;
proc freq data=tracker;
table gender race;
run;
proc freq data=tracker;
table racegrp;
run;
data tracker;
set tracker;
if race = 5 then racegrp=1;
if race = 1 or race =2 or race = 3 or race =4 or race = 6 or race = 7 then racegrp=0;
if race = . then racegrp = .;
run;
data tracker;
set tracker;
keep kidid age gender racegrp homeid;
run;
proc sort data=tracker;
by homeid;
run;
proc sort data=homerate;
by homeid;
run;

data merge1;
merge tracker (in=trackx) homerate (in=ratex);
by homeid;
fromtrack=trackx;
fromrate=ratex;
run; /*A few home id are present in tracker file but not in home observation file, and vice versa*/
proc sort data=merge1;
by kidid;
run;
proc sort data=sdqwave;
by kidid;
run;
data merge2;
merge sdqwave (in=sdqx) merge1 (in=obsx);
by kidid;
fromsdq=sdqx;
fromobs=obsx;
run;
proc sort data=merge2;
by homeid;
run;
/* Run Regression*/
libname ryan 'D:\Academics\Group homes\Data\Ryan';
data gh;
set ryan.gh_may8;
run;
proc means data=gh (where=(pag_sdqebdtot_1 ne .));
var pd_sdqebdtot_1;
run; /* Quite many kids with post discharge measures but without pre-admission measures*/
data gh;
set gh;
pdlastcont = sdqtot_lastgh - pd_sdqebdtot_1;
run;
data gh;
set gh;
pdratio = pddifcont/pag_sdqebdtot_1;
run;
data gh;
set gh;
if pd_sdqebdtot_1 >= sdqtot_lastgh then pdlast = 0;
if pd_sdqebdtot_1 < sdqtot_lastgh then pdlast = 1;
run;
data gh;
set gh;
pdcheck=pd_sdqebdtot_1 - pag_sdqebdtot_1;
run;
proc means data=gh;
var pdcheck;
run;
proc reg data=gh;
model pdcheck = tfa2;
run;
/*OLS - post discharge vs. pre-admission*/
proc reg data =gh;
model pd_sdqebdtot_1 = pag_sdqebdtot_1 tfa2;
run;
proc reg data =gh;
model pd_sdqebdtot_1 = pag_sdqebdtot_1 licenselevel;
run;
proc reg data =gh;
model pd_sdqebdtot_1 = pag_sdqebdtot_1 age;
run;
proc reg data =gh;
model pd_sdqebdtot_1 = pag_sdqebdtot_1 gender;
run;
proc reg data =gh;
model pd_sdqebdtot_1 = pag_sdqebdtot_1 racegrp;
run;
proc reg data =gh;
model pd_sdqebdtot_1 = pag_sdqebdtot_1 mho_s1a1;
run;
proc reg data =gh;
model pd_sdqebdtot_1 = pag_sdqebdtot_1 mho_s1a2;
run;
proc reg data =gh;
model pd_sdqebdtot_1 = pag_sdqebdtot_1 mho_s1a3;
run;
proc reg data =gh;
model pd_sdqebdtot_1 = pag_sdqebdtot_1 mho_s1b1;
run;
proc reg data =gh;
model pd_sdqebdtot_1 = pag_sdqebdtot_1 mho_s1b2;
run;
proc reg data =gh;
model pd_sdqebdtot_1 = pag_sdqebdtot_1 mho_s1b3;
run;
proc reg data =gh;
model pd_sdqebdtot_1 = pag_sdqebdtot_1 mho_s2a1_s1;
run;
proc reg data =gh;
model pd_sdqebdtot_1 = pag_sdqebdtot_1 mho_s2a2_s1;
run;
proc reg data =gh;
model pd_sdqebdtot_1 = pag_sdqebdtot_1 mho_s2a3_s1;
run;
proc reg data =gh;
model pd_sdqebdtot_1 = pag_sdqebdtot_1 mho_s2a4_s1;
run;
proc reg data =gh;
model pd_sdqebdtot_1 = pag_sdqebdtot_1 mho_s2b1_s1;
run;
proc reg data =gh;
model pd_sdqebdtot_1 = pag_sdqebdtot_1 mho_s2b2_s1;
run;
proc reg data =gh;
model pd_sdqebdtot_1 = pag_sdqebdtot_1 mho_s2b3_s1;
run;
proc reg data =gh;
model pd_sdqebdtot_1 = pag_sdqebdtot_1 mho_s3a1;
run;
proc reg data =gh;
model pd_sdqebdtot_1 = pag_sdqebdtot_1 mho_s3a2;
run;
proc reg data =gh;
model pd_sdqebdtot_1 = pag_sdqebdtot_1 mho_s3a3;
run;
proc reg data =gh;
model pd_sdqebdtot_1 = pag_sdqebdtot_1 leadership;
run;
proc reg data =gh;
model pd_sdqebdtot_1 = pag_sdqebdtot_1 mho_s3c1;
run;
proc reg data =gh;
model pd_sdqebdtot_1 = pag_sdqebdtot_1 mho_s3c2;
run;
proc reg data =gh;
model pd_sdqebdtot_1 = pag_sdqebdtot_1 mho_s3c3;
run;
proc reg data =gh;
model pd_sdqebdtot_1 = pag_sdqebdtot_1 mho_s3c4;
run;
proc reg data =gh;
model pd_sdqebdtot_1 = pag_sdqebdtot_1 mho_s3c5;
run;
proc reg data =gh;
model pd_sdqebdtot_1 = pag_sdqebdtot_1 mho_s4a1;
run;
proc reg data =gh;
model pd_sdqebdtot_1 = pag_sdqebdtot_1 mho_s4a2;
run;
proc reg data =gh;
model pd_sdqebdtot_1 = pag_sdqebdtot_1 mho_s4a3;
run;
proc reg data =gh;
model pd_sdqebdtot_1 = pag_sdqebdtot_1 mho_s4a4;
run;
proc reg data =gh;
model pd_sdqebdtot_1 = pag_sdqebdtot_1 mho_s4a5;
run;
proc reg data =gh;
model pd_sdqebdtot_1 = pag_sdqebdtot_1 mho_s4a6;
run;
proc reg data =gh;
model pd_sdqebdtot_1 = pag_sdqebdtot_1 mho_s4b1;
run;
proc reg data =gh;
model pd_sdqebdtot_1 = pag_sdqebdtot_1 mho_s4b2;
run;
proc reg data =gh;
model pd_sdqebdtot_1 = pag_sdqebdtot_1 mho_s4c1;
run;
proc reg data =gh;
model pd_sdqebdtot_1 = pag_sdqebdtot_1 mho_s4c2;
run;
proc reg data =gh;
model pd_sdqebdtot_1 = pag_sdqebdtot_1 mho_s4c3;
run;
proc reg data =gh;
model pd_sdqebdtot_1 = pag_sdqebdtot_1 mho_s4c4;
run;
proc reg data =gh;
model pd_sdqebdtot_1 = pag_sdqebdtot_1 mho_s4c5;
run;
proc reg data =gh;
model pd_sdqebdtot_1 = pag_sdqebdtot_1 m_yskill;
run;
proc reg data =gh;
model pd_sdqebdtot_1 = pag_sdqebdtot_1 m_skill_s1;
run;
proc reg data =gh;
model pd_sdqebdtot_1 = pag_sdqebdtot_1 m_sys;
run;
proc reg data =gh;
model pd_sdqebdtot_1 = pag_sdqebdtot_1 m_ho;
run;
proc reg data =gh;
model pd_sdqebdtot_1 = pag_sdqebdtot_1 factor1;
run;
proc reg data =gh;
model pd_sdqebdtot_1 = pag_sdqebdtot_1 tfa2 licenselevel m_ho m_skill_s1 m_yskill m_sys age gender racegrp;
run;
proc reg data =gh;
model pd_sdqebdtot_1 = pag_sdqebdtot_1 tfa2 licenselevel age gender racegrp;
run;
proc reg data =gh;
model pd_sdqebdtot_1 = pag_sdqebdtot_1 tfa2 age gender racegrp;
run;
proc reg data =gh;
model pd_sdqebdtot_1 = pag_sdqebdtot_1 tfa2 licenselevel factor1 age gender racegrp;
run;
proc reg data =gh;
model pd_sdqebdtot_1 = pag_sdqebdtot_1 factor1 age gender racegrp;
by tfa2;
run;

proc corr data=gh;
var m_ho m_skill_s1 m_yskill m_sys;
run;
proc corr data=gh;
var tfa2 licenselevel factor1;
run;
proc sort data=gh;
by licenselevel;
run;
proc sort data=gh;
by tfa2;
run;


/*Estimate factor from other explanatory variables 
proc reg data=gh;
model factor1 = pag_sdqebdtot_1 tfa2 licenselevel age gender racegrp;
run; */


/*Logistic*/

data gh;
set gh;
if pd_sdqebdtot_1 >= pag_sdqebdtot_1 then pddif = 0;
if pd_sdqebdtot_1 < pag_sdqebdtot_1 then pddif = 1;
run;

proc logistic descending data=gh (where = (pag_sdqebdtot_1 ne . and pd_sdqebdtot_1 ne .));
model pddif = tfa2 / alpha=0.1;
run;
proc logistic descending data=gh (where = (pag_sdqebdtot_1 ne . and pd_sdqebdtot_1 ne .));
model pddif = licenselevel / alpha=0.1;
run;
proc logistic descending data=gh (where = (pag_sdqebdtot_1 ne . and pd_sdqebdtot_1 ne .));
model pddif = age / alpha=0.1;
run;
proc logistic descending data=gh (where = (pag_sdqebdtot_1 ne . and pd_sdqebdtot_1 ne .));
model pddif = gender / alpha=0.1;
run;
proc logistic descending data=gh (where = (pag_sdqebdtot_1 ne . and pd_sdqebdtot_1 ne .));
model pddif =  racegrp / alpha=0.1;
run;
proc logistic descending data=gh (where = (pag_sdqebdtot_1 ne . and pd_sdqebdtot_1 ne .));
model pddif = mho_s1a1 / alpha=0.1;
run;
proc logistic descending data=gh (where = (pag_sdqebdtot_1 ne . and pd_sdqebdtot_1 ne .));
model pddif = mho_s1a2 / alpha=0.1;
run;
proc logistic descending data=gh (where = (pag_sdqebdtot_1 ne . and pd_sdqebdtot_1 ne .));
model pddif = mho_s1a3 / alpha=0.1;
run;
proc logistic descending data=gh (where = (pag_sdqebdtot_1 ne . and pd_sdqebdtot_1 ne .));
model pddif = mho_s1b1 / alpha=0.1;
run;
proc logistic descending data=gh (where = (pag_sdqebdtot_1 ne . and pd_sdqebdtot_1 ne .));
model pddif = mho_s1b2 / alpha=0.1;
run;
proc logistic descending data=gh (where = (pag_sdqebdtot_1 ne . and pd_sdqebdtot_1 ne .));
model pddif = mho_s1b3 / alpha=0.1;
run;
proc logistic descending data=gh (where = (pag_sdqebdtot_1 ne . and pd_sdqebdtot_1 ne .));
model pddif = mho_s2a1_s1 / alpha=0.1;
run;
proc logistic descending data=gh (where = (pag_sdqebdtot_1 ne . and pd_sdqebdtot_1 ne .));
model pddif = mho_s2a2_s1  / alpha=0.1;
run;
proc logistic descending data=gh (where = (pag_sdqebdtot_1 ne . and pd_sdqebdtot_1 ne .));
model pddif = mho_s2a3_s1 / alpha=0.1;
run;
proc logistic descending data=gh (where = (pag_sdqebdtot_1 ne . and pd_sdqebdtot_1 ne .));
model pddif = mho_s2a4_s1 / alpha=0.1;
run;
proc logistic descending data=gh (where = (pag_sdqebdtot_1 ne . and pd_sdqebdtot_1 ne .));
model pddif = mho_s2b1_s1 / alpha=0.1;
run;
proc logistic descending data=gh (where = (pag_sdqebdtot_1 ne . and pd_sdqebdtot_1 ne .));
model pddif = mho_s2b2_s1 / alpha=0.1;
run;
proc logistic descending data=gh (where = (pag_sdqebdtot_1 ne . and pd_sdqebdtot_1 ne .));
model pddif = mho_s2b3_s1 / alpha=0.1;
run;
proc logistic descending data=gh (where = (pag_sdqebdtot_1 ne . and pd_sdqebdtot_1 ne .));
model pddif =  mho_s3a1 / alpha=0.1;
run;
proc logistic descending data=gh (where = (pag_sdqebdtot_1 ne . and pd_sdqebdtot_1 ne .));
model pddif = mho_s3a2 / alpha=0.1;
run;
proc logistic descending data=gh (where = (pag_sdqebdtot_1 ne . and pd_sdqebdtot_1 ne .));
model pddif = mho_s3a3 / alpha=0.1;
run;
proc logistic descending data=gh (where = (pag_sdqebdtot_1 ne . and pd_sdqebdtot_1 ne .));
model pddif = leadership / alpha=0.1;
run;
proc logistic descending data=gh (where = (pag_sdqebdtot_1 ne . and pd_sdqebdtot_1 ne .));
model pddif = mho_s3c1 / alpha=0.1;
run;
proc logistic descending data=gh (where = (pag_sdqebdtot_1 ne . and pd_sdqebdtot_1 ne .));
model pddif = mho_s3c2 / alpha=0.1;
run;
proc logistic descending data=gh (where = (pag_sdqebdtot_1 ne . and pd_sdqebdtot_1 ne .));
model pddif = mho_s3c3 / alpha=0.1;
run;
proc logistic descending data=gh (where = (pag_sdqebdtot_1 ne . and pd_sdqebdtot_1 ne .));
model pddif = mho_s3c4 / alpha=0.1;
run;
proc logistic descending data=gh (where = (pag_sdqebdtot_1 ne . and pd_sdqebdtot_1 ne .));
model pddif = mho_s3c5 / alpha=0.1;
run;
proc logistic descending data=gh (where = (pag_sdqebdtot_1 ne . and pd_sdqebdtot_1 ne .));
model pddif = mho_s4a1 / alpha=0.1;
run;
proc logistic descending data=gh (where = (pag_sdqebdtot_1 ne . and pd_sdqebdtot_1 ne .));
model pddif = mho_s4a2 / alpha=0.1;
run;
proc logistic descending data=gh (where = (pag_sdqebdtot_1 ne . and pd_sdqebdtot_1 ne .));
model pddif = mho_s4a3 / alpha=0.1;
run;
proc logistic descending data=gh (where = (pag_sdqebdtot_1 ne . and pd_sdqebdtot_1 ne .));
model pddif = mho_s4a4 / alpha=0.1;
run;
proc logistic descending data=gh (where = (pag_sdqebdtot_1 ne . and pd_sdqebdtot_1 ne .));
model pddif = mho_s4a5 / alpha=0.1;
run;
proc logistic descending data=gh (where = (pag_sdqebdtot_1 ne . and pd_sdqebdtot_1 ne .));
model pddif = mho_s4a6 / alpha=0.1;
run;
proc logistic descending data=gh (where = (pag_sdqebdtot_1 ne . and pd_sdqebdtot_1 ne .));
model pddif = mho_s4b1 / alpha=0.1;
run;
proc logistic descending data=gh (where = (pag_sdqebdtot_1 ne . and pd_sdqebdtot_1 ne .));
model pddif = mho_s4b2 / alpha=0.1;
run;
proc logistic descending data=gh (where = (pag_sdqebdtot_1 ne . and pd_sdqebdtot_1 ne .));
model pddif = mho_s4c1 / alpha=0.1;
run;
proc logistic descending data=gh (where = (pag_sdqebdtot_1 ne . and pd_sdqebdtot_1 ne .));
model pddif = mho_s4c2 / alpha=0.1;
run;
proc logistic descending data=gh (where = (pag_sdqebdtot_1 ne . and pd_sdqebdtot_1 ne .));
model pddif = mho_s4c3 / alpha=0.1;
run;
proc logistic descending data=gh (where = (pag_sdqebdtot_1 ne . and pd_sdqebdtot_1 ne .));
model pddif = mho_s4c4 / alpha=0.1;
run;
proc logistic descending data=gh (where = (pag_sdqebdtot_1 ne . and pd_sdqebdtot_1 ne .));
model pddif = mho_s4c5 / alpha=0.1;
run;
proc logistic descending data=gh (where = (pag_sdqebdtot_1 ne . and pd_sdqebdtot_1 ne .));
model pddif = m_yskill / alpha=0.1;
run;
proc logistic descending data=gh (where = (pag_sdqebdtot_1 ne . and pd_sdqebdtot_1 ne .));
model pddif = m_skill_s1 / alpha=0.1;
run;
proc logistic descending data=gh (where = (pag_sdqebdtot_1 ne . and pd_sdqebdtot_1 ne .));
model pddif = m_sys / alpha=0.1;
run;
proc logistic descending data=gh (where = (pag_sdqebdtot_1 ne . and pd_sdqebdtot_1 ne .));
model pddif = m_ho / alpha=0.1;
run;
proc logistic descending data=gh (where = (pag_sdqebdtot_1 ne . and pd_sdqebdtot_1 ne .));
model pddif = tfa2 licenselevel m_ho m_skill_s1 m_yskill m_sys age gender racegrp / alpha=0.1;
run;

/*OLS - Post discharge vs. last in-home*/

proc reg data =gh (where=(pag_sdqebdtot_1 ne .));
model pd_sdqebdtot_1 = sdqtot_lastgh tfa2;
run;
proc reg data =gh (where=(pag_sdqebdtot_1 ne .));
model pd_sdqebdtot_1 = sdqtot_lastgh licenselevel;
run;
proc reg data =gh (where=(pag_sdqebdtot_1 ne .));
model pd_sdqebdtot_1 = sdqtot_lastgh age;
run;
proc reg data =gh (where=(pag_sdqebdtot_1 ne .));
model pd_sdqebdtot_1 = sdqtot_lastgh gender;
run;
proc reg data =gh (where=(pag_sdqebdtot_1 ne .));
model pd_sdqebdtot_1 = sdqtot_lastgh racegrp;
run;
proc reg data =gh (where=(pag_sdqebdtot_1 ne .));
model pd_sdqebdtot_1 = sdqtot_lastgh mho_s1a1;
run;
proc reg data =gh (where=(pag_sdqebdtot_1 ne .));
model pd_sdqebdtot_1 = sdqtot_lastgh mho_s1a2;
run;
proc reg data =gh (where=(pag_sdqebdtot_1 ne .));
model pd_sdqebdtot_1 = sdqtot_lastgh mho_s1a3;
run;
proc reg data =gh (where=(pag_sdqebdtot_1 ne .));
model pd_sdqebdtot_1 = sdqtot_lastgh mho_s1b1;
run;
proc reg data =gh (where=(pag_sdqebdtot_1 ne .));
model pd_sdqebdtot_1 = sdqtot_lastgh mho_s1b2;
run;
proc reg data =gh (where=(pag_sdqebdtot_1 ne .));
model pd_sdqebdtot_1 = sdqtot_lastgh mho_s1b3;
run;
proc reg data =gh (where=(pag_sdqebdtot_1 ne .));
model pd_sdqebdtot_1 = sdqtot_lastgh mho_s2a1_s1;
run;
proc reg data =gh (where=(pag_sdqebdtot_1 ne .));
model pd_sdqebdtot_1 = sdqtot_lastgh mho_s2a2_s1;
run;
proc reg data =gh (where=(pag_sdqebdtot_1 ne .));
model pd_sdqebdtot_1 = sdqtot_lastgh mho_s2a3_s1;
run;
proc reg data =gh (where=(pag_sdqebdtot_1 ne .));
model pd_sdqebdtot_1 = sdqtot_lastgh mho_s2a4_s1;
run;
proc reg data =gh (where=(pag_sdqebdtot_1 ne .));
model pd_sdqebdtot_1 = sdqtot_lastgh mho_s2b1_s1;
run;
proc reg data =gh (where=(pag_sdqebdtot_1 ne .));
model pd_sdqebdtot_1 = sdqtot_lastgh mho_s2b2_s1;
run;
proc reg data =gh (where=(pag_sdqebdtot_1 ne .));
model pd_sdqebdtot_1 = sdqtot_lastgh mho_s2b3_s1;
run;
proc reg data =gh (where=(pag_sdqebdtot_1 ne .));
model pd_sdqebdtot_1 = sdqtot_lastgh mho_s3a1;
run;
proc reg data =gh (where=(pag_sdqebdtot_1 ne .));
model pd_sdqebdtot_1 = sdqtot_lastgh mho_s3a2;
run;
proc reg data =gh (where=(pag_sdqebdtot_1 ne .));
model pd_sdqebdtot_1 = sdqtot_lastgh mho_s3a3;
run;
proc reg data =gh (where=(pag_sdqebdtot_1 ne .));
model pd_sdqebdtot_1 = sdqtot_lastgh leadership;
run;
proc reg data =gh (where=(pag_sdqebdtot_1 ne .));
model pd_sdqebdtot_1 = sdqtot_lastgh mho_s3c1;
run;
proc reg data =gh (where=(pag_sdqebdtot_1 ne .));
model pd_sdqebdtot_1 = sdqtot_lastgh mho_s3c2;
run;
proc reg data =gh (where=(pag_sdqebdtot_1 ne .));
model pd_sdqebdtot_1 = sdqtot_lastgh mho_s3c3;
run;
proc reg data =gh (where=(pag_sdqebdtot_1 ne .));
model pd_sdqebdtot_1 = sdqtot_lastgh mho_s3c4;
run;
proc reg data =gh (where=(pag_sdqebdtot_1 ne .));
model pd_sdqebdtot_1 = sdqtot_lastgh mho_s3c5;
run;
proc reg data =gh (where=(pag_sdqebdtot_1 ne .));
model pd_sdqebdtot_1 = sdqtot_lastgh mho_s4a1;
run;
proc reg data =gh (where=(pag_sdqebdtot_1 ne .));
model pd_sdqebdtot_1 = sdqtot_lastgh mho_s4a2;
run;
proc reg data =gh (where=(pag_sdqebdtot_1 ne .));
model pd_sdqebdtot_1 = sdqtot_lastgh mho_s4a3;
run;
proc reg data =gh (where=(pag_sdqebdtot_1 ne .));
model pd_sdqebdtot_1 = sdqtot_lastgh mho_s4a4;
run;
proc reg data =gh (where=(pag_sdqebdtot_1 ne .));
model pd_sdqebdtot_1 = sdqtot_lastgh mho_s4a5;
run;
proc reg data =gh (where=(pag_sdqebdtot_1 ne .));
model pd_sdqebdtot_1 = sdqtot_lastgh mho_s4a6;
run;
proc reg data =gh (where=(pag_sdqebdtot_1 ne .));
model pd_sdqebdtot_1 = sdqtot_lastgh mho_s4b1;
run;
proc reg data =gh (where=(pag_sdqebdtot_1 ne .));
model pd_sdqebdtot_1 = sdqtot_lastgh mho_s4b2;
run;
proc reg data =gh (where=(pag_sdqebdtot_1 ne .));
model pd_sdqebdtot_1 = sdqtot_lastgh mho_s4c1;
run;
proc reg data =gh (where=(pag_sdqebdtot_1 ne .));
model pd_sdqebdtot_1 = sdqtot_lastgh mho_s4c2;
run;
proc reg data =gh (where=(pag_sdqebdtot_1 ne .));
model pd_sdqebdtot_1 = sdqtot_lastgh mho_s4c3;
run;
proc reg data =gh (where=(pag_sdqebdtot_1 ne .));
model pd_sdqebdtot_1 = sdqtot_lastgh mho_s4c4;
run;
proc reg data =gh (where=(pag_sdqebdtot_1 ne .));
model pd_sdqebdtot_1 = sdqtot_lastgh mho_s4c5;
run;
proc reg data =gh (where=(pag_sdqebdtot_1 ne .));
model pd_sdqebdtot_1 = sdqtot_lastgh m_yskill;
run;
proc reg data =gh (where=(pag_sdqebdtot_1 ne .));
model pd_sdqebdtot_1 = sdqtot_lastgh m_skill_s1;
run;
proc reg data =gh (where=(pag_sdqebdtot_1 ne .));
model pd_sdqebdtot_1 = sdqtot_lastgh m_sys;
run;
proc reg data =gh (where=(pag_sdqebdtot_1 ne .));
model pd_sdqebdtot_1 = sdqtot_lastgh m_ho;
run;
proc reg data =gh (where=(pag_sdqebdtot_1 ne .));
model pd_sdqebdtot_1 = sdqtot_lastgh factor1;
run;

proc reg data =gh (where=(pag_sdqebdtot_1 ne .));
model pd_sdqebdtot_1 = sdqtot_lastgh factor1 age gender racegrp;
by tfa2;
run;

proc reg data =gh (where=(pag_sdqebdtot_1 ne .));
model pd_sdqebdtot_1 = sdqtot_lastgh tfa2 age gender racegrp;
run;
proc reg data =gh (where=(pag_sdqebdtot_1 ne .));
model pd_sdqebdtot_1 = sdqtot_lastgh tfa2 licenselevel age gender racegrp;
run;
proc reg data =gh (where=(pag_sdqebdtot_1 ne .));
model pd_sdqebdtot_1 = sdqtot_lastgh tfa2 licenselevel factor1 age gender racegrp;
run;

/*Logistic - Post discharge vs. last in-home*/
proc logistic descending data=gh (where = (pag_sdqebdtot_1 ne . and pd_sdqebdtot_1 ne . and sdqtot_lastgh ne .));
model pddif = tfa2 / alpha=0.1;
run;
proc logistic descending data=gh (where = (pag_sdqebdtot_1 ne . and pd_sdqebdtot_1 ne . and sdqtot_lastgh ne .));
model pddif = licenselevel / alpha=0.1;
run;
proc logistic descending data=gh (where = (pag_sdqebdtot_1 ne . and pd_sdqebdtot_1 ne . and sdqtot_lastgh ne .));
model pddif = age / alpha=0.1;
run;
proc logistic descending data=gh (where = (pag_sdqebdtot_1 ne . and pd_sdqebdtot_1 ne . and sdqtot_lastgh ne .));
model pddif = gender / alpha=0.1;
run;
proc logistic descending data=gh (where = (pag_sdqebdtot_1 ne . and pd_sdqebdtot_1 ne . and sdqtot_lastgh ne .));
model pddif =  racegrp / alpha=0.1;
run;
proc logistic descending data=gh (where = (pag_sdqebdtot_1 ne . and pd_sdqebdtot_1 ne . and sdqtot_lastgh ne .));
model pddif = mho_s1a1 / alpha=0.1;
run;
proc logistic descending data=gh (where = (pag_sdqebdtot_1 ne . and pd_sdqebdtot_1 ne . and sdqtot_lastgh ne .));
model pddif = mho_s1a2 / alpha=0.1;
run;
proc logistic descending data=gh (where = (pag_sdqebdtot_1 ne . and pd_sdqebdtot_1 ne . and sdqtot_lastgh ne .));
model pddif = mho_s1a3 / alpha=0.1;
run;
proc logistic descending data=gh (where = (pag_sdqebdtot_1 ne . and pd_sdqebdtot_1 ne . and sdqtot_lastgh ne .));
model pddif = mho_s1b1 / alpha=0.1;
run;
proc logistic descending data=gh (where = (pag_sdqebdtot_1 ne . and pd_sdqebdtot_1 ne . and sdqtot_lastgh ne .));
model pddif = mho_s1b2 / alpha=0.1;
run;
proc logistic descending data=gh (where = (pag_sdqebdtot_1 ne . and pd_sdqebdtot_1 ne . and sdqtot_lastgh ne .));
model pddif = mho_s1b3 / alpha=0.1;
run;
proc logistic descending data=gh (where = (pag_sdqebdtot_1 ne . and pd_sdqebdtot_1 ne . and sdqtot_lastgh ne .));
model pddif = mho_s2a1_s1 / alpha=0.1;
run;
proc logistic descending data=gh (where = (pag_sdqebdtot_1 ne . and pd_sdqebdtot_1 ne . and sdqtot_lastgh ne .));
model pddif = mho_s2a2_s1  / alpha=0.1;
run;
proc logistic descending data=gh (where = (pag_sdqebdtot_1 ne . and pd_sdqebdtot_1 ne . and sdqtot_lastgh ne .));
model pddif = mho_s2a3_s1 / alpha=0.1;
run;
proc logistic descending data=gh (where = (pag_sdqebdtot_1 ne . and pd_sdqebdtot_1 ne . and sdqtot_lastgh ne .));
model pddif = mho_s2a4_s1 / alpha=0.1;
run;
proc logistic descending data=gh (where = (pag_sdqebdtot_1 ne . and pd_sdqebdtot_1 ne . and sdqtot_lastgh ne .));
model pddif = mho_s2b1_s1 / alpha=0.1;
run;
proc logistic descending data=gh (where = (pag_sdqebdtot_1 ne . and pd_sdqebdtot_1 ne . and sdqtot_lastgh ne .));
model pddif = mho_s2b2_s1 / alpha=0.1;
run;
proc logistic descending data=gh (where = (pag_sdqebdtot_1 ne . and pd_sdqebdtot_1 ne . and sdqtot_lastgh ne .));
model pddif = mho_s2b3_s1 / alpha=0.1;
run;
proc logistic descending data=gh (where = (pag_sdqebdtot_1 ne . and pd_sdqebdtot_1 ne . and sdqtot_lastgh ne .));
model pddif =  mho_s3a1 / alpha=0.1;
run;
proc logistic descending data=gh (where = (pag_sdqebdtot_1 ne . and pd_sdqebdtot_1 ne . and sdqtot_lastgh ne .));
model pddif = mho_s3a2 / alpha=0.1;
run;
proc logistic descending data=gh (where = (pag_sdqebdtot_1 ne . and pd_sdqebdtot_1 ne . and sdqtot_lastgh ne .));
model pddif = mho_s3a3 / alpha=0.1;
run;
proc logistic descending data=gh (where = (pag_sdqebdtot_1 ne . and pd_sdqebdtot_1 ne . and sdqtot_lastgh ne .));
model pddif = mho_s3c1 / alpha=0.1;
run;
proc logistic descending data=gh (where = (pag_sdqebdtot_1 ne . and pd_sdqebdtot_1 ne . and sdqtot_lastgh ne .));
model pddif = mho_s3c2 / alpha=0.1;
run;
proc logistic descending data=gh (where = (pag_sdqebdtot_1 ne . and pd_sdqebdtot_1 ne . and sdqtot_lastgh ne .));
model pddif = mho_s3c3 / alpha=0.1;
run;
proc logistic descending data=gh (where = (pag_sdqebdtot_1 ne . and pd_sdqebdtot_1 ne . and sdqtot_lastgh ne .));
model pddif = mho_s3c4 / alpha=0.1;
run;
proc logistic descending data=gh (where = (pag_sdqebdtot_1 ne . and pd_sdqebdtot_1 ne . and sdqtot_lastgh ne .));
model pddif = mho_s3c5 / alpha=0.1;
run;
proc logistic descending data=gh (where = (pag_sdqebdtot_1 ne . and pd_sdqebdtot_1 ne . and sdqtot_lastgh ne .));
model pddif = mho_s4a1 / alpha=0.1;
run;
proc logistic descending data=gh (where = (pag_sdqebdtot_1 ne . and pd_sdqebdtot_1 ne . and sdqtot_lastgh ne .));
model pddif = mho_s4a2 / alpha=0.1;
run;
proc logistic descending data=gh (where = (pag_sdqebdtot_1 ne . and pd_sdqebdtot_1 ne . and sdqtot_lastgh ne .));
model pddif = mho_s4a3 / alpha=0.1;
run;
proc logistic descending data=gh (where = (pag_sdqebdtot_1 ne . and pd_sdqebdtot_1 ne . and sdqtot_lastgh ne .));
model pddif = mho_s4a4 / alpha=0.1;
run;
proc logistic descending data=gh (where = (pag_sdqebdtot_1 ne . and pd_sdqebdtot_1 ne . and sdqtot_lastgh ne .));
model pddif = mho_s4a5 / alpha=0.1;
run;
proc logistic descending data=gh (where = (pag_sdqebdtot_1 ne . and pd_sdqebdtot_1 ne . and sdqtot_lastgh ne .));
model pddif = mho_s4a6 / alpha=0.1;
run;
proc logistic descending data=gh (where = (pag_sdqebdtot_1 ne . and pd_sdqebdtot_1 ne . and sdqtot_lastgh ne .));
model pddif = mho_s4b1 / alpha=0.1;
run;
proc logistic descending data=gh (where = (pag_sdqebdtot_1 ne . and pd_sdqebdtot_1 ne . and sdqtot_lastgh ne .));
model pddif = mho_s4b2 / alpha=0.1;
run;
proc logistic descending data=gh (where = (pag_sdqebdtot_1 ne . and pd_sdqebdtot_1 ne . and sdqtot_lastgh ne .));
model pddif = mho_s4c1 / alpha=0.1;
run;
proc logistic descending data=gh (where = (pag_sdqebdtot_1 ne . and pd_sdqebdtot_1 ne . and sdqtot_lastgh ne .));
model pddif = mho_s4c2 / alpha=0.1;
run;
proc logistic descending data=gh (where = (pag_sdqebdtot_1 ne . and pd_sdqebdtot_1 ne . and sdqtot_lastgh ne .));
model pddif = mho_s4c3 / alpha=0.1;
run;
proc logistic descending data=gh (where = (pag_sdqebdtot_1 ne . and pd_sdqebdtot_1 ne . and sdqtot_lastgh ne .));
model pddif = mho_s4c4 / alpha=0.1;
run;
proc logistic descending data=gh (where = (pag_sdqebdtot_1 ne . and pd_sdqebdtot_1 ne . and sdqtot_lastgh ne .));
model pddif = mho_s4c5 / alpha=0.1;
run;
proc logistic descending data=gh (where = (pag_sdqebdtot_1 ne . and pd_sdqebdtot_1 ne . and sdqtot_lastgh ne .));
model pddif = m_yskill / alpha=0.1;
run;
proc logistic descending data=gh (where = (pag_sdqebdtot_1 ne . and pd_sdqebdtot_1 ne . and sdqtot_lastgh ne .));
model pddif = m_skill_s1 / alpha=0.1;
run;
proc logistic descending data=gh (where = (pag_sdqebdtot_1 ne . and pd_sdqebdtot_1 ne . and sdqtot_lastgh ne .));
model pddif = m_sys / alpha=0.1;
run;
proc logistic descending data=gh (where = (pag_sdqebdtot_1 ne . and pd_sdqebdtot_1 ne . and sdqtot_lastgh ne .));
model pddif = m_ho / alpha=0.1;
run;
proc logistic descending data=gh (where = (pag_sdqebdtot_1 ne . and pd_sdqebdtot_1 ne . and sdqtot_lastgh ne .));
model pddif = tfa2 licenselevel m_ho m_skill_s1 m_yskill m_sys age gender racegrp / alpha=0.1;
run;

/*Using difference variable*/
/*Post discharge vs. pre-admission*/
data gh;
set gh;
pdpre = pag_sdqebdtot_1 - pd_sdqebdtot_1;
run;

proc reg data =gh;
model pdpre = tfa2;
run;
proc reg data =gh;
model pdpre = licenselevel;
run;
proc reg data =gh;
model pdpre = age;
run;
proc reg data =gh;
model pdpre = gender;
run;
proc reg data =gh;
model pdpre = racegrp;
run;
proc reg data =gh;
model pdpre = mho_s1a1;
run;
proc reg data =gh;
model pdpre = mho_s1a2;
run;
proc reg data =gh;
model pdpre = mho_s1a3;
run;
proc reg data =gh;
model pdpre = mho_s1b1;
run;
proc reg data =gh;
model pdpre = mho_s1b2;
run;
proc reg data =gh;
model pdpre = mho_s1b3;
run;
proc reg data =gh;
model pdpre = mho_s2a1_s1;
run;
proc reg data =gh;
model pdpre = mho_s2a2_s1;
run;
proc reg data =gh;
model pdpre = mho_s2a3_s1;
run;
proc reg data =gh;
model pdpre = mho_s2a4_s1;
run;
proc reg data =gh;
model pdpre = mho_s2b1_s1;
run;
proc reg data =gh;
model pdpre = mho_s2b2_s1;
run;
proc reg data =gh;
model pdpre = mho_s2b3_s1;
run;
proc reg data =gh;
model pdpre = mho_s3a1;
run;
proc reg data =gh;
model pdpre = mho_s3a2;
run;
proc reg data =gh;
model pdpre = mho_s3a3;
run;
proc reg data =gh;
model pdpre = leadership;
run;
proc reg data =gh;
model pdpre = mho_s3c1;
run;
proc reg data =gh;
model pdpre = mho_s3c2;
run;
proc reg data =gh;
model pdpre = mho_s3c3;
run;
proc reg data =gh;
model pdpre = mho_s3c4;
run;
proc reg data =gh;
model pdpre = mho_s3c5;
run;
proc reg data =gh;
model pdpre = mho_s4a1;
run;
proc reg data =gh;
model pdpre = mho_s4a2;
run;
proc reg data =gh;
model pdpre = mho_s4a3;
run;
proc reg data =gh;
model pdpre = mho_s4a4;
run;
proc reg data =gh;
model pdpre = mho_s4a5;
run;
proc reg data =gh;
model pdpre = mho_s4a6;
run;
proc reg data =gh;
model pdpre = mho_s4b1;
run;
proc reg data =gh;
model pdpre = mho_s4b2;
run;
proc reg data =gh;
model pdpre = mho_s4c1;
run;
proc reg data =gh;
model pdpre = mho_s4c2;
run;
proc reg data =gh;
model pdpre = mho_s4c3;
run;
proc reg data =gh;
model pdpre = mho_s4c4;
run;
proc reg data =gh;
model pdpre = mho_s4c5;
run;
proc reg data =gh;
model pdpre = m_yskill;
run;
proc reg data =gh;
model pdpre = m_skill_s1;
run;
proc reg data =gh;
model pdpre = m_sys;
run;
proc reg data =gh;
model pdpre = m_ho;
run;
proc reg data =gh;
model pdpre = tfa2 licenselevel m_yskill m_skill_s1 m_sys m_ho age gender racegrp;
run;

/*Post discharge vs. last in-home*/
data gh;
set gh;
pdlast = sdqtot_lastgh - pd_sdqebdtot_1;
run;

proc reg data =gh (where=(pag_sdqebdtot_1 ne .));
model pdlast = tfa2;
run;
proc reg data =gh (where=(pag_sdqebdtot_1 ne .));
model pdlast = licenselevel;
run;
proc reg data =gh (where=(pag_sdqebdtot_1 ne .));
model pdlast = age;
run;
proc reg data =gh (where=(pag_sdqebdtot_1 ne .));
model pdlast = gender;
run;
proc reg data =gh (where=(pag_sdqebdtot_1 ne .));
model pdlast = racegrp;
run;
proc reg data =gh (where=(pag_sdqebdtot_1 ne .));
model pdlast = mho_s1a1;
run;
proc reg data =gh (where=(pag_sdqebdtot_1 ne .));
model pdlast = mho_s1a2;
run;
proc reg data =gh (where=(pag_sdqebdtot_1 ne .));
model pdlast = mho_s1a3;
run;
proc reg data =gh (where=(pag_sdqebdtot_1 ne .));
model pdlast = mho_s1b1;
run;
proc reg data =gh (where=(pag_sdqebdtot_1 ne .));
model pdlast = mho_s1b2;
run;
proc reg data =gh (where=(pag_sdqebdtot_1 ne .));
model pdlast = mho_s1b3;
run;
proc reg data =gh (where=(pag_sdqebdtot_1 ne .));
model pdlast = mho_s2a1_s1;
run;
proc reg data =gh (where=(pag_sdqebdtot_1 ne .));
model pdlast = mho_s2a2_s1;
run;
proc reg data =gh (where=(pag_sdqebdtot_1 ne .));
model pdlast = mho_s2a3_s1;
run;
proc reg data =gh (where=(pag_sdqebdtot_1 ne .));
model pdlast = mho_s2a4_s1;
run;
proc reg data =gh (where=(pag_sdqebdtot_1 ne .));
model pdlast = mho_s2b1_s1;
run;
proc reg data =gh (where=(pag_sdqebdtot_1 ne .));
model pdlast = mho_s2b2_s1;
run;
proc reg data =gh (where=(pag_sdqebdtot_1 ne .));
model pdlast = mho_s2b3_s1;
run;
proc reg data =gh (where=(pag_sdqebdtot_1 ne .));
model pdlast = mho_s3a1;
run;
proc reg data =gh (where=(pag_sdqebdtot_1 ne .));
model pdlast = mho_s3a2;
run;
proc reg data =gh (where=(pag_sdqebdtot_1 ne .));
model pdlast = mho_s3a3;
run;
proc reg data =gh (where=(pag_sdqebdtot_1 ne .));
model pdlast = leadership;
run;
proc reg data =gh (where=(pag_sdqebdtot_1 ne .));
model pdlast = mho_s3c1;
run;
proc reg data =gh (where=(pag_sdqebdtot_1 ne .));
model pdlast = mho_s3c2;
run;
proc reg data =gh (where=(pag_sdqebdtot_1 ne .));
model pdlast = mho_s3c3;
run;
proc reg data =gh (where=(pag_sdqebdtot_1 ne .));
model pdlast = mho_s3c4;
run;
proc reg data =gh (where=(pag_sdqebdtot_1 ne .));
model pdlast = mho_s3c5;
run;
proc reg data =gh (where=(pag_sdqebdtot_1 ne .));
model pdlast = mho_s4a1;
run;
proc reg data =gh (where=(pag_sdqebdtot_1 ne .));
model pdlast = mho_s4a2;
run;
proc reg data =gh (where=(pag_sdqebdtot_1 ne .));
model pdlast = mho_s4a3;
run;
proc reg data =gh (where=(pag_sdqebdtot_1 ne .));
model pdlast = mho_s4a4;
run;
proc reg data =gh (where=(pag_sdqebdtot_1 ne .));
model pdlast = mho_s4a5;
run;
proc reg data =gh (where=(pag_sdqebdtot_1 ne .));
model pdlast = mho_s4a6;
run;
proc reg data =gh (where=(pag_sdqebdtot_1 ne .));
model pdlast = mho_s4b1;
run;
proc reg data =gh (where=(pag_sdqebdtot_1 ne .));
model pdlast = mho_s4b2;
run;
proc reg data =gh (where=(pag_sdqebdtot_1 ne .));
model pdlast = mho_s4c1;
run;
proc reg data =gh (where=(pag_sdqebdtot_1 ne .));
model pdlast = mho_s4c2;
run;
proc reg data =gh (where=(pag_sdqebdtot_1 ne .));
model pdlast = mho_s4c3;
run;
proc reg data =gh (where=(pag_sdqebdtot_1 ne .));
model pdlast = mho_s4c4;
run;
proc reg data =gh (where=(pag_sdqebdtot_1 ne .));
model pdlast = mho_s4c5;
run;
proc reg data =gh (where=(pag_sdqebdtot_1 ne .));
model pdlast = m_yskill;
run;
proc reg data =gh (where=(pag_sdqebdtot_1 ne .));
model pdlast = m_skill_s1;
run;
proc reg data =gh (where=(pag_sdqebdtot_1 ne .));
model pdlast = m_sys;
run;
proc reg data =gh (where=(pag_sdqebdtot_1 ne .));
model pdlast = m_ho;
run;
proc reg data =gh (where=(pag_sdqebdtot_1 ne .));
model pdlast = factor1;
run;
proc reg data =gh (where=(pag_sdqebdtot_1 ne .));
model pdlast = factor1 age gender racegrp;
by tfa2;
run;


proc sort data=gh;
by tfa2;
run;

/*Factor analysis*/
data gh;
set ryan.gh;
run;

proc factor data=gh METHOD=P PRIORS=SMC ROTATE=PROMAX SCREE CORR RES outstat=factor;
var m_yskill m_skill_s1 m_sys m_ho;
run;

data ghnew;
set ryan.gh_may15;
run;
data ghnew;
set ghnew;
pdlast = sdqtot_lastgh - pd_sdqebdtot_1;
run;
proc reg data =ghnew (where=(pag_sdqebdtot_1 ne .));
model pdlast = tfa2 licenselevel factor1 age gender racegrp;
run;

/*Misc
libname ob 'D:\Academics\Group homes\Data check';
data mean;
set ob.meanrating;
run;
proc contents data=mean;
run;
data mean;
set mean;
keep mho_s3b1 homeid;
run;
data mean;
set mean;
rename mho_s3b1 = Leadership;
run;
data meanrate;
set mean;
run;
proc means data=meanrate;
var leadership;
run;
proc sort data=meanrate;
by homeid;
run;
proc sort data=ghnew;
by homeid;
run;
data gh_may15;
merge meanrate (in=frommeanx) ghnew (in=fromghnewx);
by homeid;
frommean=frommeanx;
fromghnew=fromghnewx;
run;
proc means data=gh_may15;
var leadership;
run;*/

data gh;
set ryan.gh;
run;
libname abcd 'D:\Academics\Group homes\Data\Ryan\Irrelevant';
data abc;
set abcd.ghnew;
run;
proc means data=abc;
var leadership;
run;
libname ryan 'D:\Academics\Group homes\Data\Ryan';
data gh;
set ryan.gh;
run;
proc corr data=gh;
var tfa2 licenselevel factor1;
run;

/*First in-home vs. pre-admission*/
proc reg data =ghmay;
model isics_sdqebdtot_1=pag_sdqebdtot_1 tfa2;
run;
proc reg data =ghmay;
model isics_sdqebdtot_1 = pag_sdqebdtot_1 licenselevel;
run;
proc reg data =ghmay;
model isics_sdqebdtot_1 = pag_sdqebdtot_1 age;
run;
proc reg data =ghmay;
model isics_sdqebdtot_1 = pag_sdqebdtot_1 gender;
run;
proc reg data =ghmay;
model isics_sdqebdtot_1 = pag_sdqebdtot_1 racegrp;
run;
proc reg data =gh;
model isics_sdqebdtot_1= pag_sdqebdtot_1 mho_s1a1;
run;
proc reg data =gh;
model isics_sdqebdtot_1= pag_sdqebdtot_1 mho_s1a2;
run;
proc reg data =gh;
model isics_sdqebdtot_1= pag_sdqebdtot_1 mho_s1a3;
run;
proc reg data =gh;
model isics_sdqebdtot_1= pag_sdqebdtot_1 mho_s1b1;
run;
proc reg data =gh;
model isics_sdqebdtot_1= pag_sdqebdtot_1 mho_s1b2;
run;
proc reg data =gh;
model isics_sdqebdtot_1= pag_sdqebdtot_1 mho_s1b3;
run;
proc reg data =gh;
model isics_sdqebdtot_1= pag_sdqebdtot_1 mho_s2a1_s1;
run;
proc reg data =gh;
model isics_sdqebdtot_1= pag_sdqebdtot_1 mho_s2a2_s1;
run;
proc reg data =gh;
model isics_sdqebdtot_1= pag_sdqebdtot_1 mho_s2a3_s1;
run;
proc reg data =gh;
model isics_sdqebdtot_1= pag_sdqebdtot_1 mho_s2a4_s1;
run;
proc reg data =gh;
model isics_sdqebdtot_1= pag_sdqebdtot_1 mho_s2b1_s1;
run;
proc reg data =gh;
model isics_sdqebdtot_1= pag_sdqebdtot_1 mho_s2b2_s1;
run;
proc reg data =gh;
model isics_sdqebdtot_1= pag_sdqebdtot_1 mho_s2b3_s1;
run;
proc reg data =gh;
model isics_sdqebdtot_1= pag_sdqebdtot_1 mho_s3a1;
run;
proc reg data =gh;
model isics_sdqebdtot_1= pag_sdqebdtot_1 mho_s3a2;
run;
proc reg data =gh;
model isics_sdqebdtot_1= pag_sdqebdtot_1 mho_s3a3;
run;
proc reg data =gh;
model isics_sdqebdtot_1= pag_sdqebdtot_1 leadership;
run;
proc reg data =gh;
model isics_sdqebdtot_1= pag_sdqebdtot_1 mho_s3c1;
run;
proc reg data =gh;
model isics_sdqebdtot_1= pag_sdqebdtot_1 mho_s3c2;
run;
proc reg data =gh;
model isics_sdqebdtot_1= pag_sdqebdtot_1 mho_s3c3;
run;
proc reg data =gh;
model isics_sdqebdtot_1= pag_sdqebdtot_1 mho_s3c4;
run;
proc reg data =gh;
model isics_sdqebdtot_1= pag_sdqebdtot_1 mho_s3c5;
run;
proc reg data =gh;
model isics_sdqebdtot_1= pag_sdqebdtot_1 mho_s4a1;
run;
proc reg data =gh;
model isics_sdqebdtot_1= pag_sdqebdtot_1 mho_s4a2;
run;
proc reg data =gh;
model isics_sdqebdtot_1= pag_sdqebdtot_1 mho_s4a3;
run;
proc reg data =gh;
model isics_sdqebdtot_1= pag_sdqebdtot_1 mho_s4a4;
run;
proc reg data =gh;
model isics_sdqebdtot_1= pag_sdqebdtot_1 mho_s4a5;
run;
proc reg data =gh;
model isics_sdqebdtot_1= pag_sdqebdtot_1 mho_s4a6;
run;
proc reg data =gh;
model isics_sdqebdtot_1= pag_sdqebdtot_1 mho_s4b1;
run;
proc reg data =gh;
model isics_sdqebdtot_1= pag_sdqebdtot_1 mho_s4b2;
run;
proc reg data =gh;
model isics_sdqebdtot_1= pag_sdqebdtot_1 mho_s4c1;
run;
proc reg data =gh;
model isics_sdqebdtot_1= pag_sdqebdtot_1 mho_s4c2;
run;
proc reg data =gh;
model isics_sdqebdtot_1= pag_sdqebdtot_1 mho_s4c3;
run;
proc reg data =gh;
model isics_sdqebdtot_1= pag_sdqebdtot_1 mho_s4c4;
run;
proc reg data =gh;
model isics_sdqebdtot_1= pag_sdqebdtot_1 mho_s4c5;
run;
proc reg data =gh;
model isics_sdqebdtot_1= pag_sdqebdtot_1 m_yskill;
run;
proc reg data =gh;
model isics_sdqebdtot_1= pag_sdqebdtot_1 m_skill_s1;
run;
proc reg data =gh;
model isics_sdqebdtot_1= pag_sdqebdtot_1 m_sys;
run;
proc reg data =gh;
model isics_sdqebdtot_1= pag_sdqebdtot_1 m_ho;
run;
proc reg data =gh;
model isics_sdqebdtot_1= pag_sdqebdtot_1 factor1;
run;
proc reg data =ghmay;
model isics_sdqebdtot_1= pag_sdqebdtot_1 yskill_f;
run;
proc reg data =ghmay;
model isics_sdqebdtot_1= pag_sdqebdtot_1 s1skill_f;
run;
proc reg data =ghmay;
model isics_sdqebdtot_1= pag_sdqebdtot_1 structure_f;
run;
proc reg data =ghmay;
model isics_sdqebdtot_1= pag_sdqebdtot_1 envi_f;
run;
proc reg data =ghmay;
model isics_sdqebdtot_1= pag_sdqebdtot_1 overall_f;
run;


/*OLS - Last in-home vs. pre-admission*/
proc reg data =ghmay;
model sdqtot_lastgh=pag_sdqebdtot_1 tfa2;
run;
proc reg data =ghmay;
model sdqtot_lastgh= pag_sdqebdtot_1 licenselevel;
run;
proc reg data =ghmay;
model sdqtot_lastgh= pag_sdqebdtot_1 age;
run;
proc reg data =ghmay;
model sdqtot_lastgh= pag_sdqebdtot_1 gender;
run;
proc reg data =ghmay;
model sdqtot_lastgh= pag_sdqebdtot_1 racegrp;
run;
proc reg data =gh;
model sdqtot_lastgh= pag_sdqebdtot_1 mho_s1a1;
run;
proc reg data =gh;
model sdqtot_lastgh= pag_sdqebdtot_1 mho_s1a2;
run;
proc reg data =gh;
model sdqtot_lastgh= pag_sdqebdtot_1 mho_s1a3;
run;
proc reg data =gh;
model sdqtot_lastgh= pag_sdqebdtot_1 mho_s1b1;
run;
proc reg data =gh;
model sdqtot_lastgh= pag_sdqebdtot_1 mho_s1b2;
run;
proc reg data =gh;
model sdqtot_lastgh= pag_sdqebdtot_1 mho_s1b3;
run;
proc reg data =gh;
model sdqtot_lastgh= pag_sdqebdtot_1 mho_s2a1_s1;
run;
proc reg data =gh;
model sdqtot_lastgh= pag_sdqebdtot_1 mho_s2a2_s1;
run;
proc reg data =gh;
model sdqtot_lastgh= pag_sdqebdtot_1 mho_s2a3_s1;
run;
proc reg data =gh;
model sdqtot_lastgh= pag_sdqebdtot_1 mho_s2a4_s1;
run;
proc reg data =gh;
model sdqtot_lastgh= pag_sdqebdtot_1 mho_s2b1_s1;
run;
proc reg data =gh;
model sdqtot_lastgh= pag_sdqebdtot_1 mho_s2b2_s1;
run;
proc reg data =gh;
model sdqtot_lastgh= pag_sdqebdtot_1 mho_s2b3_s1;
run;
proc reg data =gh;
model sdqtot_lastgh= pag_sdqebdtot_1 mho_s3a1;
run;
proc reg data =gh;
model sdqtot_lastgh= pag_sdqebdtot_1 mho_s3a2;
run;
proc reg data =gh;
model sdqtot_lastgh= pag_sdqebdtot_1 mho_s3a3;
run;
proc reg data =gh;
model sdqtot_lastgh= pag_sdqebdtot_1 leadership;
run;
proc reg data =gh;
model sdqtot_lastgh= pag_sdqebdtot_1 mho_s3c1;
run;
proc reg data =gh;
model sdqtot_lastgh= pag_sdqebdtot_1 mho_s3c2;
run;
proc reg data =gh;
model sdqtot_lastgh= pag_sdqebdtot_1 mho_s3c3;
run;
proc reg data =gh;
model sdqtot_lastgh= pag_sdqebdtot_1 mho_s3c4;
run;
proc reg data =gh;
model sdqtot_lastgh= pag_sdqebdtot_1 mho_s3c5;
run;
proc reg data =gh;
model sdqtot_lastgh= pag_sdqebdtot_1 mho_s4a1;
run;
proc reg data =gh;
model sdqtot_lastgh= pag_sdqebdtot_1 mho_s4a2;
run;
proc reg data =gh;
model sdqtot_lastgh= pag_sdqebdtot_1 mho_s4a3;
run;
proc reg data =gh;
model sdqtot_lastgh= pag_sdqebdtot_1 mho_s4a4;
run;
proc reg data =gh;
model sdqtot_lastgh= pag_sdqebdtot_1 mho_s4a5;
run;
proc reg data =gh;
model sdqtot_lastgh= pag_sdqebdtot_1 mho_s4a6;
run;
proc reg data =gh;
model sdqtot_lastgh= pag_sdqebdtot_1 mho_s4b1;
run;
proc reg data =gh;
model sdqtot_lastgh= pag_sdqebdtot_1 mho_s4b2;
run;
proc reg data =gh;
model sdqtot_lastgh= pag_sdqebdtot_1 mho_s4c1;
run;
proc reg data =gh;
model sdqtot_lastgh= pag_sdqebdtot_1 mho_s4c2;
run;
proc reg data =gh;
model sdqtot_lastgh= pag_sdqebdtot_1 mho_s4c3;
run;
proc reg data =gh;
model sdqtot_lastgh= pag_sdqebdtot_1 mho_s4c4;
run;
proc reg data =gh;
model sdqtot_lastgh= pag_sdqebdtot_1 mho_s4c5;
run;
proc reg data =gh;
model sdqtot_lastgh= pag_sdqebdtot_1 m_yskill;
run;
proc reg data =gh;
model sdqtot_lastgh= pag_sdqebdtot_1 m_skill_s1;
run;
proc reg data =gh;
model sdqtot_lastgh= pag_sdqebdtot_1 m_sys;
run;
proc reg data =gh;
model sdqtot_lastgh= pag_sdqebdtot_1 m_ho;
run;
proc reg data =gh;
model sdqtot_lastgh= pag_sdqebdtot_1 factor1;
run;

proc reg data =ghmay;
model sdqtot_lastgh= pag_sdqebdtot_1 yskill_f;
run;
proc reg data =ghmay;
model sdqtot_lastgh= pag_sdqebdtot_1 s1skill_f;
run;
proc reg data =ghmay;
model sdqtot_lastgh= pag_sdqebdtot_1 structure_f;
run;
proc reg data =ghmay;
model sdqtot_lastgh= pag_sdqebdtot_1 envi_f;
run;
proc reg data =ghmay;
model sdqtot_lastgh= pag_sdqebdtot_1 overall_f;
run;


/*OLS - Last in-home vs. first in-home*/
proc reg data =ghmay (where=(pag_sdqebdtot_1 ne .));
model sdqtot_lastgh=isics_sdqebdtot_1 tfa2;
run;
proc reg data =ghmay (where=(pag_sdqebdtot_1 ne .));
model sdqtot_lastgh= isics_sdqebdtot_1 licenselevel;
run;
proc reg data =ghmay (where=(pag_sdqebdtot_1 ne .));
model sdqtot_lastgh= isics_sdqebdtot_1 age;
run;
proc reg data =ghmay (where=(pag_sdqebdtot_1 ne .));
model sdqtot_lastgh= isics_sdqebdtot_1 gender;
run;
proc reg data =ghmay (where=(pag_sdqebdtot_1 ne .));
model sdqtot_lastgh= isics_sdqebdtot_1 racegrp;
run;
proc reg data =gh (where=(pag_sdqebdtot_1 ne .));
model sdqtot_lastgh= isics_sdqebdtot_1 mho_s1a1;
run;
proc reg data =gh (where=(pag_sdqebdtot_1 ne .));
model sdqtot_lastgh= isics_sdqebdtot_1 mho_s1a2;
run;
proc reg data =gh (where=(pag_sdqebdtot_1 ne .));
model sdqtot_lastgh= isics_sdqebdtot_1 mho_s1a3;
run;
proc reg data =gh (where=(pag_sdqebdtot_1 ne .));
model sdqtot_lastgh= isics_sdqebdtot_1 mho_s1b1;
run;
proc reg data =gh (where=(pag_sdqebdtot_1 ne .));
model sdqtot_lastgh= isics_sdqebdtot_1 mho_s1b2;
run;
proc reg data =gh (where=(pag_sdqebdtot_1 ne .));
model sdqtot_lastgh= isics_sdqebdtot_1 mho_s1b3;
run;
proc reg data =gh (where=(pag_sdqebdtot_1 ne .));
model sdqtot_lastgh= isics_sdqebdtot_1 mho_s2a1_s1;
run;
proc reg data =gh (where=(pag_sdqebdtot_1 ne .));
model sdqtot_lastgh= isics_sdqebdtot_1 mho_s2a2_s1;
run;
proc reg data =gh (where=(pag_sdqebdtot_1 ne .));
model sdqtot_lastgh= isics_sdqebdtot_1 mho_s2a3_s1;
run;
proc reg data =gh (where=(pag_sdqebdtot_1 ne .));
model sdqtot_lastgh= isics_sdqebdtot_1 mho_s2a4_s1;
run;
proc reg data =gh (where=(pag_sdqebdtot_1 ne .));
model sdqtot_lastgh= isics_sdqebdtot_1 mho_s2b1_s1;
run;
proc reg data =gh (where=(pag_sdqebdtot_1 ne .));
model sdqtot_lastgh= isics_sdqebdtot_1 mho_s2b2_s1;
run;
proc reg data =gh (where=(pag_sdqebdtot_1 ne .));
model sdqtot_lastgh= isics_sdqebdtot_1 mho_s2b3_s1;
run;
proc reg data =gh (where=(pag_sdqebdtot_1 ne .));
model sdqtot_lastgh= isics_sdqebdtot_1 mho_s3a1;
run;
proc reg data =gh (where=(pag_sdqebdtot_1 ne .));
model sdqtot_lastgh= isics_sdqebdtot_1 mho_s3a2;
run;
proc reg data =gh (where=(pag_sdqebdtot_1 ne .));
model sdqtot_lastgh= isics_sdqebdtot_1 mho_s3a3;
run;
proc reg data =gh (where=(pag_sdqebdtot_1 ne .));
model sdqtot_lastgh= isics_sdqebdtot_1 leadership;
run;
proc reg data =gh (where=(pag_sdqebdtot_1 ne .));
model sdqtot_lastgh= isics_sdqebdtot_1 mho_s3c1;
run;
proc reg data =gh (where=(pag_sdqebdtot_1 ne .));
model sdqtot_lastgh= isics_sdqebdtot_1 mho_s3c2;
run;
proc reg data =gh (where=(pag_sdqebdtot_1 ne .));
model sdqtot_lastgh= isics_sdqebdtot_1 mho_s3c3;
run;
proc reg data =gh (where=(pag_sdqebdtot_1 ne .));
model sdqtot_lastgh= isics_sdqebdtot_1 mho_s3c4;
run;
proc reg data =gh (where=(pag_sdqebdtot_1 ne .));
model sdqtot_lastgh= isics_sdqebdtot_1 mho_s3c5;
run;
proc reg data =gh (where=(pag_sdqebdtot_1 ne .));
model sdqtot_lastgh= isics_sdqebdtot_1 mho_s4a1;
run;
proc reg data =gh (where=(pag_sdqebdtot_1 ne .));
model sdqtot_lastgh= isics_sdqebdtot_1 mho_s4a2;
run;
proc reg data =gh (where=(pag_sdqebdtot_1 ne .));
model sdqtot_lastgh= isics_sdqebdtot_1 mho_s4a3;
run;
proc reg data =gh (where=(pag_sdqebdtot_1 ne .));
model sdqtot_lastgh= isics_sdqebdtot_1 mho_s4a4;
run;
proc reg data =gh (where=(pag_sdqebdtot_1 ne .));
model sdqtot_lastgh= isics_sdqebdtot_1 mho_s4a5;
run;
proc reg data =gh (where=(pag_sdqebdtot_1 ne .));
model sdqtot_lastgh= isics_sdqebdtot_1 mho_s4a6;
run;
proc reg data =gh (where=(pag_sdqebdtot_1 ne .));
model sdqtot_lastgh= isics_sdqebdtot_1 mho_s4b1;
run;
proc reg data =gh (where=(pag_sdqebdtot_1 ne .));
model sdqtot_lastgh= isics_sdqebdtot_1 mho_s4b2;
run;
proc reg data =gh (where=(pag_sdqebdtot_1 ne .));
model sdqtot_lastgh= isics_sdqebdtot_1 mho_s4c1;
run;
proc reg data =gh (where=(pag_sdqebdtot_1 ne .));
model sdqtot_lastgh= isics_sdqebdtot_1 mho_s4c2;
run;
proc reg data =gh (where=(pag_sdqebdtot_1 ne .));
model sdqtot_lastgh= isics_sdqebdtot_1 mho_s4c3;
run;
proc reg data =gh (where=(pag_sdqebdtot_1 ne .));
model sdqtot_lastgh= isics_sdqebdtot_1 mho_s4c4;
run;
proc reg data =gh (where=(pag_sdqebdtot_1 ne .));
model sdqtot_lastgh= isics_sdqebdtot_1 mho_s4c5;
run;
proc reg data =gh (where=(pag_sdqebdtot_1 ne .));
model sdqtot_lastgh= isics_sdqebdtot_1 m_yskill;
run;
proc reg data =gh (where=(pag_sdqebdtot_1 ne .));
model sdqtot_lastgh= isics_sdqebdtot_1 m_skill_s1;
run;
proc reg data =gh (where=(pag_sdqebdtot_1 ne .));
model sdqtot_lastgh= isics_sdqebdtot_1 m_sys;
run;
proc reg data =gh (where=(pag_sdqebdtot_1 ne .));
model sdqtot_lastgh= isics_sdqebdtot_1 m_ho;
run;
proc reg data =gh (where=(pag_sdqebdtot_1 ne .));
model sdqtot_lastgh= isics_sdqebdtot_1 factor1;
run;
proc reg data =ghmay (where=(pag_sdqebdtot_1 ne .));
model sdqtot_lastgh= isics_sdqebdtot_1 yskill_f;
run;
proc reg data =ghmay (where=(pag_sdqebdtot_1 ne .));
model sdqtot_lastgh= isics_sdqebdtot_1 s1skill_f;
run;
proc reg data =ghmay (where=(pag_sdqebdtot_1 ne .));
model sdqtot_lastgh= isics_sdqebdtot_1 structure_f;
run;
proc reg data =ghmay (where=(pag_sdqebdtot_1 ne .));
model sdqtot_lastgh= isics_sdqebdtot_1 envi_f;
run;
proc reg data =ghmay (where=(pag_sdqebdtot_1 ne .));
model sdqtot_lastgh= isics_sdqebdtot_1 overall_f;
run;

/*Post discharge vs. pre-admission*/
proc reg data =ghmay;
model pd_sdqebdtot_1=pag_sdqebdtot_1 tfa2;
run;
proc reg data =ghmay;
model pd_sdqebdtot_1 = pag_sdqebdtot_1 licenselevel;
run;
proc reg data =ghmay;
model pd_sdqebdtot_1 = pag_sdqebdtot_1 age;
run;
proc reg data =ghmay;
model pd_sdqebdtot_1 = pag_sdqebdtot_1 gender;
run;
proc reg data =ghmay;
model pd_sdqebdtot_1 = pag_sdqebdtot_1 racegrp;
run;
proc reg data =ghmay;
model pd_sdqebdtot_1= pag_sdqebdtot_1 yskill_f;
run;
proc reg data =ghmay;
model pd_sdqebdtot_1= pag_sdqebdtot_1 s1skill_f;
run;
proc reg data =ghmay;
model pd_sdqebdtot_1= pag_sdqebdtot_1 structure_f;
run;
proc reg data =ghmay;
model pd_sdqebdtot_1= pag_sdqebdtot_1 envi_f;
run;
proc reg data =ghmay;
model pd_sdqebdtot_1= pag_sdqebdtot_1 overall_f;
run;

/*Post discharge vs last in-home*/
proc reg data =ghmay (where=(pag_sdqebdtot_1 ne .));
model pd_sdqebdtot_1=sdqtot_lastgh tfa2;
run;
proc reg data =ghmay (where=(pag_sdqebdtot_1 ne .));
model pd_sdqebdtot_1 =sdqtot_lastgh licenselevel;
run;
proc reg data =ghmay (where=(pag_sdqebdtot_1 ne .));
model pd_sdqebdtot_1 = sdqtot_lastgh age;
run;
proc reg data =ghmay (where=(pag_sdqebdtot_1 ne .));
model pd_sdqebdtot_1 = sdqtot_lastgh gender;
run;
proc reg data =ghmay (where=(pag_sdqebdtot_1 ne .));
model pd_sdqebdtot_1 = sdqtot_lastgh racegrp;
run;
proc reg data =ghmay (where=(pag_sdqebdtot_1 ne .));
model pd_sdqebdtot_1= sdqtot_lastgh yskill_f;
run;
proc reg data =ghmay (where=(pag_sdqebdtot_1 ne .));
model pd_sdqebdtot_1= sdqtot_lastgh s1skill_f;
run;
proc reg data =ghmay (where=(pag_sdqebdtot_1 ne .));
model pd_sdqebdtot_1= sdqtot_lastgh structure_f;
run;
proc reg data =ghmay (where=(pag_sdqebdtot_1 ne .));
model pd_sdqebdtot_1= sdqtot_lastgh envi_f;
run;
proc reg data =ghmay (where=(pag_sdqebdtot_1 ne .));
model pd_sdqebdtot_1= sdqtot_lastgh overall_f;
run;


proc corr data=gh alpha;
var mho_s4a1 mho_s4a2 mho_s4a3 mho_s4a4 mho_s4a5 mho_s4a6
mho_s4b1 mho_s4b2
mho_s4c1 mho_s4c2 mho_s4c3 mho_s4c4 mho_s4c5;
run;
proc sort data=gh; by tfa2; run;
proc means data=gh (where=(pag_sdqebdtot_1 ne .));
var pag_sdqebdtot_1 isics_sdqebdtot_1 sdqtot_lastgh pd_sdqebdtot_1;
by tfa2;
run;

proc sort data=gh;
by tfa2;
run;
proc sort data=gh;
by licenselevel;
run;

proc freq data=gh;
table licenselevel;
by tfa2;
run;

proc ttest data=gh;
var pag_sdqebdtot_1;
class tfa2;
by licenselevel;
run;
proc ttest data=gh (where=(pag_sdqebdtot_1 ne .));
var sdqtot_lastgh;
class tfa2;
by licenselevel;
run;
proc ttest data=gh (where=(pag_sdqebdtot_1 ne .));
var isics_sdqebdtot_1;
class tfa2;
by licenselevel;
run;
proc ttest data=gh (where=(pag_sdqebdtot_1 ne .));
var pd_sdqebdtot_1;
class tfa2;
by licenselevel;
run;
proc means data=gh (where=(pag_sdqebdtot_1 ne .));
var factor1;
class tfa2;
by licenselevel;
run;

proc contents data=gh1;
run;
data gh1;
set abcd.gh1;
run;
data gh22;
set abcd.gh22;
run;

proc factor data=gh METHOD=P mineigen=1 nfactors=1 PRIORS=SMC ROTATE=PROMAX SCREE CORR RES out=ghmay;
var mho_s1a1 mho_s1a3 mho_s1b1 mho_s1b2 mho_s1b3;
run;
data ghmay;
set ghmay;
rename factor1 = yskill_f;
run;
proc factor data=ghmay METHOD=P mineigen=1 nfactors=1 PRIORS=SMC ROTATE=PROMAX SCREE CORR RES out=ghmay;
var mho_s2a1_s1 mho_s2a2_s1 mho_s2a3_s1 mho_s2a4_s1 mho_s2b2_s1 mho_s2b3_s1;
run;
data ghmay;
set ghmay;
rename factor1 = s1skill_f;
run;
proc factor data=ghmay METHOD=P mineigen=1 nfactors=1 PRIORS=SMC ROTATE=PROMAX SCREE CORR RES out=ghmay;
var mho_s3a1 mho_s3a2 mho_s3a3 mho_s3c1 mho_s3c2 mho_s3c3 mho_s3c4 mho_s3c5;
run;
data ghmay;
set ghmay;
rename factor1 = structure_f;
run;
proc factor data=ghmay METHOD=P mineigen=1 nfactors=1 PRIORS=SMC ROTATE=PROMAX SCREE CORR RES out=ghmay;
var mho_s4a1 mho_s4a2 mho_s4a3 mho_s4a4 mho_s4a5 mho_s4a6 mho_s4b1 mho_s4c1 mho_s4c3;
run;
data ghmay;
set ghmay;
rename factor1 = envi_f;
run;
proc factor data=ghmay METHOD=P mineigen=1 nfactors=1 PRIORS=SMC ROTATE=PROMAX SCREE CORR RES out=ghmay;
var yskill_f s1skill_f structure_f envi_f;
run;
data ghmay;
set ghmay;
rename factor1=overall_f;
run;
proc means data=ghmay (where=(pag_sdqebdtot_1 ne .));
var overall_f;
class tfa2;
by licenselevel;
run;
proc corr data=ghmay (where=(pag_sdqebdtot_1 ne .)) alpha;
var yskill_f s1skill_f structure_f envi_f;
run;


data ghmay;
set ryan.ghmay;
run;
proc factor data=ghmay METHOD=P mineigen=1 PRIORS=SMC ROTATE=PROMAX SCREE CORR RES;
var mho_s1a1 mho_s1a3 mho_s1b1 mho_s1b2 mho_s1b3;
run;
proc factor data=ghmay METHOD=P mineigen=1 PRIORS=SMC ROTATE=PROMAX SCREE CORR RES;
var mho_s2a1_s1 mho_s2a2_s1 mho_s2a3_s1 mho_s2a4_s1 mho_s2b2_s1 mho_s2b3_s1;
run;
proc factor data=ghmay METHOD=P mineigen=1 PRIORS=SMC ROTATE=PROMAX SCREE CORR RES;
var mho_s3a1 mho_s3a2 mho_s3a3 leadership mho_s3c1 mho_s3c2 mho_s3c3 mho_s3c4 mho_s3c5;
run;
proc factor data=ghmay METHOD=P mineigen=1 PRIORS=SMC ROTATE=PROMAX SCREE CORR RES;
var mho_s4a1 mho_s4a2 mho_s4a3 mho_s4a4 mho_s4a5 mho_s4a6 mho_s4b1 mho_s4c1 mho_s4c3;
run;
proc factor data=ghmay METHOD=P mineigen=1 PRIORS=SMC ROTATE=PROMAX SCREE CORR RES;
var yskill_f s1skill_f structure_f envi_f;
run;

data sdq;
set ryan.sdqwaves_042512;
run;
data gh;
set ryan.pregh_042512;
run;
proc freq data=sdq (where=(pag_sdqebdtot_1 ne .));
table tfa2;
run;
proc freq data=sdq (where=(pd_sdqebdtot_1 ne .));
table tfa2;
run;
proc freq data=sdq (where=(pag_sdqebdtot_1 ne . and pd_sdqebdtot_1 ne .));
table tfa2;
run;
proc sort data=sdq;
by kidid;
run;
data sdq;
set sdq;
if kidid=353 then delete;
run;
proc sort data=sdq;
by tfa2;
run;
proc means data=sdq;
var pag_sdqebdtot_1;
run;
proc ttest data=sdq;
var pag_sdqebdtot_1;
class tfa2;
run;
proc means data=sdq (where=(pag_sdqebdtot_1 ne .));
var isics_sdqebdtot_1;
run;
proc ttest data=sdq (where=(pag_sdqebdtot_1 ne .));
var isics_sdqebdtot_1;
class tfa2;
run;
proc means data=sdq (where=(pag_sdqebdtot_1 ne .));
var sdqtot_lastgh;
run;
proc ttest data=sdq (where=(pag_sdqebdtot_1 ne .));
var sdqtot_lastgh;
class tfa2;
run;
proc means data=sdq (where=(pag_sdqebdtot_1 ne .));
var pd_sdqebdtot_1;
run;
proc ttest data=sdq (where=(pag_sdqebdtot_1 ne .));
var pd_sdqebdtot_1;
class tfa2;
run;
proc freq data=ghmay (where=(pag_sdqebdtot_1 ne .));
table gender*tfa2 / chisq;
run;
proc freq data=ghmay (where=(pag_sdqebdtot_1 ne .));
table racegrp*tfa2/chisq;
run;

proc means data=ghmay (where=(pag_sdqebdtot_1 ne .));
var age;
run;
proc ttest data=ghmay (where=(pag_sdqebdtot_1 ne .));
var age;
class tfa2;
run;
proc freq data=ghmay (where=(pag_sdqebdtot_1 ne .));
table licenselevel*tfa2/chisq;
run;
proc means data=ghmay (where=(pag_sdqebdtot_1 ne .));;
var yskill_f;
run;
proc ttest data=ghmay (where=(pag_sdqebdtot_1 ne .));
var yskill_f;
class tfa2;
run;
proc means data=ghmay (where=(pag_sdqebdtot_1 ne .));;
var s1skill_f;
run;
proc ttest data=ghmay (where=(pag_sdqebdtot_1 ne .));
var s1skill_f;
class tfa2;
run;
proc means data=ghmay (where=(pag_sdqebdtot_1 ne .));;
var structure_f;
run;
proc ttest data=ghmay (where=(pag_sdqebdtot_1 ne .));
var structure_f;
class tfa2;
run;
proc means data=ghmay (where=(pag_sdqebdtot_1 ne .));;
var envi_f;
run;
proc ttest data=ghmay (where=(pag_sdqebdtot_1 ne .));
var envi_f;
class tfa2;
run;
proc means data=ghmay (where=(pag_sdqebdtot_1 ne .));;
var overall_f;
run;
proc ttest data=ghmay (where=(pag_sdqebdtot_1 ne .));
var overall_f;
class tfa2;
run;

data sdqwide;
set a.sdqwide;
run;
data sdqwide;
set sdqwide;
time1st = (isics_dateinterview_1-pag_dateinterview_1)/365.25;
run;
data sdqwide;
set sdqwide;
time1st = time1st*48;
run;
proc means data=sdqwide;
var time1st;
run;

data ghmay;
set ryan.ghmay;
run;
proc sort data =ghmay;
by tfa2;
run;

proc reg data=ghmay (where=(pag_sdqebdtot_1 ne .));
model pd_sdqebdtot_1 = age gender racegrp licenselevel overall_f pag_sdqebdtot_1/vif;
by tfa2;
run;
proc reg data=ghmay (where=(pag_sdqebdtot_1 ne .));
model pd_sdqebdtot_1 = age gender racegrp licenselevel overall_f isics_sdqebdtot_1/vif;
by tfa2;
run;
proc freq data=ghmay (where=(pag_sdqebdtot_1 ne .));
table tfa2*licenselevel/chisq;
run;

libname a 'D:\Academics\Group homes\Data check';
data rater;
set a.meanrating;
run;

proc factor data=rater METHOD=P mineigen=1 nfactors=1 PRIORS=SMC ROTATE=PROMAX SCREE CORR RES out=rater;
var mho_s1a1 mho_s1a3 mho_s1b1 mho_s1b2 mho_s1b3;
run;
data rater;
set rater;
rename factor1 = yskill_f;
run;

proc factor data=rater METHOD=P mineigen=1 nfactors=1 PRIORS=SMC ROTATE=PROMAX SCREE CORR RES out=rater;
var mho_s2a1_s1 mho_s2a2_s1 mho_s2a3_s1 mho_s2a4_s1 mho_s2b2_s1 mho_s2b3_s1;
run;
data rater;
set rater;
rename factor1 = s1skill_f;
run;

proc factor data=rater METHOD=P mineigen=1 nfactors=1 PRIORS=SMC ROTATE=PROMAX SCREE CORR RES out=rater;
var mho_s3a1 mho_s3a2 mho_s3a3 mho_s3c1 mho_s3c2 mho_s3c3 mho_s3c4 mho_s3c5;
run;
data rater;
set rater;
rename factor1 = structure_f;
run;
proc factor data=rater METHOD=P mineigen=1 nfactors=1 PRIORS=SMC ROTATE=PROMAX SCREE CORR RES out=rater;
var mho_s4a1 mho_s4a2 mho_s4a3 mho_s4a4 mho_s4a5 mho_s4a6 mho_s4b1 mho_s4c1 mho_s4c3;
run;
data rater;
set rater;
rename factor1 = envi_f;
run;

proc factor data=rater METHOD=P mineigen=1 nfactors=1 PRIORS=SMC ROTATE=PROMAX SCREE CORR RES out=rater;
var yskill_f s1skill_f structure_f envi_f;
run;
data rater;
set rater;
rename factor1=overall_f;
run;
proc corr data=rater alpha;
var s1skill_f structure_f envi_f yskill_f;
run;
proc contents data=rater;
run;
data rater;
set rater;
if tfa1=2 then tfa1=0;
run;
proc means data=rater;
var yskill_f;
run;
proc ttest data=rater;
var yskill_f;
class tfa1;
run;
proc means data=rater;
var s1skill_f;
run;
proc ttest data=rater;
var s1skill_f;
class tfa1;
run;
proc means data=rater;
var structure_f;
run;
proc ttest data=rater;
var structure_f;
class tfa1;
run;
proc means data=rater;
var structure_f;
run;
proc ttest data=rater;
var structure_f;
class tfa1;
run;
proc means data=rater;
var envi_f;
run;
proc ttest data=rater;
var envi_f;
class tfa1;
run;
proc means data=rater;
var overall_f;
run;
proc ttest data=rater;
var overall_f;
class tfa1;
run;
