CREATE DATABASE PROJECT2;
USE PROJECT2;

select* from cleaned_students_performance;
select count(*) from cleaned_students_performance;


-- 1..Count students in different grade ranges (A, B, C...)
SELECT
    CASE
        WHEN (math_score + reading_score + writing_score) / 3 >= 90 THEN 'A'
        WHEN (math_score + reading_score + writing_score) / 3 >= 80 THEN 'B'
        WHEN (math_score + reading_score + writing_score) / 3 >= 70 THEN 'C'
        WHEN (math_score + reading_score + writing_score) / 3 >= 60 THEN 'D'
        ELSE 'F'
    END AS grade_range,
    COUNT(*) AS student_count
FROM
   cleaned_students_performance
GROUP BY
    grade_range
ORDER BY
    grade_range;

 
-- 2..Group by categorical variables to see average grades 
SELECT 
  gender,
  round(AVG(math_score),2) AS avg_math,
  round(AVG(reading_score),2) AS avg_reading,
  round(AVG(writing_score),2) AS avg_writing
FROM cleaned_students_performance
GROUP BY gender;


-- 3..Find top 10 students with the best combined performance (G1 + G2 + G3)
SELECT 
  *,
  (math_score + reading_score + writing_score) AS total_score
FROM cleaned_students_performance
ORDER BY total_score DESC
LIMIT 10;

-- 4..How many students fall into each category of 'parental_level_of_education'
SELECT
    parental_level_of_education,
    COUNT(*) AS number_of_students
FROM
    cleaned_students_performance
GROUP BY
    parental_level_of_education
ORDER BY
    number_of_students DESC;
    

-- 5..Does the type of lunch affect students' combined performance?
SELECT
    lunch,
    AVG(math_score + reading_score + writing_score) AS average_combined_score
FROM
    cleaned_students_performance
GROUP BY
    lunch;   


-- 6..What is the highest score achieved in the Math test?
SELECT
    MAX(math_score) AS highest_math_score
FROM
    cleaned_students_performance;

-- 7..How many students have parents with a 'some college' education level?
SELECT
    COUNT(*) AS students_with_some_college_parents
FROM
    cleaned_students_performance
WHERE
    parental_level_of_education = 'some college'; 



-- 8..How many students belong to each race/ethnicity group?
SELECT
    "race/ethnicity",
    COUNT(*) AS student_count
FROM
    cleaned_students_performance
GROUP BY
    "race/ethnicity"
ORDER BY
    student_count DESC;

-- 9..Find all students who scored above 80 in ALL three subjects (Math, Reading, and Writing).
SELECT
    gender,
    "race/ethnicity",
    math_score,
    reading_score,
    writing_score
FROM
    cleaned_students_performance
WHERE
    math_score > 80 AND reading_score > 80 AND writing_score > 80;

-- 10..What is the average writing score for each parental education level, specifically for students who completed test preparation?
SELECT
    parental_level_of_education,
    AVG(writing_score) AS average_writing_score
FROM
    cleaned_students_performance
WHERE
    test_preparation_course = 'completed'
GROUP BY
    parental_level_of_education
ORDER BY
    average_writing_score DESC;

-- 11..Identify the number of students who are male, have 'standard' lunch, and did NOT complete test preparation.
SELECT
    COUNT(*) AS specific_student_count
FROM
    cleaned_students_performance
WHERE
    gender = 'male'
    AND lunch = 'standard'
    AND test_preparation_course = 'not completed';    