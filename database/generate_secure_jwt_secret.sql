-- Generate a secure JWT secret (64 characters = 512 bits)
-- This creates a random string that's secure for JWT

SELECT 'Generated JWT Secret (copy this to application.yml):' AS info FROM dual;

SELECT 
    'jwt:' AS config_line FROM dual
UNION ALL
SELECT 
    '  secret: ' || 
    DBMS_RANDOM.STRING('A', 32) || 
    DBMS_RANDOM.STRING('A', 32) AS config_line FROM dual;

-- Alternative: Use a predefined secure secret
SELECT 'Alternative secure secret:' AS info FROM dual;
SELECT 'mySecretKeyForJWTTokenGenerationMustBeAtLeast256BitsLongForSecurity' AS secure_secret FROM dual;
