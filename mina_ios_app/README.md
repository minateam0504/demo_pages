# Mina iOS App

A mobile iOS application for Mina - a smart marketplace for baby gear.

## Features

- User authentication with email, phone, Google, Facebook, and Apple Sign-In
- Beautifully designed welcome screen matching the original web design
- Integration with PostgreSQL database for user data

## Project Structure

```
mina_ios_app/
├── Models/
│   └── User.swift            # User model with authentication provider
├── Views/
│   ├── WelcomeView.swift     # The welcome screen with authentication options
│   └── Components/
│       ├── MinaLogo.swift    # Custom SVG-like logo implementation
│       └── SocialLoginButton.swift  # Reusable social login buttons
├── Helpers/
│   ├── AuthManager.swift     # Authentication manager for social login
│   ├── Constants.swift       # App colors and configuration
│   └── Database/
│       └── PostgresConfig.swift  # PostgreSQL database configuration
├── Resources/                # App resources (to be populated)
└── MinaApp.swift            # Main app entry point
```

## Setup Instructions

### Prerequisites

- Xcode 13 or later
- Swift 5.5 or later
- iOS 15.0+ target
- CocoaPods (for managing dependencies)

### Dependencies

To install the required dependencies, create a Podfile in the root directory with:

```ruby
platform :ios, '15.0'
use_frameworks!

target 'Mina' do
  # Authentication
  pod 'GoogleSignIn', '~> 6.2'
  pod 'FBSDKLoginKit', '~> 14.0'
  
  # Database
  pod 'PostgresClientKit', '~> 1.5'
end
```

Then run:

```
pod install
```

### Configuration

1. Update the authentication credentials in `Helpers/Constants.swift`:
   - Replace `YOUR_GOOGLE_CLIENT_ID` with your actual Google client ID
   - Replace `YOUR_FACEBOOK_APP_ID` with your Facebook app ID
   - Replace `YOUR_APPLE_CLIENT_ID` with your Apple client ID

2. Update PostgreSQL configuration in `Helpers/Database/PostgresConfig.swift`:
   - Update the database host, port, name, username, and password

3. Open the generated `.xcworkspace` file in Xcode

4. Build and run the project

## PostgreSQL Database Setup

1. Install PostgreSQL on your server or local development machine
2. Create a new database for Mina:
   ```sql
   CREATE DATABASE mina_db;
   ```

3. Create the necessary tables:
   ```sql
   -- Users table
   CREATE TABLE users (
       id UUID PRIMARY KEY,
       email VARCHAR(255),
       name VARCHAR(255),
       phone_number VARCHAR(50),
       profile_picture VARCHAR(255),
       auth_provider VARCHAR(50) NOT NULL,
       provider_id VARCHAR(255),
       created_at TIMESTAMP WITH TIME ZONE DEFAULT CURRENT_TIMESTAMP,
       updated_at TIMESTAMP WITH TIME ZONE DEFAULT CURRENT_TIMESTAMP,
       address TEXT,
       neighborhood VARCHAR(255),
       payment_methods JSONB
   );

   -- Create index on email
   CREATE INDEX idx_users_email ON users(email);
   ```

## Security Notes

- In a production environment, never store API keys and secrets in the client-side code
- Use environment variables or a secure key management system
- Implement proper CSRF protection
- Enable SSL/TLS for all communications, especially with the PostgreSQL database
- Set up proper authentication and authorization checks on the server side

## License

[Your License Here] 