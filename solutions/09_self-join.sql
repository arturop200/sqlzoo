-- 1.
SELECT
  COUNT(id)
FROM
  stops;

-- 2.
SELECT
  id
FROM
  stops
WHERE
  name = 'Craiglockhart';

-- 3.
SELECT
  stops.id,
  stops.name
FROM
  stops
  JOIN route ON stops.id = route.stop
WHERE
  num = '4'
  and company = 'LRT';

-- 4.
SELECT
  company,
  num,
  COUNT(*)
FROM
  route
WHERE
  stop = 149
  OR stop = 53
GROUP BY
  company,
  num
HAVING
  COUNT(*) = 2;

-- 5.
SELECT
  a.company,
  a.num,
  a.stop,
  b.stop
FROM
  route a
  JOIN route b ON (
    a.company = b.company
    AND a.num = b.num
  )
WHERE
  a.stop = 53
  and b.stop = 149;

-- 6.
SELECT
  a.company,
  a.num,
  stopa.name,
  stopb.name
FROM
  route a
  JOIN route b ON (
    a.company = b.company
    AND a.num = b.num
  )
  JOIN stops stopa ON (a.stop = stopa.id)
  JOIN stops stopb ON (b.stop = stopb.id)
WHERE
  stopa.name = 'Craiglockhart'
  AND stopb.name = 'London Road';

-- Using a self join
-- 7.
SELECT
  R1.company,
  R1.num
FROM
  route R1,
  route R2
WHERE
  R1.company = R2.company
  AND R1.num = R2.num
  AND (
    R1.stop = 115
    AND R2.stop = 137
  )
GROUP BY
  R1.company,
  R1.num;

-- 8.
SELECT
  R1.company,
  R1.num
FROM
  route R1,
  route R2,
  stops S1,
  stops S2
WHERE
  R1.company = R2.company
  AND R1.num = R2.num
  AND R1.stop = S1.id
  AND R2.stop = S2.id
  AND (
    (
      S1.name = 'Craiglockhart'
      AND S2.name = 'Tollcross'
    )
    OR (
      S1.name = 'Tollcross'
      AND S2.name = 'Craiglockhart'
    )
  )
GROUP BY
  R1.company,
  R1.num;

-- 9.
SELECT
  S2.name,
  R1.company,
  R1.num
FROM
  route R1,
  route R2,
  stops S1,
  stops S2
WHERE
  R1.company = R2.company && R1.num = R2.num
  AND R1.stop = S1.id
  AND R2.stop = S2.id
  AND S1.name = 'Craiglockhart'
GROUP BY
  R1.company,
  R1.num,
  S2.name
ORDER BY
  S1.name;

-- 10.
SELECT
  VS.num,
  VS.company,
  VS.name,
  VE.num,
  VE.company
FROM
  (
    SELECT
      R1.num,
      R1.company,
      S2.id,
      S2.name
    FROM
      route R1
      JOIN route R2 ON R1.company = R2.company
      AND R1.num = R2.num
      JOIN stops S1 ON R1.stop = S1.id
      JOIN stops S2 ON R2.stop = S2.id
    WHERE
      S1.name = 'Craiglockhart'
  ) AS VS
  JOIN (
    SELECT
      R2.company,
      S2.name,
      S2.id,
      R2.num
    FROM
      route R1
      JOIN route R2 ON R1.company = R2.company
      AND R1.num = R2.num
      JOIN stops S1 ON R1.stop = S1.id
      JOIN stops S2 ON R2.stop = S2.id
    WHERE
      S1.name = 'Lochend'
  ) AS VE ON VS.id = VE.id
ORDER BY
  VS.num,
  VE.name,
  VE.num;