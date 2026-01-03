-- =========================================================
-- 1. APPOINTMENT OPERATIONS & EFFICIENCY
-- =========================================================
select * from appointments

-- Q1. What percentage of total appointments result in
--     No-Shows, Cancellations, Completions, and Scheduled status?
--     Business Goal: Measure operational efficiency & patient reliability
select status,count(* )as total_appointment,round(
count(*)*100/(select count(*) from appointments),2) as percentage
from appointments
group by status
order by percentage desc;
-- Q2. Which appointment time slots (hour-wise) have the highest no-show rates?
--     Business Goal: Redesign scheduling strategy to reduce no-shows
SELECT
    appointment_hour,
    COUNT(appointment_id) AS total_appointments,
    COUNT(appointment_id) FILTER (WHERE status = 'No-show') AS no_show_count,
    ROUND(
        COUNT(appointment_id) FILTER (WHERE status = 'No-show')* 100.0 / COUNT(appointment_id),
        2
    ) AS no_show_percentage
FROM appointments
GROUP BY appointment_hour
ORDER BY no_show_percentage DESC;

-- Q3. Which days of the week experience the highest appointment cancellations?
--     Business Goal: Improve staffing and slot allocation
select 
 to_char(appointment_date,'day') as day_of_week,
 count(*) as total_appointment,
 count(*) filter(where status='Cancelled') as cancelled_appointment,
 round(count(*) filter(where status='Cancelled')*100/count(*) ,2) as cancelled_percentage 
from appointments 
group by day_of_week
order by cancelled_percentage desc;
-- Q4. Which appointment reasons (Consultation, Therapy, Emergency, Follow-up)
--     are most likely to result in no-shows?
--     Business Goal: Refine booking and confirmation policies
select reason_for_visit,
count(*) as total_appointment,
count(*) filter(where lower(trim(status))='no-show') as not_shown
from appointments
group by reason_for_visit
order by not_shown desc;
-- Q5. What is the average number of appointments per day,
--     and how does it fluctuate month-over-month?
--     Business Goal: Demand forecasting and capacity planning
select avg(daily_appointment) as avg_appointment_per_day
from (select appointment_date,
count(*)as daily_appointment
from appointments
group by appointment_date
) as daily_count;
select 
date_trunc('month',appointment_date) as months,
count(*) as total_appointment
from appointments
group by months
order by months 
-- =========================================================
-- 2. DOCTOR PERFORMANCE & CAPACITY UTILIZATION
-- =========================================================
select * from doctors
select * from appointments
select status from appointments

-- Q6. Which doctors have the highest number of completed appointments?
--     Business Goal: Identify top-performing doctors
--select count(appointment_id) as completed_appointment,doctor_id
--from appointments
--where status='Completed'
--group by doctor_id
--order by completed_appointment desc
select 
 d.doctor_id,
 concat(d.first_name,'',d.last_name) as doctor_name,
 count(a.appointment_id) as completed_appointment
from appointments a 
join doctors d 
on a.doctor_id= d.doctor_id
where a.status='Completed'
group by d.doctor_id,d.first_name,d.last_name
order by completed_appointment desc;
-- Q7. Which doctors face the highest no-show rates for their appointments?
--     Business Goal: Identify scheduling or communication issues
select 
 d.doctor_id,
 concat(d.first_name,'',d.last_name) as doctor_name,
 count(a.appointment_id) as Noshow_appointment
from appointments a 
join doctors d 
on a.doctor_id= d.doctor_id
where a.status='No-show'
group by d.doctor_id,d.first_name,d.last_name
order by Noshow_appointment desc;
-- Q8. Is there a relationship between doctor experience (years)
--     and appointment completion rate?
--     Business Goal: Evaluate experience vs patient outcomes
select d.doctor_id,
concat(d.first_name,' ',d.last_name) as doctor_name,
count(a.appointment_id) as total_appointment,
d.years_experience as total_experience
from appointments a 
join doctors d 
on d.doctor_id = a.doctor_id 
where a.status='Completed'
group by d.doctor_id,d.first_name,d.last_name,d.years_experience
order by total_experience desc,total_appointment desc;
-- Q9. Which doctors are overbooked vs underutilized
--     based on appointment volume?
--     Business Goal: Optimize doctor workload distribution
select d.doctor_id,
concat(d.first_name,' ',d.last_name) as doctor_name,
count(a.appointment_id) as total_appointment
from appointments a 
join doctors d 
on d.doctor_id=a.doctor_id
group by d.doctor_id,doctor_name
order by total_appointment desc;

