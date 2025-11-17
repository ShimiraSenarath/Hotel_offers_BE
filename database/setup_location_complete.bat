@echo off
echo Setting up location data in Oracle database...
echo.

echo Step 1: Creating location tables and inserting data...
sqlplus hotelsoffers/520520@localhost:1521/freepdb1 @create_location_data.sql

echo.
echo Step 2: Verifying data insertion...
sqlplus hotelsoffers/520520@localhost:1521/freepdb1 -S <<EOF
SELECT 'COUNTRIES: ' || COUNT(*) AS count FROM countries;
SELECT 'PROVINCES: ' || COUNT(*) AS count FROM provinces;
SELECT 'DISTRICTS: ' || COUNT(*) AS count FROM districts;
SELECT 'CITIES: ' || COUNT(*) AS count FROM cities;
EXIT;
EOF

echo.
echo Location data setup complete!
echo.
echo Next steps:
echo 1. Start the backend: mvn spring-boot:run
echo 2. Test API endpoints: curl http://localhost:8080/api/locations/countries
echo 3. Start frontend: npm run dev
echo.
pause
