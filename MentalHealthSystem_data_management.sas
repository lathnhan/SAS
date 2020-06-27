
/**********************************************************************************************
MENTAL HEALTH SYSTEM SURVEY
Created and updated by: Nhan La
Date: 2015/11/25
Summary: This program concatenates data management process for the Mental Health System Survey
**********************************************************************************************/

/**********************************************************************************************/
*1. Turn administrative identifying variables to UPPER case;

proc import datafile='C:\Users\nhanl\Documents\VN Mental Health System Survey\Data\Data check\Form 1.xlsx' out=work.form1 dbms=xlsx replace;
getnames=yes;run;
data form1address;set form1;keep Ten_Day_Du_cua_co_so
_1__Ten_Day_Du_cua_Co_so_
VAR8
VAR10
_2c__Tinh_Thanh_pho
;run;
data form1address;set form1address;
Ten_Co_So = upcase(_1__Ten_Day_Du_cua_Co_so_);
So_Nha_Duong_Pho=upcase(VAR8);
Quan_Huyen=upcase(VAR10);
Tinh_Thanh_Pho=upcase(_2c__Tinh_Thanh_pho);run;
drop Ten_Day_Du_cua_co_so
_1__Ten_Day_Du_cua_Co_so_
VAR8
VAR10
_2c__Tinh_Thanh_pho;run;
proc export data=work.form1address outfile='C:\Users\nhanl\Documents\VN Mental Health System Survey\Data\Data check\Form 1 address.csv'
dbms=csv replace;run;

proc import datafile='C:\Users\nhanl\Documents\VN Mental Health System Survey\Data\Data check\Form 2.xlsx' out=work.form2 dbms=xlsx replace;
getnames=yes;run;
data form2address;set form2;keep 
_1__Ten_Day_Du_cua_Co_so_
VAR9
VAR11
_2c__Tinh_Thanh_pho
;run;
data form2address;set form2address;
Ten_Co_So = upcase(_1__Ten_Day_Du_cua_Co_so_);
So_Nha_Duong_Pho=upcase(VAR9);
Quan_Huyen=upcase(VAR11);
Tinh_Thanh_Pho=upcase(_2c__Tinh_Thanh_pho);
drop 
_1__Ten_Day_Du_cua_Co_so_
VAR9
VAR11
_2c__Tinh_Thanh_pho;
run;
proc export data=work.form2address outfile='C:\Users\nhanl\Documents\VN Mental Health System Survey\Data\Data check\Form 2 address.csv'
dbms=csv replace;run;

proc import datafile='C:\Users\nhanl\Documents\VN Mental Health System Survey\Data\Data check\Form 3.xlsx' out=work.form3 dbms=xlsx replace;
getnames=yes;run;
data form3address;set form3;keep 
_1__Ten_Day_Du_cua_Co_so_
VAR9
VAR11
_2c__Tinh_Thanh_pho
;run;
data form3address;set form3address;
Ten_Co_So = upcase(_1__Ten_Day_Du_cua_Co_so_);
So_Nha_Duong_Pho=upcase(VAR9);
Quan_Huyen=upcase(VAR11);
Tinh_Thanh_Pho=upcase(_2c__Tinh_Thanh_pho);
drop 
_1__Ten_Day_Du_cua_Co_so_
VAR9
VAR11
_2c__Tinh_Thanh_pho;
run;
proc export data=work.form3address outfile='C:\Users\nhanl\Documents\VN Mental Health System Survey\Data\Data check\Form 3 address.csv'
dbms=csv replace;run;

proc import datafile='C:\Users\nhanl\Documents\VN Mental Health System Survey\Data\Data check\Form 4.xlsx' out=work.form4 dbms=xlsx replace;
getnames=yes;run;
data form4address;set form4;keep 
_1__Ten_Day_Du_cua_Co_so
VAR9
VAR11
_2c__Tinh_Thanh_pho
;run;
data form4address;set form4address;
Ten_Co_So = upcase(_1__Ten_Day_Du_cua_Co_so);
So_Nha_Duong_Pho=upcase(VAR9);
Quan_Huyen=upcase(VAR11);
Tinh_Thanh_Pho=upcase(_2c__Tinh_Thanh_pho);
drop 
_1__Ten_Day_Du_cua_Co_so
VAR9
VAR11
_2c__Tinh_Thanh_pho;
run;
proc export data=work.form4address outfile='C:\Users\nhanl\Documents\VN Mental Health System Survey\Data\Data check\Form 4 address.csv'
dbms=csv replace;run;

proc import datafile='C:\Users\nhanl\Documents\VN Mental Health System Survey\Data\Data check\Form 5.xlsx' out=work.form5 dbms=xlsx replace;
getnames=yes;run;
data form5address;set form5;keep 
_1__Ten_Day_Du_cua_Co_so_
VAR9
VAR11
_2c__Tinh_Thanh_pho
;run;
data form5address;set form5address;
Ten_Co_So = upcase(_1__Ten_Day_Du_cua_Co_so_);
So_Nha_Duong_Pho=upcase(VAR9);
Quan_Huyen=upcase(VAR11);
Tinh_Thanh_Pho=upcase(_2c__Tinh_Thanh_pho);
drop 
_1__Ten_Day_Du_cua_Co_so_
VAR9
VAR11
_2c__Tinh_Thanh_pho;
run;
proc export data=work.form5address outfile='C:\Users\nhanl\Documents\VN Mental Health System Survey\Data\Data check\Form 5 address.csv'
dbms=csv replace;run;

proc import datafile='C:\Users\nhanl\Documents\VN Mental Health System Survey\Data\Data check\Form 7.xlsx' out=work.form7 dbms=xlsx replace;
getnames=yes;run;
data form7address;set form7;keep 
_1__Ten_Day_Du_cua_Co_so_
VAR8
VAR10
_2c__Tinh_Thanh_pho
;run;
data form7address;set form7address;
Ten_Co_So = upcase(_1__Ten_Day_Du_cua_Co_so_);
So_Nha_Duong_Pho=upcase(VAR8);
Quan_Huyen=upcase(VAR10);
Tinh_Thanh_Pho=upcase(_2c__Tinh_Thanh_pho);
drop 
_1__Ten_Day_Du_cua_Co_so_
VAR8
VAR10
_2c__Tinh_Thanh_pho;
run;
proc export data=work.form7address outfile='C:\Users\nhanl\Documents\VN Mental Health System Survey\Data\Data check\Form 7 address.csv'
dbms=csv replace;run;
/**********************************************************************************************/


/**********************************************************************************************/
*2. Combine individual data sets to become a new data set, export and named "export1.xlsx";

***Remove duplications;
proc sort data=export1;by gi_id;run;
data datacheckdups datachecknodups;set export1;by gi_id;if first.GI_ID and last.gi_id then output datachecknodups;else output datacheckdups;run;
proc sort data=export1;by gi_id descending timesubmitted;run;
proc sort data=export1 nodupkey;by gi_id;run;

***Remove missing observations;
data export1; set export1;
if gi_id ne " ";run;

proc import datafile='C:\Users\nhanl\Documents\VN Mental Health System Survey\Data\Data check\export1.xlsx' out=work.datacheck dbms=xlsx replace;
getnames=yes;run;
proc freq data=datacheck;table GI_Manage GI_FacType GI_ServiceType;run;
data datacheck;set datacheck;GI_FacType=scan(GI_FacType,1,'.');run;
data datacheck;set datacheck;GI_FacType1=input(GI_FacType,8.);
drop GI_FacType;rename GI_FacType1=GI_FacType;run;
/**********************************************************************************************/

/**********************************************************************************************/
*3. Extract numeric values of multi-choice variables;
data datacheck1606;set datacheck;
GI_Manage	 =scan(	GI_Manage	 ,1,'.');
GI_ServiceType	 =scan(	GI_ServiceType,1,'.');
GI_FacType = scan(GI_FacType, 1, '.');
GI_Clients	 =scan(	GI_Clients	 ,1,'.');
GI_IntegrateFac	 =scan(	GI_IntegrateFac	 ,1,'.');
OS_DeptPlan	 =scan(	OS_DeptPlan	 ,1,'.');
OS_DeptPersonnel	 =scan(	OS_DeptPersonnel	 ,1,'.');
OS_DeptFinance	 =scan(	OS_DeptFinance	 ,1,'.');
OS_DeptMedicine	 =scan(	OS_DeptMedicine	 ,1,'.');
OS_DeptCommunity	 =scan(	OS_DeptCommunity	 ,1,'.');
OS_DeptTraining	 =scan(	OS_DeptTraining	 ,1,'.');
OS_DeptResearch	 =scan(	OS_DeptResearch	 ,1,'.');
OS_DeptAdmin	 =scan(	OS_DeptAdmin	 ,1,'.');
OS_DeptEquipment	 =scan(	OS_DeptEquipment	 ,1,'.');
OS_DeptNursing	 =scan(	OS_DeptNursing	 ,1,'.');
OS_DeptOther	 =scan(	OS_DeptOther	 ,1,'.');
OS_CliEmergency	 =scan(	OS_CliEmergency	 ,1,'.');
OS_CliOutpatient	 =scan(	OS_CliOutpatient	 ,1,'.');
OS_CliMale	 =scan(	OS_CliMale	 ,1,'.');
OS_CliFemale	 =scan(	OS_CliFemale	 ,1,'.');
OS_CliPediatric	 =scan(	OS_CliPediatric	 ,1,'.');
OS_CliInfection	 =scan(	OS_CliInfection	 ,1,'.');
OS_CliTradition	 =scan(	OS_CliTradition	 ,1,'.');
OS_CliRehab	 =scan(	OS_CliRehab	 ,1,'.');
OS_CliSubstance	 =scan(	OS_CliSubstance	 ,1,'.');
OS_CliForensic	 =scan(	OS_CliForensic	 ,1,'.');
OS_CliTreatRehab	 =scan(	OS_CliTreatRehab	 ,1,'.');
OS_CliNutrition	 =scan(	OS_CliNutrition	 ,1,'.');
OS_CliOther	 =scan(	OS_CliOther	 ,1,'.');
OS_PCliTesting	 =scan(	OS_PCliTesting	 ,1,'.');
OS_PCliImaging	 =scan(	OS_PCliImaging	 ,1,'.');
OS_PCliInfection	 =scan(	OS_PCliInfection	 ,1,'.');
OS_PCliPharma	 =scan(	OS_PCliPharma	 ,1,'.');
OS_PCliOther	 =scan(	OS_PCliOther	 ,1,'.');
PL_Policy	 =scan(	PL_Policy	 ,1,'.');
PL_Policy1	 =scan(	PL_Policy1	 ,1,'.');
PL_Policy2	 =scan(	PL_Policy2	 ,1,'.');
PL_Policy3	 =scan(	PL_Policy3	 ,1,'.');
PL_Policy4	 =scan(	PL_Policy4	 ,1,'.');
PL_Policy5	 =scan(	PL_Policy5	 ,1,'.');
PL_Policy6	 =scan(	PL_Policy6	 ,1,'.');
PL_Policy7	 =scan(	PL_Policy7	 ,1,'.');
PL_Policy8	 =scan(	PL_Policy8	 ,1,'.');
PL_Policy9	 =scan(	PL_Policy9	 ,1,'.');
PL_Policy10	 =scan(	PL_Policy10	 ,1,'.');
PL_Policy11	 =scan(	PL_Policy11	 ,1,'.');
PL_Policy12	 =scan(	PL_Policy12	 ,1,'.');
PL_PolicyOther	 =scan(	PL_PolicyOther	 ,1,'.');
PL_Psymed	 =scan(	PL_Psymed	 ,1,'.');
PL_Antipsy1	 =scan(	PL_Antipsy1	 ,1,'.');
PL_Antipsy2	 =scan(	PL_Antipsy2	 ,1,'.');
PL_Anxio1	 =scan(	PL_Anxio1	 ,1,'.');
PL_Anxio2	 =scan(	PL_Anxio2	 ,1,'.');
PL_Antidep1	 =scan(	PL_Antidep1	 ,1,'.');
PL_Antidep2	 =scan(	PL_Antidep2	 ,1,'.');
PL_Mood	 =scan(	PL_Mood	 ,1,'.');
PL_Antiepi1	 =scan(	PL_Antiepi1	 ,1,'.');
PL_Antiepi2	 =scan(	PL_Antiepi2	 ,1,'.');
PL_Plan	 =scan(	PL_Plan	 ,1,'.');
PL_Plan1	 =scan(	PL_Plan1	 ,1,'.');
PL_Plan2	 =scan(	PL_Plan2	 ,1,'.');
PL_Plan3	 =scan(	PL_Plan3	 ,1,'.');
PL_Plan4	 =scan(	PL_Plan4	 ,1,'.');
PL_Plan5	 =scan(	PL_Plan5	 ,1,'.');
PL_Plan6	 =scan(	PL_Plan6	 ,1,'.');
PL_Plan7	 =scan(	PL_Plan7	 ,1,'.');
PL_Plan8	 =scan(	PL_Plan8	 ,1,'.');
PL_Plan9	 =scan(	PL_Plan9	 ,1,'.');
PL_Plan10	 =scan(	PL_Plan10	 ,1,'.');
PL_Plan11	 =scan(	PL_Plan11	 ,1,'.');
PL_Plan12	 =scan(	PL_Plan12	 ,1,'.');
PL_Plan13	 =scan(	PL_Plan13	 ,1,'.');
PL_PlanOther	 =scan(	PL_PlanOther	 ,1,'.');
PL_CurBudget	 =scan(	PL_CurBudget	 ,1,'.');
PL_CurTime	 =scan(	PL_CurTime	 ,1,'.');
PL_CurGoal	 =scan(	PL_CurGoal	 ,1,'.');
PL_CurAchieve	 =scan(	PL_CurAchieve	 ,1,'.');
PL_Disaster	 =scan(	PL_Disaster	 ,1,'.');
PL_Legal	 =scan(	PL_Legal	 ,1,'.');
PL_Legal1	 =scan(	PL_Legal1	 ,1,'.');
PL_Legal2	 =scan(	PL_Legal2	 ,1,'.');
PL_Legal3	 =scan(	PL_Legal3	 ,1,'.');
PL_Legal4	 =scan(	PL_Legal4	 ,1,'.');
PL_Legal5	 =scan(	PL_Legal5	 ,1,'.');
PL_Legal6	 =scan(	PL_Legal6	 ,1,'.');
PL_Legal7	 =scan(	PL_Legal7	 ,1,'.');
PL_Legal8	 =scan(	PL_Legal8	 ,1,'.');
PL_Legal9	 =scan(	PL_Legal9	 ,1,'.');
PL_HRAgency	 =scan(	PL_HRAgency	 ,1,'.');
PL_HRTraining	 =scan(	PL_HRTraining	 ,1,'.');
FI_InsurancePay	 =scan(	FI_InsurancePay	 ,1,'.');
SV_CoopOutpF7	 =scan(	SV_CoopOutpF7	 ,1,'.');
SV_CoopInpF7	 =scan(	SV_CoopInpF7	 ,1,'.');
SV_CoopFacility	 =scan(	SV_CoopFacility	 ,1,'.');
SV_ExamService	 =scan(	SV_ExamService	 ,1,'.');
SV_TreatService	 =scan(	SV_TreatService	 ,1,'.');
SV_ExamTreatDept	 =scan(	SV_ExamTreatDept	 ,1,'.');
SV_ExamTreatFreq	 =scan(	SV_ExamTreatFreq	 ,1,'.');
SV_CoopComm	 =scan(	SV_CoopComm	 ,1,'.');
SV_ExamTreatService	 =scan(	SV_ExamTreatService	 ,1,'.');
SV_OutpatientKid	 =scan(	SV_OutpatientKid	 ,1,'.');
SV_RestrainP	 =scan(	SV_RestrainP	 ,1,'.');
SV_MoTeam	 =scan(	SV_MoTeam	 ,1,'.');
SV_FrsProvinceAgency	 =scan(	SV_FrsProvinceAgency	 ,1,'.');
SV_ExamF7	 =scan(	SV_ExamF7	 ,1,'.');
SV_TreatmentF7	 =scan(	SV_TreatmentF7	 ,1,'.');
SV_PsytherapyF7	 =scan(	SV_PsytherapyF7	 ,1,'.');
SV_OccuTherapyF7	 =scan(	SV_OccuTherapyF7	 ,1,'.');
SV_RehabF7	 =scan(	SV_RehabF7	 ,1,'.');
SV_SocialSupportF7	 =scan(	SV_SocialSupportF7	 ,1,'.');
SV_ServiceOtherF7	 =scan(	SV_ServiceOtherF7	 ,1,'.');
SV_ManageF7	 =scan(	SV_ManageF7	 ,1,'.');
SV_ManageOccuF7	 =scan(	SV_ManageOccuF7	 ,1,'.');
SV_ManageSocSupportF7	 =scan(	SV_ManageSocSupportF7	 ,1,'.');
SV_ManageOtherF7	 =scan(	SV_ManageOtherF7	 ,1,'.');
SV_CommunityF7	 =scan(	SV_CommunityF7	 ,1,'.');
SV_DieF7	 =scan(	SV_DieF7	 ,1,'.');
SV_PsyTherapyP	 =scan(	SV_PsyTherapyP	 ,1,'.');
SV_Antipsychotic	 =scan(	SV_Antipsychotic	 ,1,'.');
SV_Anxiolytic	 =scan(	SV_Anxiolytic	 ,1,'.');
SV_Antidepressant	 =scan(	SV_Antidepressant	 ,1,'.');
SV_MoodStable	 =scan(	SV_MoodStable	 ,1,'.');
SV_Antiepileptic	 =scan(	SV_Antiepileptic	 ,1,'.');
SV_ProjectMed	 =scan(	SV_ProjectMed	 ,1,'.');
SV_RuralUse	 =scan(	SV_RuralUse	 ,1,'.');
SV_StratMinor	 =scan(	SV_StratMinor	 ,1,'.');
SV_MinorUse	 =scan(	SV_MinorUse	 ,1,'.');
SV_Private	 =scan(	SV_Private	 ,1,'.');
SV_PrivateWait	 =scan(	SV_PrivateWait	 ,1,'.');
SV_PrivateExam	 =scan(	SV_PrivateExam	 ,1,'.');
SV_PrivateBed	 =scan(	SV_PrivateBed	 ,1,'.');
PR_GuidanceF5	 =scan(	PR_GuidanceF5	 ,1,'.');
PR_TransferF5	 =scan(	PR_TransferF5	 ,1,'.');
PR_Prescribe	 =scan(	PR_Prescribe	 ,1,'.');
PR_InteractTradMed	 =scan(	PR_InteractTradMed	 ,1,'.');
HR_PsyDeptInCharge	 =scan(	HR_PsyDeptInCharge	 ,1,'.');
HR_AbroadP	 =scan(	HR_AbroadP	 ,1,'.');
HR_Club	 =scan(	HR_Club	 ,1,'.');
HR_ClubPatient	 =scan(	HR_ClubPatient	 ,1,'.');
HR_ClubFamily	 =scan(	HR_ClubFamily	 ,1,'.');
HR_SupportClubP	 =scan(	HR_SupportClubP	 ,1,'.');
HR_SupportClubF	 =scan(	HR_SupportClubF	 ,1,'.');
HR_PolicyClubP	 =scan(	HR_PolicyClubP	 ,1,'.');
HR_PolicyClubF	 =scan(	HR_PolicyClubF	 ,1,'.');
HR_InteractClubP	 =scan(	HR_InteractClubP	 ,1,'.');
HR_InteractClubF	 =scan(	HR_InteractClubF	 ,1,'.');
HR_ActivityClubP	 =scan(	HR_ActivityClubP	 ,1,'.');
HR_ActivityClubF	 =scan(	HR_ActivityClubF	 ,1,'.');
HR_NGOCommunication	 =scan(	HR_NGOCommunication	 ,1,'.');
HR_NGOService	 =scan(	HR_NGOService	 ,1,'.');
CE_LocalAgency	 =scan(	CE_LocalAgency	 ,1,'.');
CE_AgencyGov	 =scan(	CE_AgencyGov	 ,1,'.');
CE_AgencyNGO	 =scan(	CE_AgencyNGO	 ,1,'.');
CE_AgencyProfession	 =scan(	CE_AgencyProfession	 ,1,'.');
CE_AgencyPrivate	 =scan(	CE_AgencyPrivate	 ,1,'.');
CE_AgencyInter	 =scan(	CE_AgencyInter	 ,1,'.');
CE_CommCommunity	 =scan(	CE_CommCommunity	 ,1,'.');
CE_CommKid	 =scan(	CE_CommKid	 ,1,'.');
CE_CommWomen	 =scan(	CE_CommWomen	 ,1,'.');
CE_CommAdolescent	 =scan(	CE_CommAdolescent	 ,1,'.');
CE_CommTrauma	 =scan(	CE_CommTrauma	 ,1,'.');
CE_CommEthnic	 =scan(	CE_CommEthnic	 ,1,'.');
CE_CommOther	 =scan(	CE_CommOther	 ,1,'.');
CE_Provider	 =scan(	CE_Provider	 ,1,'.');
CE_Tradition	 =scan(	CE_Tradition	 ,1,'.');
CE_Teacher	 =scan(	CE_Teacher	 ,1,'.');
CE_SocialService	 =scan(	CE_SocialService	 ,1,'.');
CE_Leader	 =scan(	CE_Leader	 ,1,'.');
CE_OtherProfession	 =scan(	CE_OtherProfession	 ,1,'.');
CE_EmployAgency	 =scan(	CE_EmployAgency	 ,1,'.');
CE_SchoolStaff	 =scan(	CE_SchoolStaff	 ,1,'.');
CE_SchoolActivity	 =scan(	CE_SchoolActivity	 ,1,'.');
CE_PoliceEducation	 =scan(	CE_PoliceEducation	 ,1,'.');
CE_JudgeEducation	 =scan(	CE_JudgeEducation	 ,1,'.');
CE_PrisonPsychosis	 =scan(	CE_PrisonPsychosis	 ,1,'.');
CE_PrisonRetard	 =scan(	CE_PrisonRetard	 ,1,'.');
CE_PrisonTreat	 =scan(	CE_PrisonTreat	 ,1,'.');
MR_Form	 =scan(	MR_Form	 ,1,'.');
MR_PttTreat	 =scan(	MR_PttTreat	 ,1,'.');
MR_ExamTimes	 =scan(	MR_ExamTimes	 ,1,'.');
MR_PttAsPlan	 =scan(	MR_PttAsPlan	 ,1,'.');
MR_PttAsFact	 =scan(	MR_PttAsFact	 ,1,'.');
MR_Bed	 =scan(	MR_Bed	 ,1,'.');
MR_Inpatient	 =scan(	MR_Inpatient	 ,1,'.');
MR_LOS	 =scan(	MR_LOS	 ,1,'.');
MR_Involuntary	 =scan(	MR_Involuntary	 ,1,'.');
MR_Confined	 =scan(	MR_Confined	 ,1,'.');
MR_Diagnose	 =scan(	MR_Diagnose	 ,1,'.');
MR_DataOther	 =scan(	MR_DataOther	 ,1,'.');
MR_MSA	 =scan(	MR_MSA	 ,1,'.');
MR_MOLISA	 =scan(	MR_MOLISA	 ,1,'.');
MR_DOH	 =scan(	MR_DOH	 ,1,'.');
MR_DOLISA	 =scan(	MR_DOLISA	 ,1,'.');
MR_NPH	 =scan(	MR_NPH	 ,1,'.');
MR_PPH	 =scan(	MR_PPH	 ,1,'.');
MR_PPS	 =scan(	MR_PPS	 ,1,'.');
MR_PGH	 =scan(	MR_PGH	 ,1,'.');
MR_PCDC	 =scan(	MR_PCDC	 ,1,'.');
MR_PHC	 =scan(	MR_PHC	 ,1,'.');
MR_RepOther	 =scan(	MR_RepOther	 ,1,'.');
MR_ReportGov13	 =scan(	MR_ReportGov13	 ,1,'.');
MR_Supervise13	 =scan(	MR_Supervise13	 ,1,'.');
MR_ResearchTopic1	 =scan(	MR_ResearchTopic1	 ,1,'.');
MR_ResearchTopic2	 =scan(	MR_ResearchTopic2	 ,1,'.');
MR_ResearchTopic3	 =scan(	MR_ResearchTopic3	 ,1,'.');
MR_ResearchTopic4	 =scan(	MR_ResearchTopic4	 ,1,'.');
MR_ResearchTopic5	 =scan(	MR_ResearchTopic5	 ,1,'.');
MR_ResearchTopic6	 =scan(	MR_ResearchTopic6	 ,1,'.');
MR_ResearchTopic7	 =scan(	MR_ResearchTopic7	 ,1,'.');
MR_ResearchTopic8	 =scan(	MR_ResearchTopic8	 ,1,'.');
MR_ResearchTopic99	 =scan(	MR_ResearchTopic99	 ,1,'.');
CP_Participate	 =scan(	CP_Participate	 ,1,'.');
CP_Participate13F5	 =scan(	CP_Participate13F5	 ,1,'.');
run;
/**********************************************************************************************/

