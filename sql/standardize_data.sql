-- STEP 3: Standardizing Data

-- View data
SELECT *
FROM layoffs_staging2;

-- Remove leading/trailing spaces from company names
SELECT company, TRIM(company)
FROM layoffs_staging2;

UPDATE layoffs_staging2
SET company = TRIM(company);

-- Standardize industry values (Crypto variations)
SELECT *
FROM layoffs_staging2
WHERE industry LIKE 'Crypto%';

UPDATE layoffs_staging2
SET industry = 'Crypto'
WHERE industry LIKE 'Crypto%';

-- Check unique country values
SELECT DISTINCT(country)
FROM layoffs_staging2
ORDER BY 1;

-- Remove trailing '.' from country names (United States.)
UPDATE layoffs_staging2
SET country = TRIM(TRAILING '.' FROM country)
WHERE country LIKE 'United States%';

-- Verify changes
SELECT DISTINCT(country)
FROM layoffs_staging2
ORDER BY 1;

-- Convert date from text to proper DATE format
SELECT `date`
FROM layoffs_staging2;

UPDATE layoffs_staging2
SET `date` = STR_TO_DATE(`date`, '%m/%d/%Y');

-- Change column data type to DATE
ALTER TABLE layoffs_staging2
MODIFY COLUMN `date` DATE;
