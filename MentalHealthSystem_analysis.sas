/**********************************************************************************************
MENTAL HEALTH SYSTEM SURVEY
Created and updated by: Nhan La
Date: 2015/12/04
Summary: This program performs descriptive analysis of facilities in domains 1, 2 and 3
**********************************************************************************************/

libname analysis 'C:\Users\nhanl\Documents\VN Mental Health System Survey\Data\For analysis\Data package';
data data0511;set analysis.data0511;run;

*Create a variable showing level of facility and routine follow-up community care;
data data0511;set data0511;
if gi_factype in (1, 2) then FacilityLevel = 1;
if gi_factype in (3, 4, 5, 6, 7, 8) then FacilityLevel = 2;
if gi_factype in (9, 10) then FacilityLevel = 3;
if gi_factype = 11 then FacilityLevel = 4;
if gi_factype in (12, 13) then FacilityLevel =5;
label FacilityLevel = 'Facility Level';
;run;

*Format variable values;
proc format;
value questz 1='National Psychiatric Hospital, National Institute of Mental Health, Provincial Psychiatric Hospital, and Mental Health Station'
2 = 'Provincial General Hospital with Mental Health Ward'
3 = 'Provincial Social Disease Protection and Control Center with Mental Health Ward'
4 = 'District Health Center, General Hospital'
5 = 'Commune Health Station'
6 = 'Mental Health Day treatment Hospital'
7 = 'Social Protection Center for People with Mental Disorders or mixed center under social sector';
value faclevelz 1='National level'
2 = 'Provincial level'
3 = 'District level'
4 = 'Commune level'
5 = 'Social services sector';
value	GI_Ecoz	1='Red river delta'
2='Northern midlands and mountain areas'
3='North Central and Central coastal areas'
4= 'Central Highlands'
5='South East'
6='Mekong river delta';
value	GI_Managez	1='Ministry of Health'
2='Department of Health'
3='District Health Centre'
4='Ministry of Labour, Invalids and Social Affairs'
5='Department of Labour, Invalids and Social Affairs'
6='Other';
value	GI_FacTypez	1='National Psychiatric Hospital'
2='National Institute of Mental Health'
3='Provincial Psychiatric Hospital'
4='Provincial Mental Health Station'
5='Mental Health Day treatment Hospital'
6='Provincial General Hospital with Mental Health Ward'
7='Provincial Social Disease Protection and Control Centre with Mental Health Ward'
8='Provincial Preventive Medicine with Mental Health Ward'
9='District Health Centre'
10='District Hospital'
11='Commune Health Station'
12='Social Protection Centre' 
13='Nursing and Rehabilitation Centre for PWMD'
99='Other';
value	GI_ServiceTypez	
1='In-patient' 2='Out-patient' 3='Both' 
4='Diagnosis and referral' 5='No services' 6='Supervision and management' 99='Others';
value	GI_Clientsz	
		1='People with mental disorders only' 2='People with mental disorders and others';