/**********************************************************************************************/
*4. Extract numeric values from check-box variables;

***Step 1 - Assign numbers to responses;
data datacheck1606;set datacheck1606;
SV_DownRef1=index(SV_DownRef,"1");  
SV_DownRef2=index(SV_DownRef,"2"); 
SV_DownRef3=index(SV_DownRef,"3");
SV_DownRef4=index(SV_DownRef,"4");
SV_DownRef5=index(SV_DownRef,"5");
SV_DownRef6=index(SV_DownRef,"6");
SV_DownRef7=index(SV_DownRef,"7");
SV_DownRef98=index(SV_DownRef,"98");
SV_DownRef99=index(SV_DownRef,"99");

SV_UpRef1=index(SV_UpRef,"1");  
SV_UpRef2=index(SV_UpRef,"2");  
SV_UpRef3=index(SV_UpRef,"3");
SV_UpRef4=index(SV_UpRef,"4");
SV_UpRef5=index(SV_UpRef,"5");
SV_UpRef6=index(SV_UpRef,"6");
SV_UpRef7=index(SV_UpRef,"7");
SV_UpRef8=index(SV_UpRef,"8");
SV_UpRef9=index(SV_UpRef,"9");
SV_UpRef10=index(SV_UpRef,"10");
SV_UpRef11=index(SV_UpRef,"11");
SV_UpRef98=index(SV_UpRef,"98");
SV_UpRef99=index(SV_UpRef,"99");

SV_MoPlace1=index(SV_MoPlace,"1");  
SV_MoPlace2=index(SV_MoPlace,"2"); 
SV_MoPlace3=index(SV_MoPlace,"3");
SV_MoPlace4=index(SV_MoPlace,"4");
SV_MoPlace5=index(SV_MoPlace,"5");
SV_MoPlace99=index(SV_MoPlace,"99");

SV_MoDist1	=index(SV_Modist,"1");   
SV_MoDist2	=index(SV_Modist,"2"); 
SV_MoDist3	=index(SV_Modist,"3");
SV_MoDist4	=index(SV_Modist,"4");
SV_MoDist5	=index(SV_Modist,"5");
SV_MoDist6	=index(SV_Modist,"6");
SV_MoDist99	=index(SV_Modist,"99");

SV_MoComm1	=index(SV_Mocomm,"1");  
SV_MoComm2	=index(SV_Mocomm,"2"); 
SV_MoComm3	=index(SV_Mocomm,"3");
SV_MoComm4	=index(SV_Mocomm,"4");
SV_MoComm5	=index(SV_Mocomm,"5");
SV_MoComm6	=index(SV_Mocomm,"6");
SV_MoComm99	=index(SV_Mocomm,"99");

SV_MoVil1=index(SV_MoVil,"1");  
SV_MoVil2=index(SV_MoVil,"2"); 
SV_MoVil3=index(SV_MoVil,"3");
SV_MoVil4=index(SV_MoVil,"4");
SV_MoVil5=index(SV_MoVil,"5");
SV_MoVil6=index(SV_MoVil,"6");
SV_MoVil99=index(SV_MoVil,"99");

SV_MoHome1=indexc(SV_MoHome,"1");  
SV_MoHome2=indexc(SV_MoHome,"2"); 
SV_MoHome3=indexc(SV_MoHome,"3");
SV_MoHome4=indexc(SV_MoHome,"4");
SV_MoHome5=indexc(SV_MoHome,"5");
SV_MoHome6=indexc(SV_MoHome,"6");
SV_MoHome99=indexc(SV_MoHome,"99");

SV_MoCoop1=indexc(SV_MoCoop,"1");  
SV_MoCoop2=indexc(SV_MoCoop,"2");  
SV_MoCoop3=indexc(SV_MoCoop,"3");
SV_MoCoop4=indexc(SV_MoCoop,"4");
SV_MoCoop5=indexc(SV_MoCoop,"5");
SV_MoCoop6=indexc(SV_MoCoop,"6");
SV_MoCoop7=indexc(SV_MoCoop,"7");
SV_MoCoop8=indexc(SV_MoCoop,"8");
SV_MoCoop9=indexc(SV_MoCoop,"9");
SV_MoCoop99=indexc(SV_MoCoop,"99");

MR_Regular1=index(MR_Regular,"1");  
MR_Regular2=index(MR_Regular,"2"); 
MR_Regular3=index(MR_Regular,"3"); 
MR_Regular4=index(MR_Regular,"4"); 
MR_Regular5=index(MR_Regular,"5"); 
MR_Regular99=index(MR_Regular,"99"); 

MR_SuperviseAgency1 = index(MR_SuperviseAgency,'1');  
MR_SuperviseAgency2 = index(MR_SuperviseAgency,'2'); 
MR_SuperviseAgency3 = index(MR_SuperviseAgency,'3'); 
MR_SuperviseAgency4 = index(MR_SuperviseAgency,'4'); 
MR_SuperviseAgency5 = index(MR_SuperviseAgency,'5'); 
MR_SuperviseAgency6 = index(MR_SuperviseAgency,'6'); 
MR_SuperviseAgency7 = index(MR_SuperviseAgency,'7'); 
MR_SuperviseAgency8 = index(MR_SuperviseAgency,'8'); 
MR_SuperviseAgency9 = index(MR_SuperviseAgency,'9'); 
MR_SuperviseAgency99 = index(MR_SuperviseAgency,'99'); 

MR_SuperviseContent1=index(MR_SuperviseContent,"1");  
MR_SuperviseContent2=index(MR_SuperviseContent,"2"); 
MR_SuperviseContent3=index(MR_SuperviseContent,"3"); 
MR_SuperviseContent4=index(MR_SuperviseContent,"4"); 
MR_SuperviseContent99=index(MR_SuperviseContent,"99"); 

SV_CoopCommContent1=index(SV_CoopCommContent,"1");  
SV_CoopCommContent2=index(SV_CoopCommContent,"2");  
SV_CoopCommContent3=index(SV_CoopCommContent,"3");  
SV_CoopCommContent4=index(SV_CoopCommContent,"4");  
SV_CoopCommContent5=index(SV_CoopCommContent,"5");  
SV_CoopCommContent98=index(SV_CoopCommContent,"98");  
SV_CoopCommContent99=index(SV_CoopCommContent,"99");  

SV_CommFreq1=index(SV_CommFreq,"1");  
SV_CommFreq2=index(SV_CommFreq,"2"); 
SV_CommFreq3=index(SV_CommFreq,"3");
SV_CommFreq4=index(SV_CommFreq,"4");
SV_CommFreq5=index(SV_CommFreq,"5");
SV_CommFreq6=index(SV_CommFreq,"6");
SV_CommFreq99=index(SV_CommFreq,"99");

SV_DirectAgency1=index(SV_DirectAgency,"1"); 
SV_DirectAgency2=index(SV_DirectAgency,"2"); 
SV_DirectAgency3=index(SV_DirectAgency,"3"); 
SV_DirectAgency4=index(SV_DirectAgency,"4"); 
SV_DirectAgency5=index(SV_DirectAgency,"5"); 
SV_DirectAgency6=index(SV_DirectAgency,"6"); 
SV_DirectAgency7=index(SV_DirectAgency,"7"); 
SV_DirectAgency8=index(SV_DirectAgency,"8"); 
SV_DirectAgency9=index(SV_DirectAgency,"9"); 
SV_DirectAgency99=index(SV_DirectAgency,"99"); 

PR_InteractMHPro1=index(PR_InteractMHPro,"1");   
PR_InteractMHPro2=index(PR_InteractMHPro,"2");   
PR_InteractMHPro3=index(PR_InteractMHPro,"3");   
PR_InteractMHPro4=index(PR_InteractMHPro,"4");   
PR_InteractMHPro5=index(PR_InteractMHPro,"5");   
PR_InteractMHPro6=index(PR_InteractMHPro,"6");   
PR_InteractMHPro99=index(PR_InteractMHPro,"99");   

PR_WhoPrescribe1=index(PR_WhoPrescribe,"1"); 
PR_WhoPrescribe2=index(PR_WhoPrescribe,"2"); 
PR_WhoPrescribe3=index(PR_WhoPrescribe,"3"); 
PR_WhoPrescribe4=index(PR_WhoPrescribe,"4"); 
PR_WhoPrescribe99=index(PR_WhoPrescribe,"99");

PR_InteractMHPro1=index(PR_InteractMHPro,"1");   
PR_InteractMHPro2=index(PR_InteractMHPro,"2");   
PR_InteractMHPro3=index(PR_InteractMHPro,"3");   
PR_InteractMHPro4=index(PR_InteractMHPro,"4");   
PR_InteractMHPro5=index(PR_InteractMHPro,"5");   
PR_InteractMHPro6=index(PR_InteractMHPro,"6");   
PR_InteractMHPro99=index(PR_InteractMHPro,"99");  
run;

***Step 2 - Categorize variables;
data datacheck1606;set datacheck1606;
array separ 
sv_downref1-sv_downref7 sv_downref98 sv_downref99
sv_upref1-sv_upref11 sv_upref98 sv_upref99
sv_moplace1-sv_moplace5 sv_moplace99
sv_modist1-sv_modist6 sv_modist99
sv_mocomm1-sv_mocomm6 sv_mocomm99
sv_movil1-sv_movil6 sv_movil99
sv_mohome1-sv_mohome6 sv_mohome99
sv_mocoop1-sv_mocoop9 sv_mocoop99
mr_regular1-mr_regular5 mr_regular99
mr_SuperviseAgency1-mr_SuperviseAgency9 mr_SuperviseAgency99
mr_SuperviseContent1-mr_SuperviseContent4 mr_SuperviseContent99
sv_coopcommcontent1-sv_coopcommcontent5 sv_coopcommcontent98 sv_coopcommcontent99
sv_commfreq1-sv_commfreq6 sv_commfreq99
sv_directagency1-sv_directagency9 sv_directagency99
pr_interactmhpro1-pr_interactmhpro6 pr_interactmhpro99
pr_whoprescribe1-pr_whoprescribe4 pr_whoprescribe99 
PR_InteractMHPro1-PR_InteractMHPro6 PR_InteractMHPro99
;
	do i=1 to 130;
	if separ[i] > 0 then separ[i]=1;
	end;
do j=1 to 9;
if SV_DownRef = ' ' then separ[j]=.;
end;
	do k=10 to 22;
	if SV_DownRef =  ' ' then separ[k]=.;
	end;
do l=23 to 28;
if SV_MoPlace = ' ' then separ[l]=.;
end;
	do m=29 to 35;
	if SV_MoDist = ' ' then separ[m]=.;
	end;
do p=36 to 42;
if SV_MoComm = ' ' then separ[p]=.;
end;
	do q=43 to 49;
	if SV_MoVil = ' ' then separ[q]=.;
	end;
do r=50 to 56;
if SV_MoHome = ' ' then separ[r]=.;
end;
	do s=57 to 66;
	if SV_MoCoop = ' ' then separ[s]=.;
	end;
do t=67 to 72;
if SV_Regular = ' ' then separ[t]=.;
end;
	do u=73 to 82;
	if MR_SuperviseAgency = ' ' then separ[u]=.;
	end;
do v = 83 to 87;
if MR_SuperviseContent = ' ' then separ[v]=.;
end;
	do w = 88 to 94;
	if sv_coopcommcontent = ' ' then separ[w]=.;
	end;
do x = 95 to 101;
if sv_commfreq = ' ' then separ[x]=.;
end;
	do y = 102 to 111;
	if sv_directagency = ' ' then separ[y]=.;
	end;
do z = 112 to 118;
if pr_interactmhpro = ' ' then separ[z]=.;
end;
	do b = 119 to 123;
	if pr_whoprescribe = ' ' then separ[b]=.;
	end;

do h = 124 to 130;
if pr_interactmhpro = ' ' then separ[h] = .;
end;
drop h i j k l m p q r s t u v w x y z b;
run;
/**********************************************************************************************/

/**********************************************************************************************/
*5. Data quality check and editing;
data datacheck1606;set datacheck1606;
if GI_FacType in (6, 7, 8) then FI_TotalSpend=FI_MHSpend13;
if GI_FacType in (6, 7, 8, 9, 10) then HR_TotalStaff=HR_PsyDeptStaff;
if gi_id='X31d' then FI_Antidepspend='588';if gi_id='X79e' then FI_Antidepspend='1213';
if FI_RevOther='co' then FI_RevOther='99999999';
if SV_CommunityF7Num = 'No data' then SV_CommunityF7Num = '99999999';
if SV_DieF7Num = 'No data' then SV_DieF7Num = '99999999';
if GI_ID = '60600b' then GI_FacType = 10;
if GI_ID = 'Y22d' then GI_FacType = 6;
if GI_ID = 'Y22g' then GI_FacType = 6;
if GI_ID = 'Y58d' then GI_FacType = 6;
if GI_ID = '22195b' then GI_FacType = 10;
if GI_ID = '33328a' then GI_FacType = 9;
if GI_ID = '64639a' then GI_FacType = 9;
if GI_ID = '79774d' then GI_FacType = 10;
if GI_ID = '79777a' then GI_FacType = 9;
if GI_ID = '87874a' then GI_FacType = 9;
if GI_ID = '0100407' then FacilityCommune = 'NGOC LAM';
if GI_ID = '2219510' then FacilityCommune = 'CAM THACH';
if GI_ID = '27260a' then GI_FacType = 9;
if GI_ID = '30290a' then GI_FacType = 9;
if GI_ID = '37375a' then GI_FacType = 9;
if GI_ID = '40412a' then GI_FacType = 9;
if GI_ID = '40422a' then GI_FacType = 9;
if GI_ID = '48494a' then GI_FacType = 9;
if GI_ID = '4849501' then FacilityCommune = 'KHUE TRUNG';
if GI_ID = '49519a' then GI_FacType = 9;
if GI_ID = '51529a' then GI_FacType = 9;
if GI_ID = '52551c' then GI_FacType = 9;
if GI_ID = '68675a' then GI_FacType = 9;
if GI_ID = '6868304' then FacilityCommune = 'GIA VIEN';
if GI_ID = '6868308' then FacilityCommune = 'PHUOC CAT 1';
if GI_ID = '7069509' then FacilityCommune = 'THUAN PHU';
if GI_ID = '7472008' then FacilityCommune = 'MINH HOA';
if GI_ID = '77750a' then GI_FacType = 9;
if GI_ID = '8484413' then FacilityCommune = 'NHI LONG';
if GI_ID = '8484602' then FacilityCommune = 'CAU QUAN';
if GI_ID = '8484903' then FacilityCommune = 'PHUOC HUNG';
if GI_ID = '8787601' then FacilityCommune = 'LAI VUNG';
if GI_ID = '8787602' then FacilityCommune = 'TAN DUONG';
if GI_ID = '8787604' then FacilityCommune = 'LONG HAU';
if GI_ID = '8787605' then FacilityCommune = 'TAN PHUOC';
if GI_ID = '8787607' then FacilityCommune = 'TAN THANH';
if GI_ID = '8787608' then FacilityCommune = 'LONG THANG';
if GI_ID = '8989304' then FacilityCommune = 'MY HOI DONG';
if GI_ID = '9189912' then FacilityCommune = 'PHI THONG';
if GI_ID = '9189913' then FacilityCommune = 'RACH SOI';
if GI_ID = '9190618' then FacilityCommune = 'HA THUAN';
if GI_ID = '9191004' then FacilityCommune = 'BINH MINH';
if GI_ID = '9191102' then FacilityCommune = 'AN THOI';
if GI_ID = '92918a' then GI_FacType = 9;
if GI_ID = '92924a' then GI_FacType = 9;
if GI_ID = '9393001' then FacilityCommune = 'PHUONG 1';
if GI_ID = '9393002' then FacilityCommune = 'PHUONG 3';
if GI_ID = '9393003' then FacilityCommune = 'PHUONG 4';
if GI_ID = '9393004' then FacilityCommune = 'PHUONG 5';
if GI_ID = '9393005' then FacilityCommune = 'PHUONG 7';
if GI_ID = '9696602' then FacilityCommune = 'KHANH AN';
if GI_ID = '0100706' then FacilityCommune = 'LE DAI HANH';
if GI_ID = '4849110' then FacilityCommune = 'HOA KHE';
if GI_ID = '4950408' then FacilityCommune = 'BHALEE';
if GI_ID = '58582a' then GI_FacType = 9;
if GI_ID = '6664320' then FacilityCommune = 'HOA KHANH';
if GI_ID = '6664410' then FacilityCommune = 'EA SIEN';
if GI_ID = '74725a' then GI_FacType = 9;
if GI_ID = '7573214' then FacilityCommune = 'XUAN LAP';
if GI_ID = '8383208' then FacilityCommune = 'TAN THIENG';
if GI_ID = '8383505' then FacilityCommune = 'PHU THUAN';
if GI_ID = '8383512' then FacilityCommune = 'THOI LAI';
if GI_ID = '8383516' then FacilityCommune = 'THANH TRI';
if GI_ID = '8383704' then FacilityCommune = 'QUOI DIEN';
if GI_ID = '8383805' then FacilityCommune = 'TAN PHU TAY';
if GI_ID = '8383807' then FacilityCommune = 'TAN THANH BINH';
if GI_ID = '8383810' then FacilityCommune = 'TAN THANH TAY';run;
/**********************************************************************************************/

