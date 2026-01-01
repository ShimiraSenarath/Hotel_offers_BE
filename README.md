# Hotels Offers Backend

A Spring Boot REST API for managing hotel offers with bank partnerships.

## Features

- **Hotel Offers Management**: CRUD operations for hotel offers
- **Bank Management**: Manage partner banks
- **Authentication**: JWT-based authentication
- **Authorization**: Role-based access control (Admin/User)
- **Search & Filtering**: Advanced filtering by location, bank, card type
- **Database**: MySQL/PlanetScale integration
- **Validation**: Comprehensive input validation
- **Error Handling**: Global exception handling

## Tech Stack

- **Java 17**
- **Spring Boot 3.2.0**
- **Spring Security** with JWT
- **Spring Data JPA**
- **MySQL/PlanetScale Database**
- **MapStruct** for DTO mapping
- **Lombok** for boilerplate reduction
- **Maven** for dependency management

## Prerequisites

- Java 17 or higher
- Maven 3.6 or higher
- MySQL/PlanetScale Database (for production) or Oracle Database (for local development)
- IDE (IntelliJ IDEA, Eclipse, VS Code)

## Database Setup

The application supports both MySQL/PlanetScale (for production) and Oracle (for local development).

### For Production (MySQL/PlanetScale)
The application uses environment variables for database configuration. See the [Deployment](#deployment) section for details.

### For Local Development (Oracle)
1. **Create Database Schema**:
   ```sql
   -- Run the schema.sql file in your Oracle database
   -- Located at: database/schema.sql
   ```

2. **Update Database Configuration**:
   ```yaml
   # Update application.yml with your database details
   spring:
     datasource:
       url: jdbc:oracle:thin:@localhost:1521:XE
       username: your_username
       password: your_password
   ```

## Installation & Setup

1. **Clone the repository**:
   ```bash
   git clone <repository-url>
   cd hotels-offers-backend
   ```

2. **Configure Database**:
   - Update `src/main/resources/application.yml` with your Oracle database credentials
   - Run the SQL scripts in the `database/` folder

3. **Build the project**:
   ```bash
   mvn clean install
   ```

4. **Run the application**:
   ```bash
   mvn spring-boot:run
   ```

The API will be available at: `http://localhost:8080/api`

## API Endpoints

### Authentication
- `POST /api/auth/login` - User login
- `GET /api/auth/me` - Get current user info

### Banks
- `GET /api/banks` - Get all banks
- `GET /api/banks/{id}` - Get bank by ID

### Hotel Offers
- `GET /api/offers` - Get all offers (paginated)
- `GET /api/offers/search` - Search offers with filters
- `GET /api/offers/current` - Get current valid offers
- `GET /api/offers/{id}` - Get offer by ID
- `POST /api/offers` - Create new offer (Admin only)
- `PUT /api/offers/{id}` - Update offer (Admin only)
- `DELETE /api/offers/{id}` - Delete offer (Admin only)

### Search Parameters
- `country` - Filter by country
- `province` - Filter by province
- `district` - Filter by district
- `city` - Filter by city
- `bankId` - Filter by bank ID
- `cardType` - Filter by card type (CREDIT/DEBIT)

## Default Admin User

```
Email: admin@hotelsoffers.com
Password: admin123
```

## API Usage Examples

### 1. Login
```bash
curl -X POST http://localhost:8080/api/auth/login \
  -H "Content-Type: application/json" \
  -d '{
    "email": "admin@hotelsoffers.com",
    "password": "admin123"
  }'
```

### 2. Get All Offers
```bash
curl -X GET "http://localhost:8080/api/offers?page=0&size=10" \
  -H "Authorization: Bearer <your-jwt-token>"
```

### 3. Search Offers
```bash
curl -X GET "http://localhost:8080/api/offers/search?country=Sri Lanka&bankId=1" \
  -H "Authorization: Bearer <your-jwt-token>"
```

### 4. Create Offer (Admin)
```bash
curl -X POST http://localhost:8080/api/offers \
  -H "Content-Type: application/json" \
  -H "Authorization: Bearer <your-jwt-token>" \
  -d '{
    "hotelName": "Test Hotel",
    "description": "A test hotel",
    "location": {
      "country": "Sri Lanka",
      "province": "Western Province",
      "district": "Colombo",
      "city": "Colombo 01"
    },
    "bankId": 1,
    "cardType": "CREDIT",
    "discount": 20,
    "validFrom": "2024-01-01",
    "validTo": "2024-12-31",
    "terms": "Test terms"
  }'
```

## Configuration

### Environment Variables

The following environment variables are required for production deployment (e.g., Render):

```bash
DB_HOST=localhost
DB_PORT=3306
DB_NAME=your_db
DB_USERNAME=your_username
DB_PASSWORD=your_password
DB_USE_SSL=false
JWT_SECRET=your-secret-key-at-least-256-bits-long-for-production
```

#### Environment Variable Descriptions:
- `DB_HOST` - Your database host (e.g., `localhost` for local, or `xxxxx.psdb.cloud` for PlanetScale)
- `DB_PORT` - Database port (default: `3306` for MySQL, `5432` for PostgreSQL, `1521` for Oracle)
- `DB_NAME` - Your database name
- `DB_USERNAME` - Database username
- `DB_PASSWORD` - Database password
- `DB_USE_SSL` - Use SSL for database connection (default: `false` for local, `true` for cloud databases like PlanetScale)
- `JWT_SECRET` - Secret key for JWT token generation (must be at least 256 bits long for production)

### How to Find Environment Variable Values

#### For PlanetScale Database:

1. **Log in to PlanetScale Dashboard**: https://app.planetscale.com

2. **Find DB_HOST**:
   - Go to your database
   - Click on **"Connect"** button
   - Select **"Connect with"** → **"General"** or **"Prisma"**
   - Look for the connection string or host field
   - The host will look like: `xxxxx.xxxxx.psdb.cloud`
   - Copy this value (without `mysql://` prefix if present)

3. **Find DB_NAME**:
   - The database name is usually shown in the PlanetScale dashboard
   - It's the name you gave your database when creating it
   - Or check the connection string: `mysql://user:pass@host:port/DB_NAME`

4. **Find DB_USERNAME and DB_PASSWORD**:
   - In PlanetScale dashboard, go to **"Settings"** → **"Passwords"**
   - Click **"New password"** to create a new database password
   - The username is usually your PlanetScale account username or the database branch name
   - Copy both values

5. **Find DB_PORT**:
   - For PlanetScale, this is always `3306` (standard MySQL port)

#### For DBeaver (MySQL/PostgreSQL/Oracle):

1. **Open DBeaver** and connect to your database

2. **Find Connection Details**:
   - Right-click on your database connection in the **Database Navigator** panel
   - Select **"Edit Connection"** (or press `F4`)
   - This opens the connection settings window

3. **Find DB_HOST**:
   - In the **"Main"** tab, look for **"Server Host"** or **"Host"** field
   - For local databases, this is usually: `localhost` or `127.0.0.1`
   - For remote databases, this will be the server IP or domain name
   - Copy this value

4. **Find DB_PORT**:
   - In the same **"Main"** tab, look for **"Port"** field
   - Common ports:
     - MySQL: `3306`
     - PostgreSQL: `5432`
     - Oracle: `1521`
   - Copy this value

5. **Find DB_NAME**:
   - In the **"Main"** tab, look for **"Database"** or **"Database/Schema"** field
   - This is the name of your database
   - Copy this value

6. **Find DB_USERNAME**:
   - In the **"Main"** tab, look for **"Username"** or **"User name"** field
   - Copy this value

7. **Find DB_PASSWORD**:
   - In the **"Main"** tab, look for **"Password"** field
   - If it shows dots/asterisks, click the **"Show password"** button (eye icon) to reveal it
   - Copy this value
   - **Note**: If you don't see the password, you may need to re-enter it in DBeaver

8. **Alternative Method - View Connection URL**:
   - In the connection settings, go to **"Driver properties"** or **"URL"** tab
   - You can see the full JDBC connection string
   - Parse it to extract: `jdbc:mysql://HOST:PORT/DB_NAME`
   - Example: `jdbc:mysql://localhost:3306/hotelsoffers`
     - Host: `localhost`
     - Port: `3306`
     - Database: `hotelsoffers`

**Example Values from DBeaver:**
```
DB_HOST=localhost          (or your server IP)
DB_PORT=3306               (MySQL) or 5432 (PostgreSQL) or 1521 (Oracle)
DB_NAME=hotelsoffers       (your database name)
DB_USERNAME=root           (or your database user)
DB_PASSWORD=yourpassword   (your database password)
```

#### Generate JWT_SECRET:

You need to generate a secure random string that's at least 256 bits (32 characters) long. Here are several ways:

**Option 1: Using OpenSSL (Recommended)**
```bash
openssl rand -base64 32
```

**Option 2: Using Node.js**
```bash
node -e "console.log(require('crypto').randomBytes(32).toString('base64'))"
```

**Option 3: Using Python**
```bash
python -c "import secrets; print(secrets.token_urlsafe(32))"
```

**Option 4: Online Generator**
- Visit: https://generate-secret.vercel.app/32
- Or: https://www.random.org/strings/
- Generate a random string of at least 32 characters

**Option 5: Manual (Not Recommended for Production)**
You can use any random string, but make sure it's:
- At least 32 characters long
- Contains a mix of letters, numbers, and special characters
- Example: `my-super-secret-jwt-key-for-production-2024!@#$`

**Important**: Keep your JWT_SECRET secure and never commit it to version control!

### Application Properties
All configuration is in `src/main/resources/application.yml`. The application will use environment variables if provided, otherwise it will fall back to default values for local development.

## Development

### Project Structure
```
src/main/java/com/hotelsoffers/
├── controller/          # REST controllers
├── dto/                 # Data Transfer Objects
├── entity/              # JPA entities
├── exception/           # Exception handling
├── mapper/              # MapStruct mappers
├── repository/          # JPA repositories
├── security/            # Security configuration
└── service/             # Business logic
```

### Adding New Features
1. Create entity in `entity/` package
2. Create DTOs in `dto/` package
3. Create mapper in `mapper/` package
4. Create repository in `repository/` package
5. Create service in `service/` package
6. Create controller in `controller/` package

## Testing

Run tests with:
```bash
mvn test
```

## Deployment

### Deploying to Render

1. **Connect your GitHub repository** to Render
2. **Create a new Web Service** in Render
3. **Configure the service**:
   - **Build Command**: `mvn clean package -DskipTests`
   - **Start Command**: `java -jar target/hotels-offers-backend-1.0.0.jar`
   - **Environment**: Java 17

4. **Add Environment Variables** in Render dashboard:
   ```
   DB_HOST=xxxxxxxx.psdb.cloud
   DB_PORT=3306
   DB_NAME=your_db
   DB_USERNAME=xxxxxxxx
   DB_PASSWORD=xxxxxxxx
   JWT_SECRET=your-secret-key-at-least-256-bits-long-for-production
   ```

5. **Deploy** - Render will automatically build and deploy your application

### Local Build & Run

#### Build JAR
```bash
mvn clean package
```

#### Run JAR
```bash
java -jar target/hotels-offers-backend-1.0.0.jar
```

### Docker (Optional)
```dockerfile
FROM openjdk:17-jdk-slim
COPY target/hotels-offers-backend-1.0.0.jar app.jar
EXPOSE 8080
ENTRYPOINT ["java", "-jar", "/app.jar"]
```

### Important Notes for Production

- **PlanetScale SSL**: The application is configured to use SSL connections (required by PlanetScale)
- **Auto Schema Creation**: Tables will be automatically created on first run via Hibernate `ddl-auto: update`
- **JWT Secret**: Use a strong, random secret key in production (at least 256 bits)
- **Database Connection**: Ensure your database allows connections from Render's IP addresses

## Contributing

1. Fork the repository
2. Create a feature branch
3. Make your changes
4. Add tests
5. Submit a pull request

## License

This project is licensed under the MIT License.
