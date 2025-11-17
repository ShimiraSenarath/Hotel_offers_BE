@echo off
echo Setting up location data in Oracle database...
echo.

echo Connecting to Oracle database...
sqlplus hotelsoffers/520520@localhost:1521/freepdb1 @create_location_data.sql

echo.
echo Location data setup complete!
echo.
echo You can now test the API endpoints:
echo - GET http://localhost:8080/api/locations/countries
echo - GET http://localhost:8080/api/locations/provinces
echo - GET http://localhost:8080/api/locations/districts
echo - GET http://localhost:8080/api/locations/cities
echo.
pause
