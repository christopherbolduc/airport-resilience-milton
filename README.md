# Hurricane Milton: Airport Resilience Analysis (October 2024)

In October 2024, Hurricane Milton made landfall in Florida, causing widespread flight cancellations across five major airports within the hurricane warning zone:  
**Daytona Beach (DAB), Orlando (MCO), Tampa (TPA), St. Pete–Clearwater (PIE), and Sarasota (SRQ).**

This project investigates how quickly each airport recovered — and whether their responses aligned with the severity of the storm they faced.

---

## Analytical Approach

Using daily flight operations and weather data, I developed a **resilience score** for each airport. The score was based on:

- **Days to recovery** – number of days until operations normalized  
- **Cancellation rate** – total percentage of cancelled flights during October  
- **Peak wind speed** – refers to *hourly average wind speed*, used to normalize outcomes by storm intensity

**Recovery** was determined using clear operational criteria: minimal cancellations and near-normal flight volume.
This allowed me to identify not just which airports were hit hardest, but which ones recovered *most effectively* given their conditions. 

## Why SRQ Stood Out

SRQ recorded the **strongest winds** of all five airports and suffered **roof damage** to Concourse B, forcing a full closure for seven days (Oct 9-15). The airport reopened on Oct 16 but took one more day to return to full operations.
Even after adjusting for storm severity, SRQ had the **highest cancellation rate** and **longest recovery timeline**, earning the highest (**worst**) resilience score.

In contrast, **DAB faced nearly the same wind intensity** but resumed normal operations within three days — the best performance in the group.

---

## Resilience Score Rankings (Adjusted for Wind Severity)

| Airport | Date Reopened | Date Recovered | Days to Reopen | Days to Recovery | % Flights Cancelled (Oct) | Peak Wind (km/h) | Resilience Score |
|:--------|:--------------|:---------------|:----------------|:------------------|:---------------------------|:------------------|:------------------|
| DAB     | 2024-10-12    | 2024-10-12     | 3               | 3                 | 7.9                        | 100.1             | 3.79              |
| TPA     | 2024-10-11    | 2024-10-12     | 2               | 3                 | 10.5                       | 83.5              | 4.85              |
| MCO     | 2024-10-11    | 2024-10-12     | 2               | 3                 | 7.6                        | 74.2              | 5.07              |
| PIE     | 2024-10-12    | 2024-10-13     | 3               | 4                 | 14.9                       | 90.4              | 6.07              |
| SRQ     | 2024-10-16    | 2024-10-17     | 7               | 8                 | 27.1                       | 117.0             | 9.15              |


[Download resilience summary CSV](csv_files/airport_resilience_summary.csv) •
[Download daily airport and weather data](csv_files/mart_airport_daily_milton.csv)

> **Note:** Reopen date marks when meaningful flight operations resumed.  
> Recovery date reflects the return to near-normal operations (fewer than 5% cancellations and at least 90% of baseline flight volume).

---

## Tools Used

- **Python**, **Pandas**, **Matplotlib**, **Seaborn**
- **SQL** (PostgreSQL), **DBeaver** for query development
- **SQLAlchemy** for programmatic SQL access and integration
- **Jupyter Notebook** for end-to-end data analysis and visualization
- **Gamma** for storytelling and visual presentation

## Data Sources

- **Meteostat API** – Historical hourly and daily weather data (e.g., temperature, wind speed, precipitation) for selected airports
- **Bureau of Transportation Statistics (BTS)** – Flight records and cancellation data for major Florida airports

## Project Structure

- `*.sql` files: Define views for **staging**, **prep**, and **mart** layers in the data pipeline
- `ap_resilience.ipynb`: Performs resilience scoring and visualization using prepared SQL views
- Visual assets are saved separately for integration into reports and presentations
- This `README.md` summarizes the methodology, tools, and key results of the analysis

---

## Takeaway

Even within the same storm, airport recovery varied greatly.  
This analysis highlights how **data-driven scoring** can reveal hidden operational strengths and vulnerabilities — and help decision-makers focus recovery efforts more effectively.

---

## Getting Started

To explore the full analysis:

1. Clone this repository
2. Create and activate a Python environment (optional but recommended)
3. Install dependencies: `pip install -r requirements.txt`
4. Open `ap_resilience.ipynb` in Jupyter

## SQL View Definitions

This project includes SQL scripts that define the data model using PostgreSQL views.

The model is organized in three layers:

- `models/staging/` — raw table wrappers
- `models/prep/` — cleaned and aggregated features
- `models/mart/` — final analytical dataset used in the notebook

> **Note:** These SQL files reference source tables (e.g., `flights_oct2024`, `wx_milton_h_raw`) that are **not included in this repository**. To fully recreate the pipeline, equivalent raw data tables must be created using historical weather and flight data from BTS and Meteostat.

## Python Dependencies

All required packages are listed in `requirements.txt`. Key dependencies include:

- pandas  
- numpy  
- matplotlib  
- seaborn  
- sqlalchemy  
- psycopg2-binary  
- meteostat  
- jupyter

---

## License

This project is licensed under the MIT License. See the `LICENSE` file for details.

## Author

Christopher Bolduc  
[GitHub](https://github.com/christopherbolduc)
