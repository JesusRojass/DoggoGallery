# 🐶 DoggoGallery

A SwiftUI-powered app that showcases a gallery of dogs
---

## 📸 Preview

- **Dark Mode**

![IMG_8280](https://github.com/user-attachments/assets/f349509b-7ba7-4855-a32c-c3c862d8a8dc)
![IMG_8279](https://github.com/user-attachments/assets/6900ed37-74f4-4b31-8ddf-98110f75f919)

- **Light Mode**

![IMG_8281](https://github.com/user-attachments/assets/99c0f9d5-d452-44a2-96b7-9249a371a3a3)
![IMG_8282](https://github.com/user-attachments/assets/d26c995d-a3d3-4c66-aea0-11f7a4ddf921)

---

## 🧱 Architecture

This project follows a clean **MVVM (Model-View-ViewModel)** architecture with a light **Coordinator** pattern for navigation.

- **SwiftUI** for UI
- **Combine** for data binding
- **Core Data** for caching API data
- **Protocols** & dependency injection for modularity
- **XCTest** for unit & UI testing

---

## 📦 Features

- Fetches a list of dogs from a remote JSON API
- Displays image, name, age, and description
- Detail view for each dog
- Pull to refresh to re-fetch latest data
- Core Data caching to persist data between launches
- Protocol-oriented and testable architecture
- Dark mode support
- Clean and adaptive layout

---

## 🧪 Tests

- Unit tests for ViewModels and data logic
- UI tests verifying list rendering and detail navigation
- `@MainActor` and `Combine` safe testing coverage

---

## 🛠️ How to Run

1. Clone the repo
2. Open `DoggoGallery.xcodeproj`
3. Select `DoggoGallery` scheme
4. Run the app using `⌘ + R` on an iOS Simulator

> ✅ Requires Xcode 15+ and iOS 17 SDK

---

## 📚 Credits

App built by **Jesús Rojas**
