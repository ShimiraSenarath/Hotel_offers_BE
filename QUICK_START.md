# Quick Start Guide

## 1. Setup Database

Connect to your Oracle database:
```bash
sqlplus hotelsoffers/520520@localhost:1521/freepdb1
```

Run the schema:
```sql
@database/schema.sql
```

This will create:
- ✅ Tables (banks, users, hotel_offers)
- ✅ Sequences
- ✅ Sample data including a default admin user

## 2. Default Login Credentials

After running the schema, you can login with:

**Email**: `admin@hoteloffers.com`  
**Password**: `admin123`  
**Role**: ADMIN

## 3. Add More Users (Optional)

### Option A: Run the SQL script
```sql
@database/add_users.sql
```

### Option B: Manual SQL Insert
```sql
INSERT INTO users (id, email, name, password, role) VALUES (
    SEQ_USERS.NEXTVAL, 
    'your@email.com', 
    'Your Name', 
    '$2a$10$N.zmdr9k7uOCQb376NoUnuTJ8iAt6Z5EHsM8lE9lBOsl7iKTVEFDi', 
    'ADMIN'
);
COMMIT;
```
This uses password: **admin123**

### Option C: Generate Custom Password Hash
```bash
cd hotels-offers-backend
mvn compile
mvn exec:java -Dexec.mainClass="com.hotelsoffers.util.PasswordHashGenerator"
```
Enter your password and copy the generated hash.

## 4. Start the Backend

```bash
cd hotels-offers-backend
mvn spring-boot:run
```

## 5. Test Login

### Using curl:
```bash
curl -X POST http://localhost:8080/api/auth/login \
  -H "Content-Type: application/json" \
  -d '{"email":"admin@hoteloffers.com","password":"admin123"}'
```

### Using the Frontend:
1. Start frontend: `cd hotels-offers && npm run dev`
2. Go to: `http://localhost:3000/login`
3. Enter credentials and click "Sign in"

## 6. Verify Everything Works

Test public endpoints (no login required):
```bash
# Get banks
curl http://localhost:8080/api/banks

# Get offers
curl http://localhost:8080/api/offers?page=0&size=20

# Search offers
curl http://localhost:8080/api/offers/search?page=0&size=20
```

Test protected endpoints (login required):
```bash
# First login and get token
TOKEN=$(curl -s -X POST http://localhost:8080/api/auth/login \
  -H "Content-Type: application/json" \
  -d '{"email":"admin@hoteloffers.com","password":"admin123"}' \
  | jq -r '.token')

# Create offer with token
curl -X POST http://localhost:8080/api/offers \
  -H "Content-Type: application/json" \
  -H "Authorization: Bearer $TOKEN" \
  -d '{...offer data...}'
```

## Common Issues

### "User not found"
- Make sure you ran `schema.sql`
- Check users exist: `SELECT * FROM users;`
- Run `add_users.sql` to add more users

### "Invalid credentials"
- Check email spelling
- Password is case-sensitive
- Default password is: `admin123`

### 403 Forbidden on public endpoints
- Make sure backend is restarted after configuration changes
- Check `SecurityConfig.java` has correct paths

## User Roles

- **ADMIN**: Can create, edit, and delete hotel offers
- **USER**: Can only view offers (future feature)

## Need Help?

- See `CREATE_USER_GUIDE.md` for detailed user creation instructions
- See `TEST_ENDPOINTS.md` for API testing examples
- See `FIXES_APPLIED.md` for security configuration details

