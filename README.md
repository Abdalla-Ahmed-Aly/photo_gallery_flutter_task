# 📸 Photo Gallery App

A simple Flutter application that displays a list of photos fetched from the Pexels API. The app follows **Clean Architecture**, uses **Cubit** for state management, supports **offline mode** with caching, and has **dark/light mode** toggle and network status indicator.

---

## 🚀 Features

- ✅ Fetch and display photos from a public API
- 📶 Network connectivity indicator (Online / Offline)
- 💾 Data & image caching using Hive & cached_network_image
- 🧱 Clean Architecture structure
- 🧠 State management using Cubit
- 🔧 Dependency Injection with Injectable
- 📦 API integration using Retrofit
- 📁 JSON parsing with json_serializable
- 🌙 Light/Dark mode with persistence
- 🔄 Infinite scrolling with pagination

---

## 📱 Screenshots

| State | Light Mode | Dark Mode |
|-------|------------|-----------|
| ✅ Online | ![Online Light](assets/screenshots/online-light.jpg) | ![Online Dark](assets/screenshots/online-dark.png) |
| 🚫 Offline | ![Offline Light](assets/screenshots/offline-light.jpg) | ![Offline Dark](assets/screenshots/offline-dark.jpg) |

---

## 🧱 Clean Architecture Overview

lib/
├── core/
│ ├── API Service/
│ ├── Theme/
│ └── Dependency Injection (DI)
├── features/
│ └── photo_list/
│ ├── data/
│ │ ├── data_sources/
│ │ ├── model/
│ │ └── repositories/
│ ├── domain/
│ │ ├── entities/
│ │ ├── usecases/
│ │ └── repositories/
│ └── view/
│ └── presentation/
│ ├── cubit/
│ └── screens/
├── main.dart

yaml
Copy
Edit

---

## ⚙️ How to Run

1. Clone the repo:

```bash
git clone https://github.com/your-username/photo_gallery_flutter_task.git
cd photo_gallery_flutter_task
Install dependencies:

bash
Copy
Edit
flutter pub get
Run code generation:

bash
Copy
Edit
flutter pub run build_runner build --delete-conflicting-outputs
Add your Pexels API key:

In ApiConstants.dart:

dart
Copy
Edit
class ApiConstans {
  static const apiKey = "YOUR_API_KEY";
}
Run the app:

bash
Copy
Edit
flutter run
🧪 Optional (Bonus)
✅ Unit testing for Cubits, Use Cases, or Repositories

🔄 More advanced pagination and error handling

🛠️ Packages Used
flutter_bloc

retrofit

dio

injectable

hive

json_serializable

cached_network_image

connectivity_plus

🧠 State Flow
State	Description
PhotoInitial	Initial state before fetching
PhotoLoading	While data is being fetched
PhotoLoaded	Data fetched successfully (from API/cache)
PhotoError	Error occurred (e.g., API failed or no cache)

💡 Network Status
A small indicator in the app bar shows:

🟢 Online: Green circle + "Online"

🔴 Offline: Red circle + "Offline"

🌗 Theme Toggle
Users can toggle between Dark and Light modes using a button.

The selected theme persists across app restarts using local storage.

🙋‍♂️ Author
Abdalla Ahmed Ali
Route Job Fair Intern
Email: abdalla@example.com
GitHub: your-github

📂 Notes
The screenshots are located in:
assets/screenshots/

Make sure to include:

online-light.png

online-dark.png

offline-light.png

offline-dark.png

Update pubspec.yaml to include screenshots in assets if needed.

✅ Final Checklist
 Clean Architecture applied

 Cubit state management

 Dependency Injection (injectable)

 Hive caching (data + images)

 Retrofit + json_serializable

 Dark / Light theme toggle

 Network status indicator

 Scrollable photo list + pagination

 Readme with screenshots