value	GI_IntegrateFacz	1='Independent' 2='Integrated';
value	PL_PsyMedz	1='Yes' 2='No' 3='There is no essential medicines list in the facility' 99='Others';
value	FI_InsurancePayz	1='No mental disorder is covered by social insurance schemes'
2='Only (some) severe mental disorders are covered by social insurance schemes'
3='All severe and some mild mental disorders are covered' 
4='All mental disorders are covered'
5='All mental disorders and all mental health problems of clinical concern are covered'
98='Unknown'	  ;
value 	SV_ExamTreatFreqz	1='Daily' 2='Weekly' 3='Bi-weekly' 99='Others'  ;
value	SV_ExamTreatDeptz	1='Mental health dept/ward' 2='Out-patient dept/ward' 3='General internal dept/ward' 99='Other' ;
value	SV_RestrainPz	1='Over 20% of patients' 2=' 11-20% of patients' 3='6-10% of patients' 4='2-5% of patients' 5='0-1% of patients' 98='Unknown' 	 ;
value	SV_PsyTherapyPz	1='None (0%)' 2='A few (1 - 20%)' 3='Some (21 - 50%)' 4='The majority (51 - 80%)' 5='All or almost all (81 - 100%)' 98='Unknown' 	  ;
value	SV_Antipsychoticz	1='Always' 2='Sometimes' 3='None'  ;
value	SV_Anxiolyticz	1='Always' 2='Sometimes' 3='None'	   ;
value	SV_Antidepressantz	1='Always' 2='Sometimes' 3='None'	   ;
value	SV_MoodStablez	1='Always' 2='Sometimes' 3='None'	   ;
value	SV_Antiepilepticz	1='Always' 2='Sometimes' 3='None'	   ;
value	SV_RuralUsez	1='Substantially over-represented in their use of services'
2='Roughly equally represented in their use of services'
3='Substantially under-represented in their use of services'
98='NA'	  ;
value	SV_MinorUsez	1='Substantially over-represented in their use of services'
2='Roughly equally represented in their use of services'
3='Substantially under-represented in their use of services'
98='NA'	   ;
value	SV_Privatez	1='Great difference' 2='No difference' 98='Unknown'	   ;
value	SV_PrivateWaitz	1='Great difference' 2='No difference' 98='Unknown'	   ;
value	SV_PrivateExamz	1='Great difference' 2='No difference' 98='Unknown'	   ;
value	SV_PrivateBedz	1='Great difference' 2='No difference' 98='Unknown'	   ;
value	PR_Prescribez	1='Not allowed'
2='Primary health care doctors are allowed to prescribe but with restrictions' 
3='Primary health care doctors are allowed to prescribe without restrictions'
4='NA';
value	HR_PsyDeptInChargez	1='Psychiatrist'
2='Non-specialized in psychiatry doctor'
3='Doctor Assisstant'
4='Nurse'
99='Other'	  ;
value	HR_AbroadPz	1='none (0%)'
2='A few (1 - 20%)' 
3='Some (21 - 50%)' 
4='The majority (51 - 80%)'
5='All or almost all (81 - 100%)'
98='Unknown' 	  ;
value	CE_SchoolActivityz	1='No primary and secondary schools (0%)'
2='A few primary and secondary schools (1%-20%)' 
3='Some primary and secondary schools (21%-50%)' 
4='Many primary and secondary schools (51%-80%)' 
5='All or almost all primary and secondary schools (81%-100%)'
98='Unknown';
value	CE_PoliceEducationz	1='No police officers (0%)'
2='Few police officers (1%-20%)' 
3='Some police officers (21%-50%)' 
4='Many police officers (51%-80%)'
5='All or almost all police officers (81%-100%)'
98='Unknown'	  ;
value	CE_JudgeEducationz	1='No judges and lawyers (0%)'
2='Few judges and lawyers (1%-20%)'
3='Some judges and lawyers (21%-50%)'
4='Many judges and lawyers (51%-80%)'
5='All or almost all judges and lawyers (81%-100%)'
98='Unknown'	  ;
value	CE_PrisonPsychosisz	1='Less than 2%'
2='2-5 %'
3='6-10%'
4='11-15%'
5='Greater than 15%'
98='Unknown' 	  ;
value	CE_PrisonRetardz	1='Less than 2%'
2='2-5 %'
3='6-10%'
4='11-15%'
5='Greater than 15%'
98='Unknown' 	  ;
value	CE_PrisonTreatz	1='No prisons (0%)'
 2='A few prisons (1 - 20%)'
 3='Some prisons (21 - 50%)'
4='Majority of prisons (51 - 80%)'
5='All or almost all prisons (81 - 100%)'
98='Unknown'	  ;
value	MR_ReportGov13z	1='No report'
2='Mental health data was published in a report without comments on the data'
3='Mental health data was published in a report with comments on the data'
98='Unknown'	  ;
value others
1='Yes'
2='No'
98='Unknown';
run;