-- Q10. What is the average appointment load per doctor per month?
--      Business Goal: Capacity and workforce planning
with monthly_appointment as (
select doctor_id,count(*) as total_monthly_appointment,
date_trunc('month',appointment_date) as months
from appointments
group by date_trunc('month',appointment_date),doctor_id

)
select doctor_id,
avg(total_monthly_appointment) as avg_monthly_appointment
from monthly_appointment
group by doctor_id
order by avg_monthly_appointment desc,doctor_id desc
-- =========================================================
-- 3. PATIENT BEHAVIOR & SEGMENTATION
-- =========================================================
select * from appointments
-- Q11. Which patients are frequent no-show offenders?
--      Business Goal: Apply stricter booking or reminder policies
select patient_id , status 
from appointments 
where status ='No-show'
order by patient_id asc
-- Q12. How does patient age group impact appointment completion
--      and cancellation behavior?
--      Business Goal: Age-based service optimization

select p.age_group,
a.status,
count(*) as appointment_count
from appointments a
join patients p 
on p.patient_id=a.patient_id
where status in ('Cancelled','Completed')
group by p.age_group,a.status
order by p.age_group,a.status
-- Q13. Are newly registered patients more likely to cancel
--      or no-show than long-term patients?
--      Business Goal: Improve onboarding and patient engagement
select * from patients
select * from appointments
select p.patient_id,p.registration_date,a.appointment_date,a.status,
case when extract(day from (a.appointment_date - p.registration_date)) <= 30 then 'new'
     else 'old'
end as type_of_patient 
from appointments a 
join patients p 
on p.patient_id=a.patient_id
where a.status in ('Cancelled','No-show')


-- Q14. Which patients have the highest number of repeat appointments?
--      Business Goal: Identify loyal and high-value patients
select patient_id,count(*) as appointment_per_patient, dense_rank() OVER (ORDER BY COUNT(*) DESC) AS repeat_rank
from appointments 
group by patient_id 
-- =========================================================
-- 4. REVENUE & FINANCIAL PERFORMANCE
-- =========================================================
SELECT *FROM billing
select * from appointments
-- Q15. What is the total revenue generated from completed
--      and paid appointments?
--      Business Goal: Measure core hospital revenue
SELECT
    SUM(b.amount) AS total_revenue
FROM billing b
JOIN appointments a
    ON b.patient_id = a.patient_id
WHERE a.status = 'Completed'
  AND b.payment_status = 'Paid';

-- Q16. How much revenue is lost due to no-shows
--      and cancelled appointments?
--      Business Goal: Quantify financial leakage
select sum(b.amount) as revenue_lost,a.status
from appointments a 
join billing b 
on b.patient_id=a.patient_id
where a.status in ('No-show','Cancelled')
group by a.status
-- Q17. Which treatment types generate the highest total revenue?
--      Business Goal: Identify most profitable services
select * from treatments
select * from billing
SELECT
    t.treatment_type,
    SUM(b.amount) AS total_revenue
FROM billing b
JOIN treatments t
    ON b.treatment_id = t.treatment_id
WHERE b.payment_status = 'Paid'
GROUP BY t.treatment_type
ORDER BY total_revenue DESC;

-- Q18. What is the average billing amount per treatment type?
--      Business Goal: Pricing and margin analysis
with billing_amount_per_treatmenttype as (
select b.amount  , t.treatment_type
from billing b
join treatments t 
on b.treatment_id=t.treatment_id 
where b.payment_status='Paid'
group by treatment_type,b.amount
)
select avg(amount) as avg_amount_per_treatment_type,treatment_type
from billing_amount_per_treatmenttype 
group by treatment_type
order by avg_amount_per_treatment_type desc


-- Q19. Which doctors generate the highest revenue
--      through completed treatments?
--      Business Goal: Revenue attribution by doctor
SELECT
    d.doctor_id,
    CONCAT(d.first_name, ' ', d.last_name) AS doctor_name,
    SUM(b.amount) AS total_revenue
FROM billing b
JOIN appointments a
    ON b.patient_id = a.patient_id
JOIN doctors d
    ON a.doctor_id = d.doctor_id
WHERE
    b.payment_status = 'Paid'
    AND a.status = 'Completed'
GROUP BY
    d.doctor_id, d.first_name, d.last_name
ORDER BY
    total_revenue DESC;

-- =========================================================
-- 5. PAYMENT & BILLING RISK ANALYSIS
-- =========================================================

-- Q20. What percentage of bills are Paid, Pending, and Failed?
--      Business Goal: Assess cash-flow health
SELECT payment_status, COUNT(*) AS total_bills,
    ROUND(
        COUNT(*) * 100.0 / SUM(COUNT(*)) OVER (),
        2
    ) AS percentage
FROM billing
GROUP BY payment_status
ORDER BY percentage DESC;

-- Q21. Which payment method contributes the highest revenue
--      (Cash, Credit Card, Insurance)?
--      Business Goal: Optimize payment strategy
SELECT payment_method,SUM(amount) AS total_revenue
FROM billing
WHERE payment_status = 'Paid'
GROUP BY payment_method
ORDER BY total_revenue DESC;

-- Q22. Is there a higher payment failure rate
--      for specific payment methods?
--      Business Goal: Reduce transaction risk
SELECT payment_method, COUNT(*) FILTER (WHERE payment_status = 'Failed') AS failed_payments,
    COUNT(*) AS total_payments,
    ROUND(
        COUNT(*) FILTER (WHERE payment_status = 'Failed') * 100.0 / COUNT(*),
        2
    ) AS failure_rate_percentage
