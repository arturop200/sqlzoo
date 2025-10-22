-- 1. Warming up
SELECT
  lastName,
  party,
  votes
FROM
  ge
WHERE
  constituency = 'S14000024'
  AND yr = 2017
ORDER BY
  votes DESC;

-- 2. Who won?
SELECT
  party,
  votes,
  RANK() OVER (
    ORDER BY
      votes DESC
  ) as posn
FROM
  ge
WHERE
  constituency = 'S14000024'
  AND yr = 2017
ORDER BY
  party;

-- 3. PARTITION BY
SELECT
  yr,
  party,
  votes,
  RANK() OVER (
    PARTITION BY
      yr
    ORDER BY
      votes DESC
  ) as posn
FROM
  ge
WHERE
  constituency = 'S14000021'
ORDER BY
  party,
  yr;

-- 4. Edinburgh Constituency
SELECT
  constituency,
  party,
  votes,
  RANK() OVER (
    PARTITION BY
      constituency
    ORDER BY
      votes DESC
  ) AS posn
FROM
  ge
WHERE
  constituency BETWEEN 'S14000021' AND 'S14000026'
  AND yr = 2017
ORDER BY
  posn,
  constituency,
  votes DESC;

-- 5. Winners Only
SELECT
  constituency,
  party
FROM
  (
    SELECT
      constituency,
      party,
      RANK() OVER (
        PARTITION BY
          constituency
        ORDER BY
          votes DESC
      ) AS posn
    FROM
      ge
    WHERE
      constituency BETWEEN 'S14000021' AND 'S14000026'
      AND yr = 2017
  ) AS partial_table_with_posn
WHERE
  posn = 1;

-- 6. Scottish seats
SELECT
  party,
  COUNT(*)
FROM
  (
    SELECT
      constituency,
      party,
      votes,
      RANK() OVER (
        PARTITION BY
          constituency
        ORDER BY
          votes DESC
      ) AS posn
    FROM
      ge
    WHERE
      constituency LIKE 'S%'
      AND yr = 2017
  ) as rank
WHERE
  posn = 1
GROUP BY
  party;
