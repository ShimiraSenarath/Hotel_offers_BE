# Hotels Offers Backend

A Spring Boot REST API for managing hotel offers with bank partnerships.

## Features

- **Hotel Offers Management**: CRUD operations for hotel offers
- **Bank Management**: Manage partner banks
- **Authentication**: JWT-based authentication
- **Authorization**: Role-based access control (Admin/User)
- **Search & Filtering**: Advanced filtering by location, bank, card type
- **Database**: Oracle Database integration
- **Validation**: Comprehensive input validation
- **Error Handling**: Global exception handling

## Tech Stack

- **Java 17**
- **Spring Boot 3.2.0**
- **Spring Security** with JWT
- **Spring Data JPA**
- **Oracle Database**
- **MapStruct** for DTO mapping
- **Lombok** for boilerplate reduction
- **Maven** for dependency management

## Prerequisites

- Java 17 or higher
- Maven 3.6 or higher
- Oracle Database 11g or higher
- IDE (IntelliJ IDEA, Eclipse, VS Code)

## Database Setup

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
- `DB_USERNAME` - Database username
- `DB_PASSWORD` - Database password
- `JWT_SECRET` - JWT secret key

### Application Properties
All configuration is in `src/main/resources/application.yml`

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

### Build JAR
```bash
mvn clean package
```

### Run JAR
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

## Contributing

1. Fork the repository
2. Create a feature branch
3. Make your changes
4. Add tests
5. Submit a pull request

## License

This project is licensed under the MIT License.

# Cloud DB Data
# Display Name - hotelsoffers
# DB Name - freepdb1
# userName - ADMIN
# password - 750750@AzIT!
# wallet password - 750750@AzIT!
