# indonesia-bank-credit-growth-analysis
Time Series Analysis of Indonesian Bank Credit Growth using ECM &amp; VECM in R

## Overview
This project analyzes the impact of BI Rate, Inflation, and Industrial Production Index (IPI) on Indonesian banking credit growth using monthly data from 2010–2025.
The analysis employs Error Correction Model (ECM) and Vector Error Correction Model (VECM) to identify both short-run and long-run relationships among macroeconomic variables.

## Objectives
- Analyze the effect of BI Rate on banking credit growth.
- Examine the impact of inflation and Industrial Production Index (IPI).
- Estimate both long-run and short-run relationships.
- Analyze dynamic responses using VECM, IRF, and FEVD.

## Dataset
Source:
- Bank Indonesia (BI)
- Badan Pusat Statistik (BPS)

Frequency:
- Monthly

Period:
- January 2010 – December 2025

## Tools & Libraries
Language:
- R

Libraries:
- readxl
- tseries
- urca
- vars
- lmtest

## Methodology
1. Data Cleaning
2. Augmented Dickey-Fuller (ADF) Test
3. Long-run Regression
4. Error Correction Model (ECM)
5. Johansen Cointegration Test
6. Vector Error Correction Model (VECM)
7. Impulse Response Function (IRF)
8. Forecast Error Variance Decomposition (FEVD)

## Key Findings
- BI Rate has a significant positive effect on bank credit growth in the short run.
- Industrial Production Index (IPI) has a significant negative effect in the long run.
- Inflation is not statistically significant.
- Bank credit growth is largely explained by its own historical dynamics.

## Project Outcome
The analysis shows that:
- BI Rate has a significant positive effect on bank credit growth in the short run.
- Industrial Production Index (IPI) has a significant negative effect on bank credit growth in the long run.
- Inflation does not have a statistically significant effect.
- The Error Correction Model confirms the existence of a long-run equilibrium relationship among the variables.


