SELECT 
  ticker,  
  date, 
  volume, 
  SUM(volume) OVER (PARTITION BY ticker ORDER BY date ROWS BETWEEN UNBOUNDED PRECEDING AND CURRENT ROW) AS cumulative_volume
FROM stock_prices
WHERE date BETWEEN '2020-01-01' AND '2020-12-31'
ORDER BY ticker, date;

WITH average_price AS (
  SELECT AVG(close) AS avg_price
  FROM stock_prices
  WHERE date BETWEEN '2020-01-01' AND '2020-12-31'
)
SELECT 
  ticker,
  COUNT(*) AS days_above_average
FROM stock_prices, average_price
WHERE close > avg_price
  AND date BETWEEN '2020-01-01' AND '2020-12-31'
GROUP BY ticker;

WITH apple_returns AS (
  SELECT 
    date,
    close,
    LAG(close) OVER (ORDER BY date) AS previous_close
  FROM stock_prices
  WHERE ticker = 'AAPL'
),
microsoft_returns AS (
  SELECT 
    date,
    close,
    LAG(close) OVER (ORDER BY date) AS previous_close
  FROM stock_prices
  WHERE ticker = 'MSFT'
)
SELECT 
  a.date,
  a.close AS apple_close,
  m.close AS microsoft_close,
  ((a.close - a.previous_close) / a.previous_close) * 100 AS apple_daily_return,
  ((m.close - m.previous_close) / m.previous_close) * 100 AS microsoft_daily_return
FROM apple_returns a
JOIN microsoft_returns m
  ON a.date = m.date
WHERE a.previous_close IS NOT NULL AND m.previous_close IS NOT NULL
ORDER BY a.date;

SELECT 
  ticker, DATE_TRUNC('month', date) AS month,
  AVG(close) AS avg_monthly_close
FROM stock_prices
WHERE date BETWEEN '2020-01-01' AND '2020-12-31'
GROUP BY ticker,month
ORDER BY ticker,month ;

WITH monthly_data AS (
  SELECT 
    ticker, DATE_TRUNC('month', date) AS month,
    AVG(close) AS avg_monthly_close
  FROM stock_prices
  WHERE date BETWEEN '2020-01-01' AND '2020-12-31'
  GROUP BY ticker,month
)
SELECT 
  ticker,month,
  avg_monthly_close,
  LAG(avg_monthly_close) OVER (ORDER BY month) AS previous_month_close,
  ((avg_monthly_close - LAG(avg_monthly_close) OVER (ORDER BY month)) / LAG(avg_monthly_close) OVER (ORDER BY month)) * 100 AS monthly_return
FROM monthly_data
ORDER BY month;

SELECT 
  ticker, 
  DATE_TRUNC('month', date) AS month,
  AVG(close) AS avg_monthly_close
FROM stock_prices
WHERE date BETWEEN '2020-01-01' AND '2020-12-31'
GROUP BY ticker, DATE_TRUNC('month', date)  
HAVING AVG(close) > 200
ORDER BY ticker, month;
WITH daily_returns AS (
  SELECT 
    date, 
    ticker,
    close,
    LAG(close) OVER (PARTITION BY ticker ORDER BY date) AS previous_close,
    CASE 
      WHEN close > LAG(close) OVER (PARTITION BY ticker ORDER BY date) THEN 1
      ELSE 0
    END AS is_up
  FROM stock_prices
),
streak_groups AS (
  SELECT *,
    SUM(CASE WHEN is_up = 0 THEN 1 ELSE 0 END) 
      OVER (PARTITION BY ticker ORDER BY date ROWS UNBOUNDED PRECEDING) AS streak_id
  FROM daily_returns
)
SELECT 
  date, 
  ticker,
  close,
  COUNT(*) OVER (PARTITION BY ticker, streak_id ORDER BY date) AS growth_streak
FROM streak_groups
WHERE ticker = 'AAPL'
ORDER BY date;
