*******: VL Descriptive Data Analysis
*: Creating final analysis records
gen included_records = 1
replace included_records = 2 in 730/742 // patient diagnosed btw 2023-2024
order included_records, after(record_id)


*************************************************************************
use "Form1and2_CCR_VL_Dataset_20032024.dta", clear

*: Extracting day, month and year from diagnosis date
gen f1_year_diagnosis = year(f1_date_diagnosis)
order f1_year_diagnosis, after(f1_date_diagnosis)

*: Socio-demographic characteristics
su f1_age if included_records == 1
tab f1_gender if included_records == 1
tab f1_pregnancy_status if included_records == 1
tab f1_occupation if included_records == 1
tab f1_educ_level if included_records == 1

*: Vital signs
su f1_weight f1_height f1_temp if included_records == 1
tab1 f1_q8_had_fever f1_q9_distension f1_q10_liver f1_q10_spleen if included_records == 1
su f1_q10_measurement_liver f1_q10_measurement_spleen  if included_records == 1

*: Table 1: Number of records abstracted by health facility and year
tab f1_year_diagnosis  if included_records == 1
bysort f1_hf_name: tab f1_year_diagnosis  if included_records == 1

* Visceral leishmaniasis cases
su f1_q1_days_onset if included_records == 1
su f1_q1_days_onset if f1_hf_name == "Kakuma SCH" & included_records == 1
su f1_q1_days_onset if f1_hf_name == "Lodwar CRH" & included_records == 1
su f1_q1_days_onset if f1_hf_name == "Lopiding SCH" & included_records == 1
su f1_q1_days_onset if f1_hf_name == "Namoruputh PAG HC" & included_records == 1

bysort f1_year_diagnosis: su f1_q1_days_onset if included_records == 1
bysort f1_year_diagnosis: su f1_q1_days_onset if f1_hf_name == "Kakuma SCH" & included_records == 1
bysort f1_year_diagnosis: su f1_q1_days_onset if f1_hf_name == "Lodwar CRH" & included_records == 1
bysort f1_year_diagnosis: su f1_q1_days_onset if f1_hf_name == "Lopiding SCH" & included_records == 1
bysort f1_year_diagnosis: su f1_q1_days_onset if f1_hf_name == "Namoruputh PAG HC" & included_records == 1

tab f1_q20_final_diagnosis if included_records == 1
tab f1_q21_method_diagnosis if included_records == 1

* Treatment of leishmaniasis cases 
tab f1_date_treatment_started if included_records == 1
su days_diag_trt if included_records == 1
bysort f1_hf_name: su days_diag_trt if included_records == 1
bysort f1_year_diagnosis: su days_diag_trt if included_records == 1
bysort f1_hf_name f1_year_diagnosis: su days_diag_trt if included_records == 1

tab f1_q22_treat_regimen if (included_records == 1 & f1_date_treatment_started != .)
tab f1_q24_treatment_completed if (included_records == 1 & f1_date_treatment_started != .)
tab f1_q25_treatment_outcome if (included_records == 1 & f1_date_treatment_started != .)
tab f1_q26_reported_sae if (included_records == 1 & f1_date_treatment_started != .)
tab f1_q27_other_cond_treated if (included_records == 1 & f1_date_treatment_started != .)

* Follow-up of leishmaniasis cases
tab f1_q28_date_follow_up if (included_records == 1 & f1_date_treatment_started != .)
tab f1_q29_final_trt_outcome if (included_records == 1 & f1_date_treatment_started != .)


*************************************************************************
use "F3_VL_Dataset_20032024.dta", clear

tabstat suspect_cases positive_cases relapse_cases death_cases, s(n sum mean min max)
bysort f3_date_year: tabstat suspect_cases positive_cases relapse_cases death_cases, s(n sum mean min max)
bysort f3_facility_name: tabstat suspect_cases positive_cases relapse_cases death_cases, s(n sum mean min max)
bysort f3_date_year f3_facility_name: tabstat suspect_cases positive_cases relapse_cases death_cases, s(n sum mean min max)


*************************************************************************
use "F4_VL_Dataset_20032024.dta", clear

tabstat f4_beginning_balance_amb f4_remaining_balance_amb f4_days_stock_out_amb, s(n sum mean min max)
tabstat f4_beginning_balance_gluc f4_remaining_balance_gluc f4_stock_out_gluc, s(n sum mean min max)
tabstat f4_beginning_balance_par f4_remaining_balance_par f4_stock_out_par, s(n sum mean min max)
tabstat f4_beginning_balance_sodium f4_remaining_balance_sodium f4_stock_out_sodium, s(n sum mean min max)
tabstat f4_beginning_balance_milt50 f4_remaining_balance_milt50 f4_stock_out_milt50, s(n sum mean min max)
tabstat f4_beginning_balance_leish f4_remaining_balance_leish f4_stock_out_leish, s(n sum mean min max)
tabstat f4_beginning_balance_dat f4_remaining_balance_dat f4_stock_out_dat, s(n sum mean min max)