/**********************************************************************************************/
*6. Transform character variables to numeric variables;
data datacheck1606;set datacheck1606;
CE_AgencyGovz	 =input(	CE_AgencyGov	 ,10.);
CE_AgencyIntezr	 =input(	CE_AgencyInter	 ,10.);
CE_AgencyNGOz	 =input(	CE_AgencyNGO	 ,10.);
CE_AgencyPrivzate	 =input(	CE_AgencyPrivate	 ,10.);
CE_AgencyProfezssion	 =input(	CE_AgencyProfession	 ,10.);
CE_CommAdolesceznt	 =input(	CE_CommAdolescent	 ,10.);
CE_CommCommunityz	 =input(	CE_CommCommunity	 ,10.);
CE_CommEthnicz	 =input(	CE_CommEthnic	 ,10.);
CE_CommKidz	 =input(	CE_CommKid	 ,10.);
CE_CommOthezr	 =input(	CE_CommOther	 ,10.);
CE_CommTraumza	 =input(	CE_CommTrauma	 ,10.);
CE_CommWomenz	 =input(	CE_CommWomen	 ,10.);
CE_EmployAgenzcy	 =input(	CE_EmployAgency	 ,10.);
CE_JudgeEducatzion	 =input(	CE_JudgeEducation	 ,10.);
CE_Leaderz	 =input(	CE_Leader	 ,10.);
CE_LocalAgzency	 =input(	CE_LocalAgency	 ,10.);
CE_OtherProzfession	 =input(	CE_OtherProfession	 ,10.);
CE_PoliceEduzcation	 =input(	CE_PoliceEducation	 ,10.);
CE_PrisonPsyczhosis	 =input(	CE_PrisonPsychosis	 ,10.);
CE_PrisonRetarzd	 =input(	CE_PrisonRetard	 ,10.);
CE_PrisonTreatz	 =input(	CE_PrisonTreat	 ,10.);
CE_Providerz	 =input(	CE_Provider	 ,10.);
CE_SchoolActzivity	 =input(	CE_SchoolActivity	 ,10.);
CE_SchoolStafzf	 =input(	CE_SchoolStaff	 ,10.);
CE_SchoolStaffzF	 =input(	CE_SchoolStaffF	 ,10.);
CE_SocialServicze	 =input(	CE_SocialService	 ,10.);
CE_Teacherz	 =input(	CE_Teacher	 ,10.);
CE_Traditiozn	 =input(	CE_Tradition	 ,10.);
CP_Participazte	 =input(	CP_Participate	 ,10.);
CP_Participatze13F5	 =input(	CP_Participate13F5	 ,10.);
FI_AntidepSpenzd	 =input(	FI_AntidepSpend	 ,10.);
FI_InsurancePayz	 =input(	FI_InsurancePay	 ,10.);
FI_RevOtherz	 =input(	FI_RevOther	 ,10.);
GI_Clientsz	 =input(	GI_Clients	 ,10.);
GI_FacTypez	 =input(	GI_FacType	 ,10.);
GI_IntegratzeFac	 =input(	GI_IntegrateFac	 ,10.);
GI_Managez	 =input(	GI_Manage	 ,10.);
GI_ServicezType	 =input(	GI_ServiceType	 ,10.);
HR_AbroadPz	 =input(	HR_AbroadP	 ,10.);
HR_ActivityzClubF	 =input(	HR_ActivityClubF	 ,10.);
HR_ActivityCzlubP	 =input(	HR_ActivityClubP	 ,10.);
HR_Clubz	 =input(	HR_Club	 ,10.);
HR_InterzactClubF	 =input(	HR_InteractClubF	 ,10.);
HR_InterazctClubP	 =input(	HR_InteractClubP	 ,10.);
HR_NGOCommzunication	 =input(	HR_NGOCommunication	 ,10.);
HR_NGOServizce	 =input(	HR_NGOService	 ,10.);
HR_PolicyCluzbF	 =input(	HR_PolicyClubF	 ,10.);
HR_PolicyClubzP	 =input(	HR_PolicyClubP	 ,10.);
HR_PsyDeptInChzarge	 =input(	HR_PsyDeptInCharge	 ,10.);
HR_SupportClubFz	 =input(	HR_SupportClubF	 ,10.);
HR_SupportClubPz	 =input(	HR_SupportClubP	 ,10.);
MR_Bedz	 =input(	MR_Bed	 ,10.);
MR_Confzined	 =input(	MR_Confined	 ,10.);
MR_DOHz	 =input(	MR_DOH	 ,10.);
MR_DOLIzSA	 =input(	MR_DOLISA	 ,10.);
MR_DataOzther	 =input(	MR_DataOther	 ,10.);
MR_Diagnozse	 =input(	MR_Diagnose	 ,10.);
MR_ExamTimzes	 =input(	MR_ExamTimes	 ,10.);
MR_Formz	 =input(	MR_Form	 ,10.);
MR_Inpatzient	 =input(	MR_Inpatient	 ,10.);
MR_Involuzntary	 =input(	MR_Involuntary	 ,10.);
MR_LOSz	 =input(	MR_LOS	 ,10.);
MR_MOLIzSA	 =input(	MR_MOLISA	 ,10.);
MR_MSAz	 =input(	MR_MSA	 ,10.);
MR_NPHz	 =input(	MR_NPH	 ,10.);
MR_PCDCz	 =input(	MR_PCDC	 ,10.);
MR_PGHz	 =input(	MR_PGH	 ,10.);
MR_PHCz	 =input(	MR_PHC	 ,10.);
MR_PPHz	 =input(	MR_PPH	 ,10.);
MR_PPSz	 =input(	MR_PPS	 ,10.);
MR_PttAzsFact	 =input(	MR_PttAsFact	 ,10.);
MR_PttAszPlan	 =input(	MR_PttAsPlan	 ,10.);
MR_PttTrezat	 =input(	MR_PttTreat	 ,10.);
MR_RepOthezr	 =input(	MR_RepOther	 ,10.);
MR_ReportGozv13	 =input(	MR_ReportGov13	 ,10.);
MR_ResearchTzopic1	 =input(	MR_ResearchTopic1	 ,10.);
MR_ResearchTozpic2	 =input(	MR_ResearchTopic2	 ,10.);
MR_ResearchTopzic3	 =input(	MR_ResearchTopic3	 ,10.);
MR_ResearchTopizc4	 =input(	MR_ResearchTopic4	 ,10.);
MR_ResearchTopicz5	 =input(	MR_ResearchTopic5	 ,10.);
MR_ResearchTopic6z	 =input(	MR_ResearchTopic6	 ,10.);
MR_ResearchTopic7z	 =input(	MR_ResearchTopic7	 ,10.);
MR_ResearchTopic8z	 =input(	MR_ResearchTopic8	 ,10.);
MR_ResearchTopic99z	 =input(	MR_ResearchTopic99	 ,10.);
MR_Supervise13z	 =input(	MR_Supervise13	 ,10.);
OS_CliEmergencyz	 =input(	OS_CliEmergency	 ,10.);
OS_CliFemalez	 =input(	OS_CliFemale	 ,10.);
OS_CliForensizc	 =input(	OS_CliForensic	 ,10.);
OS_CliInfectiozn	 =input(	OS_CliInfection	 ,10.);
OS_CliMalez	 =input(	OS_CliMale	 ,10.);
OS_CliNutriztion	 =input(	OS_CliNutrition	 ,10.);
OS_CliOtherz	 =input(	OS_CliOther	 ,10.);
OS_CliOutpatzient	 =input(	OS_CliOutpatient	 ,10.);
OS_CliPediatrzic	 =input(	OS_CliPediatric	 ,10.);
OS_CliRehabz	 =input(	OS_CliRehab	 ,10.);
OS_CliSubstaznce	 =input(	OS_CliSubstance	 ,10.);
OS_CliTraditizon	 =input(	OS_CliTradition	 ,10.);
OS_CliTreatRehzab	 =input(	OS_CliTreatRehab	 ,10.);
OS_DeptAdminz	 =input(	OS_DeptAdmin	 ,10.);
OS_DeptCommunzity	 =input(	OS_DeptCommunity	 ,10.);
OS_DeptEquipmeznt	 =input(	OS_DeptEquipment	 ,10.);
OS_DeptFinancez	 =input(	OS_DeptFinance	 ,10.);
OS_DeptMedicinez	 =input(	OS_DeptMedicine	 ,10.);
OS_DeptNursingz	 =input(	OS_DeptNursing	 ,10.);
OS_DeptOtherz	 =input(	OS_DeptOther	 ,10.);
OS_DeptPersonznel	 =input(	OS_DeptPersonnel	 ,10.);
OS_DeptPlanz	 =input(	OS_DeptPlan	 ,10.);
OS_DeptReseazrch	 =input(	OS_DeptResearch	 ,10.);
OS_DeptTrainizng	 =input(	OS_DeptTraining	 ,10.);
OS_PCliImagingz	 =input(	OS_PCliImaging	 ,10.);
OS_PCliInfectiozn	 =input(	OS_PCliInfection	 ,10.);
OS_PCliOtherz	 =input(	OS_PCliOther	 ,10.);
OS_PCliPharmaz	 =input(	OS_PCliPharma	 ,10.);
OS_PCliTestingz	 =input(	OS_PCliTesting	 ,10.);
PL_Antidep1z	 =input(	PL_Antidep1	 ,10.);
PL_Antidep2z	 =input(	PL_Antidep2	 ,10.);
PL_Antiepi1z	 =input(	PL_Antiepi1	 ,10.);
PL_Antiepi2z	 =input(	PL_Antiepi2	 ,10.);
PL_Antipsy1z	 =input(	PL_Antipsy1	 ,10.);
PL_Antipsy2z	 =input(	PL_Antipsy2	 ,10.);
PL_Anxio1z	 =input(	PL_Anxio1	 ,10.);
PL_Anxio2z	 =input(	PL_Anxio2	 ,10.);
PL_CurAchizeve	 =input(	PL_CurAchieve	 ,10.);
PL_CurBudgezt	 =input(	PL_CurBudget	 ,10.);
PL_CurGoalz	 =input(	PL_CurGoal	 ,10.);
PL_CurTimez	 =input(	PL_CurTime	 ,10.);
PL_Disasterz	 =input(	PL_Disaster	 ,10.);
PL_HRAgencyz	 =input(	PL_HRAgency	 ,10.);
PL_HRTraininzg	 =input(	PL_HRTraining	 ,10.);
PL_Legalz	 =input(	PL_Legal	 ,10.);
PL_Legal1z	 =input(	PL_Legal1	 ,10.);
PL_Legal2z	 =input(	PL_Legal2	 ,10.);
PL_Legal3z	 =input(	PL_Legal3	 ,10.);
PL_Legal4z	 =input(	PL_Legal4	 ,10.);
PL_Legal5z	 =input(	PL_Legal5	 ,10.);
PL_Legal6z	 =input(	PL_Legal6	 ,10.);
PL_Legal7z	 =input(	PL_Legal7	 ,10.);
PL_Legal8z	 =input(	PL_Legal8	 ,10.);
PL_Legal9z	 =input(	PL_Legal9	 ,10.);
PL_Moodz	 =input(	PL_Mood	 ,10.);
PL_Planz	 =input(	PL_Plan	 ,10.);
PL_Plan1z	 =input(	PL_Plan1	 ,10.);
PL_Plan2z	 =input(	PL_Plan2	 ,10.);
PL_Plan3z	 =input(	PL_Plan3	 ,10.);
PL_Plan4z	 =input(	PL_Plan4	 ,10.);
PL_Plan5z	 =input(	PL_Plan5	 ,10.);
PL_Plan6z	 =input(	PL_Plan6	 ,10.);
PL_Plan7z	 =input(	PL_Plan7	 ,10.);
PL_Plan8z	 =input(	PL_Plan8	 ,10.);
PL_Plan9z	 =input(	PL_Plan9	 ,10.);
PL_Plan10z	 =input(	PL_Plan10	 ,10.);
PL_Plan11z	 =input(	PL_Plan11	 ,10.);
PL_Plan12z	 =input(	PL_Plan12	 ,10.);
PL_Plan13z	 =input(	PL_Plan13	 ,10.);
PL_PlanOthzer	 =input(	PL_PlanOther	 ,10.);
PL_Policyz	 =input(	PL_Policy	 ,10.);
PL_Policy1z	 =input(	PL_Policy1	 ,10.);
PL_Policy2z	 =input(	PL_Policy2	 ,10.);
PL_Policy3z	 =input(	PL_Policy3	 ,10.);
PL_Policy4z	 =input(	PL_Policy4	 ,10.);
PL_Policy5z	 =input(	PL_Policy5	 ,10.);
PL_Policy6z	 =input(	PL_Policy6	 ,10.);
PL_Policy7z	 =input(	PL_Policy7	 ,10.);
PL_Policy8z	 =input(	PL_Policy8	 ,10.);
PL_Policy9z	 =input(	PL_Policy9	 ,10.);
PL_Policy10z	 =input(	PL_Policy10	 ,10.);
PL_Policy11z	 =input(	PL_Policy11	 ,10.);
PL_Policy12z	 =input(	PL_Policy12	 ,10.);
PL_PolicyOthzer	 =input(	PL_PolicyOther	 ,10.);
PL_Psymedz	 =input(	PL_Psymed	 ,10.);
PR_GuidanczeF5	 =input(	PR_GuidanceF5	 ,10.);
PR_InteractzTradMed	 =input(	PR_InteractTradMed	 ,10.);
PR_Prescribez	 =input(	PR_Prescribe	 ,10.);
PR_TransferF5z	 =input(	PR_TransferF5	 ,10.);
SV_Antidepresszant	 =input(	SV_Antidepressant	 ,10.);
SV_Antiepileptizc	 =input(	SV_Antiepileptic	 ,10.);
SV_Antipsychoticz	 =input(	SV_Antipsychotic	 ,10.);
SV_Anxiolyticzz	 =input(	SV_Anxiolytic	 ,10.);
SV_CommunityF7zz	 =input(	SV_CommunityF7	 ,10.);
SV_CommunityF7Nzzum	 =input(	SV_CommunityF7Num	 ,10.);
SV_CoopCommzz	 =input(	SV_CoopComm	 ,10.);
SV_CoopFacilzzity	 =input(	SV_CoopFacility	 ,10.);
SV_CoopInpF7z	 =input(	SV_CoopInpF7	 ,10.);
SV_CoopOutpF7z	 =input(	SV_CoopOutpF7	 ,10.);
SV_DieF7z	 =input(	SV_DieF7	 ,10.);
SV_DieF7Nzum	 =input(	SV_DieF7Num	 ,10.);
SV_ExamF7z	 =input(	SV_ExamF7	 ,10.);
SV_ExamSerzvice	 =input(	SV_ExamService	 ,10.);
SV_ExamTreaztDept	 =input(	SV_ExamTreatDept	 ,10.);
SV_ExamTreatzFreq	 =input(	SV_ExamTreatFreq	 ,10.);
SV_ExamTreatSzervice	 =input(	SV_ExamTreatService	 ,10.);
SV_FrsProvincezAgency	 =input(	SV_FrsProvinceAgency	 ,10.);
SV_ManageF7z	 =input(	SV_ManageF7	 ,10.);
SV_ManageOcczuF7	 =input(	SV_ManageOccuF7	 ,10.);
SV_ManageOthezrF7	 =input(	SV_ManageOtherF7	 ,10.);
SV_ManageSocSuzpportF7	 =input(	SV_ManageSocSupportF7	 ,10.);
SV_MinorUsez	 =input(	SV_MinorUse	 ,10.);
SV_MoTeamz	 =input(	SV_MoTeam	 ,10.);
SV_MoodStazble	 =input(	SV_MoodStable	 ,10.);
SV_OccuTherzapyF7	 =input(	SV_OccuTherapyF7	 ,10.);
SV_OutpatienztKid	 =input(	SV_OutpatientKid	 ,10.);
SV_Privatez	 =input(	SV_Private	 ,10.);
SV_PrivateBzed	 =input(	SV_PrivateBed	 ,10.);
SV_PrivateExzam	 =input(	SV_PrivateExam	 ,10.);
SV_PrivateWaizt	 =input(	SV_PrivateWait	 ,10.);
SV_ProjectMedz	 =input(	SV_ProjectMed	 ,10.);
SV_PsyTherapyPz	 =input(	SV_PsyTherapyP	 ,10.);
SV_PsytherapyF7z	 =input(	SV_PsytherapyF7	 ,10.);
SV_RehabF7z	 =input(	SV_RehabF7	 ,10.);
SV_RestrainzP	 =input(	SV_RestrainP	 ,10.);
SV_RuralUsez	 =input(	SV_RuralUse	 ,10.);
SV_ServiceOtzherF7	 =input(	SV_ServiceOtherF7	 ,10.);
SV_SocialSuppzortF7	 =input(	SV_SocialSupportF7	 ,10.);
SV_StratMinorz	 =input(	SV_StratMinor	 ,10.);
SV_TreatServicze	 =input(	SV_TreatService	 ,10.);
SV_TreatmentF7z	 =input(	SV_TreatmentF7	 ,10.);
drop 
CE_AgencyGov
CE_AgencyInter
CE_AgencyNGO
CE_AgencyPrivate
CE_AgencyProfession
CE_CommAdolescent
CE_CommCommunity
CE_CommEthnic
CE_CommKid
CE_CommOther
CE_CommTrauma
CE_CommWomen
CE_EmployAgency
CE_JudgeEducation
CE_Leader
CE_LocalAgency
CE_OtherProfession
CE_PoliceEducation
CE_PrisonPsychosis
CE_PrisonRetard
CE_PrisonTreat
CE_Provider
CE_SchoolActivity
CE_SchoolStaff
CE_SchoolStaffF
CE_SocialService
CE_Teacher
CE_Tradition
CP_Participate
CP_Participate13F5
FI_AntidepSpend
FI_InsurancePay
FI_RevOther
GI_Clients
GI_FacType
GI_IntegrateFac
GI_Manage
GI_ServiceType
HR_AbroadP
HR_ActivityClubF
HR_ActivityClubP
HR_Club
HR_InteractClubF
HR_InteractClubP
HR_NGOCommunication
HR_NGOService
HR_PolicyClubF
HR_PolicyClubP
HR_PsyDeptInCharge
HR_SupportClubF
HR_SupportClubP
MR_Bed
MR_Confined
MR_DOH
MR_DOLISA
MR_DataOther
MR_Diagnose
MR_ExamTimes
MR_Form
MR_Inpatient
MR_Involuntary
MR_LOS
MR_MOLISA
MR_MSA
MR_NPH
MR_PCDC
MR_PGH
MR_PHC
MR_PPH
MR_PPS
MR_PttAsFact
MR_PttAsPlan
MR_PttTreat
MR_RepOther
MR_ReportGov13
MR_ResearchTopic1
MR_ResearchTopic2
MR_ResearchTopic3
MR_ResearchTopic4
MR_ResearchTopic5
MR_ResearchTopic6
MR_ResearchTopic7
MR_ResearchTopic8
MR_ResearchTopic99
MR_Supervise13
OS_CliEmergency
OS_CliFemale
OS_CliForensic
OS_CliInfection
OS_CliMale
OS_CliNutrition
OS_CliOther
OS_CliOutpatient
OS_CliPediatric
OS_CliRehab
OS_CliSubstance
OS_CliTradition
OS_CliTreatRehab
OS_DeptAdmin
OS_DeptCommunity
OS_DeptEquipment
OS_DeptFinance
OS_DeptMedicine
OS_DeptNursing
OS_DeptOther
OS_DeptPersonnel
OS_DeptPlan
OS_DeptResearch
OS_DeptTraining
OS_PCliImaging
OS_PCliInfection
OS_PCliOther
OS_PCliPharma
OS_PCliTesting
PL_Antidep1
PL_Antidep2
PL_Antiepi1
PL_Antiepi2
PL_Antipsy1
PL_Antipsy2
PL_Anxio1
PL_Anxio2
PL_CurAchieve
PL_CurBudget
PL_CurGoal
PL_CurTime
PL_Disaster
PL_HRAgency
PL_HRTraining
PL_Legal
PL_Legal1
PL_Legal2
PL_Legal3
PL_Legal4
PL_Legal5
PL_Legal6
PL_Legal7
PL_Legal8
PL_Legal9
PL_Mood
PL_Plan
PL_Plan1
PL_Plan2
PL_Plan3
PL_Plan4
PL_Plan5
PL_Plan6
PL_Plan7
PL_Plan8
PL_Plan9
PL_Plan10
PL_Plan11
PL_Plan12
PL_Plan13
PL_PlanOther
PL_Policy
PL_Policy1
PL_Policy2
PL_Policy3
PL_Policy4
PL_Policy5
PL_Policy6
PL_Policy7
PL_Policy8
PL_Policy9
PL_Policy10
PL_Policy11
PL_Policy12
PL_PolicyOther
PL_Psymed
PR_GuidanceF5
PR_InteractTradMed
PR_Prescribe
PR_TransferF5
SV_Antidepressant
SV_Antiepileptic
SV_Antipsychotic
SV_Anxiolytic
SV_CommunityF7
SV_CommunityF7Num
SV_CoopComm
SV_CoopFacility
SV_CoopInpF7
SV_CoopOutpF7
SV_DieF7
SV_DieF7Num
SV_ExamF7
SV_ExamService
SV_ExamTreatDept
SV_ExamTreatFreq
SV_ExamTreatService
SV_FrsProvinceAgency
SV_ManageF7
SV_ManageOccuF7
SV_ManageOtherF7
SV_ManageSocSupportF7
SV_MinorUse
SV_MoTeam
SV_MoodStable
SV_OccuTherapyF7
SV_OutpatientKid
SV_Private
SV_PrivateBed
SV_PrivateExam
SV_PrivateWait
SV_ProjectMed
SV_PsyTherapyP
SV_PsytherapyF7
SV_RehabF7
SV_RestrainP
SV_RuralUse
SV_ServiceOtherF7
SV_SocialSupportF7
SV_StratMinor
SV_TreatService
SV_TreatmentF7;
rename
GI_Managez = GI_Manage
CE_AgencyGovz	 =	CE_AgencyGov
CE_AgencyIntezr	 =	CE_AgencyInter
CE_AgencyNGOz	 =	CE_AgencyNGO
CE_AgencyPrivzate	 =	CE_AgencyPrivate
CE_AgencyProfezssion	 =	CE_AgencyProfession
CE_CommAdolesceznt	 =	CE_CommAdolescent
CE_CommCommunityz	 =	CE_CommCommunity
CE_CommEthnicz	 =	CE_CommEthnic
CE_CommKidz	 =	CE_CommKid
CE_CommOthezr	 =	CE_CommOther
CE_CommTraumza	 =	CE_CommTrauma
CE_CommWomenz	 =	CE_CommWomen
CE_EmployAgenzcy	 =	CE_EmployAgency
CE_JudgeEducatzion	 =	CE_JudgeEducation
CE_Leaderz	 =	CE_Leader
CE_LocalAgzency	 =	CE_LocalAgency
CE_OtherProzfession	 =	CE_OtherProfession
CE_PoliceEduzcation	 =	CE_PoliceEducation
CE_PrisonPsyczhosis	 =	CE_PrisonPsychosis
CE_PrisonRetarzd	 =	CE_PrisonRetard
CE_PrisonTreatz	 =	CE_PrisonTreat
CE_Providerz	 =	CE_Provider
CE_SchoolActzivity	 =	CE_SchoolActivity
CE_SchoolStafzf	 =	CE_SchoolStaff
CE_SchoolStaffzF	 =	CE_SchoolStaffF
CE_SocialServicze	 =	CE_SocialService
CE_Teacherz	 =	CE_Teacher
CE_Traditiozn	 =	CE_Tradition
CP_Participazte	 =	CP_Participate
CP_Participatze13F5	 =	CP_Participate13F5
FI_AntidepSpenzd	 =	FI_AntidepSpend
FI_InsurancePayz	 =	FI_InsurancePay
FI_RevOtherz	 =	FI_RevOther
GI_Clientsz	 =	GI_Clients
GI_FacTypez	 =	GI_FacType
GI_IntegratzeFac	 =	GI_IntegrateFac
GI_Managez	 =	GI_Manage
GI_ServicezType	 =	GI_ServiceType
HR_AbroadPz	 =	HR_AbroadP
HR_ActivityzClubF	 =	HR_ActivityClubF
HR_ActivityCzlubP	 =	HR_ActivityClubP
HR_Clubz	 =	HR_Club
HR_InterzactClubF	 =	HR_InteractClubF
HR_InterazctClubP	 =	HR_InteractClubP
HR_NGOCommzunication	 =	HR_NGOCommunication
HR_NGOServizce	 =	HR_NGOService
HR_PolicyCluzbF	 =	HR_PolicyClubF
HR_PolicyClubzP	 =	HR_PolicyClubP
HR_PsyDeptInChzarge	 =	HR_PsyDeptInCharge
HR_SupportClubFz	 =	HR_SupportClubF
HR_SupportClubPz	 =	HR_SupportClubP
MR_Bedz	 =	MR_Bed
MR_Confzined	 =	MR_Confined
MR_DOHz	 =	MR_DOH
MR_DOLIzSA	 =	MR_DOLISA
MR_DataOzther	 =	MR_DataOther
MR_Diagnozse	 =	MR_Diagnose
MR_ExamTimzes	 =	MR_ExamTimes
MR_Formz	 =	MR_Form
MR_Inpatzient	 =	MR_Inpatient
MR_Involuzntary	 =	MR_Involuntary
MR_LOSz	 =	MR_LOS
MR_MOLIzSA	 =	MR_MOLISA
MR_MSAz	 =	MR_MSA
MR_NPHz	 =	MR_NPH
MR_PCDCz	 =	MR_PCDC
MR_PGHz	 =	MR_PGH
MR_PHCz	 =	MR_PHC
MR_PPHz	 =	MR_PPH
MR_PPSz	 =	MR_PPS
MR_PttAzsFact	 =	MR_PttAsFact
MR_PttAszPlan	 =	MR_PttAsPlan
MR_PttTrezat	 =	MR_PttTreat
MR_RepOthezr	 =	MR_RepOther
MR_ReportGozv13	 =	MR_ReportGov13
MR_ResearchTzopic1	 =	MR_ResearchTopic1
MR_ResearchTozpic2	 =	MR_ResearchTopic2
MR_ResearchTopzic3	 =	MR_ResearchTopic3
MR_ResearchTopizc4	 =	MR_ResearchTopic4
MR_ResearchTopicz5	 =	MR_ResearchTopic5
MR_ResearchTopic6z	 =	MR_ResearchTopic6
MR_ResearchTopic7z	 =	MR_ResearchTopic7
MR_ResearchTopic8z	 =	MR_ResearchTopic8
MR_ResearchTopic99z	 =	MR_ResearchTopic99
MR_Supervise13z	 =	MR_Supervise13
OS_CliEmergencyz	 =	OS_CliEmergency
OS_CliFemalez	 =	OS_CliFemale
OS_CliForensizc	 =	OS_CliForensic
OS_CliInfectiozn	 =	OS_CliInfection
OS_CliMalez	 =	OS_CliMale
OS_CliNutriztion	 =	OS_CliNutrition
OS_CliOtherz	 =	OS_CliOther
OS_CliOutpatzient	 =	OS_CliOutpatient
OS_CliPediatrzic	 =	OS_CliPediatric
OS_CliRehabz	 =	OS_CliRehab
OS_CliSubstaznce	 =	OS_CliSubstance
OS_CliTraditizon	 =	OS_CliTradition
OS_CliTreatRehzab	 =	OS_CliTreatRehab
OS_DeptAdminz	 =	OS_DeptAdmin
OS_DeptCommunzity	 =	OS_DeptCommunity
OS_DeptEquipmeznt	 =	OS_DeptEquipment
OS_DeptFinancez	 =	OS_DeptFinance
OS_DeptMedicinez	 =	OS_DeptMedicine
OS_DeptNursingz	 =	OS_DeptNursing
OS_DeptOtherz	 =	OS_DeptOther
OS_DeptPersonznel	 =	OS_DeptPersonnel
OS_DeptPlanz	 =	OS_DeptPlan
OS_DeptReseazrch	 =	OS_DeptResearch
OS_DeptTrainizng	 =	OS_DeptTraining
OS_PCliImagingz	 =	OS_PCliImaging
OS_PCliInfectiozn	 =	OS_PCliInfection
OS_PCliOtherz	 =	OS_PCliOther
OS_PCliPharmaz	 =	OS_PCliPharma
OS_PCliTestingz	 =	OS_PCliTesting
PL_Antidep1z	 =	PL_Antidep1
PL_Antidep2z	 =	PL_Antidep2
PL_Antiepi1z	 =	PL_Antiepi1
PL_Antiepi2z	 =	PL_Antiepi2
PL_Antipsy1z	 =	PL_Antipsy1
PL_Antipsy2z	 =	PL_Antipsy2
PL_Anxio1z	 =	PL_Anxio1
PL_Anxio2z	 =	PL_Anxio2
PL_CurAchizeve	 =	PL_CurAchieve
PL_CurBudgezt	 =	PL_CurBudget
PL_CurGoalz	 =	PL_CurGoal
PL_CurTimez	 =	PL_CurTime
PL_Disasterz	 =	PL_Disaster
PL_HRAgencyz	 =	PL_HRAgency
PL_HRTraininzg	 =	PL_HRTraining
PL_Legalz	 =	PL_Legal
PL_Legal1z	 =	PL_Legal1
PL_Legal2z	 =	PL_Legal2
PL_Legal3z	 =	PL_Legal3
PL_Legal4z	 =	PL_Legal4
PL_Legal5z	 =	PL_Legal5
PL_Legal6z	 =	PL_Legal6
PL_Legal7z	 =	PL_Legal7
PL_Legal8z	 =	PL_Legal8
PL_Legal9z	 =	PL_Legal9
PL_Moodz	 =	PL_Mood
PL_Planz	 =	PL_Plan
PL_Plan1z	 =	PL_Plan1
PL_Plan2z	 =	PL_Plan2
PL_Plan3z	 =	PL_Plan3
PL_Plan4z	 =	PL_Plan4
PL_Plan5z	 =	PL_Plan5
PL_Plan6z	 =	PL_Plan6
PL_Plan7z	 =	PL_Plan7
PL_Plan8z	 =	PL_Plan8
PL_Plan9z	 =	PL_Plan9
PL_Plan10z	 =	PL_Plan10
PL_Plan11z	 =	PL_Plan11
PL_Plan12z	 =	PL_Plan12
PL_Plan13z	 =	PL_Plan13
PL_PlanOthzer	 =	PL_PlanOther
PL_Policyz	 =	PL_Policy
PL_Policy1z	 =	PL_Policy1
PL_Policy2z	 =	PL_Policy2
PL_Policy3z	 =	PL_Policy3
PL_Policy4z	 =	PL_Policy4
PL_Policy5z	 =	PL_Policy5
PL_Policy6z	 =	PL_Policy6
PL_Policy7z	 =	PL_Policy7
PL_Policy8z	 =	PL_Policy8
PL_Policy9z	 =	PL_Policy9
PL_Policy10z	 =	PL_Policy10
PL_Policy11z	 =	PL_Policy11
PL_Policy12z	 =	PL_Policy12
PL_PolicyOthzer	 =	PL_PolicyOther
PL_Psymedz	 =	PL_Psymed
PR_GuidanczeF5	 =	PR_GuidanceF5
PR_InteractzTradMed	 =	PR_InteractTradMed
PR_Prescribez	 =	PR_Prescribe
PR_TransferF5z	 =	PR_TransferF5
SV_Antidepresszant	 =	SV_Antidepressant
SV_Antiepileptizc	 =	SV_Antiepileptic
SV_Antipsychoticz	 =	SV_Antipsychotic
SV_Anxiolyticzz	 =	SV_Anxiolytic
SV_CommunityF7zz	 =	SV_CommunityF7
SV_CommunityF7Nzzum	 =	SV_CommunityF7Num
SV_CoopCommzz	 =	SV_CoopComm
SV_CoopFacilzzity	 =	SV_CoopFacility
SV_CoopInpF7z	 =	SV_CoopInpF7
SV_CoopOutpF7z	 =	SV_CoopOutpF7
SV_DieF7z	 =	SV_DieF7
SV_DieF7Nzum	 =	SV_DieF7Num
SV_ExamF7z	 =	SV_ExamF7
SV_ExamSerzvice	 =	SV_ExamService
SV_ExamTreaztDept	 =	SV_ExamTreatDept
SV_ExamTreatzFreq	 =	SV_ExamTreatFreq
SV_ExamTreatSzervice	 =	SV_ExamTreatService
SV_FrsProvincezAgency	 =	SV_FrsProvinceAgency
SV_ManageF7z	 =	SV_ManageF7
SV_ManageOcczuF7	 =	SV_ManageOccuF7
SV_ManageOthezrF7	 =	SV_ManageOtherF7
SV_ManageSocSuzpportF7	 =	SV_ManageSocSupportF7
SV_MinorUsez	 =	SV_MinorUse
SV_MoTeamz	 =	SV_MoTeam
SV_MoodStazble	 =	SV_MoodStable
SV_OccuTherzapyF7	 =	SV_OccuTherapyF7
SV_OutpatienztKid	 =	SV_OutpatientKid
SV_Privatez	 =	SV_Private
SV_PrivateBzed	 =	SV_PrivateBed
SV_PrivateExzam	 =	SV_PrivateExam
SV_PrivateWaizt	 =	SV_PrivateWait
SV_ProjectMedz	 =	SV_ProjectMed
SV_PsyTherapyPz	 =	SV_PsyTherapyP
SV_PsytherapyF7z	 =	SV_PsytherapyF7
SV_RehabF7z	 =	SV_RehabF7
SV_RestrainzP	 =	SV_RestrainP
SV_RuralUsez	 =	SV_RuralUse
SV_ServiceOtzherF7	 =	SV_ServiceOtherF7
SV_SocialSuppzortF7	 =	SV_SocialSupportF7
SV_StratMinorz	 =	SV_StratMinor
SV_TreatServicze	 =	SV_TreatService
SV_TreatmentF7z	 =	SV_TreatmentF7;
run;


