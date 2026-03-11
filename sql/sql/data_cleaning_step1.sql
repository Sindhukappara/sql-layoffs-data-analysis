-- STEP 1: Create staging table
CREATE TABLE layoffs_staging
LIKE layoffs;

-- STEP 2: Insert data
INSERT layoffs_staging
SELECT *
FROM layoffs;

-- STEP 3: Check duplicates using ROW_NUMBER
SELECT *,
ROW_NUMBER() OVER(
PARTITION BY company,location,industry,total_laid_off,
percentage_laid_off,`date`,stage,country,funds_raised_millions
) AS row_num
FROM layoffs_staging;

-- STEP 4: Identify duplicate rows
WITH duplicate_cte AS
(
SELECT *,
ROW_NUMBER() OVER(
PARTITION BY company,location,industry,total_laid_off,
percentage_laid_off,`date`,stage,country,funds_raised_millions
) AS row_num
FROM layoffs_staging
)
SELECT *
FROM duplicate_cte
WHERE row_num > 1;

-- STEP 5: Remove duplicates
DELETE
FROM layoffs_staging2
WHERE row_num > 1;
