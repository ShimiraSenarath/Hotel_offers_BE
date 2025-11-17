# Troubleshooting Login 401 Error

## Problem
Getting `{"error":"Invalid email or password"}` when trying to login with `admin@hoteloffers.com` / `admin123`

## Quick Diagnostics

### Step 1: Check if user exists in database

```bash
sqlplus hotelsoffers/520520@localhost:1521/freepdb1 @database/check_user.sql
```

You should see:
- Email: `admin@hoteloffers.com`
- Role: `ADMIN` (not `'ADMIN'` with quotes)
- is_active: `1`
- password_length: `60` (BCrypt hashes are always 60 characters)

### Step 2: Verify password hash

```bash
cd hotels-offers-backend
mvn test-compile
mvn exec:java -Dexec.mainClass="com.hotelsoffers.PasswordTest"
```

This will test if the password hash matches `admin123`.

### Step 3: Check backend logs

When you try to login, check the backend console for errors. Look for:
- `User not found with email: admin@hoteloffers.com` 
- `Bad credentials`
- Any Spring Security debug messages

## Common Issues & Solutions

### Issue 1: User doesn't exist

**Check:**
```sql
SELECT * FROM users WHERE email = 'admin@hoteloffers.com';
```

**Fix:**
```sql
INSERT INTO users (id, email, name, password, role, is_active) VALUES (
    SEQ_USERS.NEXTVAL, 
    'admin@hoteloffers.com', 
    'Admin User', 
    '$2a$10$N.zmdr9k7uOCQb376NoUnuTJ8iAt6Z5EHsM8lE9lBOsl7iKTVEFDi', 
    'ADMIN',
    1
);
COMMIT;
```

### Issue 2: Password hash is incorrect

**Test the hash:**
```bash
mvn exec:java -Dexec.mainClass="com.hotelsoffers.PasswordTest"
```

**If it fails, generate a new hash:**
```bash
mvn exec:java -Dexec.mainClass="com.hotelsoffers.util.PasswordHashGenerator"
# Enter: admin123
# Copy the generated hash
```

**Update database:**
```sql
UPDATE users 
SET password = '$2a$10$NEW_HASH_HERE' 
WHERE email = 'admin@hoteloffers.com';
COMMIT;
```

### Issue 3: User is inactive

**Check:**
```sql
SELECT email, is_active FROM users WHERE email = 'admin@hoteloffers.com';
```

**Fix:**
```sql
UPDATE users 
SET is_active = 1 
WHERE email = 'admin@hoteloffers.com';
COMMIT;
```

### Issue 4: Role is wrong format

The database should have `ADMIN` not `'ADMIN'` (no quotes).

**Check:**
```sql
SELECT email, role, DUMP(role) FROM users WHERE email = 'admin@hoteloffers.com';
```

**Fix if needed:**
```sql
UPDATE users 
SET role = 'ADMIN' 
WHERE email = 'admin@hoteloffers.com';
COMMIT;
```

### Issue 5: Backend not connected to database

**Check application.yml:**
```yaml
spring:
  datasource:
    url: jdbc:oracle:thin:@localhost:1521/freepdb1
    username: hotelsoffers
    password: 520520
```

**Test connection:**
```bash
sqlplus hotelsoffers/520520@localhost:1521/freepdb1
```

### Issue 6: Context path issue

Your backend has `context-path: /api`, so the login endpoint is:
- ✅ Correct: `http://localhost:8080/api/auth/login`
- ❌ Wrong: `http://localhost:8080/auth/login`

## Manual Testing

### Test 1: Check if backend is running

```bash
curl http://localhost:8080/api/banks
```

Should return list of banks (this is a public endpoint).

### Test 2: Test login with curl

```bash
curl -v -X POST http://localhost:8080/api/auth/login \
  -H "Content-Type: application/json" \
  -d '{"email":"admin@hoteloffers.com","password":"admin123"}'
```

**Expected response (success):**
```json
{
  "token": "eyJhbGc...",
  "type": "Bearer",
  "user": {
    "id": "1",
    "email": "admin@hoteloffers.com",
    "name": "Admin User",
    "role": "ADMIN"
  }
}
```

**Error responses:**

**401 Unauthorized** with `Invalid email or password`:
- User doesn't exist
- Password is wrong
- User is inactive

**500 Internal Server Error**:
- Database connection issue
- Backend error (check logs)

### Test 3: Check frontend network request

Open browser DevTools → Network tab:
1. Go to `http://localhost:3000/login`
2. Enter credentials
3. Click "Sign in"
4. Look at the network request:
   - URL should be: `http://localhost:8080/api/auth/login`
   - Method: POST
   - Request body: `{"email":"admin@hoteloffers.com","password":"admin123"}`
   - Response status: Should be 200, not 401

## Complete Reset & Verification Script

If nothing works, try this complete reset:

```sql
-- Connect to database
sqlplus hotelsoffers/520520@localhost:1521/freepdb1

-- Delete existing user
DELETE FROM users WHERE email = 'admin@hoteloffers.com';
COMMIT;

-- Create fresh user with correct password hash
INSERT INTO users (id, email, name, password, role, is_active) VALUES (
    SEQ_USERS.NEXTVAL, 
    'admin@hoteloffers.com', 
    'Admin User', 
    '$2a$10$N.zmdr9k7uOCQb376NoUnuTJ8iAt6Z5EHsM8lE9lBOsl7iKTVEFDi', 
    'ADMIN',
    1
);
COMMIT;

-- Verify
SELECT id, email, name, role, is_active, LENGTH(password) as pwd_len 
FROM users 
WHERE email = 'admin@hoteloffers.com';

-- Exit
EXIT;
```

Then restart your backend:
```bash
# Stop backend (Ctrl+C)
# Start again
mvn spring-boot:run
```

## Debugging Steps

### Enable Spring Security Debug Logging

Add to `application.yml`:
```yaml
logging:
  level:
    org.springframework.security: DEBUG
    com.hotelsoffers: DEBUG
```

Restart backend and try login again. You'll see detailed authentication flow in the logs.

### Check the exact error

Look for these in backend logs:
```
User not found with email: admin@hoteloffers.com
```
→ User doesn't exist in database

```
Bad credentials
```
→ Password is wrong or user is inactive

```
JPA error / database connection
```
→ Database connection issue

## Still Not Working?

If you've tried everything above and it still doesn't work, provide:

1. **User data from database:**
   ```sql
   SELECT * FROM users WHERE email = 'admin@hoteloffers.com';
   ```

2. **Backend logs** when you try to login

3. **Frontend network request** details from browser DevTools

4. **Password test result:**
   ```bash
   mvn exec:java -Dexec.mainClass="com.hotelsoffers.PasswordTest"
   ```

This will help identify the exact issue!