***Assigning missing values to "Data not available"***;
data datacheck1706;set datacheck1606;
array nodata
CE_AgencyGov
CE_AgencyInter
CE_AgencyNGO
CE_AgencyPrivate
CE_AgencyProfession
CE_CommAdolescent
CE_CommCommunity
CE_CommEthnic
CE_CommKid
CE_CommOther
CE_CommTrauma
CE_CommWomen
CE_EmployAgency
CE_JudgeEducation
CE_Leader
CE_LocalAgency
CE_OtherProfession
CE_PoliceEducation
CE_PrisonPsychosis
CE_PrisonRetard
CE_PrisonTreat
CE_Provider
CE_SchoolActivity
CE_SchoolStaff
CE_SchoolStaffF
CE_SocialService
CE_Teacher
CE_TotalSchool
CE_Tradition
CP_AggressivePatient
CP_DangerousPatient
CP_DepressionPatientF54
CP_EpilepsyPatientF54
CP_OtherModel
CP_OtherPatientF54
CP_Participate
CP_Participate13F5
CP_ParticipateYrF5
CP_Patient13F54
CP_PatientDrop
CP_ProjDepressionPatient
CP_ProjDepressionSite
CP_ProjEpilepsyPatient
CP_ProjEpilepsySite
CP_ProjSchizoEpi
CP_ProjSchizoEpiA
CP_ProjSchizoEpiB
CP_ProjSchizoPatient
CP_ProjSchizoSite
CP_ProjSite
CP_SchizoPatientF54
FI_AbroadDonor
FI_AntidepSpend
FI_AntipsySpend
FI_ExpenseGovHlth
FI_ExpenseGovSS
FI_Families
FI_InsurancePay
FI_Labor
FI_MHSpend13
FI_NationalDonor
FI_OOPPay
FI_Project13
FI_ProjectGov
FI_ProjectProv
FI_RevByFacility
FI_RevDonor
FI_RevGovernment
FI_RevInsurance
FI_RevOOP
FI_RevOther
FI_RevProvince
FI_SpendAdmin
FI_SpendBenefi
FI_SpendMed
FI_SpendOther
FI_SpendProfession
FI_SpendSalary
FI_SubsidyF7
FI_SubsidyFactF7
FI_SubsidyPlanF7
FI_TotalRev
FI_TotalSpend
GI_Clients
GI_Commune
GI_Districts
GI_Eco
GI_FacType
GI_IntegrateFac
GI_Manage
GI_Population
GI_ServiceType
HR_AbroadF
HR_AbroadP
HR_ActivityClubF
HR_ActivityClubP
HR_Club
HR_ClubFamily
HR_ClubPatient
HR_DocAssistF5
HR_InteractClubF
HR_InteractClubP
HR_Midwives
HR_NGOCommunication
HR_NGOService
HR_Nurse
HR_Occupation
HR_OtherDocs
HR_PharmaSecond
HR_PharmaUni
HR_PolicyClubF
HR_PolicyClubP
HR_PsyDeptInCharge
HR_PsyDeptStaff
HR_PsyNurse
HR_Psychiatrist
HR_Psychologist
HR_SocWorker
HR_StaffOthr
HR_SupportClubF
HR_SupportClubP
HR_Technician
HR_TotalStaff
HR_TradMed
HR_TrainDrug
HR_TrainDrugA
HR_TrainDrugAF5
HR_TrainDrugB
HR_TrainDrugBF5
HR_TrainDrugC
HR_TrainDrugCF5
HR_TrainDrugD
HR_TrainDrugDF5
HR_TrainDrugE
HR_TrainDrugEF5
HR_TrainDrugF5
HR_TrainKid
HR_TrainKidA
HR_TrainKidAF5
HR_TrainKidB
HR_TrainKidBF5
HR_TrainKidC
HR_TrainKidCF5
HR_TrainKidD
HR_TrainKidDF5
HR_TrainKidE
HR_TrainKidEF5
HR_TrainKidF5
HR_TrainSocPsy
HR_TrainSocPsyA
HR_TrainSocPsyAF5
HR_TrainSocPsyB
HR_TrainSocPsyBF5
HR_TrainSocPsyC
HR_TrainSocPsyCF5
HR_TrainSocPsyD
HR_TrainSocPsyDF5
HR_TrainSocPsyE
HR_TrainSocPsyEF5
HR_TrainSocPsyF5
MR_Bed
MR_Confined
MR_DOH
MR_DOLISA
MR_DataOther
MR_Diagnose
MR_ExamTimes
MR_Form
MR_Inpatient
MR_Involuntary
MR_LOS
MR_MOLISA
MR_MSA
MR_NPH
MR_PCDC
MR_PGH
MR_PHC
MR_PPH
MR_PPS
MR_PttAsFact
MR_PttAsPlan
MR_PttTreat
MR_Regular1
MR_Regular2
MR_Regular3
MR_Regular4
MR_Regular5
MR_Regular99
MR_RepOther
MR_ReportGov13
MR_ResearchFac
MR_ResearchMinistry
MR_ResearchNational
MR_ResearchStaff
MR_ResearchStaffA
MR_ResearchStaffB
MR_ResearchStaffC
MR_ResearchStaffD
MR_ResearchStaffE
MR_ResearchStaffF
MR_ResearchTopic1
MR_ResearchTopic2
MR_ResearchTopic3
MR_ResearchTopic4
MR_ResearchTopic5
MR_ResearchTopic6
MR_ResearchTopic7
MR_ResearchTopic8
MR_ResearchTopic99
MR_Supervise13
MR_SuperviseAgency1
MR_SuperviseAgency2
MR_SuperviseAgency3
MR_SuperviseAgency4
MR_SuperviseAgency5
MR_SuperviseAgency6
MR_SuperviseAgency7
MR_SuperviseAgency8
MR_SuperviseAgency9
MR_SuperviseAgency99
MR_SuperviseContent1
MR_SuperviseContent2
MR_SuperviseContent3
MR_SuperviseContent4
MR_SuperviseContent99
OS_CliEmergency
OS_CliFemale
OS_CliForensic
OS_CliInfection
OS_CliMale
OS_CliNutrition
OS_CliOther
OS_CliOutpatient
OS_CliPediatric
OS_CliRehab
OS_CliSubstance
OS_CliTradition
OS_CliTreatRehab
OS_DeptAdmin
OS_DeptCommunity
OS_DeptEquipment
OS_DeptFinance
OS_DeptMedicine
OS_DeptNursing
OS_DeptOther
OS_DeptPersonnel
OS_DeptPlan
OS_DeptResearch
OS_DeptTraining
OS_PCliImaging
OS_PCliInfection
OS_PCliOther
OS_PCliPharma
OS_PCliTesting
OS_TotalDept
PL_Antidep1
PL_Antidep2
PL_Antiepi1
PL_Antiepi2
PL_Antipsy1
PL_Antipsy2
PL_Anxio1
PL_Anxio2
PL_CurAchieve
PL_CurBudget
PL_CurGoal
PL_CurTime
PL_Disaster
PL_HRAgency
PL_HRTraining
PL_Legal
PL_Legal1
PL_Legal2
PL_Legal3
PL_Legal4
PL_Legal5
PL_Legal6
PL_Legal7
PL_Legal8
PL_Legal9
PL_Mood
PL_Plan
PL_Plan1
PL_Plan2
PL_Plan3
PL_Plan4
PL_Plan5
PL_Plan6
PL_Plan7
PL_Plan8
PL_Plan9
PL_Plan10
PL_Plan11
PL_Plan12
PL_Plan13
PL_PlanOther
PL_Policy
PL_Policy1
PL_Policy2
PL_Policy3
PL_Policy4
PL_Policy5
PL_Policy6
PL_Policy7
PL_Policy8
PL_Policy9
PL_Policy10
PL_Policy11
PL_Policy12
PL_PolicyOther
PL_Psymed
PR_DocsTrainingF5
PR_GuidanceF5
PR_InteractMHPro1
PR_InteractMHPro2
PR_InteractMHPro3
PR_InteractMHPro4
PR_InteractMHPro5
PR_InteractMHPro6
PR_InteractMHPro99
PR_InteractTradMed
PR_NurseTrainingF5
PR_OtherTrainingF5
PR_Prescribe
PR_TransferF5
PR_WhoPrescribe1
PR_WhoPrescribe2
PR_WhoPrescribe3
PR_WhoPrescribe4
PR_WhoPrescribe99
SV_Antidepressant
SV_Antiepileptic
SV_Antipsychotic
SV_Anxiolytic
SV_BedFact09
SV_BedFact13
SV_BedKid
SV_BedPlan09
SV_BedPlan13
SV_BedorPttPlan13
SV_CommFreq1
SV_CommFreq2
SV_CommFreq3
SV_CommFreq4
SV_CommFreq5
SV_CommFreq6
SV_CommFreq99
SV_CommunityF7
SV_CommunityF7Num
SV_CoopComm
SV_CoopCommContent1
SV_CoopCommContent2
SV_CoopCommContent3
SV_CoopCommContent4
SV_CoopCommContent5
SV_CoopCommContent98
SV_CoopCommContent99
SV_CoopFacility
SV_CoopInpF7
SV_CoopOutpF7
SV_DieF7
SV_DieF7Num
SV_DirectAgency1
SV_DirectAgency2
SV_DirectAgency3
SV_DirectAgency4
SV_DirectAgency5
SV_DirectAgency6
SV_DirectAgency7
SV_DirectAgency8
SV_DirectAgency9
SV_DirectAgency99
SV_Discharge
SV_DownRef1
SV_DownRef2
SV_DownRef3
SV_DownRef4
SV_DownRef5
SV_DownRef6
SV_DownRef7
SV_DownRef98
SV_DownRef99
SV_ExamF7
SV_ExamFemale13
SV_ExamPatient13
SV_ExamService
SV_ExamTreatDept
SV_ExamTreatFreq
SV_ExamTreatService
SV_ExamTreatTimes
SV_F10
SV_F00F03
SV_F11F19
SV_F20F29
SV_F30F39
SV_F40F48
SV_F60F69
SV_F70F79
SV_FProvinceBed
SV_FProvinceBed1
SV_FProvinceBed2
SV_FProvinceBed3
SV_FProvinceBed4
SV_FProvinceBed5
SV_FProvinceBed6
SV_FemaleTreat13
SV_ForensicLoS
SV_ForensicLoS0
SV_ForensicLoS1
SV_ForensicLoS5
SV_ForensicLoS10
SV_ForensicMinistry
SV_FrsProvinceAgency
SV_G40G41
SV_ICD10
SV_ICD10Other
SV_Inp0
SV_Inp1
SV_Inp5
SV_Inp10
SV_Inpatient13
SV_Inpatient15
SV_Inpatient17
SV_InpatientFemale13
SV_InpatientLoS
SV_InpatientTime
SV_InvoluntaryAdmission
SV_ManageF7
SV_ManageOccuF7
SV_ManageOtherF7
SV_ManageSocSupportF7
SV_MinorUse
SV_MoComm1
SV_MoComm2
SV_MoComm3
SV_MoComm4
SV_MoComm5
SV_MoComm6
SV_MoComm99
SV_MoCoop1
SV_MoCoop2
SV_MoCoop3
SV_MoCoop4
SV_MoCoop5
SV_MoCoop6
SV_MoCoop7
SV_MoCoop8
SV_MoCoop9
SV_MoCoop99
SV_MoDist1
SV_MoDist2
SV_MoDist3
SV_MoDist4
SV_MoDist5
SV_MoDist6
SV_MoDist99
SV_MoHome1
SV_MoHome2
SV_MoHome3
SV_MoHome4
SV_MoHome5
SV_MoHome6
SV_MoHome99
SV_MoPlace1
SV_MoPlace2
SV_MoPlace3
SV_MoPlace4
SV_MoPlace5
SV_MoPlace99
SV_MoTeam
SV_MoVil1
SV_MoVil2
SV_MoVil3
SV_MoVil4
SV_MoVil5
SV_MoVil6
SV_MoVil99
SV_MoodStable
SV_OccuTherapyF7
SV_OutpatientKid
SV_Private
SV_PrivateBed
SV_PrivateExam
SV_PrivateWait
SV_ProjectMed
SV_PsyTherapyF
SV_PsyTherapyP
SV_PsytherapyF7
SV_PttTreat13
SV_RehabF7
SV_RestrainF
SV_RestrainP
SV_RuralUse
SV_ServiceOtherF7
SV_SocialSupportF7
SV_StratMinor
SV_TreatService
SV_TreatmentF7
SV_UpRef1
SV_UpRef2
SV_UpRef3
SV_UpRef4
SV_UpRef5
SV_UpRef6
SV_UpRef7
SV_UpRef8
SV_UpRef9
SV_UpRef10
SV_UpRef11
SV_UpRef98
SV_UpRef99;
do i=1 to 511;
if nodata[i] in (999999, 9999999, 99999999, 999999999) then nodata[i] = .;
end;drop i;run;
/**********************************************************************************************/

/**********************************************************************************************/
*7. Recalculate total values for continuous variables based on individual values;
data datacheck1706;set datacheck1706;
FI_TotalRevRecal=0;
array finance1
FI_RevGovernment
FI_RevProvince
FI_RevOOP
FI_RevInsurance
FI_RevDonor
FI_RevByFacility
FI_NationalDonor
FI_AbroadDonor
FI_Families
FI_Labor
FI_RevOther;
do i=1 to 11;
if finance1(i) ne . then FI_TotalRevRecal = FI_TotalRevRecal  + finance1(i);end;
if FI_TotalRev ne . then FI_TotalRevCheck = FI_TotalRevRecal - FI_TotalRev;

FI_Project13Recal=0;
array finance2
FI_ProjectGov
FI_ProjectProv;
do j=1 to 2;
if finance2(j) ne . then FI_Project13Recal = FI_Project13Recal + finance2(j);end;
if FI_Project13 ne . then FI_Project13Check = FI_Project13Recal - FI_Project13;

FI_TotalSpendRecal=0;
array finance3
FI_SpendSalary 
FI_SpendProfession
FI_SpendMed 
FI_SpendBenefi
FI_SpendOther;
do k=1 to 5;
if finance3(k) ne . then FI_TotalSpendRecal = FI_TotalSpendRecal + finance3(k);end;
if FI_TotalSpend ne . then FI_TotalSpendCheck = FI_TotalSpendRecal - FI_TotalSpend;

SV_ICD10Recal = 0;
array icd10
SV_G40G41 
SV_F00F03 
SV_F10 
SV_F11F19
SV_F20F29
SV_F30F39
SV_F40F48
SV_F60F69
SV_F70F79
SV_ICD10Other;
do l=1 to 10;
if icd10(l) ne . then SV_ICD10Recal = SV_ICD10Recal + icd10(l);end;
if SV_ICD10 ne . then SV_ICD10Check = SV_ICD10Recal - SV_ICD10;

SV_InpatientTimeRecal=0;
array inpatient
SV_Inp10
SV_Inp5
SV_Inp1
SV_Inp0;
do m=1 to 4;
if inpatient(m) ne . then SV_InpatientTimeRecal = SV_InpatientTimeRecal + inpatient(m);end;
if SV_InpatientTime ne . then SV_InpatientTimeCheck = SV_InpatientTimeRecal - SV_InpatientTime;

SV_FProvinceBedRecal=0;
array forenbed
SV_FProvinceBed1
SV_FProvinceBed2
SV_FProvinceBed3
SV_FProvinceBed4
SV_FProvinceBed5;
do n=1 to 5;
if forenbed(n) ne . then SV_FProvinceBedRecal = SV_FProvinceBedRecal + forenbed(n);end;
if SV_FProvinceBed ne . then SV_FProvinceBedCheck = SV_FProvinceBedRecal - SV_FProvinceBed;

SV_ForensicLoSRecal=0;
array forenlos
SV_ForensicLoS10
SV_ForensicLoS5 
SV_ForensicLoS1 
SV_ForensicLoS0;
do p=1 to (4);
if forenlos(p) ne . then SV_ForensicLoSRecal = SV_ForensicLoSRecal + forenlos(p);end;
if SV_ForensicLoS ne . then SV_ForensicLoSCheck = SV_ForensicLoSRecal - SV_ForensicLoS;

HR_StaffRecal=0;
array staff
HR_Psychiatrist
HR_OtherDocs
HR_Nurse
HR_PsyNurse
HR_Psychologist
HR_SocWorker
HR_Occupation
HR_PharmaUni
HR_PharmaSecond
HR_Midwives
HR_Technician
HR_TradMed
HR_StaffOthr;
do q = 1 to 13;
if staff(q) ne . then HR_StaffRecal = HR_StaffRecal + staff(q);end;
if HR_TotalStaff ne . then HR_TotalStaffCheck = HR_StaffRecal - HR_TotalStaff;

HR_TrainDrugRecal = 0;
array train1
HR_TrainDrugA
HR_TrainDrugB
HR_TrainDrugC
HR_TrainDrugD
HR_TrainDrugE;
do r = 1 to 5;
if train1(r) ne . then HR_TrainDrugRecal = HR_TrainDrugRecal + train1(r);end;
if HR_TrainDrug ne . then HR_TrainDrugCheck = HR_TrainDrugRecal - HR_TrainDrug;

HR_TrainSocPsyRecal=0;
array train2
HR_TrainSocPsyA
HR_TrainSocPsyB
HR_TrainSocPsyC
HR_TrainSocPsyD
HR_TrainSocPsyE;
do s = 1 to 5;
if train2(s) ne . then HR_TrainSocPsyRecal = HR_TrainSocPsyRecal + train2(s);end;
if HR_TrainSocPsy ne . then HR_TrainSocPsyCheck = HR_TrainSocPsyRecal - HR_TrainSocPsy;

HR_TrainKidRecal = 0;
array train3
HR_TrainKidA
HR_TrainKidB
HR_TrainKidC
HR_TrainKidD
HR_TrainKidE;
do t=1 to 5;
if train3(t) ne . then HR_TrainKidRecal = HR_TrainKidRecal + train3(t);end;
if HR_TrainKid ne . then HR_TrainKidCheck = HR_TrainKidRecal - HR_TrainKid;

MR_ResearchStaffRecal=0;
array research
MR_ResearchStaffA
MR_ResearchStaffB
MR_ResearchStaffC
MR_ResearchStaffD
MR_ResearchStaffE
MR_ResearchStaffF;
do u = 1 to 6;
if research(u) ne . then MR_ResearchStaffRecal = MR_ResearchStaffRecal + research(u);end;
if MR_ResearchStaff ne . then MR_ResearchStaffCheck = MR_ResearchStaffRecal - MR_ResearchStaff;

CP_Patient13F54Recal=0;
array patient54
CP_SchizoPatientF54
CP_EpilepsyPatientF54
CP_DepressionPatientF54
CP_OtherPatientF54;
do v = 1 to 4;
if patient54(v) ne . then CP_Patient13F54Recal = CP_Patient13F54Recal + patient54(v);end;
if CP_Patient13F54 ne . then CP_Patient13F54Check = CP_Patient13F54Recal - CP_Patient13F54;

CP_ProjSiteRecal=0;
array project
CP_ProjSchizoSite
CP_ProjEpilepsySite
CP_ProjDepressionSite
CP_ProjSchizoEpi
CP_OtherModel;
do w = 1 to 5;
if project(w) ne . then CP_ProjSiteRecal = CP_ProjSiteRecal + project(w);end;
if CP_ProjSite ne . then CP_ProjSiteCheck = CP_ProjSiteRecal - CP_ProjSite;
drop i j k l m n p q r s t u v w;run;

***Data check and editing;
data datacheck1706;set datacheck1706;
if GI_ID in ( '17156a'	, '34342a', '38392a', '40429a', '40430a', '70693a') then GI_FacType = 9;
if GI_ID='1210710' then delete;run;
if GI_ID='56785678' then FacilityCommune = 'THI TRAN THANH AN';
if GI_ID='3029801' then FacilityCommune = 'THI TRAN TU KY';
if GI_ID='9189913' then FacilityCommune = 'RACH SOI 1';
if GI_ID in ('66455a', 'X01c', '2018421', '108804', '3840724') then delete;run;
/**********************************************************************************************/

