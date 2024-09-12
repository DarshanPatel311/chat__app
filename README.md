# 🗨️ True Chat
A simple chat application built with Flutter and Firebase, supporting real-time messaging, authentication, and push notifications using Firebase services.

## 🚀 Features
### Firebase Authentication: User sign-in and sign-up with email and password.
### Real-Time Messaging: Chat with real-time updates using Firebase Firestore.
### Push Notifications: Receive notifications for new messages via Firebase Cloud Messaging (FCM).

## 🛠️ Tech Stack
### Framework: Flutter
### Backend: Firebase (Authentication, Firestore, Cloud Messaging)
### State Management: Getx
## ⚙️ Firebase Setup
1. Create Firebase Project
Go to Firebase Console and create a new project.
Add your Android and/or iOS app to the Firebase project.
Download and add the Firebase configuration files:
google-services.json for Android: Place in android/app/.
GoogleService-Info.plist for iOS: Place in ios/Runner/.
2. Enable Firebase Services
Authentication: Go to Firebase Console > Authentication > Sign-in method > Enable Email/Password.
Firestore Database: Set up a Firestore database in production or test mode.
Firebase Cloud Messaging: Enable FCM for push notifications.
📝 Installation

1. Clone the Repo
```
bash
Copy code
git clone https://github.com/yourusername/chat-app.git
cd chat-app
```
2. Install Dependencies
 ```
bash
Copy code
flutter pub get
```
4. Run the App
Ensure you have an emulator running or a physical device connected, then run:
```

bash
Copy code
flutter run
```
🔥 Firebase Integration
Firebase Authentication
Manages user registration and login via firebase_auth.
Provides basic email/password authentication.
dart
```
Copy code
FirebaseAuth.instance.createUserWithEmailAndPassword(email: email, password: password);
```
Firebase Firestore
Stores and retrieves real-time messages.
Messages are stored in a chats collection with fields like senderId, message, and timestamp.
dart
```
Copy code
FirebaseFirestore.instance.collection('chats').add({
  'senderId': senderId,
  'message': message,
  'timestamp': FieldValue.serverTimestamp(),
});
```
Firebase Cloud Messaging (FCM)
Push notifications alert users of new messages, even when the app is in the background or closed.
dart
```
Copy code
FirebaseMessaging.onMessage.listen((RemoteMessage message) {
  // Handle in-app message notifications
});
```

## 📁 Project Structure
```
bash
Copy code
lib/
├── main.dart              # App entry point
├── services/              # Firebase services
│   ├── auth_service.dart   # Authentication service
│   └── chat_service.dart   # Chat functionality
├── models/                # Data models
│   └── user.dart           # User model
├── screens/               # UI screens
│   ├── login_screen.dart   # Login screen
│   ├── chat_screen.dart    # Chat screen
│   └── profile_screen.dart # User profile screen
└── widgets/               # Reusable UI components
```
## 📦 Dependencies
yaml
```
Copy code
dependencies:
  flutter:
    sdk: flutter
  firebase_core: latest_version
  firebase_auth: latest_version
  cloud_firestore: latest_version
  firebase_messaging: latest_version
```
## ✨ Firebase Packages Used
```
firebase_core: Initializes Firebase.
firebase_auth: Authentication services.
cloud_firestore: Firestore database.
firebase_messaging: Push notifications.
```

## ScreenShot

<p align='center'>
   <img src='https://github.com/user-attachments/assets/1310c71b-e155-4bf1-bf0c-12aa42d19092' width=240>
  <img src='https://github.com/user-attachments/assets/79f1cd6c-cab7-49b4-8277-517e0f9efeef' width=240>
    <img src='https://github.com/user-attachments/assets/e7d03649-236e-4b60-8349-a3abb0c2223b' width=240>
  <img src='https://github.com/user-attachments/assets/674b23e0-1dc0-4709-9805-37a85a4c218c' width=240>
   <img src='https://github.com/user-attachments/assets/b0ef28fa-186a-419a-bbbb-f29bbac72a02' width=240>
    <img src='https://github.com/user-attachments/assets/ea493a6f-f745-491f-8cdd-f0b7fa098b56' width=240>
     <img src='https://github.com/user-attachments/assets/63e65c66-a9f8-4ff3-9f31-843b6b42ce3d' width=240>
      




</p>

## Video

https://github.com/user-attachments/assets/5f3cc4ad-fad6-476a-b5dc-db6b6cda21c1