data data0511;set data0511;format
Questionnaire questz.
FacilityLevel faclevelz.
GI_Eco	GI_Ecoz.
GI_Manage	GI_Managez.
GI_FacType	GI_FacTypez.
GI_ServiceType	GI_ServiceTypez.
GI_Clients	GI_Clientsz.
GI_IntegrateFac	GI_IntegrateFacz.
PL_PsyMed	PL_PsyMedz.
FI_InsurancePay	FI_InsurancePayz.
SV_ExamTreatFreq	SV_ExamTreatFreqz.
SV_ExamTreatDept	SV_ExamTreatDeptz.
SV_RestrainP	SV_RestrainPz.
SV_PsyTherapyP	SV_PsyTherapyPz.
SV_Antipsychotic	SV_Antipsychoticz.
SV_Anxiolytic	SV_Anxiolyticz.
SV_Antidepressant	SV_Antidepressantz.
SV_MoodStable	SV_MoodStablez.
SV_Antiepileptic	SV_Antiepilepticz.
SV_RuralUse	SV_RuralUsez.
SV_MinorUse	SV_MinorUsez.
SV_Private	SV_Privatez.
SV_PrivateWait	SV_PrivateWaitz.
SV_PrivateExam	SV_PrivateExamz.
SV_PrivateBed	SV_PrivateBedz.
PR_Prescribe	PR_Prescribez.
HR_PsyDeptInCharge	HR_PsyDeptInChargez.
HR_AbroadP	HR_AbroadPz.
CE_SchoolActivity	CE_SchoolActivityz.
CE_PoliceEducation	CE_PoliceEducationz.
CE_JudgeEducation	CE_JudgeEducationz.
CE_PrisonPsychosis	CE_PrisonPsychosisz.
CE_PrisonRetard	CE_PrisonRetardz.
CE_PrisonTreat	CE_PrisonTreatz.
MR_ReportGov13	MR_ReportGov13z.
OS_DeptPlan
OS_DeptPersonnel 
OS_DeptPersonnel
OS_DeptFinance
OS_DeptMedicine
OS_DeptPersonAdmin
OS_DeptCommunity
OS_DeptTraining
OS_DeptResearch
OS_DeptAdmin
OS_DeptEquipment
OS_DeptNursing
OS_DeptOther
OS_CliEmergency
OS_CliOutpatient
OS_CliMale
OS_CliFemale
OS_CliPediatric
OS_CliInfection
OS_CliTradition
OS_CliRehab
OS_CliSubstance
OS_CliForensic
OS_CliTreatRehab
OS_CliNutrition
OS_CliOther
OS_PCliTesting
OS_PCliImaging
OS_PCliInfection
OS_PCliPharma
OS_PCliOther
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
PL_Antipsy1
PL_Antipsy2
PL_Anxio1
PL_Anxio2
PL_Antidep1
PL_Antidep2
PL_Mood
PL_Antiepi1
PL_Antiepi2
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
PL_CurBudget
PL_CurTime
PL_CurGoal
PL_CurAchieve
PL_Disaster
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
PL_HRAgency
PL_HRTraining
SV_CoopOutpF7
SV_CoopInpF7
SV_CoopFacility
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
SV_ExamService
SV_TreatService
SV_OutpatientKid
SV_CoopComm
SV_CoopCommContent1
SV_CoopCommContent2
SV_CoopCommContent3
SV_CoopCommContent4
SV_CoopCommContent5
SV_CoopCommContent98
SV_CoopCommContent99
SV_ExamTreatService
SV_CommFreq1
SV_CommFreq2
SV_CommFreq3
SV_CommFreq4
SV_CommFreq5
SV_CommFreq6
SV_CommFreq99
SV_CommFreqRe 
SV_MoTeam
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
SV_FrsProvinceAgency
SV_ExamF7
SV_TreatmentF7
SV_PsytherapyF7
SV_OccuTherapyF7
SV_RehabF7
SV_SocialSupportF7
SV_ServiceOtherF7
SV_ManageF7
SV_ManageOccuF7
SV_ManageSocSupportF7
SV_ManageOtherF7
SV_CommunityF7
SV_DieF7
SV_ProjectMed
SV_StratMinor
PR_GuidanceF5
PR_TransferF5
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
PR_InteractTradMed
HR_Club
HR_SupportClubP
HR_SupportClubF
HR_PolicyClubP
HR_PolicyClubF
HR_InteractClubP
HR_InteractClubF
HR_ActivityClubP
HR_ActivityClubF
HR_NGOCommunication
HR_NGOService
CE_LocalAgency
CE_AgencyGov
CE_AgencyNGO
CE_AgencyProfession
CE_AgencyPrivate
CE_AgencyInter
CE_CommCommunity
CE_CommKid
CE_CommWomen
CE_CommAdolescent
CE_CommTrauma
CE_CommEthnic
CE_CommOther
CE_Provider
CE_Tradition
CE_Teacher
CE_SocialService
CE_Leader
CE_OtherProfession
CE_EmployAgency
CE_SchoolStaff
CE_SchoolStaffF
MR_Form
MR_PttTreat
MR_ExamTimes
MR_PttAsPlan
MR_PttAsFact
MR_CareDay
MR_InvoluntaryCare
MR_Bed
MR_Inpatient
MR_LOS
MR_InvoluntaryAdmission
MR_Confined
MR_Diagnose
MR_DataOther
MR_MSA
MR_MOLISA
MR_DOH
MR_DOLISA
MR_NPH
MR_PPH
MR_PPS
MR_PGH
MR_PCDC
MR_PHC
MR_RepOther
MR_Regular1
MR_Regular2
MR_Regular3
MR_Regular4
MR_Regular5
MR_Regular99
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
MR_ResearchTopic1
MR_ResearchTopic2
MR_ResearchTopic3
MR_ResearchTopic4
MR_ResearchTopic5
MR_ResearchTopic6
MR_ResearchTopic7
MR_ResearchTopic8
MR_ResearchTopic99
CP_Participate
CP_ParticipateYrF5
CP_Participate13F5
MR_SuperviseAgency98 others.;
run;


