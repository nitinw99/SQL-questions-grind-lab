/*
- Given a list of exchange rates from various currencies to US Dollars (USD) in different months.
Show how the exchange rate of all the currencies changed in the first half of 2020.
Output the currency code and the difference between values of the exchange rate between July 1, 2020 and January 1, 2020.

CREATE TABLE sf_exchange_rates ( date DATETIME, exchange_rate FLOAT, source_currency VARCHAR(10), target_currency VARCHAR(10));

INSERT INTO sf_exchange_rates (date, exchange_rate, source_currency, target_currency) VALUES ('2020-01-01', 1.12, 'EUR', 'USD'), ('2020-01-01', 1.31, 'GBP', 'USD'), ('2020-01-01', 109.56, 'JPY', 'USD'), ('2020-07-01', 1.17, 'EUR', 'USD'), ('2020-07-01', 1.29, 'GBP', 'USD'), ('2020-07-01', 109.66, 'JPY', 'USD'), ('2020-01-01', 0.75, 'AUD', 'USD'), ('2020-07-01', 0.73, 'AUD', 'USD'), ('2020-01-01', 6.98, 'CNY', 'USD'), ('2020-07-01', 7.05, 'CNY', 'USD');

*/

-- SELECT * FROM sf_exchange_rates;

WITH cte AS (
SELECT source_currency,
    MAX(CASE WHEN to_date(date)='2020-01-01' THEN exchange_rate END) AS jan_rate,
    MAX(CASE WHEN to_date(date)='2020-07-01' THEN exchange_rate END) AS july_rate
FROM sf_exchange_rates
WHERE target_currency = 'USD' AND to_date(date) IN ('2020-01-01','2020-07-01')
GROUP BY 1
)

SELECT source_currency,
COALESCE(july_rate,0) - COALESCE(jan_rate ,0) AS rate_change
FROM cte
ORDER BY 1;