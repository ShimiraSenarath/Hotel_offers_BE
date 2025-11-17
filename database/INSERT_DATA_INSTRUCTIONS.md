# How to Insert Sample Data into Your Database

## Quick Instructions

### Step 1: Connect to Oracle Database
```bash
sqlplus hotelsoffers/520520@localhost:1521/freepdb1
```

### Step 2: Run the Sample Data Script
```sql
@D:\Project\HotelsOffers\hotels-offers-backend\database\insert_sample_data.sql
```

### Step 3: Verify Data Was Inserted
You should see output like:
```
TABLE_NAME    COUNT
----------    -----
Banks:        6
Users:        2
Hotel Offers: 10
```

### Step 4: Exit SQL*Plus
```sql
EXIT;
```

---

## What Data Will Be Inserted?

### 📊 **6 Banks:**
- Commercial Bank
- Peoples Bank
- Sampath Bank
- HNB
- DFCC Bank
- NTB

### 👤 **2 Users:**

**Admin User:**
- Email: `admin@hotelsoffers.com`
- Password: `admin123`
- Role: ADMIN

**Test User:**
- Email: `user@hotelsoffers.com`
- Password: `user123`
- Role: USER

### 🏨 **10 Hotel Offers:**
1. Cinnamon Grand Colombo (25% discount)
2. Shangri-La Colombo (20% discount)
3. Heritance Kandalama (30% discount)
4. Jetwing Lighthouse (35% discount)
5. Anantara Peace Haven (28% discount)
6. Amaya Hills Kandy (22% discount)
7. Kingsbury Hotel (18% discount)
8. Centara Ceysands Resort (32% discount)
9. Earl's Regency Hotel (26% discount)
10. Hilton Colombo (24% discount)

---

## Alternative: Run Everything at Once

If you haven't created the database yet, you can run the full schema (which includes sample data):

```bash
sqlplus hotelsoffers/520520@localhost:1521/freepdb1
@D:\Project\HotelsOffers\hotels-offers-backend\database\schema.sql
EXIT;
```

---

## Troubleshooting

### Error: "unique constraint violated"
This means data already exists. You can:
1. Delete existing data first (see the commented-out section in `insert_sample_data.sql`)
2. Or skip this step if you already have data

### Error: "sequence does not exist"
Run the full schema first:
```sql
@D:\Project\HotelsOffers\hotels-offers-backend\database\schema.sql
```

### Error: "table or view does not exist"
Create the tables first:
```sql
@D:\Project\HotelsOffers\hotels-offers-backend\database\schema.sql
```

---

## After Inserting Data

1. **Start the backend**:
   ```bash
   cd D:\Project\HotelsOffers\hotels-offers-backend
   mvn spring-boot:run
   ```

2. **Start the frontend**:
   ```bash
   cd D:\Project\HotelsOffers\hotels-offers
   npm run dev
   ```

3. **Login with admin credentials**:
   - Email: `admin@hotelsoffers.com`
   - Password: `admin123`

4. **View the hotel offers** at http://localhost:3000/hotel-offers

---

## Quick Verification Queries

After inserting data, you can verify it with these SQL queries:

```sql
-- Count all records
SELECT 'Banks' AS table_name, COUNT(*) FROM banks
UNION ALL
SELECT 'Users', COUNT(*) FROM users
UNION ALL
SELECT 'Offers', COUNT(*) FROM hotel_offers;

-- View all banks
SELECT * FROM banks;

-- View all users (without passwords)
SELECT id, email, name, role FROM users;

-- View all hotel offers
SELECT hotel_name, city, discount, card_type, valid_from, valid_to 
FROM hotel_offers 
ORDER BY discount DESC;

-- View offers by bank
SELECT b.name AS bank, h.hotel_name, h.discount
FROM hotel_offers h
JOIN banks b ON h.bank_id = b.id
ORDER BY b.name, h.discount DESC;
```