******ANALYSIS OF DOMAIN 1******;

*Mental health policy;
proc freq data=data0511;table
facilityprovince*pl_policy;run;
proc freq data=data0511;table 
(PL_Policy1
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
PL_PolicyOther)*facilitylevel
;run;
proc freq dat=data0511;table facilitylevel;run;

*Essential pschotropic medicines;
proc freq data=data0511;table
(PL_Psymed
PL_Antipsy1
PL_Antipsy2
PL_Anxio1
PL_Anxio2
PL_Antidep1
PL_Antidep2
PL_Mood
PL_Antiepi1
PL_Antiepi2)*facilitylevel
;run;

*Mental health plan;
proc freq data=data0511;table
facilityprovince*pl_plan;run;
proc freq data=data0511;table
(PL_Plan1
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
PL_CurBudget
PL_CurTime
PL_CurGoal
PL_CurAchieve)*facilitylevel
;run;

*Mental health disaster preparedness;
proc freq data=data0511;table
facilityprovince*pl_disaster;run;

*Mental health legislation;
proc freq data=data0511;table
facilityprovince*PL_Legal;run;
proc freq data=data0511;table
(PL_Legal1
PL_Legal2
PL_Legal3
PL_Legal4
PL_Legal5
PL_Legal6
PL_Legal7
PL_Legal8
PL_Legal9)*facilitylevel
;run;

*Human rights supervision and training;
proc freq data=data0511;table
(PL_HRAgency PL_HRTraining)*facilitylevel;run;

**Finance variables**;

*Budget for Community Mental Health Project;
proc means data=data0511 n mean min p25 median p75 max;where facilitylevel=2;
var FI_Project13Recal;run;

*Health care spending in mental health hospitals. Note: the template only indicates mental health hospitals, but there are other facilities also asked for this information.;
proc means data=data0511 n mean min p25 median p75 max;where gi_factype = 3;
var FI_TotalSpendRecal;run;

*Insurance coverage of mental disoders;
proc freq data=data0511 ;
table FI_InsurancePay*facilitylevel;run;

*Number of patients paying out of pocket;
proc means data=data0511 n mean min p25 median p75 max;
class facilitylevel;var FI_OOPPay;run;
proc means data=data0511 n mean min p25 median p75 max;
var FI_OOPPay;run;

