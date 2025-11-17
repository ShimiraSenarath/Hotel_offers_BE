@echo off
echo ============================================
echo Hotels Offers - Insert Sample Data
echo ============================================
echo.
echo This will insert sample data into your database:
echo - 6 Banks
echo - 2 Users (Admin and Test User)
echo - 10 Hotel Offers
echo.
echo Database: freepdb1
echo Username: hotelsoffers
echo Password: 520520
echo.
pause

echo.
echo Connecting to database and inserting data...
echo.

sqlplus -S hotelsoffers/520520@localhost:1521/freepdb1 @insert_sample_data.sql

echo.
echo ============================================
echo Data insertion complete!
echo ============================================
echo.
echo You can now:
echo 1. Start the backend (mvn spring-boot:run)
echo 2. Start the frontend (npm run dev)
echo 3. Login with: admin@hotelsoffers.com / admin123
echo.
pause

