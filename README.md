# Hospital_appointment_analysis
End-to-end hospital appointment analytics project using SQL and Power BI to analyze patient behavior, operational efficiency, doctor performance, and revenue trends.
# End-to-End Hospital Appointment Analytics

## 📌 Project Overview
This project is an end-to-end hospital appointment analytics solution built using SQL and Power BI.  
The goal is to analyze patient appointment behavior, operational efficiency, doctor performance, and revenue trends to support better decision-making in healthcare operations.
---

## 📊 Dashboard Overview (Power BI)

### 🔹 Overall Dashboard View
![Dashboard Overview](screenshots/dashboard%20overview.png)

### 🔹 Dashboard with Filters Applied
![Dashboard Filters](screenshots/dashboard%20filter.png)

---

---

## 📂 Dataset Description
The analysis is based on multiple structured datasets representing real-world hospital operations:

- **appointments** – appointment details, status, time, and reason for visit  
- **billing** – billing amount, payment status, billing date  
- **patients** – patient demographics  
- **doctors** – doctor information and specialization  
- **treatments** – treatment types linked to appointments  

---

## 🛠 Tools & Technologies Used
- **SQL (PostgreSQL)** – data querying and business analysis  
- **Power BI** – interactive dashboard and data visualization  
- **Excel** – raw data storage  
- **GitHub** – project version control and portfolio hosting  

---

## 📊 Business Questions & SQL Analysis

### Q1. What percentage of total appointments result in different statuses?
**Business Goal:** Measure operational efficiency and patient reliability.

**Key Insight:**  
Completed appointments form the majority, while No-shows and Cancellations indicate potential operational inefficiencies and revenue leakage.

---

### Q2. Which appointment time slots have the highest no-show rates?
**Business Goal:** Optimize scheduling strategy.

**Key Insight:**  
Certain hours show significantly higher no-show percentages, suggesting the need for reminders or overbooking strategies during those slots.

---

### Q3. Which days of the week experience the highest cancellations?
**Business Goal:** Improve staffing and slot allocation.

**Key Insight:**  
Specific weekdays have higher cancellation rates, indicating demand imbalance and staffing optimization opportunities.

---

### Q4. Which appointment reasons are most likely to result in no-shows?
**Business Goal:** Refine booking and confirmation policies.

**Key Insight:**  
Consultations and follow-ups show higher no-show counts compared to emergency visits, highlighting areas for stricter confirmation processes.

---

### Q5. What is the average number of appointments per day and monthly trend?
**Business Goal:** Demand forecasting and capacity planning.

**Key Insight:**  
Appointments fluctuate month-over-month, requiring flexible resource planning to handle peak and low-demand periods.

---

### Q6. Which doctors have the highest number of completed appointments?
**Business Goal:** Identify top-performing doctors.

**Key Insight:**  
A small group of doctors consistently handle a higher number of completed appointments, indicating strong performance and higher patient trust.

---

## 📈 Power BI Dashboard Overview
The Power BI dashboard provides interactive insights into:

- Total revenue, appointments, and patients  
- Monthly appointment vs revenue trends  
- Revenue by treatment type  
- Revenue distribution by payment status  
- Dynamic filtering using slicers (month, treatment type, payment status)

---

## 🔍 Key Insights
- Revenue does not always directly correlate with appointment volume  
- Diagnostic treatments contribute disproportionately higher revenue  
- No-shows and cancellations represent significant optimization opportunities  
- Payment failures and pending bills highlight revenue collection risks  

---

## ✅ Conclusion
This project demonstrates an end-to-end analytics workflow — from raw data and SQL analysis to an interactive Power BI dashboard.  
It showcases practical problem-solving skills, business thinking, and data storytelling relevant to real-world healthcare analytics.

---

## 📎 Project Files
- SQL scripts for analysis  
- Power BI dashboard (.pbix)  
- Jupyter notebook for exploration  

