<img width="1345" height="745" alt="Screenshot" src="https://github.com/user-attachments/assets/469d3fed-77ad-4b0e-b098-934c8e0a5b07" />
🏥 Hospital ER Operations Analysis & Strategic Insights
📋 Project Overview
An end-to-end data analytics project focused on optimizing Emergency Room operations for a high-volume hospital. By analyzing over 9,200 patient records, this project identifies operational bottlenecks, patient demographic trends, and critical data governance gaps to improve healthcare delivery.
🛠️ Tech Stack

    Database: Microsoft SQL Server (T-SQL, CTEs, Window Functions)
    Analysis: Python (Jupyter Notebook, Pandas, NumPy)
    Visualization: Power BI (Interactive Dashboards, DAX), Seaborn, Matplotlib
    Documentation: Microsoft Word (Strategic Reporting)

🔍 Key Analytical Features

    Patient Demographics: Segmented population into Children, Adults, and Seniors, revealing that 77% of patients are Adults or Seniors.
    Operational Efficiency: Measured average wait times (consistent at ~35 mins) and flagged admission rates (50.04%).
    Data Quality Audit: Identified a massive 58% "Unknown" referral rate and a 72% NULL rate in patient satisfaction scores.
    Statistical Analysis: Conducted correlation matrices and outlier detection (Z-Score > 3) to validate data integrity.
    Time-Series Trends: Analyzed Month-over-Month (MoM) admission fluctuations from April 2023 to October 2024.

💡 Strategic Recommendations

    Standardize Data Entry: Implement mandatory EHR fields to eliminate the high "Unknown" referral and demographic categories.
    Predictive Staffing: Align clinical shifts with peak admission months (August/May) identified in the trend analysis.
    Enhance Patient Feedback: Deploy point-of-care SMS surveys to bridge the 72% satisfaction data gap.
    Targeted Care Models: Tailor facility resources toward geriatric and adult chronic care to match the 77% primary demographic.

📂 Project Structure

    /SQL_Queries/: T-SQL scripts for data extraction and business logic.
    /Python_Analysis/: Jupyter Notebooks for statistical modeling and correlation.
    /Dashboards/: Power BI .pbix files and screenshots of interactive reports.
    /Reports/: Final executive summary and strategic recommendations.

Dataset Link: https://www.kaggle.com/datasets/xavierberge/hospital-emergency-dataset