/**********************************************************************************************/
*8. Assign missing values based on presence of variables on questionnaires;
data data2306;set data1706;
if GI_FacType in (1, 2, 3, 4) then do;
GI_Clients	 =.;
GI_PopDistrict	 =.;
GI_PopCommune	 =.;
GI_HomeConfinedF5	 =.;
GI_IntegrateFac	 =.;
OS_DeptMedicine	 =.;
OS_DeptPersonAdmin	 =.;
OS_DeptOther5	 =.;
OS_CliTreatRehab	 =.;
FI_RevByFacility	 =.;
FI_NationalDonor	 =.;
FI_AbroadDonor	 =.;
FI_Families	 =.;
FI_Labor	 =.;
FI_ExpenseGovSS	 =.;
FI_MHSpend13	 =.;
FI_SpendBenefi	 =.;
FI_SpendAdmin	 =.;
FI_SubsidyF7	 =.;
FI_SubsidyPlanF7	 =.;
FI_SubsidyFactF7	 =.;
SV_CoopOutpF7	 =.;
SV_CoopInpF7	 =.;
SV_DirectAgency	 =.;
SV_ExamService	 =.;
SV_TreatService	 =.;
SV_ExamTreatDept	 =.;
SV_ExamTreatFreq	 =.;
SV_CoopComm	 =.;
SV_CoopCommContent	 =.;
SV_ExamTreatService	 =.;
SV_ExamTreatTimes	 =.;
SV_PttTreat13	 =.;
SV_FemaleTreat13	 =.;
SV_BedorPttPlan13	 =.;
SV_CareTreatFact13	 =.;
SV_CareTreat13Female	 =.;
SV_CommFreq	 =.;
SV_MoDist	 =.;
SV_MoComm	 =.;
SV_FrsProvinceAgency	 =.;
SV_ExamF7	 =.;
SV_TreatmentF7	 =.;
SV_PsytherapyF7	 =.;
SV_OccuTherapyF7	 =.;
SV_RehabF7	 =.;
SV_SocialSupportF7	 =.;
SV_ServiceOtherF7	 =.;
SV_ServiceOtherSpecF7	 =.;
SV_ManageF7	 =.;
SV_ManageOccuF7	 =.;
SV_ManageSocSupportF7	 =.;
SV_ManageOtherF7	 =.;
SV_ManageOtherSpecF7	 =.;
SV_CommunityF7	 =.;
SV_DieF7	 =.;
SV_AvaiDrug1	 =.;
SV_AvaiDrug2	 =.;
SV_AvaiDrug3	 =.;
SV_AvaiDrug4	 =.;
SV_AvaiDrug5	 =.;
SV_RuralUse	 =.;
SV_StratMinor	 =.;
PR_GuidanceF5	 =.;
PR_DocsTrainingF5	 =.;
PR_NurseTrainingF5	 =.;
PR_OtherTrainingF5	 =.;
PR_TransferF5	 =.;
PR_InteractMHPro	 =.;
PR_Prescribe	 =.;
PR_WhoPrescribe	 =.;
PR_InteractTradMed	 =.;
HR_PsyDeptStaff	 =.;
HR_DocAssistF5	 =.;
HR_PsyNurse	 =.;
HR_PharmaUni	 =.;
HR_PharmaSecond	 =.;
HR_Midwives	 =.;
HR_Technician	 =.;
HR_TradMed	 =.;
HR_TrainDrugF5	 =.;
HR_TrainDrugAF5	 =.;
HR_TrainDrugBF5	 =.;
HR_TrainDrugCF5	 =.;
HR_TrainDrugDF5	 =.;
HR_TrainDrugEF5	 =.;
HR_TrainSocPsyF5	 =.;
HR_TrainSocPsyAF5	 =.;
HR_TrainSocPsyBF5	 =.;
HR_TrainSocPsyCF5	 =.;
HR_TrainSocPsyDF5	 =.;
HR_TrainSocPsyEF5	 =.;
HR_TrainKidF5	 =.;
HR_TrainKidAF5	 =.;
HR_TrainKidBF5	 =.;
HR_TrainKidCF5	 =.;
HR_TrainKidDF5	 =.;
HR_TrainKidEF5	 =.;
HR_PsyDeptInCharge	 =.;
MR_PttTreat	 =.;
MR_ExamTimes	 =.;
MR_PttAsPlan	 =.;
MR_PttAsFact	 =.;
MR_CareDay	 =.;
MR_InvoluntaryCare	 =.;
CP_ParticipateYrF5	 =.;
CP_Participate13F5	 =.;
CP_Patient13F54	 =.;
CP_SchizoPatientF54	 =.;
CP_EpilepsyPatientF54	 =.;
CP_DepressionPatientF54	 =.;
CP_OtherPatientF54	 =.;
CP_OtherPatientF54Spec	 =.;
SV_DirectAgency1	 =.;
SV_DirectAgency2	 =.;
SV_DirectAgency3	 =.;
SV_DirectAgency4	 =.;
SV_DirectAgency5	 =.;
SV_DirectAgency6	 =.;
SV_DirectAgency7	 =.;
SV_DirectAgency8	 =.;
SV_DirectAgency9	 =.;
SV_DirectAgency99	 =.;
SV_CoopCommContent1	 =.;
SV_CoopCommContent2	 =.;
SV_CoopCommContent3	 =.;
SV_CoopCommContent4	 =.;
SV_CoopCommContent5	 =.;
SV_CoopCommContent98	 =.;
SV_CoopCommContent99	 =.;
SV_CommFreq1	 =.;
SV_CommFreq2	 =.;
SV_CommFreq3	 =.;
SV_CommFreq4	 =.;
SV_CommFreq5	 =.;
SV_CommFreq6	 =.;
SV_CommFreq99	 =.;
SV_MoDist1	 =.;
SV_MoDist2	 =.;
SV_MoDist3	 =.;
SV_MoDist4	 =.;
SV_MoDist5	 =.;
SV_MoDist6	 =.;
SV_MoDist99	 =.;
SV_MoComm1	 =.;
SV_MoComm2	 =.;
SV_MoComm3	 =.;
SV_MoComm4	 =.;
SV_MoComm5	 =.;
SV_MoComm6	 =.;
SV_MoComm99	 =.;
PR_InteractMHPro1	 =.;
PR_InteractMHPro2	 =.;
PR_InteractMHPro3	 =.;
PR_InteractMHPro4	 =.;
PR_InteractMHPro5	 =.;
PR_InteractMHPro6	 =.;
PR_InteractMHPro99	 =.;
PR_WhoPrescribe1	 =.;
PR_WhoPrescribe2	 =.;
PR_WhoPrescribe3	 =.;
PR_WhoPrescribe4	 =.;
PR_WhoPrescribe99	 =.;
end;
if GI_FacType = 6 then do;
GI_Clients	 =.;
GI_PopDistrict	 =.;
GI_PopCommune	 =.;
GI_HomeConfinedF5	 =.;
GI_IntegrateFac	 =.;
OS_DeptMedicine	 =.;
OS_DeptPersonAdmin	 =.;
OS_DeptOther5	 =.;
OS_CliTreatRehab	 =.;
FI_RevByFacility	 =.;
FI_NationalDonor	 =.;
FI_AbroadDonor	 =.;
FI_Families	 =.;
FI_Labor	 =.;
FI_ExpenseGovSS	 =.;
FI_SpendBenefi	 =.;
FI_SpendAdmin	 =.;
SV_CoopOutpF7	 =.;
SV_CoopInpF7	 =.;
SV_DirectAgency	 =.;
SV_ExamService	 =.;
SV_TreatService	 =.;
SV_ExamTreatDept	 =.;
SV_ExamTreatFreq	 =.;
SV_CoopComm	 =.;
SV_CoopCommContent	 =.;
SV_ExamTreatService	 =.;
SV_ExamTreatTimes	 =.;
SV_PttTreat13	 =.;
SV_FemaleTreat13	 =.;
SV_BedorPttPlan13	 =.;
SV_CareTreatFact13	 =.;
SV_CareTreat13Female	 =.;
SV_CommFreq	 =.;
SV_MoDist	 =.;
SV_MoComm	 =.;
SV_ExamF7	 =.;
SV_TreatmentF7	 =.;
SV_PsytherapyF7	 =.;
SV_OccuTherapyF7	 =.;
SV_RehabF7	 =.;
SV_SocialSupportF7	 =.;
SV_ServiceOtherF7	 =.;
SV_ServiceOtherSpecF7	 =.;
SV_ManageF7	 =.;
SV_ManageOccuF7	 =.;
SV_ManageSocSupportF7	 =.;
SV_ManageOtherF7	 =.;
SV_ManageOtherSpecF7	 =.;
SV_CommunityF7	 =.;
SV_DieF7	 =.;
SV_AvaiDrug1	 =.;
SV_AvaiDrug2	 =.;
SV_AvaiDrug3	 =.;
SV_AvaiDrug4	 =.;
SV_AvaiDrug5	 =.;
SV_RuralUse	 =.;
SV_StratMinor	 =.;
PR_GuidanceF5	 =.;
PR_DocsTrainingF5	 =.;
PR_NurseTrainingF5	 =.;
PR_OtherTrainingF5	 =.;
PR_TransferF5	 =.;
PR_InteractMHPro	 =.;
PR_Prescribe	 =.;
PR_WhoPrescribe	 =.;
PR_InteractTradMed	 =.;
HR_DocAssistF5	 =.;
HR_PharmaUni	 =.;
HR_PharmaSecond	 =.;
HR_Midwives	 =.;
HR_Technician	 =.;
HR_TradMed	 =.;
HR_TrainDrugF5	 =.;
HR_TrainDrugAF5	 =.;
HR_TrainDrugBF5	 =.;
HR_TrainDrugCF5	 =.;
HR_TrainDrugDF5	 =.;
HR_TrainDrugEF5	 =.;
HR_TrainSocPsyF5	 =.;
HR_TrainSocPsyAF5	 =.;
HR_TrainSocPsyBF5	 =.;
HR_TrainSocPsyCF5	 =.;
HR_TrainSocPsyDF5	 =.;
HR_TrainSocPsyEF5	 =.;
HR_TrainKidF5	 =.;
HR_TrainKidAF5	 =.;
HR_TrainKidBF5	 =.;
HR_TrainKidCF5	 =.;
HR_TrainKidDF5	 =.;
HR_TrainKidEF5	 =.;
MR_PttTreat	 =.;
MR_ExamTimes	 =.;
MR_PttAsPlan	 =.;
MR_PttAsFact	 =.;
MR_CareDay	 =.;
MR_InvoluntaryCare	 =.;
CP_ParticipateYrF5	 =.;
CP_Participate13F5	 =.;
CP_Patient13F54	 =.;
CP_SchizoPatientF54	 =.;
CP_EpilepsyPatientF54	 =.;
CP_DepressionPatientF54	 =.;
CP_OtherPatientF54	 =.;
CP_OtherPatientF54Spec	 =.;
SV_DirectAgency1	 =.;
SV_DirectAgency2	 =.;
SV_DirectAgency3	 =.;
SV_DirectAgency4	 =.;
SV_DirectAgency5	 =.;
SV_DirectAgency6	 =.;
SV_DirectAgency7	 =.;
SV_DirectAgency8	 =.;
SV_DirectAgency9	 =.;
SV_DirectAgency99	 =.;
SV_CoopCommContent1	 =.;
SV_CoopCommContent2	 =.;
SV_CoopCommContent3	 =.;
SV_CoopCommContent4	 =.;
SV_CoopCommContent5	 =.;
SV_CoopCommContent98	 =.;
SV_CoopCommContent99	 =.;
SV_CommFreq1	 =.;
SV_CommFreq2	 =.;
SV_CommFreq3	 =.;
SV_CommFreq4	 =.;
SV_CommFreq5	 =.;
SV_CommFreq6	 =.;
SV_CommFreq99	 =.;
SV_MoDist1	 =.;
SV_MoDist2	 =.;
SV_MoDist3	 =.;
SV_MoDist4	 =.;
SV_MoDist5	 =.;
SV_MoDist6	 =.;
SV_MoDist99	 =.;
SV_MoComm1	 =.;
SV_MoComm2	 =.;
SV_MoComm3	 =.;
SV_MoComm4	 =.;
SV_MoComm5	 =.;
SV_MoComm6	 =.;
SV_MoComm99	 =.;
PR_InteractMHPro1	 =.;
PR_InteractMHPro2	 =.;
PR_InteractMHPro3	 =.;
PR_InteractMHPro4	 =.;
PR_InteractMHPro5	 =.;
PR_InteractMHPro6	 =.;
PR_InteractMHPro99	 =.;
PR_WhoPrescribe1	 =.;
PR_WhoPrescribe2	 =.;
PR_WhoPrescribe3	 =.;
PR_WhoPrescribe4	 =.;
PR_WhoPrescribe99	 =.;
OS_TotalDept	 =.;
OS_DeptPlan	 =.;
OS_DeptPersonnel	 =.;
OS_DeptFinance	 =.;
OS_DeptCommunity	 =.;
OS_DeptTraining	 =.;
OS_DeptResearch	 =.;
OS_DeptAdmin	 =.;
OS_DeptEquipment	 =.;
OS_DeptNursing	 =.;
OS_DeptOther	 =.;
OS_DeptOther1	 =.;
OS_DeptOther2	 =.;
OS_DeptOther3	 =.;
OS_DeptOther4	 =.;
OS_CliEmergency	 =.;
OS_CliOutpatient	 =.;
OS_CliMale	 =.;
OS_CliFemale	 =.;
OS_CliPediatric	 =.;
OS_CliInfection	 =.;
OS_CliTradition	 =.;
OS_CliRehab	 =.;
OS_CliSubstance	 =.;
OS_CliForensic	 =.;
OS_CliNutrition	 =.;
OS_CliOther	 =.;
OS_CliOther1	 =.;
OS_CliOther2	 =.;
OS_CliOther3	 =.;
OS_CliOther4	 =.;
OS_CliOther5	 =.;
OS_CliOther6	 =.;
OS_PCliTesting	 =.;
OS_PCliImaging	 =.;
OS_PCliInfection	 =.;
OS_PCliPharma	 =.;
OS_PCliOther	 =.;
OS_PCliOther1	 =.;
OS_PCliOther2	 =.;
OS_PCliOther3	 =.;
OS_PCliOther4	 =.;
FI_TotalSpend	 =.;
SV_BedFact13	 =.;
SV_BedPlan09	 =.;
SV_BedFact09	 =.;
SV_ExamPatient13	 =.;
SV_ExamFemale13	 =.;
SV_InpatientTime	 =.;
SV_Inp10	 =.;
SV_Inp5	 =.;
SV_Inp1	 =.;
SV_Inp0	 =.;
SV_ForensicMinistry	 =.;
SV_MinorUse	 =.;
HR_AbroadF	 =.;
HR_AbroadP	 =.;
end;
if GI_FacType in (7, 8) then do;
GI_Clients	 =.;
GI_PopDistrict	 =.;
GI_PopCommune	 =.;
GI_HomeConfinedF5	 =.;
GI_IntegrateFac	 =.;
OS_DeptMedicine	 =.;
OS_DeptPersonAdmin	 =.;
OS_DeptOther5	 =.;
OS_CliTreatRehab	 =.;
FI_RevByFacility	 =.;
FI_NationalDonor	 =.;
FI_AbroadDonor	 =.;
FI_Families	 =.;
FI_Labor	 =.;
FI_ExpenseGovSS	 =.;
FI_SpendBenefi	 =.;
FI_SpendAdmin	 =.;
SV_CoopOutpF7	 =.;
SV_CoopInpF7	 =.;
SV_DirectAgency	 =.;
SV_ExamService	 =.;
SV_TreatService	 =.;
SV_ExamTreatDept	 =.;
SV_ExamTreatFreq	 =.;
SV_CoopComm	 =.;
SV_CoopCommContent	 =.;
SV_BedorPttPlan13	 =.;
SV_CareTreatFact13	 =.;
SV_CareTreat13Female	 =.;
SV_ExamF7	 =.;
SV_TreatmentF7	 =.;
SV_PsytherapyF7	 =.;
SV_OccuTherapyF7	 =.;
SV_RehabF7	 =.;
SV_SocialSupportF7	 =.;
SV_ServiceOtherF7	 =.;
SV_ServiceOtherSpecF7	 =.;
SV_ManageF7	 =.;
SV_ManageOccuF7	 =.;
SV_ManageSocSupportF7	 =.;
SV_ManageOtherF7	 =.;
SV_ManageOtherSpecF7	 =.;
SV_CommunityF7	 =.;
SV_DieF7	 =.;
SV_AvaiDrug1	 =.;
SV_AvaiDrug2	 =.;
SV_AvaiDrug3	 =.;
SV_AvaiDrug4	 =.;
SV_AvaiDrug5	 =.;
PR_GuidanceF5	 =.;
PR_DocsTrainingF5	 =.;
PR_NurseTrainingF5	 =.;
PR_OtherTrainingF5	 =.;
PR_TransferF5	 =.;
PR_InteractMHPro	 =.;
PR_Prescribe	 =.;
PR_WhoPrescribe	 =.;
PR_InteractTradMed	 =.;
HR_DocAssistF5	 =.;
HR_PharmaUni	 =.;
HR_PharmaSecond	 =.;
HR_Midwives	 =.;
HR_Technician	 =.;
HR_TradMed	 =.;
HR_TrainDrugF5	 =.;
HR_TrainDrugAF5	 =.;
HR_TrainDrugBF5	 =.;
HR_TrainDrugCF5	 =.;
HR_TrainDrugDF5	 =.;
HR_TrainDrugEF5	 =.;
HR_TrainSocPsyF5	 =.;
HR_TrainSocPsyAF5	 =.;
HR_TrainSocPsyBF5	 =.;
HR_TrainSocPsyCF5	 =.;
HR_TrainSocPsyDF5	 =.;
HR_TrainSocPsyEF5	 =.;
HR_TrainKidF5	 =.;
HR_TrainKidAF5	 =.;
HR_TrainKidBF5	 =.;
HR_TrainKidCF5	 =.;
HR_TrainKidDF5	 =.;
HR_TrainKidEF5	 =.;
MR_PttAsPlan	 =.;
MR_PttAsFact	 =.;
MR_CareDay	 =.;
MR_InvoluntaryCare	 =.;
CP_ParticipateYrF5	 =.;
CP_Participate13F5	 =.;
CP_Patient13F54	 =.;
CP_SchizoPatientF54	 =.;
CP_EpilepsyPatientF54	 =.;
CP_DepressionPatientF54	 =.;
CP_OtherPatientF54	 =.;
CP_OtherPatientF54Spec	 =.;
SV_DirectAgency1	 =.;
SV_DirectAgency2	 =.;
SV_DirectAgency3	 =.;
SV_DirectAgency4	 =.;
SV_DirectAgency5	 =.;
SV_DirectAgency6	 =.;
SV_DirectAgency7	 =.;
SV_DirectAgency8	 =.;
SV_DirectAgency9	 =.;
SV_DirectAgency99	 =.;
SV_CoopCommContent1	 =.;
SV_CoopCommContent2	 =.;
SV_CoopCommContent3	 =.;
SV_CoopCommContent4	 =.;
SV_CoopCommContent5	 =.;
SV_CoopCommContent98	 =.;
SV_CoopCommContent99	 =.;
PR_InteractMHPro1	 =.;
PR_InteractMHPro2	 =.;
PR_InteractMHPro3	 =.;
PR_InteractMHPro4	 =.;
PR_InteractMHPro5	 =.;
PR_InteractMHPro6	 =.;
PR_InteractMHPro99	 =.;
PR_WhoPrescribe1	 =.;
PR_WhoPrescribe2	 =.;
PR_WhoPrescribe3	 =.;
PR_WhoPrescribe4	 =.;
PR_WhoPrescribe99	 =.;
OS_TotalDept	 =.;
OS_DeptPlan	 =.;
OS_DeptPersonnel	 =.;
OS_DeptFinance	 =.;
OS_DeptCommunity	 =.;
OS_DeptTraining	 =.;
OS_DeptResearch	 =.;
OS_DeptAdmin	 =.;
OS_DeptEquipment	 =.;
OS_DeptNursing	 =.;
OS_DeptOther	 =.;
OS_DeptOther1	 =.;
OS_DeptOther2	 =.;
OS_DeptOther3	 =.;
OS_DeptOther4	 =.;
OS_CliEmergency	 =.;
OS_CliOutpatient	 =.;
OS_CliMale	 =.;
OS_CliFemale	 =.;
OS_CliPediatric	 =.;
OS_CliInfection	 =.;
OS_CliTradition	 =.;
OS_CliRehab	 =.;
OS_CliSubstance	 =.;
OS_CliForensic	 =.;
OS_CliNutrition	 =.;
OS_CliOther	 =.;
OS_CliOther1	 =.;
OS_CliOther2	 =.;
OS_CliOther3	 =.;
OS_CliOther4	 =.;
OS_CliOther5	 =.;
OS_CliOther6	 =.;
OS_PCliTesting	 =.;
OS_PCliImaging	 =.;
OS_PCliInfection	 =.;
OS_PCliPharma	 =.;
OS_PCliOther	 =.;
OS_PCliOther1	 =.;
OS_PCliOther2	 =.;
OS_PCliOther3	 =.;
OS_PCliOther4	 =.;
FI_TotalSpend	 =.;
SV_BedFact13	 =.;
SV_BedPlan09	 =.;
SV_BedFact09	 =.;
SV_ExamPatient13	 =.;
SV_ExamFemale13	 =.;
SV_InpatientTime	 =.;
SV_Inp10	 =.;
SV_Inp5	 =.;
SV_Inp1	 =.;
SV_Inp0	 =.;
SV_ForensicMinistry	 =.;
HR_AbroadF	 =.;
HR_AbroadP	 =.;
FI_SubsidyF7	 =.;
FI_SubsidyPlanF7	 =.;
FI_SubsidyFactF7	 =.;
HR_PsyNurse	 =.;
PL_HRAgency	 =.;
PL_HRTraining	 =.;
SV_BedPlan13	 =.;
SV_Inpatient13	 =.;
SV_InpatientFemale13	 =.;
SV_ICD10	 =.;
SV_InvoluntaryAdmission	 =.;
SV_InpatientLoS	 =.;
SV_Discharge	 =.;
SV_RestrainP	 =.;
SV_RestrainF	 =.;
SV_BedKid	 =.;
SV_PrjMed5	 =.;
SV_PrivateBed	 =.;
MR_Bed	 =.;
MR_Inpatient	 =.;
MR_InvoluntaryAdmission	 =.;
MR_Confined	 =.;
MR_Diagnose	 =.;
end;
if GI_FacType in (9, 10) then do;
GI_Clients	 =.;
GI_PopCommune	 =.;
GI_HomeConfinedF5	 =.;
OS_DeptMedicine	 =.;
OS_DeptPersonAdmin	 =.;
OS_DeptOther5	 =.;
OS_CliTreatRehab	 =.;
FI_RevByFacility	 =.;
FI_NationalDonor	 =.;
FI_AbroadDonor	 =.;
FI_Families	 =.;
FI_Labor	 =.;
FI_ExpenseGovSS	 =.;
FI_SpendBenefi	 =.;
FI_SpendAdmin	 =.;
SV_CoopOutpF7	 =.;
SV_CoopInpF7	 =.;
SV_DirectAgency	 =.;
SV_TreatService	 =.;
SV_BedorPttPlan13	 =.;
SV_CareTreatFact13	 =.;
SV_CareTreat13Female	 =.;
SV_ExamF7	 =.;
SV_TreatmentF7	 =.;
SV_PsytherapyF7	 =.;
SV_OccuTherapyF7	 =.;
SV_RehabF7	 =.;
SV_SocialSupportF7	 =.;
SV_ServiceOtherF7	 =.;
SV_ServiceOtherSpecF7	 =.;
SV_ManageF7	 =.;
SV_ManageOccuF7	 =.;
SV_ManageSocSupportF7	 =.;
SV_ManageOtherF7	 =.;
SV_ManageOtherSpecF7	 =.;
SV_CommunityF7	 =.;
SV_DieF7	 =.;
SV_AvaiDrug1	 =.;
SV_AvaiDrug2	 =.;
SV_AvaiDrug3	 =.;
SV_AvaiDrug4	 =.;
SV_AvaiDrug5	 =.;
PR_GuidanceF5	 =.;
PR_DocsTrainingF5	 =.;
PR_NurseTrainingF5	 =.;
PR_OtherTrainingF5	 =.;
PR_TransferF5	 =.;
PR_InteractMHPro	 =.;
PR_Prescribe	 =.;
PR_WhoPrescribe	 =.;
PR_InteractTradMed	 =.;
HR_DocAssistF5	 =.;
HR_TradMed	 =.;
HR_TrainDrugF5	 =.;
HR_TrainDrugAF5	 =.;
HR_TrainDrugBF5	 =.;
HR_TrainDrugCF5	 =.;
HR_TrainDrugDF5	 =.;
HR_TrainDrugEF5	 =.;
HR_TrainSocPsyF5	 =.;
HR_TrainSocPsyAF5	 =.;
HR_TrainSocPsyBF5	 =.;
HR_TrainSocPsyCF5	 =.;
HR_TrainSocPsyDF5	 =.;
HR_TrainSocPsyEF5	 =.;
HR_TrainKidF5	 =.;
HR_TrainKidAF5	 =.;
HR_TrainKidBF5	 =.;
HR_TrainKidCF5	 =.;
HR_TrainKidDF5	 =.;
HR_TrainKidEF5	 =.;
MR_PttAsPlan	 =.;
MR_PttAsFact	 =.;
MR_CareDay	 =.;
MR_InvoluntaryCare	 =.;
CP_ParticipateYrF5	 =.;
CP_Participate13F5	 =.;
SV_DirectAgency1	 =.;
SV_DirectAgency2	 =.;
SV_DirectAgency3	 =.;
SV_DirectAgency4	 =.;
SV_DirectAgency5	 =.;
SV_DirectAgency6	 =.;
SV_DirectAgency7	 =.;
SV_DirectAgency8	 =.;
SV_DirectAgency9	 =.;
SV_DirectAgency99	 =.;
PR_InteractMHPro1	 =.;
PR_InteractMHPro2	 =.;
PR_InteractMHPro3	 =.;
PR_InteractMHPro4	 =.;
PR_InteractMHPro5	 =.;
PR_InteractMHPro6	 =.;
PR_InteractMHPro99	 =.;
PR_WhoPrescribe1	 =.;
PR_WhoPrescribe2	 =.;
PR_WhoPrescribe3	 =.;
PR_WhoPrescribe4	 =.;
PR_WhoPrescribe99	 =.;
OS_TotalDept	 =.;
OS_DeptPlan	 =.;
OS_DeptPersonnel	 =.;
OS_DeptFinance	 =.;
OS_DeptCommunity	 =.;
OS_DeptTraining	 =.;
OS_DeptResearch	 =.;
OS_DeptAdmin	 =.;
OS_DeptEquipment	 =.;
OS_DeptNursing	 =.;
OS_DeptOther	 =.;
OS_DeptOther1	 =.;
OS_DeptOther2	 =.;
OS_DeptOther3	 =.;
OS_DeptOther4	 =.;
OS_CliEmergency	 =.;
OS_CliOutpatient	 =.;
OS_CliMale	 =.;
OS_CliFemale	 =.;
OS_CliPediatric	 =.;
OS_CliInfection	 =.;
OS_CliTradition	 =.;
OS_CliRehab	 =.;
OS_CliSubstance	 =.;
OS_CliForensic	 =.;
OS_CliNutrition	 =.;
OS_CliOther	 =.;
OS_CliOther1	 =.;
OS_CliOther2	 =.;
OS_CliOther3	 =.;
OS_CliOther4	 =.;
OS_CliOther5	 =.;
OS_CliOther6	 =.;
OS_PCliTesting	 =.;
OS_PCliImaging	 =.;
OS_PCliInfection	 =.;
OS_PCliPharma	 =.;
OS_PCliOther	 =.;
OS_PCliOther1	 =.;
OS_PCliOther2	 =.;
OS_PCliOther3	 =.;
OS_PCliOther4	 =.;
FI_TotalSpend	 =.;
SV_BedFact13	 =.;
SV_BedPlan09	 =.;
SV_BedFact09	 =.;
SV_ExamPatient13	 =.;
SV_ExamFemale13	 =.;
SV_InpatientTime	 =.;
SV_Inp10	 =.;
SV_Inp5	 =.;
SV_Inp1	 =.;
SV_Inp0	 =.;
SV_ForensicMinistry	 =.;
HR_AbroadF	 =.;
HR_AbroadP	 =.;
FI_SubsidyF7	 =.;
FI_SubsidyPlanF7	 =.;
FI_SubsidyFactF7	 =.;
HR_PsyNurse	 =.;
PL_HRAgency	 =.;
PL_HRTraining	 =.;
SV_BedPlan13	 =.;
SV_Inpatient13	 =.;
SV_InpatientFemale13	 =.;
SV_InvoluntaryAdmission	 =.;
SV_InpatientLoS	 =.;
SV_Discharge	 =.;
SV_RestrainP	 =.;
SV_RestrainF	 =.;
SV_BedKid	 =.;
SV_PrivateBed	 =.;
MR_Bed	 =.;
MR_Inpatient	 =.;
MR_Confined	 =.;
MR_Diagnose	 =.;
SV_ExamTreatService	 =.;
SV_MoDist	 =.;
SV_MoComm	 =.;
SV_MoDist1	 =.;
SV_MoDist2	 =.;
SV_MoDist3	 =.;
SV_MoDist4	 =.;
SV_MoDist5	 =.;
SV_MoDist6	 =.;
SV_MoDist99	 =.;
SV_MoComm1	 =.;
SV_MoComm2	 =.;
SV_MoComm3	 =.;
SV_MoComm4	 =.;
SV_MoComm5	 =.;
SV_MoComm6	 =.;
SV_MoComm99	 =.;
FI_MHSpend13	 =.;
SV_FrsProvinceAgency	 =.;
GI_PopProvince	 =.;
GI_Districts	 =.;
PL_Policy	 =.;
PL_PolicyYr	 =.;
PL_PolicyName	 =.;
PL_Policy1	 =.;
PL_Policy2	 =.;
PL_Policy3	 =.;
PL_Policy4	 =.;
PL_Policy5	 =.;
PL_Policy6	 =.;
PL_Policy7	 =.;
PL_Policy8	 =.;
PL_Policy9	 =.;
PL_Policy10	 =.;
PL_Policy11	 =.;
PL_Policy12	 =.;
PL_PolicyOther	 =.;
PL_PolicyOther1	 =.;
PL_PolicyOther3	 =.;
PL_PolicyOther2	 =.;
PL_PolicyOther4	 =.;
PL_Plan	 =.;
PL_PlanYr	 =.;
PL_PlanName	 =.;
PL_Plan1	 =.;
PL_Plan2	 =.;
PL_Plan3	 =.;
PL_Plan4	 =.;
PL_Plan5	 =.;
PL_Plan6	 =.;
PL_Plan7	 =.;
PL_Plan8	 =.;
PL_Plan9	 =.;
PL_Plan10	 =.;
PL_Plan11	 =.;
PL_Plan12	 =.;
PL_Plan13	 =.;
PL_PlanOther	 =.;
PL_PlanOther1	 =.;
PL_PlanOther3	 =.;
PL_PlanOther2	 =.;
PL_PlanOther4	 =.;
PL_CurBudget	 =.;
PL_CurTime	 =.;
PL_CurGoal	 =.;
PL_CurAchieve	 =.;
PL_Disaster	 =.;
PL_DisasterYr	 =.;
PL_DisasterName	 =.;
PL_Legal	 =.;
PL_LegalYr	 =.;
PL_LegalName	 =.;
PL_Legal1	 =.;
PL_Legal2	 =.;
PL_Legal3	 =.;
PL_Legal4	 =.;
PL_Legal5	 =.;
PL_Legal6	 =.;
PL_Legal7	 =.;
PL_Legal8	 =.;
PL_Legal9	 =.;
FI_TotalRev	 =.;
FI_RevGovernment	 =.;
FI_RevProvince	 =.;
FI_RevOOP	 =.;
FI_RevInsurance	 =.;
FI_RevDonor	 =.;
FI_RevOther	 =.;
FI_RevOtherSpec	 =.;
FI_ExpenseGovHlth	 =.;
FI_Project13	 =.;
FI_ProjectGov	 =.;
FI_ProjectProv	 =.;
FI_SpendSalary	 =.;
FI_SpendProfession	 =.;
FI_SpendMed	 =.;
FI_SpendOther	 =.;
FI_SpendOtherSpec	 =.;
FI_InsurancePay	 =.;
FI_OOPPay	 =.;
FI_AntipsyMed	 =.;
FI_AntipsySpend	 =.;
FI_AntidepMed	 =.;
FI_AntidepSpend	 =.;
SV_FProvinceBed	 =.;
SV_FProvinceBed1	 =.;
SV_FProvinceBed2	 =.;
SV_FProvinceBed3	 =.;
SV_FProvinceBed4	 =.;
SV_FProvinceBed5	 =.;
SV_FProvinceBed6	 =.;
SV_ForensicLoS	 =.;
SV_ForensicLoS10	 =.;
SV_ForensicLoS5	 =.;
SV_ForensicLoS1	 =.;
SV_ForensicLoS0	 =.;
HR_Club	 =.;
HR_ClubPatient	 =.;
HR_ClubFamily	 =.;
HR_SupportClubP	 =.;
HR_SupportClubF	 =.;
HR_PolicyClubP	 =.;
HR_PolicyClubF	 =.;
HR_InteractClubP	 =.;
HR_InteractClubF	 =.;
HR_ActivityClubP	 =.;
HR_ActivityClubF	 =.;
HR_NGOCommunication	 =.;
HR_NGOService	 =.;
CE_LocalAgency	 =.;
CE_AgencyGov	 =.;
CE_AgencyNGO	 =.;
CE_AgencyProfession	 =.;
CE_AgencyPrivate	 =.;
CE_AgencyInter	 =.;
CE_CommCommunity	 =.;
CE_CommKid	 =.;
CE_CommWomen	 =.;
CE_CommAdolescent	 =.;
CE_CommTrauma	 =.;
CE_CommEthnic	 =.;
CE_CommOther	 =.;
CE_Provider	 =.;
CE_Tradition	 =.;
CE_Teacher	 =.;
CE_SocialService	 =.;
CE_Leader	 =.;
CE_OtherProfession	 =.;
CE_EmployAgency	 =.;
CE_SchoolStaff	 =.;
CE_SchoolStaffF	 =.;
CE_TotalSchool	 =.;
CE_SchoolActivity	 =.;
CE_PoliceEducation	 =.;
CE_JudgeEducation	 =.;
CE_PrisonPsychosis	 =.;
CE_PrisonRetard	 =.;
CE_PrisonTreat	 =.;
MR_ReportGov13	 =.;
MR_ResearchStaff	 =.;
MR_ResearchStaffA	 =.;
MR_ResearchStaffB	 =.;
MR_ResearchStaffC	 =.;
MR_ResearchStaffD	 =.;
MR_ResearchStaffE	 =.;
MR_ResearchStaffF	 =.;
MR_ResearchTopic1	 =.;
MR_ResearchTopic2	 =.;
MR_ResearchTopic3	 =.;
MR_ResearchTopic4	 =.;
MR_ResearchTopic5	 =.;
MR_ResearchTopic6	 =.;
MR_ResearchTopic7	 =.;
MR_ResearchTopic8	 =.;
MR_ResearchTopic99	 =.;
MR_ResearchTopicSpec	 =.;
MR_ResearchFac	 =.;
MR_ResearchMinistry	 =.;
MR_ResearchNational	 =.;
CP_ProjSite	 =.;
CP_ProjSchizoSite	 =.;
CP_ProjSchizoPatient	 =.;
CP_ProjEpilepsySite	 =.;
CP_ProjEpilepsyPatient	 =.;
CP_ProjDepressionSite	 =.;
CP_ProjDepressionPatient	 =.;
CP_ProjSchizoEpi	 =.;
CP_ProjSchizoEpiA	 =.;
CP_ProjSchizoEpiB	 =.;
CP_OtherModel	 =.;
CP_OtherModelSpec	 =.;
CP_AggressivePatient	 =.;
CP_DangerousPatient	 =.;
end;
if GI_FacType = 11 then do;
GI_Clients	 =.;
OS_DeptMedicine	 =.;
OS_DeptPersonAdmin	 =.;
OS_DeptOther5	 =.;
OS_CliTreatRehab	 =.;
FI_RevByFacility	 =.;
FI_NationalDonor	 =.;
FI_AbroadDonor	 =.;
FI_Families	 =.;
FI_Labor	 =.;
FI_ExpenseGovSS	 =.;
FI_SpendBenefi	 =.;
FI_SpendAdmin	 =.;
SV_CoopOutpF7	 =.;
SV_CoopInpF7	 =.;
SV_BedorPttPlan13	 =.;
SV_CareTreatFact13	 =.;
SV_CareTreat13Female	 =.;
SV_ExamF7	 =.;
SV_TreatmentF7	 =.;
SV_PsytherapyF7	 =.;
SV_OccuTherapyF7	 =.;
SV_RehabF7	 =.;
SV_SocialSupportF7	 =.;
SV_ServiceOtherF7	 =.;
SV_ServiceOtherSpecF7	 =.;
SV_ManageF7	 =.;
SV_ManageOccuF7	 =.;
SV_ManageSocSupportF7	 =.;
SV_ManageOtherF7	 =.;
SV_ManageOtherSpecF7	 =.;
SV_CommunityF7	 =.;
SV_DieF7	 =.;
MR_PttAsPlan	 =.;
MR_PttAsFact	 =.;
MR_CareDay	 =.;
MR_InvoluntaryCare	 =.;
OS_TotalDept	 =.;
OS_DeptPlan	 =.;
OS_DeptPersonnel	 =.;
OS_DeptFinance	 =.;
OS_DeptCommunity	 =.;
OS_DeptTraining	 =.;
OS_DeptResearch	 =.;
OS_DeptAdmin	 =.;
OS_DeptEquipment	 =.;
OS_DeptNursing	 =.;
OS_DeptOther	 =.;
OS_DeptOther1	 =.;
OS_DeptOther2	 =.;
OS_DeptOther3	 =.;
OS_DeptOther4	 =.;
OS_CliEmergency	 =.;
OS_CliOutpatient	 =.;
OS_CliMale	 =.;
OS_CliFemale	 =.;
OS_CliPediatric	 =.;
OS_CliInfection	 =.;
OS_CliTradition	 =.;
OS_CliRehab	 =.;
OS_CliSubstance	 =.;
OS_CliForensic	 =.;
OS_CliNutrition	 =.;
OS_CliOther	 =.;
OS_CliOther1	 =.;
OS_CliOther2	 =.;
OS_CliOther3	 =.;
OS_CliOther4	 =.;
OS_CliOther5	 =.;
OS_CliOther6	 =.;
OS_PCliTesting	 =.;
OS_PCliImaging	 =.;
OS_PCliInfection	 =.;
OS_PCliPharma	 =.;
OS_PCliOther	 =.;
OS_PCliOther1	 =.;
OS_PCliOther2	 =.;
OS_PCliOther3	 =.;
OS_PCliOther4	 =.;
FI_TotalSpend	 =.;
SV_BedFact13	 =.;
SV_BedPlan09	 =.;
SV_BedFact09	 =.;
SV_ExamPatient13	 =.;
SV_ExamFemale13	 =.;
SV_InpatientTime	 =.;
SV_Inp10	 =.;
SV_Inp5	 =.;
SV_Inp1	 =.;
SV_Inp0	 =.;
SV_ForensicMinistry	 =.;
HR_AbroadF	 =.;
HR_AbroadP	 =.;
FI_SubsidyF7	 =.;
FI_SubsidyPlanF7	 =.;
FI_SubsidyFactF7	 =.;
HR_PsyNurse	 =.;
PL_HRAgency	 =.;
PL_HRTraining	 =.;
SV_BedPlan13	 =.;
SV_Inpatient13	 =.;
SV_InpatientFemale13	 =.;
SV_InvoluntaryAdmission	 =.;
SV_InpatientLoS	 =.;
SV_Discharge	 =.;
SV_RestrainP	 =.;
SV_RestrainF	 =.;
SV_BedKid	 =.;
SV_PrivateBed	 =.;
MR_Bed	 =.;
MR_Inpatient	 =.;
MR_Confined	 =.;
MR_Diagnose	 =.;
SV_ExamTreatService	 =.;
SV_MoDist	 =.;
SV_MoComm	 =.;
SV_MoDist1	 =.;
SV_MoDist2	 =.;
SV_MoDist3	 =.;
SV_MoDist4	 =.;
SV_MoDist5	 =.;
SV_MoDist6	 =.;
SV_MoDist99	 =.;
SV_MoComm1	 =.;
SV_MoComm2	 =.;
SV_MoComm3	 =.;
SV_MoComm4	 =.;
SV_MoComm5	 =.;
SV_MoComm6	 =.;
SV_MoComm99	 =.;
FI_MHSpend13	 =.;
SV_FrsProvinceAgency	 =.;
GI_PopProvince	 =.;
GI_Districts	 =.;
PL_Policy	 =.;
PL_PolicyYr	 =.;
PL_PolicyName	 =.;
PL_Policy1	 =.;
PL_Policy2	 =.;
PL_Policy3	 =.;
PL_Policy4	 =.;
PL_Policy5	 =.;
PL_Policy6	 =.;
PL_Policy7	 =.;
PL_Policy8	 =.;
PL_Policy9	 =.;
PL_Policy10	 =.;
PL_Policy11	 =.;
PL_Policy12	 =.;
PL_PolicyOther	 =.;
PL_PolicyOther1	 =.;
PL_PolicyOther3	 =.;
PL_PolicyOther2	 =.;
PL_PolicyOther4	 =.;
PL_Plan	 =.;
PL_PlanYr	 =.;
PL_PlanName	 =.;
PL_Plan1	 =.;
PL_Plan2	 =.;
PL_Plan3	 =.;
PL_Plan4	 =.;
PL_Plan5	 =.;
PL_Plan6	 =.;
PL_Plan7	 =.;
PL_Plan8	 =.;
PL_Plan9	 =.;
PL_Plan10	 =.;
PL_Plan11	 =.;
PL_Plan12	 =.;
PL_Plan13	 =.;
PL_PlanOther	 =.;
PL_PlanOther1	 =.;
PL_PlanOther3	 =.;
PL_PlanOther2	 =.;
PL_PlanOther4	 =.;
PL_CurBudget	 =.;
PL_CurTime	 =.;
PL_CurGoal	 =.;
PL_CurAchieve	 =.;
PL_Disaster	 =.;
PL_DisasterYr	 =.;
PL_DisasterName	 =.;
PL_Legal	 =.;
PL_LegalYr	 =.;
PL_LegalName	 =.;
PL_Legal1	 =.;
PL_Legal2	 =.;
PL_Legal3	 =.;
PL_Legal4	 =.;
PL_Legal5	 =.;
PL_Legal6	 =.;
PL_Legal7	 =.;
PL_Legal8	 =.;
PL_Legal9	 =.;
FI_TotalRev	 =.;
FI_RevGovernment	 =.;
FI_RevProvince	 =.;
FI_RevOOP	 =.;
FI_RevInsurance	 =.;
FI_RevDonor	 =.;
FI_RevOther	 =.;
FI_RevOtherSpec	 =.;
FI_ExpenseGovHlth	 =.;
FI_Project13	 =.;
FI_ProjectGov	 =.;
FI_ProjectProv	 =.;
FI_SpendSalary	 =.;
FI_SpendProfession	 =.;
FI_SpendMed	 =.;
FI_SpendOther	 =.;
FI_SpendOtherSpec	 =.;
FI_InsurancePay	 =.;
FI_OOPPay	 =.;
FI_AntipsyMed	 =.;
FI_AntipsySpend	 =.;
FI_AntidepMed	 =.;
FI_AntidepSpend	 =.;
SV_FProvinceBed	 =.;
SV_FProvinceBed1	 =.;
SV_FProvinceBed2	 =.;
SV_FProvinceBed3	 =.;
SV_FProvinceBed4	 =.;
SV_FProvinceBed5	 =.;
SV_FProvinceBed6	 =.;
SV_ForensicLoS	 =.;
SV_ForensicLoS10	 =.;
SV_ForensicLoS5	 =.;
SV_ForensicLoS1	 =.;
SV_ForensicLoS0	 =.;
HR_Club	 =.;
HR_ClubPatient	 =.;
HR_ClubFamily	 =.;
HR_SupportClubP	 =.;
HR_SupportClubF	 =.;
HR_PolicyClubP	 =.;
HR_PolicyClubF	 =.;
HR_InteractClubP	 =.;
HR_InteractClubF	 =.;
HR_ActivityClubP	 =.;
HR_ActivityClubF	 =.;
HR_NGOCommunication	 =.;
HR_NGOService	 =.;
CE_LocalAgency	 =.;
CE_AgencyGov	 =.;
CE_AgencyNGO	 =.;
CE_AgencyProfession	 =.;
CE_AgencyPrivate	 =.;
CE_AgencyInter	 =.;
CE_CommCommunity	 =.;
CE_CommKid	 =.;
CE_CommWomen	 =.;
CE_CommAdolescent	 =.;
CE_CommTrauma	 =.;
CE_CommEthnic	 =.;
CE_CommOther	 =.;
CE_Provider	 =.;
CE_Tradition	 =.;
CE_Teacher	 =.;
CE_SocialService	 =.;
CE_Leader	 =.;
CE_OtherProfession	 =.;
CE_EmployAgency	 =.;
CE_SchoolStaff	 =.;
CE_SchoolStaffF	 =.;
CE_TotalSchool	 =.;
CE_SchoolActivity	 =.;
CE_PoliceEducation	 =.;
CE_JudgeEducation	 =.;
CE_PrisonPsychosis	 =.;
CE_PrisonRetard	 =.;
CE_PrisonTreat	 =.;
MR_ReportGov13	 =.;
MR_ResearchStaff	 =.;
MR_ResearchStaffA	 =.;
MR_ResearchStaffB	 =.;
MR_ResearchStaffC	 =.;
MR_ResearchStaffD	 =.;
MR_ResearchStaffE	 =.;
MR_ResearchStaffF	 =.;
MR_ResearchTopic1	 =.;
MR_ResearchTopic2	 =.;
MR_ResearchTopic3	 =.;
MR_ResearchTopic4	 =.;
MR_ResearchTopic5	 =.;
MR_ResearchTopic6	 =.;
MR_ResearchTopic7	 =.;
MR_ResearchTopic8	 =.;
MR_ResearchTopic99	 =.;
MR_ResearchTopicSpec	 =.;
MR_ResearchFac	 =.;
MR_ResearchMinistry	 =.;
MR_ResearchNational	 =.;
CP_ProjSite	 =.;
CP_ProjSchizoSite	 =.;
CP_ProjSchizoPatient	 =.;
CP_ProjEpilepsySite	 =.;
CP_ProjEpilepsyPatient	 =.;
CP_ProjDepressionSite	 =.;
CP_ProjDepressionPatient	 =.;
CP_ProjSchizoEpi	 =.;
CP_ProjSchizoEpiA	 =.;
CP_ProjSchizoEpiB	 =.;
CP_OtherModel	 =.;
CP_OtherModelSpec	 =.;
CP_AggressivePatient	 =.;
CP_DangerousPatient	 =.;
GI_PopDistrict	 =.;
GI_IntegrateFac	 =.;
SV_ExamTreatDept	 =.;
SV_ExamTreatFreq	 =.;
SV_CoopComm	 =.;
SV_CoopCommContent	 =.;
SV_CoopCommContent1	 =.;
SV_CoopCommContent2	 =.;
SV_CoopCommContent3	 =.;
SV_CoopCommContent4	 =.;
SV_CoopCommContent5	 =.;
SV_CoopCommContent98	 =.;
SV_CoopCommContent99	 =.;
SV_ICD10	 =.;
MR_InvoluntaryAdmission	 =.;
GI_Commune	 =.;
PL_Psymed	 =.;
PL_Antipsy1	 =.;
PL_Antipsy2	 =.;
PL_Anxio1	 =.;
PL_Anxio2	 =.;
PL_Antidep1	 =.;
PL_Antidep2	 =.;
PL_Mood	 =.;
PL_Antiepi1	 =.;
PL_Antiepi2	 =.;
SV_DownRef	 =.;
SV_G40G41	 =.;
SV_F00F03	 =.;
SV_F10	 =.;
SV_F11F19	 =.;
SV_F20F29	 =.;
SV_F30F39	 =.;
SV_F40F48	 =.;
SV_F60F69	 =.;
SV_F70F79	 =.;
SV_ICD10Other	 =.;
SV_ProjectMed	 =.;
CP_PatientDrop	 =.;
SV_DownRef1	 =.;
SV_DownRef2	 =.;
SV_DownRef3	 =.;
SV_DownRef4	 =.;
SV_DownRef5	 =.;
SV_DownRef6	 =.;
SV_DownRef7	 =.;
SV_DownRef98	 =.;
SV_DownRef99	 =.;
end;
if GI_FacType=5 then do;
GI_Clients	 =.;
OS_DeptMedicine	 =.;
OS_DeptPersonAdmin	 =.;
OS_DeptOther5	 =.;
OS_CliTreatRehab	 =.;
FI_RevByFacility	 =.;
FI_NationalDonor	 =.;
FI_AbroadDonor	 =.;
FI_Families	 =.;
FI_Labor	 =.;
FI_ExpenseGovSS	 =.;
FI_SpendBenefi	 =.;
FI_SpendAdmin	 =.;
SV_CoopOutpF7	 =.;
SV_CoopInpF7	 =.;
SV_BedorPttPlan13	 =.;
SV_CareTreatFact13	 =.;
SV_CareTreat13Female	 =.;
SV_ExamF7	 =.;
SV_TreatmentF7	 =.;
SV_PsytherapyF7	 =.;
SV_OccuTherapyF7	 =.;
SV_RehabF7	 =.;
SV_SocialSupportF7	 =.;
SV_ServiceOtherF7	 =.;
SV_ServiceOtherSpecF7	 =.;
SV_ManageF7	 =.;
SV_ManageOccuF7	 =.;
SV_ManageSocSupportF7	 =.;
SV_ManageOtherF7	 =.;
SV_ManageOtherSpecF7	 =.;
SV_CommunityF7	 =.;
SV_DieF7	 =.;
MR_PttAsPlan	 =.;
MR_PttAsFact	 =.;
MR_CareDay	 =.;
MR_InvoluntaryCare	 =.;
FI_SubsidyF7	 =.;
FI_SubsidyPlanF7	 =.;
FI_SubsidyFactF7	 =.;
HR_PsyNurse	 =.;
SV_ExamTreatService	 =.;
SV_MoDist	 =.;
SV_MoComm	 =.;
SV_MoDist1	 =.;
SV_MoDist2	 =.;
SV_MoDist3	 =.;
SV_MoDist4	 =.;
SV_MoDist5	 =.;
SV_MoDist6	 =.;
SV_MoDist99	 =.;
SV_MoComm1	 =.;
SV_MoComm2	 =.;
SV_MoComm3	 =.;
SV_MoComm4	 =.;
SV_MoComm5	 =.;
SV_MoComm6	 =.;
SV_MoComm99	 =.;
FI_MHSpend13	 =.;
SV_FrsProvinceAgency	 =.;
FI_Project13	 =.;
FI_ProjectGov	 =.;
FI_ProjectProv	 =.;
GI_PopDistrict	 =.;
GI_IntegrateFac	 =.;
SV_ExamTreatDept	 =.;
SV_ExamTreatFreq	 =.;
SV_CoopComm	 =.;
SV_CoopCommContent	 =.;
SV_CoopCommContent1	 =.;
SV_CoopCommContent2	 =.;
SV_CoopCommContent3	 =.;
SV_CoopCommContent4	 =.;
SV_CoopCommContent5	 =.;
SV_CoopCommContent98	 =.;
SV_CoopCommContent99	 =.;
GI_PopCommune	 =.;
GI_HomeConfinedF5	 =.;
SV_DirectAgency	 =.;
SV_TreatService	 =.;
SV_AvaiDrug1	 =.;
SV_AvaiDrug2	 =.;
SV_AvaiDrug3	 =.;
SV_AvaiDrug4	 =.;
SV_AvaiDrug5	 =.;
PR_GuidanceF5	 =.;
PR_DocsTrainingF5	 =.;
PR_NurseTrainingF5	 =.;
PR_OtherTrainingF5	 =.;
PR_TransferF5	 =.;
PR_InteractMHPro	 =.;
PR_Prescribe	 =.;
PR_WhoPrescribe	 =.;
PR_InteractTradMed	 =.;
HR_DocAssistF5	 =.;
HR_TradMed	 =.;
HR_TrainDrugF5	 =.;
HR_TrainDrugAF5	 =.;
HR_TrainDrugBF5	 =.;
HR_TrainDrugCF5	 =.;
HR_TrainDrugDF5	 =.;
HR_TrainDrugEF5	 =.;
HR_TrainSocPsyF5	 =.;
HR_TrainSocPsyAF5	 =.;
HR_TrainSocPsyBF5	 =.;
HR_TrainSocPsyCF5	 =.;
HR_TrainSocPsyDF5	 =.;
HR_TrainSocPsyEF5	 =.;
HR_TrainKidF5	 =.;
HR_TrainKidAF5	 =.;
HR_TrainKidBF5	 =.;
HR_TrainKidCF5	 =.;
HR_TrainKidDF5	 =.;
HR_TrainKidEF5	 =.;
CP_ParticipateYrF5	 =.;
CP_Participate13F5	 =.;
SV_DirectAgency1	 =.;
SV_DirectAgency2	 =.;
SV_DirectAgency3	 =.;
SV_DirectAgency4	 =.;
SV_DirectAgency5	 =.;
SV_DirectAgency6	 =.;
SV_DirectAgency7	 =.;
SV_DirectAgency8	 =.;
SV_DirectAgency9	 =.;
SV_DirectAgency99	 =.;
PR_InteractMHPro1	 =.;
PR_InteractMHPro2	 =.;
PR_InteractMHPro3	 =.;
PR_InteractMHPro4	 =.;
PR_InteractMHPro5	 =.;
PR_InteractMHPro6	 =.;
PR_InteractMHPro99	 =.;
PR_WhoPrescribe1	 =.;
PR_WhoPrescribe2	 =.;
PR_WhoPrescribe3	 =.;
PR_WhoPrescribe4	 =.;
PR_WhoPrescribe99	 =.;
SV_ExamService	 =.;
HR_PharmaUni	 =.;
HR_PharmaSecond	 =.;
HR_Midwives	 =.;
HR_Technician	 =.;
CP_Patient13F54	 =.;
CP_SchizoPatientF54	 =.;
CP_EpilepsyPatientF54	 =.;
CP_DepressionPatientF54	 =.;
CP_OtherPatientF54	 =.;
CP_OtherPatientF54Spec	 =.;
SV_ExamTreatTimes	 =.;
SV_PttTreat13	 =.;
SV_FemaleTreat13	 =.;
SV_CommFreq	 =.;
SV_RuralUse	 =.;
SV_StratMinor	 =.;
MR_PttTreat	 =.;
MR_ExamTimes	 =.;
SV_CommFreq1	 =.;
SV_CommFreq2	 =.;
SV_CommFreq3	 =.;
SV_CommFreq4	 =.;
SV_CommFreq5	 =.;
SV_CommFreq6	 =.;
SV_CommFreq99	 =.;
HR_PsyDeptStaff	 =.;
HR_PsyDeptInCharge	 =.;
MR_DataOther	 =.;
MR_DataOtherSpec	 =.;
end;
if GI_FacType in (12, 13) then do;
HR_PsyNurse	 =.;
SV_ExamTreatService	 =.;
SV_MoDist	 =.;
SV_MoComm	 =.;
SV_MoDist1	 =.;
SV_MoDist2	 =.;
SV_MoDist3	 =.;
SV_MoDist4	 =.;
SV_MoDist5	 =.;
SV_MoDist6	 =.;
SV_MoDist99	 =.;
SV_MoComm1	 =.;
SV_MoComm2	 =.;
SV_MoComm3	 =.;
SV_MoComm4	 =.;
SV_MoComm5	 =.;
SV_MoComm6	 =.;
SV_MoComm99	 =.;
SV_FrsProvinceAgency	 =.;
FI_Project13	 =.;
FI_ProjectGov	 =.;
FI_ProjectProv	 =.;
GI_PopDistrict	 =.;
GI_IntegrateFac	 =.;
SV_ExamTreatDept	 =.;
SV_ExamTreatFreq	 =.;
SV_CoopComm	 =.;
SV_CoopCommContent	 =.;
SV_CoopCommContent1	 =.;
SV_CoopCommContent2	 =.;
SV_CoopCommContent3	 =.;
SV_CoopCommContent4	 =.;
SV_CoopCommContent5	 =.;
SV_CoopCommContent98	 =.;
SV_CoopCommContent99	 =.;
GI_PopCommune	 =.;
GI_HomeConfinedF5	 =.;
SV_DirectAgency	 =.;
SV_TreatService	 =.;
SV_AvaiDrug1	 =.;
SV_AvaiDrug2	 =.;
SV_AvaiDrug3	 =.;
SV_AvaiDrug4	 =.;
SV_AvaiDrug5	 =.;
PR_GuidanceF5	 =.;
PR_DocsTrainingF5	 =.;
PR_NurseTrainingF5	 =.;
PR_OtherTrainingF5	 =.;
PR_TransferF5	 =.;
PR_InteractMHPro	 =.;
PR_Prescribe	 =.;
PR_WhoPrescribe	 =.;
PR_InteractTradMed	 =.;
HR_DocAssistF5	 =.;
HR_TradMed	 =.;
HR_TrainDrugF5	 =.;
HR_TrainDrugAF5	 =.;
HR_TrainDrugBF5	 =.;
HR_TrainDrugCF5	 =.;
HR_TrainDrugDF5	 =.;
HR_TrainDrugEF5	 =.;
HR_TrainSocPsyF5	 =.;
HR_TrainSocPsyAF5	 =.;
HR_TrainSocPsyBF5	 =.;
HR_TrainSocPsyCF5	 =.;
HR_TrainSocPsyDF5	 =.;
HR_TrainSocPsyEF5	 =.;
HR_TrainKidF5	 =.;
HR_TrainKidAF5	 =.;
HR_TrainKidBF5	 =.;
HR_TrainKidCF5	 =.;
HR_TrainKidDF5	 =.;
HR_TrainKidEF5	 =.;
CP_ParticipateYrF5	 =.;
CP_Participate13F5	 =.;
SV_DirectAgency1	 =.;
SV_DirectAgency2	 =.;
SV_DirectAgency3	 =.;
SV_DirectAgency4	 =.;
SV_DirectAgency5	 =.;
SV_DirectAgency6	 =.;
SV_DirectAgency7	 =.;
SV_DirectAgency8	 =.;
SV_DirectAgency9	 =.;
SV_DirectAgency99	 =.;
PR_InteractMHPro1	 =.;
PR_InteractMHPro2	 =.;
PR_InteractMHPro3	 =.;
PR_InteractMHPro4	 =.;
PR_InteractMHPro5	 =.;
PR_InteractMHPro6	 =.;
PR_InteractMHPro99	 =.;
PR_WhoPrescribe1	 =.;
PR_WhoPrescribe2	 =.;
PR_WhoPrescribe3	 =.;
PR_WhoPrescribe4	 =.;
PR_WhoPrescribe99	 =.;
SV_ExamService	 =.;
HR_PharmaUni	 =.;
HR_PharmaSecond	 =.;
HR_Midwives	 =.;
HR_Technician	 =.;
CP_Patient13F54	 =.;
CP_SchizoPatientF54	 =.;
CP_EpilepsyPatientF54	 =.;
CP_DepressionPatientF54	 =.;
CP_OtherPatientF54	 =.;
CP_OtherPatientF54Spec	 =.;
SV_ExamTreatTimes	 =.;
SV_PttTreat13	 =.;
SV_FemaleTreat13	 =.;
SV_CommFreq	 =.;
SV_RuralUse	 =.;
SV_StratMinor	 =.;
MR_PttTreat	 =.;
MR_ExamTimes	 =.;
SV_CommFreq1	 =.;
SV_CommFreq2	 =.;
SV_CommFreq3	 =.;
SV_CommFreq4	 =.;
SV_CommFreq5	 =.;
SV_CommFreq6	 =.;
SV_CommFreq99	 =.;
HR_PsyDeptStaff	 =.;
MR_DataOther	 =.;
MR_DataOtherSpec	 =.;
OS_DeptPlan	 =.;
OS_DeptPersonnel	 =.;
OS_DeptCommunity	 =.;
OS_DeptTraining	 =.;
OS_DeptResearch	 =.;
OS_DeptAdmin	 =.;
OS_DeptEquipment	 =.;
OS_DeptNursing	 =.;
OS_CliEmergency	 =.;
OS_CliOutpatient	 =.;
OS_CliMale	 =.;
OS_CliFemale	 =.;
OS_CliPediatric	 =.;
OS_CliInfection	 =.;
OS_CliTradition	 =.;
OS_CliRehab	 =.;
OS_CliSubstance	 =.;
OS_CliForensic	 =.;
OS_CliOther	 =.;
OS_CliOther1	 =.;
OS_CliOther2	 =.;
OS_CliOther3	 =.;
OS_CliOther4	 =.;
OS_CliOther5	 =.;
OS_CliOther6	 =.;
OS_PCliTesting	 =.;
OS_PCliImaging	 =.;
OS_PCliInfection	 =.;
OS_PCliPharma	 =.;
OS_PCliOther	 =.;
OS_PCliOther1	 =.;
OS_PCliOther2	 =.;
OS_PCliOther3	 =.;
OS_PCliOther4	 =.;
FI_TotalSpend	 =.;
SV_BedFact13	 =.;
SV_BedPlan09	 =.;
SV_BedFact09	 =.;
SV_ExamPatient13	 =.;
SV_ExamFemale13	 =.;
SV_ForensicMinistry	 =.;
HR_AbroadF	 =.;
HR_AbroadP	 =.;
SV_BedPlan13	 =.;
SV_Inpatient13	 =.;
SV_InpatientFemale13	 =.;
SV_InvoluntaryAdmission	 =.;
SV_Discharge	 =.;
SV_PrivateBed	 =.;
MR_Bed	 =.;
MR_Inpatient	 =.;
GI_PopProvince	 =.;
GI_Districts	 =.;
FI_RevOOP	 =.;
FI_RevInsurance	 =.;
FI_RevDonor	 =.;
FI_ExpenseGovHlth	 =.;
FI_SpendProfession	 =.;
FI_SpendMed	 =.;
SV_FProvinceBed	 =.;
SV_FProvinceBed1	 =.;
SV_FProvinceBed2	 =.;
SV_FProvinceBed3	 =.;
SV_FProvinceBed4	 =.;
SV_FProvinceBed5	 =.;
SV_FProvinceBed6	 =.;
SV_ForensicLoS	 =.;
SV_ForensicLoS10	 =.;
SV_ForensicLoS5	 =.;
SV_ForensicLoS1	 =.;
SV_ForensicLoS0	 =.;
HR_Club	 =.;
HR_ClubPatient	 =.;
HR_ClubFamily	 =.;
HR_SupportClubP	 =.;
HR_SupportClubF	 =.;
HR_PolicyClubP	 =.;
HR_PolicyClubF	 =.;
HR_InteractClubP	 =.;
HR_InteractClubF	 =.;
HR_ActivityClubP	 =.;
HR_ActivityClubF	 =.;
HR_NGOCommunication	 =.;
HR_NGOService	 =.;
CE_AgencyGov	 =.;
CE_AgencyNGO	 =.;
CE_AgencyProfession	 =.;
CE_AgencyPrivate	 =.;
CE_AgencyInter	 =.;
CE_EmployAgency	 =.;
CE_SchoolStaff	 =.;
CE_SchoolStaffF	 =.;
CE_TotalSchool	 =.;
CE_SchoolActivity	 =.;
CE_PoliceEducation	 =.;
CE_JudgeEducation	 =.;
CE_PrisonPsychosis	 =.;
CE_PrisonRetard	 =.;
CE_PrisonTreat	 =.;
CP_ProjSite	 =.;
CP_ProjSchizoSite	 =.;
CP_ProjSchizoPatient	 =.;
CP_ProjEpilepsySite	 =.;
CP_ProjEpilepsyPatient	 =.;
CP_ProjDepressionSite	 =.;
CP_ProjDepressionPatient	 =.;
CP_ProjSchizoEpi	 =.;
CP_ProjSchizoEpiA	 =.;
CP_ProjSchizoEpiB	 =.;
CP_OtherModel	 =.;
CP_OtherModelSpec	 =.;
CP_AggressivePatient	 =.;
CP_DangerousPatient	 =.;
SV_ICD10	 =.;
MR_InvoluntaryAdmission	 =.;
GI_Commune	 =.;
SV_G40G41	 =.;
SV_F00F03	 =.;
SV_F10	 =.;
SV_F11F19	 =.;
SV_F20F29	 =.;
SV_F30F39	 =.;
SV_F40F48	 =.;
SV_F60F69	 =.;
SV_F70F79	 =.;
SV_ICD10Other	 =.;
SV_ProjectMed	 =.;
CP_PatientDrop	 =.;
SV_PrjMed5	 =.;
SV_MinorUse	 =.;
SV_CoopFacility	 =.;
SV_OutpatientKid	 =.;
SV_OutpatientKidSpec	 =.;
SV_MoTeam	 =.;
SV_MoPlace	 =.;
SV_Movil	 =.;
SV_MoHome	 =.;
SV_MoCoop	 =.;
SV_PrjMed1	 =.;
SV_PrjMed2	 =.;
SV_PrjMed3	 =.;
SV_PrjMed4	 =.;
SV_Private	 =.;
SV_PrivateWait	 =.;
SV_PrivateExam	 =.;
MR_LOS	 =.;
MR_MSA	 =.;
MR_NPH	 =.;
MR_PPH	 =.;
MR_PPS	 =.;
MR_PGH	 =.;
MR_PCDC	 =.;
MR_PHC	 =.;
CP_Participate	 =.;
SV_MoPlace1	 =.;
SV_MoPlace2	 =.;
SV_MoPlace3	 =.;
SV_MoPlace4	 =.;
SV_MoPlace5	 =.;
SV_MoPlace99	 =.;
SV_MoVil1	 =.;
SV_MoVil2	 =.;
SV_MoVil3	 =.;
SV_MoVil4	 =.;
SV_MoVil5	 =.;
SV_MoVil6	 =.;
SV_MoVil99	 =.;
SV_MoHome1	 =.;
SV_MoHome2	 =.;
SV_MoHome3	 =.;
SV_MoHome4	 =.;
SV_MoHome5	 =.;
SV_MoHome6	 =.;
SV_MoHome99	 =.;
SV_MoCoop1	 =.;
SV_MoCoop2	 =.;
SV_MoCoop3	 =.;
SV_MoCoop4	 =.;
SV_MoCoop5	 =.;
SV_MoCoop6	 =.;
SV_MoCoop7	 =.;
SV_MoCoop8	 =.;
SV_MoCoop9	 =.;
SV_MoCoop99	 =.;
end;
if GI_FacType in (9, 10, 11, 12, 13) then GI_PopProvince = .;
if GI_FacType in (9, 10, 11) then SV_RestrainF = .;
if GI_FacType in (12, 13) then do;
OS_DeptPersonnel = .;
SV_Inpatient13 = .;
SV_InpatientFemale13 = .;
MR_LOS = .;
MR_InvoluntaryAdmission = .;
end;
run;
/**********************************************************************************************/