*Percentage of people having to pay OOP among total patients;
data data0511;set data0511;
FI_OOPayPct = .;
if questionnaire = 3 then FI_OOPayPct = FI_OOPPay/(SV_ExamTreatTimes + SV_PttTreat13)*100;
if questionnaire in (1, 2, 6) then FI_OOPayPct = FI_OOPPay/SV_Inpatient13*100;
if questionnaire = 7 then FI_OOPayPct = FI_OOPPay/SV_CareTreatFact13*100;run;
proc means data=data0511 n mean min p25 median p75 max;
class facilitylevel;var FI_OOPayPct;run;
proc means data=data0511 n mean min p25 median p75 max;
var FI_OOPayPct;run;

*Spending for the cheapest antipsychotropic drug;
proc means data=data0511 n mean min p25 median p75 max;
class facilitylevel;var FI_AntipsySpend;run;
proc means data=data0511 n mean min p25 median p75 max;
var FI_AntipsySpend;run;

*Spending for the cheapest antidepressant drug;
proc means data=data0511 n mean min p25 median p75 max;
class facilitylevel;var FI_AntidepSpend;run;
proc means data=data0511 n mean min p25 median p75 max;
var FI_AntidepSpend;run;


******ANALYSIS OF DOMAIN 2******;

*Organizational cooperation with other facilities;
proc freq data=data0511;table 
SV_CoopFacility*facilitylevel;
run;

*Service type;
proc freq data=data0511;table
GI_ServiceType*facilitylevel;run;

*Inpatient beds;
proc means data=data0511 n mean min p25 median p75 max;
where gi_factype in (1, 2, 3, 6);
class gi_factype;
var SV_BedPlan13
SV_BedFact13
SV_BedPlan09
SV_BedFact09
SV_BedPlan13Pop
SV_BedFact13Pop
SV_BedPlan09Pop
SV_BedFact09Pop
SV_FProvinceBed1
SV_FProvinceBed2
SV_FProvinceBed3
SV_FProvinceBed4
SV_FProvinceBed5
SV_FProvinceBed6
;run;

*Beds for children and adolescents only;
data data0511;set data0511;
SV_BedKidPct = SV_BedKid/SV_BedFact13*100;run;
proc means data=data0511 n mean min p25 median p75 max;
class facilitylevel;
var 
SV_BedKid
SV_BedKidPct
;run;

*Outpatient facility for children and adolescents only;
proc freq data=data0511;table gi_eco*SV_OutpatientKid;run;

*Outpatient inpatients services;

*Calculating female percentage variables;
data data0511;set data0511;
*form 3, 4, 5;
SV_FemaleTreat13Pct = SV_FemaleTreat13/SV_PttTreat13*100;
*form 7;
SV_CareTreat13FemalePct = SV_CareTreat13Female/SV_CareTreatFact13*100;
*form 1, 6;
SV_ExamFemale13Pct = SV_ExamFemale13/SV_ExamPatient13*100;
*form 1, 2, 6;
SV_InpatientFemale13Pct = SV_InpatientFemale13/SV_Inpatient13*100;
run;

*Outpatient services - form 3,4,5;
proc means data=data0511 n mean min p25 median p75 max;
where questionnaire in (3, 4, 5);
class questionnaire;
var
SV_ExamTreatTimes
SV_PttTreat13
SV_FemaleTreat13
SV_FemaleTreat13Pct
;run;

*Examination services - form 1,6. In terms of meaning, it is similar to outpatient services, so they two are combined in result table;
proc means data=data0511 n mean min p25 median p75 max;
where questionnaire in (1, 6);
class questionnaire;
var
SV_ExamPatient13
SV_ExamFemale13
SV_ExamFemale13Pct
;run;

*Inpatient services - form 1,2,6;
proc means data=data0511 n mean min p25 median p75 max; 
where questionnaire in (1, 2, 6);
class questionnaire;
var
SV_Inpatient13
SV_InpatientFemale13
SV_InpatientFemale13Pct
;run;

