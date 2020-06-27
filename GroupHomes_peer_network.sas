/**********************************************************************************************
YOUTH GROUP HOMES
Created and updated by: Nhan La
Date: 2012/11/30
Summary: This program generates peer social networks among youth
**********************************************************************************************/

libname network 'D:\Academics\Group homes\Data';

data kidwide;
set network.fuskids_wide;
run;
data fuskid;
set network.fuskids;
run;
data home1;
set network.fushome; run;
data staff;
set network.fusstaff; run;
data kid;
set network.ik;
run;
proc sort data=kid;
by homeid ik_dateinterview;
run;
proc contents data=kid;
run;
proc contents data=home;
run;
proc means data=home;
var fus_nsubjectkids;
run;
proc means data=home;
var fus_71;
run;

data home;
set home;
kidintdiff=fus_71-fus_nsubjectkids;
run;
proc means data=home;
var kidintdiff;
run;

proc freq data=home;
table fus_homevisitnumber;
run;
data home1;
set home;
if fus_homevisitnumber=1;
run;
proc freq data=home1;
table fus_homevisitnumber;
run;

proc sort data=home1;
by homeid dateinterview;
run;
proc sort data=kid;
by homeid dateinterview;
run;

data nwkpeer;
merge kid (in=kidx) home1 (in=home1x);
by homeid dateinterview;
fromkid=kidx;
fromhome1=home1x;
run;
data nwkpeer;
set nwkpeer;
if fromhome1=1;
run;
proc freq data=nwkpeer;
table fromhome1;
run;
proc freq data=nwkpeer;
table ik_79;
run;