/**********************************************************************************************/
*9. Binary recode: 0 to 2;
data data0307;set data2306;
array sync
SV_DownRef1
SV_DownRef2
SV_DownRef3
SV_DownRef4
SV_DownRef5
SV_DownRef6
SV_DownRef7
SV_DownRef98
SV_DownRef99
SV_UpRef1
SV_UpRef2
SV_UpRef3
SV_UpRef4
SV_UpRef5
SV_UpRef6
SV_UpRef7
SV_UpRef8
SV_UpRef9
SV_UpRef10
SV_UpRef11
SV_UpRef98
SV_UpRef99
SV_DirectAgency1
SV_DirectAgency2
SV_DirectAgency3
SV_DirectAgency4
SV_DirectAgency5
SV_DirectAgency6
SV_DirectAgency7
SV_DirectAgency8
SV_DirectAgency9
SV_DirectAgency99
SV_CoopCommContent1
SV_CoopCommContent2
SV_CoopCommContent3
SV_CoopCommContent4
SV_CoopCommContent5
SV_CoopCommContent98
SV_CoopCommContent99
SV_CommFreq1
SV_CommFreq2
SV_CommFreq3
SV_CommFreq4
SV_CommFreq5
SV_CommFreq6
SV_CommFreq99
SV_MoPlace1
SV_MoPlace2
SV_MoPlace3
SV_MoPlace4
SV_MoPlace5
SV_MoPlace99
SV_MoDist1
SV_MoDist2
SV_MoDist3
SV_MoDist4
SV_MoDist5
SV_MoDist6
SV_MoDist99
SV_MoComm1
SV_MoComm2
SV_MoComm3
SV_MoComm4
SV_MoComm5
SV_MoComm6
SV_MoComm99
SV_MoVil1
SV_MoVil2
SV_MoVil3
SV_MoVil4
SV_MoVil5
SV_MoVil6
SV_MoVil99
SV_MoHome1
SV_MoHome2
SV_MoHome3
SV_MoHome4
SV_MoHome5
SV_MoHome6
SV_MoHome99
SV_MoCoop1
SV_MoCoop2
SV_MoCoop3
SV_MoCoop4
SV_MoCoop5
SV_MoCoop6
SV_MoCoop7
SV_MoCoop8
SV_MoCoop9
SV_MoCoop99
PR_InteractMHPro1
PR_InteractMHPro2
PR_InteractMHPro3
PR_InteractMHPro4
PR_InteractMHPro5
PR_InteractMHPro6
PR_InteractMHPro99
PR_WhoPrescribe1
PR_WhoPrescribe2
PR_WhoPrescribe3
PR_WhoPrescribe4
PR_WhoPrescribe99
MR_Regular1
MR_Regular2
MR_Regular3
MR_Regular4
MR_Regular5
MR_Regular99
MR_SuperviseAgency1
MR_SuperviseAgency2
MR_SuperviseAgency3
MR_SuperviseAgency4
MR_SuperviseAgency5
MR_SuperviseAgency6
MR_SuperviseAgency7
MR_SuperviseAgency8
MR_SuperviseAgency9
MR_SuperviseAgency99
MR_SuperviseContent1
MR_SuperviseContent2
MR_SuperviseContent3
MR_SuperviseContent4
MR_SuperviseContent99;
do i=1 to 123;
if sync(i) = 0 then sync(i) = 2;end;run;

