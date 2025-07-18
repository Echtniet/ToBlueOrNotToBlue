# ToBlueOrNotToBlue

**ToBlueOrNotToBlue** is an iOS app built with SwiftUI that lists stores and allows users to sort them based on their current location. The app is architected using the Clean MVVM-C pattern, leverages Apollo GraphQL for data fetching, and uses Swinject for dependency injection.

---

## 🚀 Features

- 📍 List available stores  
- 📌 Sort stores based on the user’s current location  

---

## ⚙️ Technical Highlights

- 🧱 **Clean MVVM-C architecture** for separation of concerns  
- 🌐 **Apollo GraphQL integration** for efficient data querying  
- 💉 **Swinject** for scalable and testable dependency injection  
- 🧪 **Includes Unit, Integration, and UI testing**  

---

## 🧱 Architecture

The project follows a **Clean MVVM-C** architecture:

- **Model** – Domain entities and business logic  
- **DTOs (Data Transfer Objects)** – Represent raw data received from API  
- **APIService** – Handles network calls and communicates with Apollo GraphQL  
- **Repositories** – Transform DTOs into domain Models and provide data to Use Cases  
- **Use Cases** – Encapsulate business rules and logic  
- **ViewModel** – UI logic, transforms model data for views  
- **View** – SwiftUI interface  
- **Coordinator** – Handles navigation and module composition  
- **DI Container** – Built with Swinject  

---

## 🛠 Tech Stack

- **SwiftUI** – Declarative UI  
- **Apollo iOS** – GraphQL networking  
- **Swinject** – Dependency injection  
- **CoreLocation** – User location services  
- **XCTest** – Unit, integration & UI testing  

---

## 🧪 Testing

Testing is implemented across different layers:

- ✅ **Unit Tests** – ViewModels, Use Cases, and Repositories  
- 🔁 **Integration Tests** – Network and data flow testing  
- 👀 **UI Tests** – Simulated real-device interaction  

---

## 🚧 To-Do

- [ ] Add a pre-build script to generate GraphQL queries using Apollo CLI  
- [ ] Update `.gitignore` to exclude derived data, Apollo-generated files, etc.  
- [ ] Properly design the UI for a polished look  
- [ ] Add more robust and complete test cases across the layers  
