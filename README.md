# 📸 Photo Gallery App

A Flutter application that fetches and displays a gallery of photos from the [Pexels API](https://www.pexels.com/api/). The app is built using **Clean Architecture**, features **offline support**, and implements **state management with Cubit**, with support for **light/dark themes** and **network status detection**.

---

## 🚀 Features

- ✅ Fetch and display photos with infinite scroll
- 📶 Network connectivity status (Online/Offline)
- 💾 Data and image caching (Hive + cached_network_image)
- 🧱 Follows Clean Architecture principles
- 🧠 State management using Cubit
- 🔧 Dependency Injection with `injectable` + `get_it`
- 📦 API integration via `Retrofit` and `Dio`
- 🔄 Pull to refresh & pagination
- 🌙 Light/Dark mode with persistent storage

---

## 📱 Screenshots

| Mode       | Online                     | Offline                    |
|------------|----------------------------|----------------------------|
| Light Mode | ![Online Light](assets/screenshots/online-light.jpg) | ![Offline Light](assets/screenshots/offline-light.jpg) |
| Dark Mode  | ![Online Dark](assets/screenshots/online-dark.jpg)   | ![Offline Dark](assets/screenshots/offline-dark.jpg)   |

---

## 🧱 Clean Architecture Structure

lib/
├── core/
│ ├── api/
│ ├── theme/
│ └── di/ # Dependency Injection
│
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

yaml
Copy
Edit

---

## ⚙️ How to Run

1. **Clone the repository:**

```bash
git clone https://github.com/Abdalla-Ahmed-Aly/photo_gallery_flutter_task
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
Add your API key:

Replace in ApiConstants.dart:

dart
Copy
Edit
class ApiConstants {
  static const apiKey = "YOUR_PEXELS_API_KEY";
}
Run the app:

bash
Copy
Edit
flutter run
🧪 Unit Testing (Bonus ✅)
This project includes unit tests for key logic layers.

✔️ Coverage:
Layer	What’s Tested
Cubits	Emitted states on success & failure
Use Cases	Business logic test (e.g., page fetch)
Repositories	Network & cache behaviors, error scenarios

🔍 Test Examples:
dart
Copy
Edit
blocTest<PhotoCubit, PhotoState>(
  'emits [PhotoLoading, PhotoLoaded] when fetchPhotos succeeds',
  build: () {
    when(mockRepo.fetchPhotos(page: 1, perPage: 10))
        .thenAnswer((_) async => mockPhotoModel);
    return PhotoCubit(mockRepo);
  },
  act: (cubit) => cubit.fetchPhotos(page: 1),
  expect: () => [isA<PhotoLoading>(), isA<PhotoLoaded>()],
);
▶️ Run Tests:
bash
Copy
Edit
flutter test
🧪 Tools Used:
flutter_test

mockito

bloc_test

💡 Network Status Indicator
🟢 Green: Online

🔴 Red: Offline
Shown in app bar for clear visibility.

🌗 Theme Switching
Users can toggle between Light & Dark mode.

Selected theme is stored locally and persists across app restarts.

👤 Author
Abdalla Ahmed Ali
📩 abdalla01145854052@gmail.com
🔗 GitHub
🎓 Route Job Fair Intern

📂 Assets
All screenshots are stored in:

bash
Copy
Edit
assets/screenshots/
Make sure pubspec.yaml includes:

yaml
Copy
Edit
assets:
  - assets/screenshots/
✅ Final Checklist
 Clean Architecture implemented

 State management via Cubit

 Dependency Injection (injectable, get_it)

 Data + image caching with Hive

 API integration using Retrofit & Dio

 JSON parsing with json_serializable

 Light/Dark theme toggle

 Online/Offline indicator

 Infinite scrolling with pagination

 Unit testing for core logic

 Documentation with screenshots ✅