FROM billing
GROUP BY payment_method
ORDER BY failure_rate_percentage DESC;

-- Q23. What is the average delay between treatment date
--      and billing date?
SELECT
    ROUND(
        AVG(
            EXTRACT(
                EPOCH FROM (b.bill_date - a.appointment_date)
            ) / 86400
        ),
        2
    ) AS avg_delay_days
FROM billing b
JOIN appointments a
    ON b.patient_id = a.patient_id
WHERE b.payment_status = 'Paid'
  AND a.appointment_date <= b.bill_date;






-- =========================================================
-- 6. STRATEGIC & EXECUTIVE INSIGHTS
-- =========================================================

-- Q24. Which age group contributes the highest revenue
--      to the hospital?
--      Business Goal: Market and service focus

select p.age_group,sum(b.amount) as total_revenue
from billing b 
join patients p 
on p.patient_id=b.patient_id 
where b.payment_status = 'Paid'
group by p.age_group
order by total_revenue desc;
-- Q25. Which treatments are high-volume but low-revenue,
--      and which are low-volume but high-revenue?
--      Business Goal: Service portfolio optimization
select * from appointments
select * from billing
select * from treatments
WITH treatment_metrics AS (
    SELECT
        t.treatment_type,
        COUNT(DISTINCT a.appointment_id) AS treatment_volume,
        SUM(b.amount) AS total_revenue
    FROM appointments a
    JOIN billing b
        ON a.patient_id = b.patient_id
    JOIN treatments t
        ON b.treatment_id = t.treatment_id
    WHERE
        a.status = 'Completed'
        AND b.payment_status = 'Paid'
    GROUP BY t.treatment_type
)
SELECT
    treatment_type,
    treatment_volume,
    total_revenue,
    CASE
        WHEN treatment_volume >= AVG(treatment_volume) OVER ()
             AND total_revenue < AVG(total_revenue) OVER ()
            THEN 'High Volume - Low Revenue'
        WHEN treatment_volume < AVG(treatment_volume) OVER ()
             AND total_revenue >= AVG(total_revenue) OVER ()
            THEN 'Low Volume - High Revenue'
        ELSE 'Balanced'
    END AS treatment_category
FROM treatment_metrics
ORDER BY total_revenue DESC;


-- Q26. What percentage of total revenue comes from repeat patients?
--      Business Goal: Patient lifetime value analysis
WITH patient_appointments AS (
    SELECT
        a.patient_id,
        COUNT(a.appointment_id) AS completed_appointments
    FROM appointments a
    WHERE a.status = 'Completed'
    GROUP BY a.patient_id
),
patient_revenue AS (
    SELECT
        b.patient_id,
        SUM(b.amount) AS revenue
    FROM billing b
    WHERE b.payment_status = 'Paid'
    GROUP BY b.patient_id
),
repeat_vs_total AS (
    SELECT
        SUM(
            CASE 
                WHEN pa.completed_appointments > 1 THEN pr.revenue
                ELSE 0
            END
        ) AS repeat_patient_revenue,
        SUM(pr.revenue) AS total_revenue
    FROM patient_appointments pa
    JOIN patient_revenue pr
        ON pa.patient_id = pr.patient_id
)
SELECT
    ROUND(
        ((repeat_patient_revenue * 100.0) / total_revenue)::numeric,
        2
    ) AS repeat_patient_revenue_percentage
FROM repeat_vs_total;

-- Q27. Which month generates the highest revenue
--      and the highest appointment volume?
--      Business Goal: Seasonality and planning
SELECT
    DATE_TRUNC('month', a.appointment_date) AS month,
    COUNT(a.appointment_id) AS appointment_volume,
    SUM(b.amount) AS total_revenue
FROM appointments a
JOIN billing b
    ON a.patient_id = b.patient_id
WHERE
    a.status = 'Completed'
    AND b.payment_status = 'Paid'
GROUP BY month
ORDER BY total_revenue DESC, appointment_volume DESC;

-- Q28. Which doctor + treatment combinations
--      are the most profitable?
--      Business Goal: Strategic specialization decisions
SELECT
    d.doctor_id,
    CONCAT(d.first_name, ' ', d.last_name) AS doctor_name,
    t.treatment_type,
    COUNT(a.appointment_id) AS treatment_count,
    SUM(b.amount) AS total_revenue
FROM appointments a
JOIN doctors d
    ON a.doctor_id = d.doctor_id
JOIN treatments t
    ON a.appointment_id = t.appointment_id
JOIN billing b
    ON a.patient_id = b.patient_id
WHERE
    a.status = 'Completed'
    AND b.payment_status = 'Paid'
GROUP BY
    d.doctor_id,
    doctor_name,
    t.treatment_type
ORDER BY total_revenue DESC;