*Treatment and care in social service facilities - form 7;
proc means data=data0511 n mean min p25 median p75 max;
where questionnaire =7;
var
SV_PttPlan13
SV_CareTreatFact13
SV_CareTreat13Female
SV_CareTreat13FemalePct
;run;

*Involuntary admissions - form 1,2,6;
proc means data=data0511 n mean min p25 median p75 max;
where questionnaire in (1, 2, 6);
class questionnaire;
var
SV_InvoluntaryAdmission
;run;

*Services for children and adolescent;
proc means data=data0511 n mean min p25 median p75 max;
class facilitylevel;
var
SV_Inpatient17
SV_Inpatient15
;run;

*Length of stay in civil (non-forensic) psychiatry facilities;
proc means data=data0511 n mean min p25 median p75 max;
class facilitylevel;
var
SV_Inp10
SV_Inp5
SV_Inp1
SV_Inp0
;run;

*Length of stay in forensic psychiatry facilities;
proc means data=data0511 n mean min p25 median p75 max;
class facilitylevel;
var
SV_ForensicLoS10
SV_ForensicLoS5
SV_ForensicLoS1
SV_ForensicLoS0
;run;

*Cumulative number of days of treatment of all patients;
proc means data=data0511 n mean min p25 median p75 max;
class facilitylevel;
var
SV_InpatientLoS
;run;
proc means data=data0511 n mean min p25 median p75 max;
where gi_factype in (1, 2, 3, 4, 5, 6);
class facilityprovince;
var SV_InpatientLoS
;run;
proc means data=data0511 n mean min p25 median p75 max;
where gi_factype in (12, 13);
class facilityprovince;
var SV_InpatientLoS
;run;

*Follow-up community care activities;
proc freq data=data0511;where gi_servicetype in (2, 3);
table
gi_eco*SV_CommFreqRe;run;

*Patients with physical restraint and seclusion;
*At home - form 5;
proc means data=data0511 n mean min p25 median p75 max;
var GI_HomeConfinedF5
;run;
*At facility - forms 1, 2, 6;
proc freq data=data0511;
table 
facilitylevel*SV_RestrainP
;run;

*Mobile mental health clinic team;
proc sort data=data0511;by facilitylevel;run;
proc freq data=data0511;
table
facilitylevel*SV_MoTeam;
;run;

*Patient diagnoses by ICD-10;
proc means data=data0511 n mean min p25 median p75 max;
class facilitylevel;
var
SV_G40G41
SV_F00F03
SV_F10
SV_F11F19
SV_F20F29
SV_F30F39
SV_F40F48
SV_F60F69
SV_F70F79
SV_ICD10Other
;run;

*Availability of psychotropic medicines;
proc freq data=data0511;
table
facilitylevel*(SV_Antipsychotic
SV_Anxiolytic
SV_Antidepressant
SV_MoodStable
SV_Antiepileptic)
;run;

proc freq data=data0511;
table
facilitylevel*SV_PsyTherapyP
;run;

*Equity of access to mental health services;
proc freq data=data0511;table
facilitylevel*(SV_RuralUse
SV_StratMinor
SV_MinorUse
SV_Private
SV_PrivateWait
SV_PrivateExam
SV_PrivateBed);
run;

******ANALYSIS OF DOMAIN 3******;

data data0511;set data0511;if PR_OtherTrainingF5 = 88888888 then PR_OtherTrainingF5 = .;run;

proc means data=data0511;
class gi_eco;
var
PR_DocsTrainingF5
PR_NurseTrainingF5
PR_OtherTrainingF5
;run;
proc means data=data0511;
var
PR_DocsTrainingF5
PR_NurseTrainingF5
PR_OtherTrainingF5
;run;

proc sort data=data0511;by gi_eco;run;
proc freq data=data0511;
table
gi_eco*(PR_GuidanceF5
PR_TransferF5
PR_Prescribe
PR_WhoPrescribe1
PR_WhoPrescribe2
PR_WhoPrescribe3
PR_WhoPrescribe4
PR_WhoPrescribe99
PR_InteractTradMed)
;run;