***Data check and editing;
data data2107;set data0307;
if PL_PlanYr='2011, 2013 ' then PL_PlanYr='2013';
if PL_PlanYr='2011; 2012 ' then PL_PlanYr='2012'; 
if PL_PlanYr='Cham soc suc khoe tam than ban Dau ' then PL_PlanYr='99999999'; 
if PL_PlanYr='De an 1215 cuc Lao Dong Thuong Binh va Xa Hoi ban hanh nam 2012 ' then PL_PlanYr='2012'; 
if PL_PlanYr='Khong biet ' then PL_PlanYr=' 99999999';
if PL_PlanYr='Nam 2013 ' then PL_PlanYr=' 2013';
if PL_PlanYr='Nam 2014 ' then PL_PlanYr=' 2014';
if PL_PlanYr='ban hanh tung nam (ke hoach nam) ' then PL_PlanYr='2014';
if PL_PlanYr='nam 2014' then PL_PlanYr='2014';run; 
data data2107;set data2107;
PL_PlanYr1=input(PL_PlanYr,8.0);
drop PL_PlanYr;rename PL_PlanYr1=PL_PlanYr;run;
data data2107;set data2107;
if PL_DisasterYr='So lao dong thuong binh va xa hoi' then PL_DisasterYr = '99999999';
if PL_DisasterYr='0' then PL_DisasterYr = ' ';run;
data data2107;set data2107;
PL_DisasterYr1 = input(PL_DisasterYr, 8.0);
drop PL_DisasterYr;rename PL_DisasterYr1 = PL_DisasterYr;run;
data data2107;set data2107;if GI_FacType in (9, 10, 11) then PL_DisasterYr = -1;run;
data data2407;set data2107;
if PL_PolicyYr = 41292 then PL_PolicyYr = 99999999;
if CP_ParticipateYrF5 = 4.2007 then CP_ParticipateYrF5 = 2007;
if CP_ParticipateYrF5 = 20113 then CP_ParticipateYrF5 = 2013;
if CP_ParticipateYrF5 = 20122 then CP_ParticipateYrF5 = 2012;
if CP_ParticipateYrF5 in (9999999, 999999999) then CP_ParticipateYrF5 = 99999999;
run;
data data2407;set data2407;
CP_StrengthUp = upcase(CP_Strength);
CP_InitiativeUp = upcase(CP_Initiative);
CP_ChallengeUp = upcase(CP_Challenge);
CP_ProposeUp = upcase(CP_Propose);
run;
data data2707;set data2407;
FI_AntidepMed1Up	 =upcase(	FI_AntidepMed1		);
FI_AntidepMed2Up	 =upcase(	FI_AntidepMed2		);
FI_AntidepMed3Up	 =upcase(	FI_AntidepMed3		);
FI_AntipsyMed1Up	 =upcase(	FI_AntipsyMed1		);
FI_AntipsyMed2Up	 =upcase(	FI_AntipsyMed2		);
FI_AntipsyMed3Up	 =upcase(	FI_AntipsyMed3		);
FI_AntipsyMed4Up	 =upcase(	FI_AntipsyMed4		);
SV_AvaiDrug1_ReUp	 =upcase(	SV_AvaiDrug1_Re		);
SV_AvaiDrug2_ReUp	 =upcase(	SV_AvaiDrug2_Re		);
SV_AvaiDrug3_ReUp	 =upcase(	SV_AvaiDrug3_Re		);
SV_AvaiDrug4_ReUp	 =upcase(	SV_AvaiDrug4_Re		);
SV_AvaiDrug5_ReUp	 =upcase(	SV_AvaiDrug5_Re		);
SV_PrjMed1_ReUp	 =upcase(	SV_PrjMed1_Re		);
SV_PrjMed2_ReUp	 =upcase(	SV_PrjMed2_Re		);
SV_PrjMed3_ReUp	 =upcase(	SV_PrjMed3_Re		);
SV_PrjMed4_ReUp	 =upcase(	SV_PrjMed4_Re		);
SV_PrjMed5_ReUp	 =upcase(	SV_PrjMed5_Re		);run;
/**********************************************************************************************/

/**********************************************************************************************/
*10. Assign skip pattern;
data data2907;set data2907;
array policy
PL_PolicyYr
PL_Policy1
PL_Policy2
PL_Policy3
PL_Policy4
PL_Policy5
PL_Policy6
PL_Policy7
PL_Policy8
PL_Policy9
PL_Policy10
PL_Policy11
PL_Policy12
PL_PolicyOther;
do i = 1 to 14;
if PL_Policy = 2 and policy(i) ne . then policy(i) = -1;
if PL_Policy = 98 and policy(i) ne . then policy(i) = 98;
end;
if PL_Policy = 2 and PL_PolicyName ne ' ' then PL_PolicyName = '-1';
if PL_Policy = 98 and PL_PolicyName ne ' ' then PL_PolicyName = '98';drop i;run;

data data2907;set data2907;
array psymed
PL_Antipsy1
PL_Antipsy2
PL_Anxio1
PL_Anxio2
PL_Antidep1
PL_Antidep2
PL_Mood
PL_Antiepi1
PL_Antiepi2;
do i = 1 to 9;if PL_Psymed in (2, 3) and psymed(i) ne . then psymed(i) = -1;end;drop i;run;

data data2907;set data2907;
array policyplan
PL_PlanYr
PL_Plan1
PL_Plan2
PL_Plan3
PL_Plan4
PL_Plan5
PL_Plan6
PL_Plan7
PL_Plan8
PL_Plan9
PL_Plan10
PL_Plan11
PL_Plan12
PL_Plan13
PL_PlanOther;
do i = 1 to 15;
if PL_Plan = 2 and policyplan(i) ne . then policyplan(i) = -1;
if PL_Plan = 98 and policyplan(i) ne . then policyplan(i) = 98;
end;
if PL_Plan = 2 and PL_PlanName ne ' ' then PL_PlanName = '-1';
if PL_Plan = 98 and PL_PlanName ne ' ' then PL_PlanName = '98';
if GI_FacType in (9, 10, 11) then PL_PlanYr = -1;
drop i;
run;

data data2907;set data2907;
if PL_Disaster = 2 and PL_DisasterYr ne . then PL_DisasterYr = -1;
if PL_Disaster = 2 and PL_DisasterName ne ' ' then PL_DisasterName = '-1';
if PL_Disaster = 98 and PL_DisasterYr ne . then PL_DisasterYr = 98;
if PL_Disaster = 98 and PL_DisasterName ne ' ' then PL_DisasterName = '98';run;

data data2907;set data2907;
array legal
PL_LegalYr
PL_Legal1
PL_Legal2
PL_Legal3
PL_Legal4
PL_Legal5
PL_Legal6
PL_Legal7
PL_Legal8
PL_Legal9;
do i = 1 to 10;
if PL_Legal = 2 and legal(i) ne . then legal(i) = -1;
if PL_Legal = 98 and legal(i) ne . then legal(i) = 98;
end;
if PL_Legal = 2 and PL_LegalName ne ' ' then PL_LegalName = '-1';
if PL_Legal = 98 and PL_LegalName ne ' ' then PL_LegalName = '98';
drop i;run;

