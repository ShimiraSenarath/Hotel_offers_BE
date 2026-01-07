# Render Deployment Guide

This guide explains how to deploy the Hotels Offers Backend to Render and configure the Oracle database connection.

## Prerequisites

- Oracle Cloud Database (or other Oracle database accessible from Render)
- Render account
- Database connection details (host, port, service name, username, password)

## Step 1: Set Environment Variables in Render

In your Render service dashboard, go to **Environment** and add the following environment variables:

### Required Environment Variables

#### Database Connection

**Option A: Direct Connection (Recommended for most cases)**
```
DB_URL=jdbc:oracle:thin:@YOUR_HOST:1521/YOUR_SERVICE_NAME
DB_USERNAME=ADMIN
DB_PASSWORD=your_database_password
```

**Option B: Oracle Cloud with Wallet**
```
DB_URL=jdbc:oracle:thin:@YOUR_TNS_NAME?TNS_ADMIN=/app/wallet
DB_USERNAME=ADMIN
DB_PASSWORD=your_database_password
```

**Note:** If using Option B, you'll need to upload the Oracle wallet files to your Render service. See "Oracle Wallet Setup" below.

#### JWT Secret (Required)
```
JWT_SECRET=your_very_long_secret_key_at_least_256_bits_long
```

### Example Environment Variables

For Oracle Cloud Free Tier (direct connection):
```
DB_URL=jdbc:oracle:thin:@your-db-host.subnet.vcn.oraclevcn.com:1521/freepdb1
DB_USERNAME=ADMIN
DB_PASSWORD=750750@AzIT!
JWT_SECRET=your-super-secret-jwt-key-at-least-32-characters-long-for-security
```

## Step 2: Oracle Wallet Setup (If Using Wallet Connection)

If you're using Oracle Cloud with wallet authentication, you need to ensure the wallet files are available in Render.

### Option A: Include Wallet in Repository (Recommended)

1. **Ensure wallet files are in your repository:**
   - Your wallet files should be in `Wallet_freepdb1/` directory
   - Make sure this directory is committed to your Git repository

2. **Update Build Command in Render:**
   ```
   mvn clean package -DskipTests && mkdir -p /app/wallet && cp -r Wallet_freepdb1/* /app/wallet/
   ```

3. **Set Environment Variables:**
   ```
   DB_TNS_NAME=freepdb1_high
   DB_USERNAME=ADMIN
   DB_PASSWORD=your_password
   ```
   
   **Note:** Available TNS names from your wallet:
   - `freepdb1_high` (recommended for production)
   - `freepdb1_medium`
   - `freepdb1_low`
   - `freepdb1_tp`
   - `freepdb1_tpurgent`

### Option B: Use Direct Connection (Simpler, No Wallet Needed)

If you prefer not to use the wallet, you can use a direct connection:

1. **Set Environment Variables:**
   ```
   DB_URL=jdbc:oracle:thin:@adb.ap-hyderabad-1.oraclecloud.com:1522/g7fc0e7633915ca_freepdb1_high.adb.oraclecloud.com
   DB_USERNAME=ADMIN
   DB_PASSWORD=your_password
   ```
   
   **Note:** For direct connection, you may need to configure Oracle Cloud to allow connections without wallet (less secure).

## Step 3: Configure Render Service

### Build Settings

**If using wallet (Option A):**
- **Build Command:** `mvn clean package -DskipTests && mkdir -p /app/wallet && cp -r Wallet_freepdb1/* /app/wallet/`
- **Start Command:** `java -jar target/hotels-offers-backend-1.0.0.jar`

**If using direct connection (Option B):**
- **Build Command:** `mvn clean package -DskipTests`
- **Start Command:** `java -jar target/hotels-offers-backend-1.0.0.jar`

### Port Configuration

The application runs on port 8080 by default. Render will automatically assign a port via the `PORT` environment variable. Update your `application.yml` if needed:

```yaml
server:
  port: ${PORT:8080}
```

## Step 4: Verify Database Connectivity

### Check Database Access from Render

