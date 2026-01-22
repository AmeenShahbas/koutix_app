# Troubleshooting Authentication Errors

## "ClientException: Failed to fetch"
This error typically occurs on **Flutter Web** when the browser blocks the request due to **CORS (Cross-Origin Resource Sharing)**.

### Solution 1 (Recommended): Fix the Backend
Configure your backend (Node.js/Express in this case) to allow CORS requests from your Flutter app's port.
Example in Express.js:
```javascript
const cors = require('cors');
app.use(cors());
```

### Solution 2 (For Development Only): Disable Web Security
If you cannot modify the backend, run your Flutter Web app with security validation disabled:
```bash
flutter run -d chrome --web-browser-flag "--disable-web-security"
```
*Note: This effectively disables CORS checks in the browser session launched by Flutter.*

## Android Emulator Issues
If you are running on an **Android Emulator**, `localhost` refers to the emulator device itself, not your computer.
**Fix**: Change `localhost` to `10.0.2.2` in `lib/core/services/auth_service.dart`.
```dart
static const String baseUrl = 'http://10.0.2.2:3000/api';
```
