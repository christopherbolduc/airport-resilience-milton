> This project evaluates the operational resilience of five Florida airports affected by Hurricane Milton (Oct 2024). Using flight and weather data, I developed a resilience score to assess recovery performance relative to storm severity. Results show that DAB performed best, while SRQ showed significant recovery delays despite comparable wind intensity.


# Hurricane Milton: Airport Resilience Analysis (October 2024)

In October 2024, Hurricane Milton made landfall in Florida, causing widespread flight cancellations across five major airports within the hurricane warning zone:  
**Daytona Beach (DAB), Orlando (MCO), Tampa (TPA), St. Pete–Clearwater (PIE), and Sarasota (SRQ).**

This project investigates how quickly each airport recovered — and whether their responses aligned with the severity of the storm they faced.

---
**Flight Cancellations Surrounding Hurricane Milton**  

![Recovery Timeline](images/cancellation_rate_trend.png)

## Analytical Approach

Using daily flight operations and weather data, I developed a **resilience score** for each airport. The score was based on:

- **Days to recovery** – number of days until operations normalized  
- **Cancellation rate** – total percentage of cancelled flights during October  
- **Peak wind speed** – refers to maximum *hourly average* wind speed, used in the denominator (with square root scaling) to normalize by storm intensity

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
| MCO     | 2024-10-11    | 2024-10-12     | 2               | 3                 | 7.6                        | 74.2              | 4.37              |
| TPA     | 2024-10-11    | 2024-10-12     | 2               | 3                 | 10.5                       | 83.5              | 4.43              |
| PIE     | 2024-10-12    | 2024-10-13     | 3               | 4                 | 14.9                       | 90.4              | 5.77              |
| SRQ     | 2024-10-16    | 2024-10-17     | 7               | 8                 | 27.1                       | 117.0             | 9.90              |


[Download resilience summary CSV](csv_files/airport_resilience_summary.csv) •
[Download daily airport and weather data](csv_files/mart_airport_daily_milton.csv)

> **Note:** Reopen date marks when meaningful flight operations resumed.  
> Recovery date reflects the return to near-normal operations (fewer than 5% cancellations and at least 90% of baseline flight volume).

**Resilience Score Comparison** 
 
![Resilience Score Chart](images/resilience_score_barchart.png)

---
## Resilience Score Formula

The formula used to compute each airport’s resilience score:

<pre>resilience_score = ( 
    (days_to_recovery + (pct_cancelled_oct * 10)) /
    (peak_wind_speed_kmh ** 0.5 / 10) 
) </pre>

The resilience score balances operational recovery with storm impact by scaling cancellation rates (×10) to match the range of recovery days and applying square root scaling to wind speed. This ensures both disruption and severity are fairly represented in the final score.

Lower scores indicate more resilient performance (faster recovery and fewer disruptions), normalized by storm intensity.

### Code Implementation (Python)

For technical readers, the formula is implemented as a Python function:

```python
def resilience_score(days_to_recovery, pct_cancelled, peak_wind_speed_kmh):
    return (
        (days_to_recovery + (pct_cancelled * 10)) /
        ((peak_wind_speed_kmh ** 0.5) / 10)
    )
```
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
```
hurricane_milton/
├── analysis/                              Notebooks for data extraction, transformation, and scoring
│   ├── ap_resilience.ipynb                Main notebook for resilience scoring and visualizations
│   └── sql_to_pandas.ipynb                Querying SQL views and loading into pandas
├── models/                                SQL views for flight and weather modeling
│   ├── staging/                           Raw data wrappers and standardization
│   │   ├── stag_airports.sql
│   │   ├── stag_flights_milton.sql
│   │   ├── stag_wx_milton_d.sql
│   │   └── stag_wx_milton_h.sql
│   ├── prep/                              Cleaned and enriched features
│   │   ├── prep_flights_milton.sql
│   │   └── prep_wx_milton_h.sql
│   └── mart/                              Final analytical dataset
│       └── mart_airport_daily_milton.sql
├── csv_files/                             Exported results
│   ├── airport_resilience_summary.csv     Final scores and metrics for each airport
│   └── mart_airport_daily_milton.csv      Full daily dataset (ops + weather)
├── images/                                Visual assets used in README and reports
│   ├── cancellation_rate_trend.png
│   ├── resilience_score_barchart.png
├── index.html                             Homepage for GitHub Pages report
├── about.html                             Project background page (GitHub Pages)
├── methodology.html                       Methods breakdown (GitHub Pages)
├── airport_resilience_milton.pdf          Final PDF version of the report (Gamma)
├── .env                                   Environment file containing DB/API credentials
├── .gitignore                             Git exclusion rules
├── requirements.txt                       Python dependencies for analysis
├── LICENSE  
└── README.md                                 
```
---

## Takeaway

Even within the same storm, airport recovery varied greatly.  
This analysis highlights how **data-driven scoring** can reveal hidden operational strengths and vulnerabilities--and help decision-makers focus recovery efforts more effectively.

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

This project is licensed under the MIT License. See the [`LICENSE`](LICENSE) file for details.

## Author

**Christopher Bolduc**  
[LinkedIn](https://www.linkedin.com/in/christopher-david-bolduc/) • [GitHub](https://github.com/christopherbolduc)