1. Ensure your Oracle database allows connections from Render's IP addresses
2. For Oracle Cloud, you may need to:
   - Add Render's IP to security lists
   - Configure Network Security Groups
   - Allow inbound connections on port 1521

### Test Connection

After deployment, check the logs for connection errors. The application will attempt to connect on startup.

## Step 5: Troubleshooting

### Error: "ORA-12541: Cannot connect. No listener at host localhost"

**Cause:** The `DB_URL` environment variable is not set, so it's using the default localhost connection.

**Solution:** 
1. Go to Render Dashboard → Your Service → Environment
2. Add `DB_URL` with your actual database connection string
3. Redeploy the service

### Error: "ORA-12154: TNS:could not resolve the connect identifier"

**Cause:** TNS name cannot be resolved or wallet path is incorrect.

**Solution:**
- Verify `DB_TNS_NAME` is set to a valid TNS name (e.g., `freepdb1_high`)
- Ensure wallet files are copied to `/app/wallet` during build
- Check that wallet files exist in the repository `Wallet_freepdb1/` directory
- Verify the build command includes the wallet copy step

### Error: "Cannot resolve reference to bean 'jpaSharedEM_entityManagerFactory'"

**Cause:** Database connection is failing, preventing JPA from initializing.

**Solution:**
1. Check that `DB_URL` or `DB_TNS_NAME` environment variable is set correctly
2. Verify database credentials (`DB_USERNAME`, `DB_PASSWORD`)
3. Ensure wallet files are present at `/app/wallet` (if using wallet)
4. Check Render logs for database connection errors
5. Verify Oracle Cloud allows connections from Render's IP addresses

### Error: "ORA-01017: invalid username/password"

**Cause:** Database credentials are incorrect.

**Solution:**
- Verify `DB_USERNAME` and `DB_PASSWORD` environment variables
- Ensure credentials match your Oracle database

### Connection Timeout

**Cause:** Database is not accessible from Render's network.

**Solution:**
1. Check Oracle Cloud security rules
2. Verify database host and port are correct
3. Ensure database is running and accessible
4. Check firewall rules

## Environment Variables Summary

| Variable | Required | Description | Example |
|----------|----------|-------------|---------|
| `DB_URL` | Conditional | Full JDBC connection URL (if not using wallet) | `jdbc:oracle:thin:@host:1522/service` |
| `DB_TNS_NAME` | Conditional | TNS name from wallet (if using wallet) | `freepdb1_high` |
| `DB_USERNAME` | Yes | Database username | `ADMIN` |
| `DB_PASSWORD` | Yes | Database password | `your_password` |
| `JWT_SECRET` | Yes | JWT signing secret | `your-secret-key` |

## Quick Setup Checklist

**For Wallet Connection:**
- [ ] Ensure `Wallet_freepdb1/` directory is in your repository
- [ ] Set `DB_TNS_NAME` environment variable (e.g., `freepdb1_high`)
- [ ] Set `DB_USERNAME` environment variable
- [ ] Set `DB_PASSWORD` environment variable
- [ ] Set `JWT_SECRET` environment variable
- [ ] Update build command to copy wallet files
- [ ] Configure database firewall/security to allow Render IPs
- [ ] Deploy and check logs for connection success
- [ ] Test API endpoints after deployment

**For Direct Connection:**
- [ ] Set `DB_URL` environment variable with full JDBC URL
- [ ] Set `DB_USERNAME` environment variable
- [ ] Set `DB_PASSWORD` environment variable
- [ ] Set `JWT_SECRET` environment variable
- [ ] Configure database firewall/security to allow Render IPs
- [ ] Deploy and check logs for connection success
- [ ] Test API endpoints after deployment

## Additional Resources

- [Render Environment Variables Documentation](https://render.com/docs/environment-variables)
- [Oracle JDBC Connection Strings](https://docs.oracle.com/en/database/oracle/oracle-database/19/jjdbc/data-sources-and-URLs.html)
- [Oracle Cloud Database Connection Guide](https://docs.oracle.com/en/cloud/paas/autonomous-database/adbsa/connect-preparing.html)

