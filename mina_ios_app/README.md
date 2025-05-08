# Mina iOS App

A mobile iOS application for Mina - a smart marketplace for baby gear.

## Features

- User authentication with email and phone
- Beautifully designed welcome screen matching the original web design

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
│   ├── AuthManager.swift     # Authentication manager
│   └── Constants.swift       # App colors and configuration
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

2. Open the generated `.xcworkspace` file in Xcode

3. Build and run the project

## Security Notes

- In a production environment, never store API keys and secrets in the client-side code
- Use environment variables or a secure key management system
- Implement proper CSRF protection
- Enable SSL/TLS for all communications
- Set up proper authentication and authorization checks on the server side

## License

[Your License Here] 