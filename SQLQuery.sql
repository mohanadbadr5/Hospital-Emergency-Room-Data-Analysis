-- Quick Checking
select *
from patient;

-- A) Patient Demographics & Trends
-- 1. What is the age distribution of the patients?

with age_groups as (
	select
		case
			when patient_age <= 18 then 'Children'
			when patient_age < 60 then 'Adults'
			else 'Seniors' End as age_category
	from patient
)
select
		age_category,
		count(*) as Number_of_patients,
		round(count(*) * 100 /sum(count(*)) over(),2) || '%' as percentage
from age_groups
group by age_category
order by number_of_patients desc;

-- 2. Which departments receive the most referrals?

select
		department_referral,
		count(*) as number_of_referals,
		round(count(*) * 100/sum(count(*)) over(),2) || '%' as percentage
from patient
group by department_referral
order by number_of_referals desc;

-- 3. What is the diversity profile of the patient population?

select
		patient_race,
		count(*) number_of_patients,
		round(count(*) * 100/sum(count(*)) over(),2) || '%' as percentage
from patient
group by patient_race
order by number_of_patients desc;

-- B) Operational Efficiency
-- 1. What is the average wait time across different departments?

select
		department_referral,
		round(avg(cast(patient_waittime as float)),2) as average_waittime,
		count(*) as total_patients
from patient
group by department_referral
order by average_waittime desc;

-- 2. Is there a correlation between wait time and patient age?

select
	case
		when patient_age <= 18 then 'Children'
		when patient_age < 60 then 'Adults'
		else 'Seniors' End as age_category,
	count(*) as total_patients,
	round(avg(cast(patient_waittime as float)), 2) AS avg_wait_time,
	min(patient_waittime) as min_wait,
	max(patient_waittime) as max_wait
from patient
group by case
		when patient_age <= 18 then 'Children'
		when patient_age < 60 then 'Adults'
		else 'Seniors' End
order by avg_wait_time desc;

-- 3. What percentage of admissions are flagged?

select
		avg(cast(patient_admission_flag as float)) * 100 || '%' as flagging_percentage
from patient;

-- C) Quality of Service
-- 1. How does wait time affect satisfaction scores?

select
		case
			when patient_satisfaction_score <= 6 then 'Detractor'
			when patient_satisfaction_score <= 8 then 'Passive'
			when patient_satisfaction_score >= 9 then 'Promoter'
			else 'Unknown' end as feedback,
			round(avg(cast(patient_waittime as float)), 2) as avg_wait_time,
			count(*) as total_responses
from patient
group by
		case
			when patient_satisfaction_score <= 6 then 'Detractor'
			when patient_satisfaction_score <= 8 then 'Passive'
			when patient_satisfaction_score >= 9 then 'Promoter'
			else 'Unknown' end
order by avg_wait_time desc;

-- 2. What is the "NULL" rate for satisfaction scores?

select
		count(*) as total_responses,
		sum(case when patient_satisfaction_score is null then 1 else 0 end) as null_count,
		cast(sum(case when patient_satisfaction_score is null then 1 else 0 end) * 100 / count(*) as decimal(10,2)) || '%' as null_rate
from patient;

-- 3. How do satisfaction scores vary by department?

select
		department_referral,
		round(avg(patient_satisfaction_score),2) average_satisfaction_score,
		count(patient_satisfaction_score) as number_of_serveys,
		count(*) - count(patient_satisfaction_score) as missing_scores
from patient
group by department_referral
order by average_satisfaction_score desc;

-- D) Advanced Business Insights (Strategic Level)
-- 1. Patient Loyalty & Frequency
select
		patient_fullname,
		count(patient_id) as frequency
from patient
group by patient_fullname
having count(patient_id) > 1
order by frequency;

-- 2. Wait Time Consistency per each department
select
		distinct department_referral,
		round(stdev(cast(patient_waittime as float)) over(partition by department_referral),2) as wait_time_std_dev
from patient
order by wait_time_std_dev asc;

-- 3. Time Trend Analysis
select
		format(patient_admission_date, 'yyyy-MM') as admission_month,
		count(*) as total_admission,
		round(avg(cast(patient_waittime as float)),2) as avg_wait_time,
		round(avg(cast(patient_satisfaction_score as float)),2) as avg_satisfaction_score,
		count(*) - lag(count(*)) over(order by format(patient_admission_date, 'yyyy-MM')) as mom_change
from patient
group by format(patient_admission_date, 'yyyy-MM')
order by format(patient_admission_date, 'yyyy-MM');