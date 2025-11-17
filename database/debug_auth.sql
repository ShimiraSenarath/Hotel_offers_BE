-- Debug authentication issues
-- Run this to get detailed information about the user

SET SERVEROUTPUT ON;

DECLARE
    user_email VARCHAR2(255) := 'admin@hotelsoffers.com';
    user_count NUMBER;
    user_record users%ROWTYPE;
BEGIN
    -- Check if user exists
    SELECT COUNT(*) INTO user_count FROM users WHERE email = user_email;
    
    IF user_count = 0 THEN
        DBMS_OUTPUT.PUT_LINE('ERROR: User not found');
    ELSIF user_count > 1 THEN
        DBMS_OUTPUT.PUT_LINE('ERROR: Multiple users found (' || user_count || ')');
    ELSE
        DBMS_OUTPUT.PUT_LINE('SUCCESS: Exactly 1 user found');
        
        -- Get user details
        SELECT * INTO user_record FROM users WHERE email = user_email;
        
        DBMS_OUTPUT.PUT_LINE('========================================');
        DBMS_OUTPUT.PUT_LINE('User Details:');
        DBMS_OUTPUT.PUT_LINE('========================================');
        DBMS_OUTPUT.PUT_LINE('ID: ' || user_record.id);
        DBMS_OUTPUT.PUT_LINE('Email: ' || user_record.email);
        DBMS_OUTPUT.PUT_LINE('Name: ' || user_record.name);
        DBMS_OUTPUT.PUT_LINE('Role: ' || user_record.role);
        DBMS_OUTPUT.PUT_LINE('Is Active: ' || user_record.is_active);
        DBMS_OUTPUT.PUT_LINE('Password Length: ' || LENGTH(user_record.password));
        DBMS_OUTPUT.PUT_LINE('Password Start: ' || SUBSTR(user_record.password, 1, 10));
        DBMS_OUTPUT.PUT_LINE('Password End: ' || SUBSTR(user_record.password, -10));
        
        -- Check password format
        IF user_record.password LIKE '$2a$%' THEN
            DBMS_OUTPUT.PUT_LINE('Password Format: CORRECT (BCrypt)');
        ELSE
            DBMS_OUTPUT.PUT_LINE('Password Format: INCORRECT (Not BCrypt)');
        END IF;
        
        -- Check if user is active
        IF user_record.is_active = 1 THEN
            DBMS_OUTPUT.PUT_LINE('Account Status: ACTIVE');
        ELSE
            DBMS_OUTPUT.PUT_LINE('Account Status: INACTIVE');
        END IF;
        
        DBMS_OUTPUT.PUT_LINE('========================================');
    END IF;
END;
/

-- Also show the raw data
SELECT 'RAW USER DATA:' AS info FROM dual;
SELECT 
    id,
    email,
    name,
    role,
    is_active,
    password,
    created_at
FROM users 
WHERE email = 'admin@hotelsoffers.com';
