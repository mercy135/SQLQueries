-- Rank, DENSE_RANK, and ROW_NUMBER for taxi trip data examples
-- We can't partition by a floating point number, so we CAST trip_miles to INT64
-- Here's some pseudocode:
-- SELECT
  -- *, 
  -- RANK() OVER(PARTITION BY CAST(trip_miles AS INT64) ORDER BY tips DESC) AS tip_rank,
  -- DENSE_RANK() OVER(PARTITION BY CAST(trip_miles AS INT64) ORDER BY tips DESC) AS dense_rank,
  -- ROW_NUMBER() OVER(PARTITION BY CAST(trip_miles AS INT64) ORDER BY tips DESC) AS row_num
-- FROM `bigquery-public-data.chicago_taxi_trips.taxi_trips`
-- WHERE tips > 2.0

DROP TABLE IF EXISTS temp_table;

CREATE TABLE temp_table as (
SELECT 
    *, 
    RANK() OVER(PARTITION BY partition_by_rank_tip AND order_by_tips DESC)
FROM `bigquery-public-data.chicago_taxi_trips.taxi_trips`
WHERE tips > 2.0
);

Results:
trip_id| tip_rank| partition_by_rank_tip  | order_by_tips DESC
2.0    | 100.0    | 1                     | 1
2.0    | 70.0     | 2                     | 3
2.0    | 62.5     | 3                     | 4
2.0    | 60.0     | 4                     | 5


Another Example
SALARY | ROW_NUMBER | RANK | DENSE_RANK
1000   | 1          | 1    | 1
1500   | 2          | 2    | 2
1500   | 3          | 2    | 2
2000   | 4          | 4    | 3
2200   | 5          | 5    | 4
2500   | 6          | 6    | 5
2500   | 7          | 6    | 5
2500   | 8          | 6    | 5
3000   | 9          | 9    | 6


CREATE TABLE t AS
SELECT 'p' v FROM dual UNION ALL
SELECT 'p'   FROM dual UNION ALL
SELECT 'p'   FROM dual UNION ALL
SELECT 'q'   FROM dual UNION ALL
SELECT 'r'   FROM dual UNION ALL
SELECT 'r'   FROM dual UNION ALL
SELECT 's'   FROM dual UNION ALL
SELECT 't'   FROM dual;

SELECT
  v,
  ROW_NUMBER() OVER (ORDER BY v) row_number,
  RANK()       OVER (ORDER BY v) rank,
  DENSE_RANK() OVER (ORDER BY v) dense_rank
FROM t
ORDER BY v;
The above will yield:

+---+------------+------+------------+
| V | ROW_NUMBER | RANK | DENSE_RANK |
+---+------------+------+------------+
| p |          1 |    1 |          1 |
| p |          2 |    1 |          1 |
| p |          3 |    1 |          1 |
| q |          4 |    4 |          2 |
| r |          5 |    5 |          3 |
| r |          6 |    5 |          3 |
| s |          7 |    7 |          4 |
| t |          8 |    8 |          5 |
+---+------------+------+------------+
