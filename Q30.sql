/*
- Find the top 3 most common letters across all the words from both the tables (ignore filename column).
Output the letter along with the number of occurrences and order records in descending order based on the number of occurrences.

CREATE TABLE google_file_store (contents VARCHAR, filename VARCHAR(255));

INSERT INTO google_file_store (contents, filename) VALUES ('This is a sample content with some words.', 'file1.txt'), ('Another file with more words and letters.', 'file2.txt'), ('Text for testing purposes with various characters.', 'file3.txt');

CREATE TABLE google_word_lists ( words1 VARCHAR, words2 VARCHAR);

INSERT INTO google_word_lists (words1, words2) VALUES ('apple banana cherry', 'dog elephant fox'), ('grape honeydew kiwi', 'lemon mango nectarine'), ('orange papaya quince', 'raspberry strawberry tangerine');
*/

-- SELECT * FROM google_file_store;

-- SELECT * FROM google_word_lists;


WITH RECURSIVE Numbers AS (
SELECT 1 AS value
UNION ALL
SELECT value+1
FROM Numbers
WHERE value<100
),

Normalized_text AS (
SELECT REGEXP_REPLACE(contents, '[^a-zA-Z]', '') AS clean_text
FROM google_file_store
UNION ALL
SELECT REGEXP_REPLACE(words1 || ' ' || words2, '[^a-zA-Z]', '') AS clean_text
FROM google_word_lists
),

Exploded_letters AS (
SELECT SUBSTRING(clean_text, n.value, 1) AS letter
FROM Normalized_text, Numbers n
WHERE n.value<= LENGTH(clean_text)
),

Letter_counts AS (
SELECT LOWER(letter) AS letter, COUNT(*) AS occurrences
FROM Exploded_letters
GROUP BY 1
)

SELECT letter, occurrences
FROM Letter_counts
ORDER BY occurrences DESC
LIMIT 3;