data data2907;set data2907;
array mobile
SV_MoPlace1
SV_MoPlace2
SV_MoPlace3
SV_MoPlace4
SV_MoPlace5
SV_MoPlace99
SV_MoVil1
SV_MoVil2
SV_MoVil3
SV_MoVil4
SV_MoVil5
SV_MoVil6
SV_MoVil99
SV_MoHome1
SV_MoHome2
SV_MoHome3
SV_MoHome4
SV_MoHome5
SV_MoHome6
SV_MoHome99
SV_MoCoop1
SV_MoCoop2
SV_MoCoop3
SV_MoCoop4
SV_MoCoop5
SV_MoCoop6
SV_MoCoop7
SV_MoCoop8
SV_MoCoop9
SV_MoCoop99;
do i = 1 to 30;
if SV_MoTeam = 2 and mobile(i) ne . then mobile(i) = -1;
if SV_MoTeam = 98 and mobile(i) ne . then mobile(i) = 98;
end;drop i;run;

data data2907;set data2907;
array mobile2
SV_MoDist1
SV_MoDist2
SV_MoDist3
SV_MoDist4
SV_MoDist5
SV_MoDist6
SV_MoDist99
SV_MoComm1
SV_MoComm2
SV_MoComm3
SV_MoComm4
SV_MoComm5
SV_MoComm6
SV_MoComm99;
do i = 1 to 14;
if SV_MoTeam = 2 and GI_FacType in (7, 8) and mobile2(i) ne . then mobile2(i) = -1;
if SV_MoTeam = 98 and GI_FacType in (7, 8) and mobile2(i) ne . then mobile2(i) = 98;
end;drop i;run;

data data2907;set data2907;
array private
SV_PrivateWait
SV_PrivateExam;
do i = 1 to 2;
if SV_Private = 2 and private(i) ne . then private(i) = -1;
if SV_Private = 98 and private(i) ne . then private(i) = 98;
end;drop i;run;

data data2907;set data2907;
if SV_Private = 2 and GI_FacType in(1, 2, 3, 4, 5, 6) and SV_PrivateBed ne . then SV_PrivateBed = -1;
if SV_Private = 98 and GI_FacType in(1, 2, 3, 4, 5, 6) and SV_PrivateBed ne . then SV_PrivateBed = 98;
run;

data data2907;set data2907;
array club
HR_ClubPatient
HR_ClubFamily
HR_SupportClubP
HR_SupportClubF
HR_PolicyClubP
HR_PolicyClubF
HR_InteractClubP
HR_InteractClubF
HR_ActivityClubP
HR_ActivityClubF
HR_NGOCommunication
HR_NGOService;
do i = 1 to 12;
if HR_Club = 2 and club(i) ne . then club(i) = -1;
if HR_Club = 98 and club(i) ne . then club(i) = 98;
end; drop i; run;

data data2907;set data2907;
MR_ReportAgency = 1;
if sum(of MR_MSA
MR_MOLISA
MR_DOH
MR_DOLISA
MR_NPH
MR_PPH
MR_PPS
MR_PGH
MR_PCDC
MR_PHC
MR_RepOther) = 22 then MR_ReportAgency = 2;
run;

data data2907;set data2907;
array report
MR_Regular1
MR_Regular2
MR_Regular3
MR_Regular4
MR_Regular5
MR_Regular99;
do i = 1 to 6;
if MR_ReportAgency = 2 and report(i) ne . then report(i) = -1;
end;drop i;run;

data data2907;set data2907;
array supervise
MR_SuperviseAgency1
MR_SuperviseAgency2
MR_SuperviseAgency3
MR_SuperviseAgency4
MR_SuperviseAgency5
MR_SuperviseAgency6
MR_SuperviseAgency7
MR_SuperviseAgency8
MR_SuperviseAgency9
MR_SuperviseAgency99
MR_SuperviseContent1
MR_SuperviseContent2
MR_SuperviseContent3
MR_SuperviseContent4
MR_SuperviseContent99;
do i = 1 to 15;
if MR_Supervise13 = 2 and supervise(i) ne . then supervise(i) = -1;
if MR_Supervise13 = 98 and supervise(i) ne . then supervise(i) = 98;
end;drop i;run;

data data2907;set data2907;
array patient54
CP_SchizoPatientF54
CP_EpilepsyPatientF54
CP_DepressionPatientF54
CP_OtherPatientF54;
do i = 1 to 4;
if CP_Participate = 2 and GI_FacType in (9, 10, 11) and patient54(i) ne . then patient54(i) = -1;
end;
array patientall
CP_ProjSite
CP_ProjSchizoSite
CP_ProjSchizoPatient
CP_ProjEpilepsySite
CP_ProjEpilepsyPatient
CP_ProjDepressionSite
CP_ProjDepressionPatient
CP_ProjSchizoEpi
CP_ProjSchizoEpiA
CP_ProjSchizoEpiB
CP_OtherModel
CP_AggressivePatient
CP_DangerousPatient;
do j = 1 to 13;
if CP_Participate = 2 and GI_FacType in (1, 2, 3, 4, 5, 6, 7, 8) and patientall(j) ne . then patientall(j) = -1;end;
if CP_Participate = 2 and GI_FacType = 11 and CP_ParticipateYrF5 ne . then CP_ParticipateYrF5 = -1;
if CP_Participate = 2 and GI_FacType = 11 and CP_Participate13F5 ne . then CP_Participate13F5 = -1;
if CP_Participate = 2 and GI_FacType not in (12, 13) and CP_PatientDrop ne . then CP_PatientDrop = -1;
drop i j;
run;

data data2907;set data2907;
array coopcomm
SV_CoopCommContent1
SV_CoopCommContent2
SV_CoopCommContent3
SV_CoopCommContent4
SV_CoopCommContent5
SV_CoopCommContent98
SV_CoopCommContent99;
do i = 1 to 7;
if SV_CoopComm = 2 and coopcomm(i) ne . then coopcomm(i) = -1;
end;drop i;run;

data data2907;set data2907;
array prescribe 
PR_WhoPrescribe1
PR_WhoPrescribe2
PR_WhoPrescribe3
PR_WhoPrescribe4
PR_WhoPrescribe99;
do i = 1 to 5;
if PR_Prescribe in (1, 4) and prescribe(i) ne . then prescribe(i) = -1;
end;drop i;run;

***Data check and editing;

data data0408;set data2907;
if GI_FacType in (9, 10, 11) then FI_TotalRevRecal = -1;
if GI_FacType not in (1, 2, 3, 4, 6, 7, 8) then FI_Project13Recal = -1;
FI_MHSpend13Recal = -1;
if GI_FacType in (6, 7, 8, 12, 13) then FI_MHSpend13Recal = FI_TotalSpendRecal;
if GI_FacType not in (1, 2, 3, 4, 5) then FI_TotalSpendRecal = -1;
if GI_FacType in (11, 12, 13) then SV_ICD10Recal = -1;
if GI_FacType not in (1, 2, 3, 4, 5, 12, 13) then SV_InpatientTimeRecal = -1;
if GI_FacType in (9, 10, 11, 12, 13) then SV_FProvinceBedRecal = -1;
if GI_FacType in (9, 10, 11, 12, 13) then SV_ForensicLoSRecal = -1;
HR_PsyDeptStaffRecal = -1;
if GI_FacType not in (1, 2, 3, 4, 5, 12, 13) then HR_PsyDeptStaffRecal = HR_StaffRecal;
if GI_FacType in (9, 10, 11) then MR_ResearchStaffRecal = -1;
if GI_FacType not in (9, 10, 11) then CP_Patient13F54Recal = -1;
if GI_FacType in (9, 10, 11, 12, 13) then CP_ProjSiteRecal = -1;
run;

***Create questionnaire variable;
data data0408;set data0408;
Questionnaire = .;
if GI_FacType in (1, 2, 3, 4) then Questionnaire = 1;
if GI_FacType = 6 then Questionnaire = 2;
if GI_Factype in (7, 8) then Questionnaire = 3;
if gi_factype in (9, 10) then Questionnaire = 4;
if gi_factype = 11 then Questionnaire = 5;
if gi_factype = 5 then Questionnaire = 6;
if gi_factype in (12, 13) then Questionnaire = 7;
if GI_ID='Y01b' then GI_Manage = 99;
if GI_ID = 'Y82a' then GI_Manage = 2;
run;
proc format;
value quest 1 = 'Form 1'
2 = 'Form 2'
3 = 'Form 3'
4 = 'Form 4'
5 = 'Form 5'
6 = 'Form 6'
7 = 'Form 7';run;
data data0408;set data0408;format Questionnaire quest.;run;

***Fix information of ecological region;
data data0408;set data0408;
if facilityprovince = 'AN GIANG' then gi_eco =	6	 ;
if facilityprovince = 'BEN TRE' then gi_eco =	6	 ;
if facilityprovince = 'CAN THO' then gi_eco =	6	 ;
if facilityprovince = 'DAK LAK' then gi_eco =	4	 ;
if facilityprovince = 'DONG THAP' then gi_eco =	6	 ;
if facilityprovince = 'HA GIANG' then gi_eco =	2	 ;
if facilityprovince = 'HA NOI' then gi_eco =	1	 ;
if facilityprovince = 'HUNG YEN' then gi_eco =	1	 ;
if facilityprovince = 'KHANH HOA' then gi_eco =	3	 ;
if facilityprovince = 'KIEN GIANG' then gi_eco =	6	 ;
if facilityprovince = 'LANG SON' then gi_eco =	2	 ;
if facilityprovince = 'NINH BINH' then gi_eco =	1	 ;
if facilityprovince = 'PHU THO' then gi_eco =	2	 ;
if facilityprovince = 'PHU YEN' then gi_eco =	3	 ;
if facilityprovince = 'QUANG BINH' then gi_eco =	3	 ;
if facilityprovince = 'THAI BINH' then gi_eco =	1	 ;
if facilityprovince = 'THAI NGUYEN' then gi_eco =	2	 ;
if facilityprovince = 'THANH HOA' then gi_eco =	3	 ;
if facilityprovince = 'THANH PHO HO CHI MINH' then gi_eco =	5	 ;
if facilityprovince = 'VINH LONG' then gi_eco =	6	 ;
if gi_id = '4044227' then gi_manage = 3;
if gi_manage = . and gi_factype in (7, 9, 10) then gi_manage = 2;
if gi_manage = . and gi_factype = 11 then gi_manage = 3;run;
 
data data0408;set data0408;
if facilityprovince in('QUANG NINH', 'VINH PHUC', 'HAI DUONG') then gi_eco = 1;
if facilityprovince in ('THUA THIEN HUE', 'BINH THUAN', 'QUANG NGAI') then gi_eco = 3;
if facilityprovince in ('DAK NONG', 'LAM DONG') then gi_eco = 4;
if facilityprovince in ('BAC LIEU', 'LONG AN', 'SOC TRANG', 'TRA VINH', 'TIEN GIANG') then gi_eco = 6;
if facilityprovince = 'BINH PHUOC' then gi_eco = 5;run;

***Adjust number of staff in CHSs not to exceed 13;
data data0909;set data0408;
array chs
HR_PsyDeptStaff
HR_Psychiatrist
HR_OtherDocs
HR_DocAssistF5
HR_Nurse
HR_Psychologist
HR_SocWorker
HR_Occupation
HR_PharmaUni
HR_PharmaSecond
HR_Midwives
HR_Technician
HR_TradMed
HR_StaffOthr;
do i = 1 to 14;
if questionnaire = 5 and chs(i) > 13 then chs(i) = 13;
end;drop i;run;
/**********************************************************************************************/

/**********************************************************************************************/
*11. Imputation: Assign mean values of communes in each district for communes with missing values;
proc sort data=data0909;by facilityprovince facilitydistrict;run;
proc standard data=data0909 replace;where questionnaire = 5;
var 
HR_Psychiatrist
HR_OtherDocs
HR_DocAssistF5
HR_Nurse
HR_Psychologist
HR_SocWorker
HR_Occupation
HR_PharmaUni
HR_PharmaSecond
HR_Midwives
HR_Technician
HR_TradMed
HR_StaffOthr;
by facilityprovince facilitydistrict;run;

***A fraction of observations have missing values of all communes of the district, resulting in missing values not to be replaced
in the previous step. For these cases, assign mean values of communes in province for communes in districts with non-missing values
at communes;
proc standard data=data1 replace;
var 
HR_Psychiatrist
HR_OtherDocs
HR_DocAssistF5
HR_Nurse
HR_Psychologist
HR_SocWorker
HR_Occupation
HR_PharmaUni
HR_PharmaSecond
HR_Midwives
HR_Technician
HR_TradMed
HR_StaffOthr;
by facilityprovince;run;

***Assign mean values of district facilities;
proc standard data=data0909 replace;where questionnaire = 4;
var 
HR_Psychiatrist
HR_OtherDocs
HR_Nurse
HR_Psychologist
HR_SocWorker
HR_Occupation
HR_PharmaUni
HR_PharmaSecond
HR_Midwives
HR_Technician
HR_StaffOthr;
by facilityprovince;run;

proc means data=data2909 nmiss;where questionnaire=4;
var
HR_Psychiatrist
HR_OtherDocs
HR_Nurse
HR_Psychologist
HR_SocWorker
HR_Occupation
HR_PharmaUni
HR_PharmaSecond
HR_Midwives
HR_Technician
HR_StaffOthr;
run;
proc means data=data2 nmiss;where questionnaire=4;
var
HR_Psychiatrist
HR_OtherDocs
HR_Nurse
HR_Psychologist
HR_SocWorker
HR_Occupation
HR_PharmaUni
HR_PharmaSecond
HR_Midwives
HR_Technician
HR_StaffOthr;
run;

data data2;set data2;
keep gi_id 
HR_Psychiatrist
HR_OtherDocs
HR_DocAssistF5
HR_Nurse
HR_Psychologist
HR_SocWorker
HR_Occupation
HR_PharmaUni
HR_PharmaSecond
HR_Midwives
HR_Technician
HR_TradMed
HR_StaffOthr;run;
data data2;set data2;
rename
HR_Psychiatrist = HR_PsychiatristCMN
HR_OtherDocs = HR_OtherDocsCMN
HR_DocAssistF5 = HR_DocAssistF5CMN
HR_Nurse = HR_NurseCMN
HR_Psychologist = HR_PsychologistCMN
HR_SocWorker = HR_SocWorkerCMN
HR_Occupation = HR_OccupationCMN
HR_PharmaUni = HR_PharmaUniCMN
HR_PharmaSecond = HR_PharmaSecondCMN
HR_Midwives = HR_MidwivesCMN
HR_Technician = HR_TechnicianCMN
HR_TradMed = HR_TradMedCMN
HR_StaffOthr = HR_StaffOthrCMN;
run;
data data3;set data3;keep gi_id
HR_Psychiatrist
HR_OtherDocs
HR_Nurse
HR_Psychologist
HR_SocWorker
HR_Occupation
HR_PharmaUni
HR_PharmaSecond
HR_Midwives
HR_Technician
HR_StaffOthr;run;
data data3;set data3;rename
HR_Psychiatrist = HR_PsychiatristCMN
HR_OtherDocs = HR_OtherDocsCMN
HR_Nurse = HR_NurseCMN
HR_Psychologist = HR_PsychologistCMN
HR_SocWorker = HR_SocWorkerCMN
HR_Occupation = HR_OccupationCMN
HR_PharmaUni = HR_PharmaUniCMN
HR_PharmaSecond = HR_PharmaSecondCMN
HR_Midwives = HR_MidwivesCMN
HR_Technician = HR_TechnicianCMN
HR_StaffOthr = HR_StaffOthrCMN;run;
proc sort data=data0909;by gi_id;run;
proc sort data=data2;by gi_id;run;
proc sort data=data3;by gi_id;run;
data data23;set data2 data3;run;
proc sort data=data23;by gi_id;run;
data data3009;merge data0909 (in=f0909x) data23 (in=f23x);by gi_id;
f2909=f2909x;f23=f23x;run;
data data3009;set data3009;if f23=1 then do;
HR_DocAssistF5	 =	HR_DocAssistF5CMN	 ;
HR_Midwives	 =	HR_MidwivesCMN	 ;
HR_Nurse	 =	HR_NurseCMN	 ;
HR_Occupation	 =	HR_OccupationCMN	 ;
HR_OtherDocs	 =	HR_OtherDocsCMN	 ;
HR_PharmaSecond	 =	HR_PharmaSecondCMN	 ;
HR_PharmaUni	 =	HR_PharmaUniCMN	 ;
HR_Psychiatrist	 =	HR_PsychiatristCMN	 ;
HR_Psychologist	 =	HR_PsychologistCMN	 ;
HR_SocWorker	 =	HR_SocWorkerCMN	 ;
HR_StaffOthr	 =	HR_StaffOthrCMN	 ;
HR_Technician	 =	HR_TechnicianCMN	 ;
HR_TradMed	 =	HR_TradMedCMN	 ;
end;run;
data data3009;set data3009;
drop HR_DocAssistF5CMN 
HR_MidwivesCMN 
HR_NurseCMN 
HR_OccupationCMN 
HR_OtherDocsCMN 
HR_PharmaSecondCMN 
HR_PharmaUniCMN 
HR_PsychiatristCMN 
HR_PsychologistCMN 
HR_SocWorkerCMN 
HR_StaffOthrCMN 
HR_TechnicianCMN 
HR_TradMedCMN 
f2909 f23
;run;
/**********************************************************************************************/

/**********************************************************************************************/
*12. Derived variables;
***Create a new staff variable to match with result template;
data data3009;set data3009;
HR_NewStaffOther = .;
array hrnew
HR_DocAssistF5
HR_PsyNurse
HR_PharmaUni
HR_PharmaSecond
HR_Midwives
HR_Technician
HR_TradMed
HR_StaffOthr;
do i = 1 to 8;
if hrnew(i) ne . then HR_NewStaffOther = sum(of hrnew(*));
end;drop i;run;
data data3009;set data3009;
HR_StaffPsySWOc = .;
array ahr
HR_Psychologist
HR_SocWorker
HR_Occupation;
do i = 1 to 3;
if ahr(i) ne . then HR_StaffPsySWOc = sum(of ahr(*));
end;drop i;run;

***Calculate ratio of staff per bed;
data data3009;set data3009;
HR_PsychiatristPerBed = HR_Psychiatrist/SV_BedFact13;
HR_OtherDocsPerBed = HR_OtherDocs/SV_BedFact13;
HR_NursePerBed = HR_Nurse/SV_BedFact13;
HR_PsySWOcPerBed = HR_StaffPsySOWc/SV_BedFact13;
HR_StaffOtherPerBed = HR_NewStaffOther/SV_BedFact13;run;

***Calculate proportion of refresher training staff;
data data3009;set data3009;
HR_TrainDrugAPro = HR_TrainDrugA/HR_TrainDrugRecal*100;
HR_TrainDrugBPro = HR_TrainDrugB/HR_TrainDrugRecal*100;
HR_TrainDrugCPro = HR_TrainDrugC/HR_TrainDrugRecal*100;
HR_TrainDrugDPro = HR_TrainDrugD/HR_TrainDrugRecal*100;
HR_TrainDrugEPro = HR_TrainDrugE/HR_TrainDrugRecal*100;

HR_TrainSocPsyAPro = HR_TrainSocPsyA/HR_TrainSocPsyRecal*100;
HR_TrainSocPsyBPro = HR_TrainSocPsyB/HR_TrainSocPsyRecal*100;
HR_TrainSocPsyCPro = HR_TrainSocPsyC/HR_TrainSocPsyRecal*100;
HR_TrainSocPsyDPro = HR_TrainSocPsyD/HR_TrainSocPsyRecal*100;
HR_TrainSocPsyEPro = HR_TrainSocPsyE/HR_TrainSocPsyRecal*100;

HR_TrainKidAPro = HR_TrainKidA/HR_TrainKidRecal*100;
HR_TrainKidBPro = HR_TrainKidB/HR_TrainKidRecal*100;
HR_TrainKidCPro = HR_TrainKidC/HR_TrainKidRecal*100;
HR_TrainKidDPro = HR_TrainKidD/HR_TrainKidRecal*100;
HR_TrainKidEPro = HR_TrainKidE/HR_TrainKidRecal*100;

HR_TrainDrugPro = HR_TrainDrugRecal/HR_StaffRecal*100;
HR_TrainSocPsyPro = HR_TrainSocPsyRecal/HR_StaffRecal*100;
HR_TrainKidPro = HR_TrainKidRecal/HR_StaffRecal*100;
run;

***Proportion of human resources working in mental hospitals compared to other facilities by region;
data data3009;set data3009;
FacHospital = .;
if questionnaire in (1, 6) then FacHospital = 1;
else FacHospital = 0;run;

proc freq data=data3009;table questionnaire FacHospital;run;
data hospital;set data3009;keep FacilityProvince GI_ID FacHospital GI_Eco HR_StaffRecal;run;
proc means data=hospital nway;class GI_Eco FacilityProvince FacHospital; var HR_StaffRecal;output out=hospitalout sum=total;run;
proc sort data=hospitalout;by FacilityProvince;run;
proc transpose data=hospitalout out=hospitalwide prefix=staff;
by FacilityProvince;
id FacHospital;
var total;run;
data eco;set hospitalout;keep GI_Eco FacilityProvince;run;
proc sort data=eco nodupkey;by FacilityProvince;run;
proc sort data=hospitalwide;by FacilityProvince;run;
data hospitaleco;merge hospitalwide eco;by FacilityProvince;run;
data hospitaleco;set hospitaleco;
staffratio = staff1/(staff1+staff0)*100;run;
proc means data=hospitaleco n mean min p25 median p75 max sum;var staffratio;class GI_Eco;run;

***Create total number of schizophrenia and epilepsy patients under the management of CMHP;
data data1510;set data3009;
CP_TotalSchizo = .;
CP_TotalEpi = .;
array apatient
CP_ProjSchizoPatient
CP_ProjSchizoEpiB
CP_ProjEpilepsyPatient
CP_ProjSchizoEpiA;
do i = 1 to 2;
if apatient(i) ne . then CP_TotalSchizo = sum(of apatient(1), apatient(2));end;
do j = 3 to 4;
if apatient(j) ne . then CP_TotalEpi = sum(of apatient(3), apatient(4));end;
drop i j;run;

***Create a variable showing level of facility and routine follow-up community care;
data data0411;set data1510;
if gi_factype in (1, 2) then FacilityLevel = 1;
if gi_factype in (3, 4, 5, 6, 7, 8) then FacilityLevel = 2;
if gi_factype in (9, 10) then FacilityLevel = 3;
if gi_factype = 11 then FacilityLevel = 4;
if gi_factype in (12, 13) then FacilityLevel =5;
label FacilityLevel = 'Facility Level';
if SV_CommFreq6 = . then SV_CommFreqRe = .;
else if SV_CommFreq6 = 1 then SV_CommFreqRe = 2;
else SV_CommFreqRe = 1;
label SV_CommFreqRe = 'Whether the facility provided routine follow-up community care in 2013'
SV_InpatientLoS = 'Cumulative number of days on which users were present in mental health day treatment facilities in the previous year? F1 Q54a ; F2 Q46 ; F6 Q53 ; F7 Q46'
;run;

***Assigning variable of facility cooperation to social service sector facilities;
data data0411;set data0411;
if SV_CoopInpF7=1 and SV_CoopOutpF7 = 1 then SV_CoopFacility=1;
if SV_CoopInpF7=2 or SV_CoopOutpF7 = 2 then SV_CoopFacility=2;
run;

***Create proportion of patients who have to pay at least 20% of psychotropic medicines among those treated in facilities;
data data0511;set data0411;
FI_OOPayPct = .;run;
data data0511;set data0511;
if questionnaire = 3 then FI_OOPayPct = FI_OOPPay/(SV_ExamTreatTimes + SV_PttTreat13)*100;
if questionnaire in (1, 2, 6) then FI_OOPayPct = FI_OOPPay/SV_Inpatient13*100;
if questionnaire = 7 then FI_OOPayPct = FI_OOPPay/SV_CareTreatFact13*100;run;

***Create proportion of female patients;
data data0511;set data0511;
SV_ExamFemale13Pct = .;
SV_InpatientFemale13Pct=.;
SV_FemaleTreat13Pct=.;
SV_CareTreat13FemalePct=.;
if questionnaire in (1, 6) then SV_ExamFemale13Pct = SV_ExamFemale13/SV_ExamPatient13*100;
if questionnaire in (1, 2, 6) then SV_InpatientFemale13Pct = SV_InpatientFemale13/SV_Inpatient13*100;
if questionnaire in (3, 4, 5) then SV_FemaleTreat13Pct = SV_FemaleTreat13/SV_PttTreat13*100;
if questionnaire = 7 then SV_CareTreat13FemalePct = SV_CareTreat13Female/SV_CareTreatFact13*100;
run;

***Create proportion of involuntary admissions- form 1,2,6;
data data0511;set data0511;
SV_InvoluntaryAdmissionPct=.;
SV_InvoluntaryAdmissionPct=SV_InvoluntaryAdmission/SV_AllOutpatient*100;
run;

***Create proportion of Children and adolescent patients;
data data0511;set data0511;
SV_Inpatient17Pct = SV_Inpatient17/SV_AllInpatient*100;
SV_Inpatient15Pct = SV_Inpatient15/SV_AllInpatient*100;
run;

/**********************************************************************************************/
