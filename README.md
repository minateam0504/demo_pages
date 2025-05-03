# Mina - Smart Marketplace for Baby Gear

## Logo Implementation

The Mina logo has been created and implemented across the app. The logo features a stroller with wheels, a cloud shape, and the text "mina" in a serif font, using the app's color palette of terracotta, sage green, cream, and charcoal.

### Logo Assets

- SVG Vector Version: `assets/mina-logo.svg`
- CSS Styles: `assets/mina-logo.css`
- Base64 Encoded Version: `assets/logo-svg-base64.txt` (for direct embedding)
- Component Templates:
  - `logo-component.html` - Reusable logo component
  - `logo-styles.html` - Styles with options for different placements
  - `assets/logo-header.html` - Header version of the logo

### Using the Logo

There are two main logo components that can be used:

1. **Centered Logo** - For welcome and authentication screens:
```html
<div class="mina-centered-logo">
    <svg class="mina-centered-logo-img" viewBox="0 0 280 280" fill="none" xmlns="http://www.w3.org/2000/svg">
        <!-- SVG content... -->
    </svg>
    <div class="mina-centered-logo-text">mina</div>
</div>
```

2. **Header Logo** - For app screens with navigation:
```html
<div class="mina-header-logo">
    <svg class="mina-header-logo-img" viewBox="0 0 280 280" fill="none" xmlns="http://www.w3.org/2000/svg">
        <!-- SVG content... -->
    </svg>
    <div class="mina-header-logo-text">mina</div>
</div>
```

To add the logo to any page:
1. Include the CSS: `<link rel="stylesheet" href="assets/mina-logo.css">`
2. Add the appropriate logo component HTML where needed

The base template (`base-template.html`) already includes the logo in the header for new screens.

## Single Sign-On (SSO) Implementation

This project includes SSO integration with Google, Facebook, and Apple ID. Follow the steps below to configure each provider.

### Setup Requirements

1. Create developer accounts with each provider:
   - [Google Developer Console](https://console.developers.google.com/)
   - [Facebook for Developers](https://developers.facebook.com/)
   - [Apple Developer Program](https://developer.apple.com/)

2. Install required dependencies:
   ```
   npm install axios jsonwebtoken
   ```

### Google Sign-In Setup

1. Create a new project in the [Google Cloud Console](https://console.cloud.google.com/)
2. Go to "APIs & Services" > "Credentials"
3. Create an OAuth 2.0 Client ID
4. Configure the authorized JavaScript origins and redirect URIs
5. Copy your Client ID and Client Secret to the auth config:
   - Update `YOUR_GOOGLE_CLIENT_ID` in `/js/auth.js`
   - Update both `YOUR_GOOGLE_CLIENT_ID` and `YOUR_GOOGLE_CLIENT_SECRET` in `/server/auth-handlers.js`

### Facebook Login Setup

1. Create a new app in the [Facebook Developer Dashboard](https://developers.facebook.com/apps/)
2. Add the Facebook Login product to your app
3. Configure Valid OAuth Redirect URIs
4. Copy your App ID and App Secret to the auth config:
   - Update `YOUR_FACEBOOK_APP_ID` in `/js/auth.js`
   - Update both `YOUR_FACEBOOK_APP_ID` and `YOUR_FACEBOOK_APP_SECRET` in `/server/auth-handlers.js`

### Apple Sign-In Setup

1. Register an App ID in the [Apple Developer Portal](https://developer.apple.com/account/resources/identifiers/list)
2. Enable "Sign In with Apple" capability
3. Create a Services ID and configure domains and redirect URLs
4. Create a private key for client authentication
5. Update the configuration:
   - Update `YOUR_APPLE_CLIENT_ID` in `/js/auth.js`
   - Update all Apple-related credentials in `/server/auth-handlers.js`

### Implementation Details

The SSO implementation consists of:

1. **Client-side** (`/js/auth.js`): 
   - Handles user interaction with login buttons
   - Initiates OAuth flows
   - Sends authentication tokens to the backend

2. **Server-side** (`/server/auth-handlers.js`):
   - Processes authentication tokens
   - Verifies user identity with providers
   - Creates or updates user records
   - Issues JWT tokens for the application

### Security Notes

- In production, **never store API keys and secrets in client-side code**
- Use environment variables for all sensitive credentials
- Implement proper CSRF protection
- Set secure and HTTP-only flags on cookies
- Use HTTPS for all communications

### Testing

To test the SSO implementation:
1. Configure all providers with proper credentials
2. Start your development server
3. Visit the welcome page
4. Click on any of the social login buttons
5. Complete the authentication flow
6. You should be redirected back to the application and logged in 