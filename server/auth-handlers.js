/**
 * Authentication Handlers for Mina
 * 
 * This module contains server-side handlers for processing authentication 
 * requests from Google, Facebook and Apple Sign-In.
 */

const axios = require('axios');
const jwt = require('jsonwebtoken');
const crypto = require('crypto');

// Replace these with actual secrets in a production environment
// In production, use environment variables rather than hardcoding
const JWT_SECRET = 'your-jwt-secret-key';
const AUTH_PROVIDERS = {
  google: {
    clientId: 'YOUR_GOOGLE_CLIENT_ID',
    clientSecret: 'YOUR_GOOGLE_CLIENT_SECRET',
    tokenUrl: 'https://oauth2.googleapis.com/token',
    userInfoUrl: 'https://www.googleapis.com/oauth2/v3/userinfo'
  },
  facebook: {
    appId: 'YOUR_FACEBOOK_APP_ID',
    appSecret: 'YOUR_FACEBOOK_APP_SECRET',
    userInfoUrl: 'https://graph.facebook.com/me'
  },
  apple: {
    clientId: 'YOUR_APPLE_CLIENT_ID',
    teamId: 'YOUR_APPLE_TEAM_ID',
    keyId: 'YOUR_APPLE_KEY_ID',
    privateKey: '-----BEGIN PRIVATE KEY-----\nYOUR_APPLE_PRIVATE_KEY\n-----END PRIVATE KEY-----',
  }
};

/**
 * Handle Google OAuth callback
 */
async function handleGoogleCallback(req, res) {
  try {
    const { code } = req.body;
    if (!code) {
      return res.status(400).json({ error: 'Authorization code is required' });
    }

    // Exchange code for token
    const tokenResponse = await axios.post(AUTH_PROVIDERS.google.tokenUrl, {
      code,
      client_id: AUTH_PROVIDERS.google.clientId,
      client_secret: AUTH_PROVIDERS.google.clientSecret,
      redirect_uri: `${req.protocol}://${req.get('host')}/auth/google/callback`,
      grant_type: 'authorization_code'
    });
    
    // Get access token from response
    const { access_token } = tokenResponse.data;
    
    // Get user info with access token
    const userInfoResponse = await axios.get(AUTH_PROVIDERS.google.userInfoUrl, {
      headers: {
        Authorization: `Bearer ${access_token}`
      }
    });
    
    // Extract user data
    const { sub: googleId, email, name, picture } = userInfoResponse.data;
    
    // Find or create user in your database
    const user = await findOrCreateUser({
      provider: 'google',
      providerId: googleId,
      email,
      name,
      profilePicture: picture
    });
    
    // Generate JWT token
    const authToken = generateToken(user);
    
    // Return success with token
    return res.json({ success: true, token: authToken });
  } catch (error) {
    console.error('Google auth error:', error);
    return res.status(500).json({ error: 'Authentication failed' });
  }
}

/**
 * Handle Facebook authentication
 */
async function handleFacebookAuth(req, res) {
  try {
    const { token: fbAccessToken } = req.body;
    if (!fbAccessToken) {
      return res.status(400).json({ error: 'Access token is required' });
    }
    
    // Verify token and get user data
    const userInfoResponse = await axios.get(`${AUTH_PROVIDERS.facebook.userInfoUrl}?fields=id,name,email,picture&access_token=${fbAccessToken}`);
    
    // Extract user data
    const { id: facebookId, email, name, picture } = userInfoResponse.data;
    
    // Find or create user in your database
    const user = await findOrCreateUser({
      provider: 'facebook',
      providerId: facebookId,
      email,
      name,
      profilePicture: picture?.data?.url
    });
    
    // Generate JWT token
    const authToken = generateToken(user);
    
    // Return success with token
    return res.json({ success: true, token: authToken });
  } catch (error) {
    console.error('Facebook auth error:', error);
    return res.status(500).json({ error: 'Authentication failed' });
  }
}

/**
 * Handle Apple Sign-In
 */
async function handleAppleAuth(req, res) {
  try {
    const { code, id_token } = req.body;
    if (!code || !id_token) {
      return res.status(400).json({ error: 'Code and ID token are required' });
    }
    
    // Verify the ID token
    // In a real implementation, you would verify the JWT signature
    const decodedToken = jwt.decode(id_token);
    
    // Extract user data
    const { sub: appleId, email } = decodedToken;
    
    // Apple doesn't always provide the name, so we may need to handle that
    // Name might be provided only on the first login
    const name = req.body.user ? JSON.parse(req.body.user).name : null;
    
    // Find or create user in your database
    const user = await findOrCreateUser({
      provider: 'apple',
      providerId: appleId,
      email,
      name: name || email.split('@')[0] // Use email prefix if name not provided
    });
    
    // Generate JWT token
    const authToken = generateToken(user);
    
    // Return success with token
    return res.json({ success: true, token: authToken });
  } catch (error) {
    console.error('Apple auth error:', error);
    return res.status(500).json({ error: 'Authentication failed' });
  }
}

/**
 * Find or create a user in the database
 * This is a placeholder function - implement according to your database
 */
async function findOrCreateUser(userData) {
  // This would be replaced with actual database operations
  // For example, using MongoDB, Firebase, or SQL database
  
  // Simulated user object
  return {
    id: crypto.randomBytes(16).toString('hex'),
    ...userData,
    createdAt: new Date(),
    updatedAt: new Date()
  };
}

/**
 * Generate a JWT token for the user
 */
function generateToken(user) {
  return jwt.sign(
    { 
      userId: user.id,
      email: user.email,
      provider: user.provider
    }, 
    JWT_SECRET, 
    { expiresIn: '7d' }
  );
}

module.exports = {
  handleGoogleCallback,
  handleFacebookAuth,
  handleAppleAuth
}; 