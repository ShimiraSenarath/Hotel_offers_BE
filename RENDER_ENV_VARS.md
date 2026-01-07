# Render Environment Variables - Quick Setup

## Required Environment Variables

Copy and paste these into Render Dashboard → Your Service → Environment:

### For Wallet-Based Connection (Recommended)

```
DB_TNS_NAME=freepdb1_high
DB_USERNAME=ADMIN
DB_PASSWORD=750750@AzIT!
JWT_SECRET=your-super-secret-jwt-key-at-least-32-characters-long-for-security
```

**Available TNS Names:**
- `freepdb1_high` (recommended for production)
- `freepdb1_medium`
- `freepdb1_low`
- `freepdb1_tp`
- `freepdb1_tpurgent`

### For Direct Connection (Alternative)

If you prefer not to use the wallet, set:

```
DB_URL=jdbc:oracle:thin:@adb.ap-hyderabad-1.oraclecloud.com:1522/g7fc0e7633915ca_freepdb1_high.adb.oraclecloud.com
DB_USERNAME=ADMIN
DB_PASSWORD=750750@AzIT!
JWT_SECRET=your-super-secret-jwt-key-at-least-32-characters-long-for-security
```

## Build Command

Make sure your Build Command in Render includes wallet file copying:

```bash
mvn clean package -DskipTests && mkdir -p /app/wallet && cp -r Wallet_freepdb1/* /app/wallet/
```

Or use the build script:

```bash
chmod +x render-build.sh && ./render-build.sh
```

## Start Command

```bash
java -jar target/hotels-offers-backend-1.0.0.jar
```

## Important Notes

1. **Wallet Files**: The `Wallet_freepdb1/` directory must be in your Git repository
2. **Database Access**: Ensure Oracle Cloud allows connections from Render's IP addresses
3. **No localhost**: Never use `localhost` in production - it will always fail

## Troubleshooting

If you see `ORA-12541: Cannot connect. No listener at host localhost`:
- ✅ Check that `DB_TNS_NAME` or `DB_URL` is set in Render environment variables
- ✅ Verify wallet files are copied during build (check build logs)
- ✅ Ensure database firewall allows Render IPs

