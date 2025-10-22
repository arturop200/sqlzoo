-- 1. Check out one row
SELECT
  A_STRONGLY_AGREE
FROM
  nss
WHERE
  question = 'Q01'
  AND institution = 'Edinburgh Napier University'
  AND subject = '(8) Computer Science';

-- 2. Calculate how many agree or strongly agree
SELECT
  institution,
  subject
FROM
  nss
WHERE
  question = 'Q15'
  AND score >= 100;

-- 3. Unhappy Computer Students
SELECT
  institution,
  score
FROM
  nss
WHERE
  question = 'Q15'
  AND subject = '(8) Computer Science'
  AND score < 50;

-- 4. More Computing or Creative Students
SELECT
  subject,
  SUM(response)
FROM
  nss
WHERE
  question = 'Q22'
  AND (
    subject = '(8) Computer Science'
    OR subject = '(H) Creative Arts and Design'
  )
GROUP BY
  subject;

-- 5. Strongly Agree Numbers
SELECT
  subject,
  SUM(A_STRONGLY_AGREE * response / 100)
FROM
  nss
WHERE
  question = 'Q22'
  AND (
    subject = '(8) Computer Science'
    OR subject = '(H) Creative Arts and Design'
  )
GROUP BY
  subject;

-- 6. Strongly Agree, Percentage
SELECT
  subject,
  ROUND(
    SUM(A_STRONGLY_AGREE * response / 100) / SUM(response) * 100,
    0
  )
FROM
  nss
WHERE
  question = 'Q22'
  AND (
    subject = '(8) Computer Science'
    OR subject = '(H) Creative Arts and Design'
  )
GROUP BY
  subject;

-- 7. Scores for Institutions in Manchester
SELECT
  institution,
  ROUND(
    SUM(score * response / 100) / SUM(response) * 100,
    0
  )
FROM
  nss
WHERE
  question = 'Q22'
  AND (institution LIKE '%Manchester%')
GROUP BY
  institution
ORDER BY
  institution;

-- 8. Number of Computing Students in Manchester
/*SELECT institution,subject,score,response, sample*/
SELECT
  institution,
  SUM(sample),
  SUM(
    CASE
      WHEN subject LIKE '%Computer Science%' THEN sample
      ELSE 0
    END
  )
FROM
  nss
WHERE
  question = 'Q01'
  AND (institution LIKE '%Manchester%')
GROUP BY
  institution;