/**
 * Mina Authentication Module
 * Handles social sign-in with Google, Facebook, and Apple
 */

// Configuration for authentication providers
const authConfig = {
  google: {
    clientId: 'YOUR_GOOGLE_CLIENT_ID',
    redirectUri: window.location.origin + '/auth/google/callback'
  },
  facebook: {
    appId: 'YOUR_FACEBOOK_APP_ID',
    redirectUri: window.location.origin + '/auth/facebook/callback'
  },
  apple: {
    clientId: 'YOUR_APPLE_CLIENT_ID',
    redirectUri: window.location.origin + '/auth/apple/callback'
  }
};

// Initialize authentication listeners once DOM is loaded
document.addEventListener('DOMContentLoaded', () => {
  // Set up click handlers for social login buttons
  const googleBtn = document.querySelector('.btn-google');
  const facebookBtn = document.querySelector('.btn-facebook');
  const appleBtn = document.querySelector('.btn-apple');
  
  if (googleBtn) googleBtn.addEventListener('click', signInWithGoogle);
  if (facebookBtn) facebookBtn.addEventListener('click', signInWithFacebook);
  if (appleBtn) appleBtn.addEventListener('click', signInWithApple);
});

/**
 * Initiate Google Sign-In
 */
function signInWithGoogle(e) {
  e.preventDefault();
  // Construct Google OAuth URL
  const authUrl = `https://accounts.google.com/o/oauth2/v2/auth?client_id=${authConfig.google.clientId}&redirect_uri=${encodeURIComponent(authConfig.google.redirectUri)}&response_type=code&scope=email%20profile&prompt=select_account`;
  
  window.location.href = authUrl;
}

/**
 * Initiate Facebook Sign-In
 */
function signInWithFacebook(e) {
  e.preventDefault();
  // Load Facebook SDK if not already loaded
  if (!window.FB) {
    loadFacebookSDK(() => {
      FB.login((response) => {
        if (response.authResponse) {
          handleFacebookToken(response.authResponse.accessToken);
        }
      }, {scope: 'email,public_profile'});
    });
  } else {
    FB.login((response) => {
      if (response.authResponse) {
        handleFacebookToken(response.authResponse.accessToken);
      }
    }, {scope: 'email,public_profile'});
  }
}

/**
 * Load Facebook SDK
 */
function loadFacebookSDK(callback) {
  window.fbAsyncInit = function() {
    FB.init({
      appId: authConfig.facebook.appId,
      cookie: true,
      xfbml: true,
      version: 'v17.0'
    });
    callback();
  };
  
  (function(d, s, id) {
    var js, fjs = d.getElementsByTagName(s)[0];
    if (d.getElementById(id)) return;
    js = d.createElement(s); js.id = id;
    js.src = "https://connect.facebook.net/en_US/sdk.js";
    fjs.parentNode.insertBefore(js, fjs);
  }(document, 'script', 'facebook-jssdk'));
}

/**
 * Handle Facebook authentication token
 */
function handleFacebookToken(token) {
  // Send token to your backend
  fetch('/api/auth/facebook', {
    method: 'POST',
    headers: {
      'Content-Type': 'application/json'
    },
    body: JSON.stringify({ token })
  })
  .then(response => response.json())
  .then(data => {
    if (data.success) {
      window.location.href = '/home.html';
    }
  })
  .catch(error => {
    console.error('Facebook authentication error:', error);
  });
}

/**
 * Initiate Apple Sign-In
 */
function signInWithApple(e) {
  e.preventDefault();
  // Check if Apple Sign-In JS is available
  if (window.AppleID) {
    initAppleSignIn();
  } else {
    loadAppleSignInJS(() => {
      initAppleSignIn();
    });
  }
}

/**
 * Load Apple Sign-In JavaScript
 */
function loadAppleSignInJS(callback) {
  const script = document.createElement('script');
  script.src = 'https://appleid.cdn-apple.com/appleauth/static/jsapi/appleid/1/en_US/appleid.auth.js';
  script.onload = callback;
  document.head.appendChild(script);
}

/**
 * Initialize Apple Sign-In
 */
function initAppleSignIn() {
  AppleID.auth.init({
    clientId: authConfig.apple.clientId,
    scope: 'email name',
    redirectURI: authConfig.apple.redirectUri,
    usePopup: true
  });
  
  AppleID.auth.signIn()
    .then(response => {
      // Handle successful Sign in
      handleAppleSignIn(response);
    })
    .catch(error => {
      console.error('Apple Sign-In error:', error);
    });
}

/**
 * Handle Apple Sign-In response
 */
function handleAppleSignIn(response) {
  // Send token to your backend
  fetch('/api/auth/apple', {
    method: 'POST',
    headers: {
      'Content-Type': 'application/json'
    },
    body: JSON.stringify({ 
      code: response.authorization.code,
      id_token: response.authorization.id_token
    })
  })
  .then(response => response.json())
  .then(data => {
    if (data.success) {
      window.location.href = '/home.html';
    }
  })
  .catch(error => {
    console.error('Apple authentication error:', error);
  });
}

// Function to check if user is authenticated
function isAuthenticated() {
  const token = localStorage.getItem('mina_auth_token');
  return !!token;
}

// Function to log out
function logout() {
  localStorage.removeItem('mina_auth_token');
  window.location.href = '/welcome.html';
} 