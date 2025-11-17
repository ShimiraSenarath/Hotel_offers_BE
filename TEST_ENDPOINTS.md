# Testing Backend Endpoints

## Important Note About Context Path

Your application has `context-path: /api` configured in `application.yml`, which means:
- External URL: `http://localhost:8080/api/banks`
- Internal Spring mapping: `/banks` (without `/api`)

The Security configuration uses the internal paths (without `/api`).

## Test Public Endpoints (Should work without authentication)

### 1. Get All Banks
```bash
curl http://localhost:8080/api/banks
```

Expected: JSON array of banks

### 2. Get All Hotel Offers
```bash
curl "http://localhost:8080/api/offers?page=0&size=20"
```

Expected: Paginated response with hotel offers

### 3. Search Hotel Offers
```bash
curl "http://localhost:8080/api/offers/search?page=0&size=20"
```

Expected: Paginated response with hotel offers

### 4. Search with Filters
```bash
curl "http://localhost:8080/api/offers/search?country=Sri%20Lanka&page=0&size=20"
```

Expected: Filtered hotel offers

## Test Authentication

### 5. Login
```bash
curl -X POST http://localhost:8080/api/auth/login \
  -H "Content-Type: application/json" \
  -d '{"email":"admin@hoteloffers.com","password":"admin123"}'
```

Expected: JSON with token and user info
```json
{
  "token": "eyJhbGc...",
  "type": "Bearer",
  "user": {
    "id": "1",
    "email": "admin@hoteloffers.com",
    "name": "Admin User",
    "role": "admin"
  }
}
```

## Test Protected Endpoints (Require authentication)

First, get a token from the login endpoint above, then:

### 6. Create Hotel Offer (Protected)
```bash
curl -X POST http://localhost:8080/api/offers \
  -H "Content-Type: application/json" \
  -H "Authorization: Bearer YOUR_TOKEN_HERE" \
  -d '{
    "hotelName": "Test Hotel",
    "description": "Test Description",
    "location": {
      "country": "Sri Lanka",
      "province": "Western Province",
      "district": "Colombo",
      "city": "Colombo 03"
    },
    "bankId": 1,
    "cardType": "credit",
    "discount": 20,
    "validFrom": "2024-01-01",
    "validTo": "2024-12-31",
    "terms": "Test terms",
    "isActive": true
  }'
```

Expected: Created offer with HTTP 201

### 7. Update Hotel Offer (Protected)
```bash
curl -X PUT http://localhost:8080/api/offers/1 \
  -H "Content-Type: application/json" \
  -H "Authorization: Bearer YOUR_TOKEN_HERE" \
  -d '{
    "hotelName": "Updated Hotel",
    "description": "Updated Description",
    "location": {
      "country": "Sri Lanka",
      "province": "Western Province",
      "district": "Colombo",
      "city": "Colombo 03"
    },
    "bankId": 1,
    "cardType": "credit",
    "discount": 25,
    "validFrom": "2024-01-01",
    "validTo": "2024-12-31",
    "terms": "Updated terms",
    "isActive": true
  }'
```

### 8. Delete Hotel Offer (Protected)
```bash
curl -X DELETE http://localhost:8080/api/offers/1 \
  -H "Authorization: Bearer YOUR_TOKEN_HERE"
```

## Testing from Browser Console

Open your browser console on `http://localhost:3000` and run:

```javascript
// Test public endpoint
fetch('http://localhost:8080/api/banks')
  .then(r => r.json())
  .then(console.log)
  .catch(console.error);

// Test search
fetch('http://localhost:8080/api/offers/search?page=0&size=20')
  .then(r => r.json())
  .then(console.log)
  .catch(console.error);
```

## Troubleshooting

### If you still get 403 errors:

1. **Check the logs** in the backend terminal for security debug messages

2. **Verify paths** - Remember the context-path is `/api`, so:
   - Frontend calls: `http://localhost:8080/api/banks`
   - Spring Security sees: `/banks`

3. **Check if endpoints exist**:
   ```bash
   curl http://localhost:8080/api/actuator/health
   ```

4. **Test without CORS** (from terminal, not browser):
   ```bash
   curl -v http://localhost:8080/api/banks
   ```

5. **Check controller mappings** - Make sure your controllers use:
   ```java
   @RestController
   @RequestMapping("/banks")  // NOT "/api/banks"
   public class BankController { ... }
   ```

6. **Restart the backend** after making changes:
   ```bash
   mvn clean spring-boot:run
   ```

## Expected Security Behavior

| Endpoint | Method | Authentication Required |
|----------|--------|------------------------|
| /banks | GET | ❌ No |
| /offers | GET | ❌ No |
| /offers/search | GET | ❌ No |
| /auth/login | POST | ❌ No |
| /offers | POST | ✅ Yes (Admin) |
| /offers/{id} | PUT | ✅ Yes (Admin) |
| /offers/{id} | DELETE | ✅ Yes (Admin) |

