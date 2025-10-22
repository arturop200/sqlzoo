-- 1. Bigger than Russia
SELECT
  name
FROM
  world
WHERE
  population > (
    SELECT
      population
    FROM
      world
    WHERE
      name = 'Russia'
  );

-- 2. Richer than UK
SELECT
  name
FROM
  world
WHERE
  continent = 'Europe'
  AND gdp / population > (
    SELECT
      gdp / population
    FROM
      world
    WHERE
      name = 'United Kingdom'
  );

-- 3. Neighbours of Argentina and Australia
SELECT
  name,
  continent
FROM
  world
WHERE
  continent IN (
    SELECT
      continent
    FROM
      world
    WHERE
      name = 'Argentina'
      OR name = 'Australia'
  )
ORDER BY
  name;

-- 4. Between Canada and Poland
SELECT
  name,
  population
FROM
  world
WHERE
  population > (
    SELECT
      population
    FROM
      world
    WHERE
      name = 'United Kingdom'
  )
  AND population < (
    SELECT
      population
    FROM
      world
    WHERE
      name = 'Germany'
  );

-- 5. Percentages of Germany
SELECT
  name,
  CONCAT(
    ROUND(
      population / (
        SELECT
          population
        FROM
          world
        WHERE
          name = 'Germany'
      ) * 100
    ),
    '%'
  ) AS percentage
FROM
  world
WHERE
  continent = 'Europe';

-- 6. Bigger than every country in Europe
SELECT
  name
FROM
  world
WHERE
  gdp > ALL (
    SELECT
      gdp
    FROM
      world
    WHERE
      continent = 'Europe'
      AND gdp IS NOT NULL
  );

-- 7. Largest in each continent
SELECT
  continent,
  name,
  area
FROM
  world x
WHERE
  area >= ALL (
    SELECT
      area
    FROM
      world y
    WHERE
      y.continent = x.continent
  );

-- 8. First country of each continent (alphabetically)
SELECT
  continent,
  name
FROM
  world x
WHERE
  name <= ALL (
    SELECT
      name
    FROM
      world y
    WHERE
      x.continent = y.continent
  );

-- Difficult Question That Utilize Techniques Not Covered In Prior Sections
-- 9.
SELECT
  name,
  continent,
  population
FROM
  world
WHERE
  continent IN (
    SELECT DISTINCT
      continent
    FROM
      world
    GROUP BY
      continent
    HAVING
      MAX(population) <= 25000000
  );

-- 10. Three time bigger
SELECT
  name,
  continent
FROM
  world AS x
WHERE
  population > ALL (
    SELECT
      3 * population
    FROM
      world AS y
    WHERE
      x.continent = y.continent
      AND x.name != y.name
  );