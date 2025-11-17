// JWT Secret Generator
// Run this Java code to generate a secure JWT secret

import io.jsonwebtoken.security.Keys;
import javax.crypto.SecretKey;
import java.util.Base64;

public class JWTSecretGenerator {
    public static void main(String[] args) {
        // Generate a secure 256-bit key
        SecretKey key = Keys.secretKeyFor(io.jsonwebtoken.SignatureAlgorithm.HS256);
        
        // Convert to Base64 string for use in application.yml
        String secretKey = Base64.getEncoder().encodeToString(key.getEncoded());
        
        System.out.println("Generated JWT Secret:");
        System.out.println(secretKey);
        System.out.println();
        System.out.println("Add this to your application.yml:");
        System.out.println("jwt:");
        System.out.println("  secret: " + secretKey);
    }
}
