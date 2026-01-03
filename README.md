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
---

## 📁 Project Structure

```text
Hospital_appointment_analysis/
│
├── data/
│   ├── appointments.csv
│   ├── billing.csv
│   ├── patients.csv
│   ├── doctors.csv
│   └── treatments.csv
│
├── screenshots/
│   ├── dashboard_overview.png
│   └── dashboard_filter.png
│
├── report/
│   └── Hospital_appointment_analysis_report.pdf
│
├── Hospital_appointment_dashboard.pbix
├── hospital_appointment.ipynb
├── hospital_appointment_analysis.sql
├── README.md
└── LICENSE
---

## ▶️ How to Run This Project

This project can be executed end-to-end using SQL, Python, and Power BI.

### 1️⃣ SQL Analysis
- File: `hospital_appointment_analysis.sql`
- Run queries using PostgreSQL / MySQL
- Covers:
  - Appointment status analysis (No-shows, Cancellations, Completed)
  - Doctor performance
  - Time-slot and day-wise trends
  - Operational efficiency metrics

### 2️⃣ Python Data Analysis
- File: `hospital_appointment.ipynb`
- Tools used: pandas, matplotlib, seaborn
- Performs:
  - Exploratory Data Analysis (EDA)
  - Data cleaning and transformations
  - Trend and distribution analysis

### 3️⃣ Power BI Dashboard
- File: `Hospital_appointment_dashboard.pbix`
- Steps:
  1. Open the `.pbix` file in Power BI Desktop
  2. Load CSV files from the `data/` folder
  3. Refresh the data model
  4. Use slicers for:
     - Appointment Month
     - Treatment Type
     - Payment Status
- View KPIs, trends, and interactive insights

---

## 🧠 Business Questions Answered

This project answers real-world hospital operations and revenue optimization questions:

### 1️⃣ Appointment Status Distribution
**Question:** What percentage of appointments result in Completed, No-Shows, Cancellations, and Scheduled status?  
**Insight:** A significant share of appointments do not reach completion, highlighting operational inefficiencies and patient reliability challenges.

### 2️⃣ No-Show Analysis by Time Slot
**Question:** Which appointment time slots have the highest no-show rates?  
**Insight:** Certain hours experience disproportionately higher no-shows, indicating opportunities to redesign scheduling and reminder systems.

### 3️⃣ Cancellation Trends by Day of Week
**Question:** Which days of the week face the highest appointment cancellations?  
**Insight:** Specific weekdays show higher cancellation rates, enabling better staffing and slot allocation planning.

### 4️⃣ Visit Reason vs No-Show Behavior
**Question:** Which appointment reasons are most likely to result in no-shows?  
**Insight:** Follow-up and non-urgent visits exhibit higher no-show tendencies compared to emergency or therapy visits.

### 5️⃣ Demand & Capacity Planning
**Question:** What is the average number of appointments per day and how does demand change monthly?  
**Insight:** Appointment demand fluctuates month-over-month, supporting data-driven capacity planning and resource optimization.

### 6️⃣ Doctor Performance Analysis
**Question:** Which doctors complete the highest number of appointments?  
**Insight:** Top-performing doctors can be identified for best-practice benchmarking and workload balancing.

---

These insights collectively support **better operational efficiency, improved patient experience, and stronger revenue control**.
