*******: VL Data Analysis
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


*******************************************************************************
***: Analysis of VL data (revised codes)

***: Socio-demographic characteristics ***
* Table 1: Number of case management records extracted per health facility
tab f1_hf_name
bysort diag_year: tab f1_hf_name

su f1_age if included_records == 1
tab f1_gender if included_records == 1
tab f1_pregnancy_status if included_records == 1
tab f1_occupation if included_records == 1
tab f1_educ_level if included_records == 1

su f1_weight if included_records == 1
su f1_height if included_records == 1
su f1_temp if included_records == 1
tab f1_q8_had_fever if included_records == 1
tab f1_q9_distension if included_records == 1
tab f1_q10_liver if included_records == 1
tab f1_q10_spleen if included_records == 1
su f1_q10_measurement_liver if included_records == 1
su f1_q10_measurement_spleen if included_records == 1












