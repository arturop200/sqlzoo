-- 1. Introducing the covid table
SELECT
  name,
  DAY(whn),
  confirmed,
  deaths,
  recovered
FROM
  covid
WHERE
  name = 'Spain'
  AND MONTH(whn) = 3
  AND YEAR(whn) = 2020
ORDER BY
  whn;

-- 2. Introducing the LAG function
SELECT
  name,
  DAY(whn),
  confirmed,
  LAG(confirmed, 1) OVER (
    PARTITION BY
      name
    ORDER BY
      whn
  )
FROM
  covid
WHERE
  name = 'Italy'
  AND MONTH(whn) = 3
  AND YEAR(whn) = 2020
ORDER BY
  whn;

-- 3. Number of new cases
SELECT
  name,
  DAY(whn),
  confirmed - LAG(confirmed, 1) OVER (
    PARTITION BY
      name
    ORDER BY
      whn
  ) AS new_cases
FROM
  covid
WHERE
  name = 'Italy'
  AND MONTH(whn) = 3
  AND YEAR(whn) = 2020
ORDER BY
  whn;

-- 4. Weekly changes
SELECT
  name,
  DATE_FORMAT(whn, '%Y-%m-%d'),
  confirmed - LAG(confirmed, 1) OVER (
    PARTITION BY
      name
    ORDER BY
      whn
  ) AS new_cases
FROM
  covid
WHERE
  name = 'Italy'
  AND WEEKDAY(whn) = 0
  AND YEAR(whn) = 2020
ORDER BY
  whn;

-- 5. LAG using a JOIN
SELECT
  tw.name,
  DATE_FORMAT(tw.whn, '%Y-%m-%d'),
  tw.confirmed - lw.confirmed
FROM
  covid tw
  LEFT JOIN covid lw ON DATE_ADD(lw.whn, INTERVAL 1 WEEK) = tw.whn
  AND tw.name = lw.name
WHERE
  tw.name = 'Italy'
  AND WEEKDAY(tw.whn) = 0
ORDER BY
  tw.whn;

-- 6. RANK()
SELECT
  name,
  confirmed,
  RANK() OVER (
    ORDER BY
      confirmed DESC
  ) rc,
  deaths,
  RANK() OVER (
    ORDER BY
      deaths DESC
  ) deaths_rc
FROM
  covid
WHERE
  whn = '2020-04-20'
ORDER BY
  confirmed DESC;

-- 7. Infection rate
SELECT
  world.name,
  ROUND(100000 * confirmed / population, 2),
  RANK() OVER (
    ORDER BY
      100000 * confirmed / population
  ) as rank
FROM
  covid
  JOIN world ON covid.name = world.name
WHERE
  whn = '2020-04-20'
  AND population > 10000000
ORDER BY
  population DESC;

-- 8. Turning the corner
SELECT
  name,
  DATE_FORMAT(whn, '%Y-%m-%d'),
  new_cases
FROM
  (
    SELECT
      name,
      whn,
      new_cases,
      RANK() OVER (
        PARTITION BY
          name
        ORDER BY
          new_cases DESC
      ) as rank
    FROM
      (
        SELECT
          name,
          whn,
          confirmed - LAG(confirmed, 1) OVER (
            PARTITION BY
              name
            ORDER BY
              whn
          ) AS new_cases
        FROM
          covid
      ) as ncsd
    WHERE
      new_cases > 20000
  ) as ranking
WHERE
  rank = 1;
