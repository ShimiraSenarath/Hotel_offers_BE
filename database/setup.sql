-- Oracle Database Setup Script for Hotels Offers
-- Run this script as SYS user with SYSDBA privileges

-- Connect as SYS with SYSDBA privileges
-- sqlplus sys/your_sys_password@localhost:1521/FREE as sysdba

-- Create the application user
CREATE USER hotelsoffers IDENTIFIED BY 520520;

-- Grant necessary privileges
GRANT CONNECT TO hotelsoffers;
GRANT RESOURCE TO hotelsoffers;
GRANT CREATE SESSION TO hotelsoffers;
GRANT CREATE TABLE TO hotelsoffers;
GRANT CREATE SEQUENCE TO hotelsoffers;
GRANT CREATE PROCEDURE TO hotelsoffers;
GRANT CREATE TRIGGER TO hotelsoffers;
GRANT UNLIMITED TABLESPACE TO hotelsoffers;

-- Grant permissions on system tables (needed for Hibernate)
GRANT SELECT ON SYS.DBA_ROLE_PRIVS TO hotelsoffers;
GRANT SELECT ON SYS.DBA_SYS_PRIVS TO hotelsoffers;
GRANT SELECT ON SYS.DBA_TAB_PRIVS TO hotelsoffers;

-- Connect as the new user and create the schema
-- sqlplus hotelsoffers/520520@localhost:1521/FREE

-- Now run the schema.sql file as the hotelsoffers user

COMMIT;
