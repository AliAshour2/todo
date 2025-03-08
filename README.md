# 📝 Todo App 
A modern todo application built with Flutter and Firebase, featuring authentication and dark/light theme support.

## ✨ Features
- 🔐 User Authentication (Login/Signup)
- 📱 Beautiful Material Design UI
- 🌓 Dark/Light Theme Support
- 📅 Calendar View for Tasks
- ✅ Task Management (Add, Delete, Update)
- 🔄 Real-time Data Sync with Firebase
- 📊 Task Progress Tracking

## 🛠️ Tech Stack
- Flutter
- Firebase Authentication
- Cloud Firestore
- Provider State Management
- Material Design 3

## 📁 Project Structure
```
lib/
├── common/
│   ├── app_colors.dart
│   ├── app_theme.dart
│   └── remote/
│       └── firebase_services.dart
├── providers/
│   ├── auth_provider.dart
│   ├── tasks_provider.dart
│   └── theme_provider.dart
├── screens/
│   ├── auth/
│   │   ├── log_in_screen.dart
│   │   └── sign_up_screen.dart
│   └── home/
│       └── home_screen.dart
├── ui/
│   ├── taps/
│   │   └── tasks/
│   │       ├── list_tap.dart
│   │       └── models/
│   │           └── task_model.dart
│   └── widgets/
│       ├── custom_auth_text_field.dart
│       ├── custom_elevated_button.dart
│       └── task_card.dart
└── main.dart
```

## 🚀 Getting Started

### Prerequisites
- Flutter SDK
- Firebase Account
- Android Studio/VS Code

### 🔧 Installation
1. Clone the repository
```bash
git clone https://github.com/yourusername/todo.git
```

2. Install dependencies
```bash
flutter pub get
```

3. Configure Firebase
- Add your `google-services.json` for Android
- Add your `GoogleService-Info.plist` for iOS

4. Run the app
```bash
flutter run
```

## 📱 Screenshots
<div align="center">
    <img src="https://github.com/AliAshour2/todo/blob/main/assets/gitImages/app%20(3).jpeg" width="100" style="display: inline-block; margin: 5px;">
    <img src="https://github.com/AliAshour2/todo/blob/main/assets/gitImages/app%20(4).jpeg" width="100" style="display: inline-block; margin: 5px;">
    <img src="https://github.com/AliAshour2/todo/blob/main/assets/gitImages/app%20(2).jpeg" width="100" style="display: inline-block; margin: 5px;">
    <img src="https://github.com/AliAshour2/todo/blob/main/assets/gitImages/app%20(1).jpeg" width="100" style="display: inline-block; margin: 5px;">
    <img src="https://github.com/AliAshour2/todo/blob/main/assets/gitImages/app%20(5).jpeg" width="100" style="display: inline-block; margin: 5px;">
    <img src="https://github.com/AliAshour2/todo/blob/main/assets/gitImages/app%20(6).jpeg" width="100" style="display: inline-block; margin: 5px;">
</div>

 
## 🤝 Contributing
Contributions are welcome! Please feel free to submit a Pull Request.

## 📄 License
This project is licensed under the MIT License - see the [LICENSE](LICENSE) file for details

## 🥽 Author
Ali Ashour
- GitHub: [@aliashour](https://github.com/AliAshour2)
- LinkedIn: [Ali Ashour](https://www.linkedin.com/in/ali-ashour-812a34229/)

