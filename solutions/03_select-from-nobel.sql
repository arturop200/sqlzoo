-- 1. Winners from 1950
SELECT
  yr,
  subject,
  winner
FROM
  nobel
WHERE
  yr = 1950;

-- 2. 1962 Literature
SELECT
  winner
FROM
  nobel
WHERE
  yr = 1962
  AND subject = 'literature';

-- 3. Albert Einstein
SELECT
  yr,
  subject
FROM
  nobel
WHERE
  winner = 'Albert Einstein';

-- 4. Recent Peace Prizes
SELECT
  winner
FROM
  nobel
WHERE
  subject = 'peace'
  AND yr >= 2000;

-- 5. Literature in the 1980's
SELECT
  yr,
  subject,
  winner
FROM
  nobel
WHERE
  subject = 'literature'
  AND yr >= 1980
  AND yr <= 1989;

-- 6. Only Presidents
SELECT
  *
FROM
  nobel
WHERE
  winner IN (
    'Theodore Roosevelt',
    'Thomas Woodrow Wilson',
    'Jimmy Carter',
    'Barack Obama'
  );

-- 7. John
SELECT
  winner
FROM
  nobel
WHERE
  winner LIKE 'John %';

-- 8. Chemistry and Physics from different years
SELECT
  yr,
  subject,
  winner
FROM
  nobel
WHERE
  (
    subject = 'physics'
    AND yr = 1980
  )
  OR (
    subject = 'chemistry'
    AND yr = 1984
  );

-- 9. Exclude Chemists and Medics
SELECT
  yr,
  subject,
  winner
FROM
  nobel
WHERE
  yr = 1980
  AND subject NOT IN('chemistry', 'medicine');

-- 10. Early Medicine, Late Literature
SELECT
  yr,
  subject,
  winner
FROM
  nobel
WHERE
  (
    subject = 'medicine'
    AND yr < 1910
  )
  OR (
    subject = 'literature'
    AND yr >= 2004
  );

-- Harder Question
-- 11. Umlaut
SELECT
  yr,
  subject,
  winner
FROM
  nobel
WHERE
  winner LIKE 'PETER GRÜNBERG';

-- 12. Apostrophe
SELECT
  yr,
  subject,
  winner
FROM
  nobel
WHERE
  winner LIKE "EUGENE O'NEILL";

-- 13. Knights of the realm
SELECT
  winner,
  yr,
  subject
FROM
  nobel
WHERE
  winner LIKE 'Sir %'
ORDER BY
  yr DESC,
  winner;

-- 14. Chemistry and Physics last
SELECT
  winner,
  subject
FROM
  nobel
WHERE
  yr = 1984
ORDER BY
  subject IN ('physics', 'chemistry') ASC;
