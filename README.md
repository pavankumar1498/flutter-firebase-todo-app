# Flutter Firebase To-Do App

A clean and responsive **To-Do List mobile application** built with **Flutter**, using **Firebase Authentication** and **Firebase Realtime Database**.
The application allows users to securely manage their tasks with features like **authentication, task CRUD operations, completion status tracking, and responsive UI**.

The project follows a **feature-based clean architecture** with clear separation between **data, application (state management), and presentation layers**.

---

# Features

## 1. User Authentication

* Firebase **Email & Password Authentication**
* User **Registration**
* User **Login**
* Secure **Logout**
* Error handling with dialogs
* Success feedback using **SnackBars**

---

## 2. Task Management

Users can manage tasks with the following operations:

* View all tasks
* Add new tasks
* Edit existing tasks
* Delete tasks
* Mark tasks as completed / uncompleted
* Pull-to-refresh task list

---

## 3. State Management

The app uses **Provider** for state management.

Two providers are implemented:

* **AuthProvider**

  * Handles login, registration, logout
  * Manages authentication state

* **TaskProvider**

  * Fetch tasks
  * Add task
  * Update task
  * Delete task
  * Toggle task completion

---

## 4. Database Integration

The application uses **Firebase Realtime Database**.

Tasks are stored per user using **REST API requests**.

Example database structure:

```
tasks
   └── userId
         └── taskId
               title: "Buy milk"
               completed: false
```

---

# Tech Stack

* **Flutter**
* **Firebase Authentication**
* **Firebase Realtime Database**
* **Provider (State Management)**
* **HTTP package (REST API communication)**

---

# Project Architecture

The project follows a **feature-based clean architecture**.

```
lib
│
├── core
│
├── features
│   └── todo
│
│       ├── data
│       │   ├── models
│       │   │     task_model.dart
│       │   │
│       │   └── services
│       │         auth_service.dart
│       │         task_service.dart
│       │
│       ├── application
│       │   └── providers
│       │         auth_provider.dart
│       │         task_provider.dart
│       │
│       ├── presentation
│       │   ├── screens
│       │   │     login_screen.dart
│       │   │     signup_screen.dart
│       │   │     home_screen.dart
│       │   │     add_task_screen.dart
│       │   │     edit_task_screen.dart
│       │   │
│       │   └── widgets
│       │         task_tile.dart
│       │
│       └── routes
│             todo_routes.dart
│
├── routes
│     app_routes.dart
│
└── main.dart
```

---

# Layer Responsibilities

## Data Layer

Handles **data sources and models**.

* Firebase REST API communication
* Task data models
* Authentication services

Files:

* `task_model.dart`
* `auth_service.dart`
* `task_service.dart`

---

## Application Layer

Handles **business logic and state management**.

Providers manage:

* Loading states
* Errors
* API calls
* UI updates

Files:

* `auth_provider.dart`
* `task_provider.dart`

---

## Presentation Layer

Handles **UI components and screens**.

Screens:

* Login
* Signup
* Home (Task list)
* Add Task
* Edit Task

Reusable widgets:

* `task_tile.dart`

---

# UI/UX Features

* Responsive UI
* Clean Material design
* Loading indicators
* Success SnackBars
* Error dialogs
* Pull-to-refresh task list
* Task completion visual indicator

---

# Installation

## 1. Clone the repository

```
git clone https://github.com/pavankumar1498/flutter-firebase-todo-app.git
```

---

## 2. Navigate to project

```
cd todo-firebase-app
```

---

## 3. Install dependencies

```
flutter pub get
```

---

## 4. Configure Firebase

Create a Firebase project and enable:

* Firebase Authentication
* Realtime Database

Add your Firebase configuration using:

```
flutterfire configure
```

---

## 5. Run the app

```
flutter run
```

---

# Author

Developed using **Flutter and Firebase** following clean architecture principles.
