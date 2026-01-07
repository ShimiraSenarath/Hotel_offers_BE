#!/bin/bash
# Build script for Render deployment with Oracle Wallet support

# Build the application
mvn clean package -DskipTests

# Create wallet directory and copy wallet files
mkdir -p /app/wallet
if [ -d "Wallet_freepdb1" ]; then
    cp -r Wallet_freepdb1/* /app/wallet/
    echo "Wallet files copied to /app/wallet"
else
    echo "Warning: Wallet_freepdb1 directory not found"
fi

echo "Build completed successfully"

