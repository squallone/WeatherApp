# WeatherApp

This is a simple iOS app developed in **Swift**, utilizing **RxSwift**, the **Model-View-ViewModel (MVVM)** design pattern, and principles of **Clean Architecture**. The app fetches and displays real-time weather data using the **OpenWeather API**.

<img width=50% src="https://github.com/user-attachments/assets/7b8dd2e8-236c-4019-8246-57cf1a235b28">

#### Features:
- **Search Functionality**:
   - Search for weather data by entering a city name.
   - Autocomplete suggestions (if implemented).
  
- **Real-Time Weather Data**:
   - Displays the current temperature.
   - Additional weather information such as humidity, wind speed, and atmospheric pressure.
   - Dynamic weather icons or conditions representation (if included).

- **Reactive Programming**:
   - Implements **RxSwift** for efficient and responsive data binding.
   - Ensures a seamless and interactive user experience.

- **Architecture**:
   - Adheres to **MVVM** to separate concerns and facilitate scalability.
   - Follows **Clean Architecture** principles for improved testability, maintainability, and modularity.

#### Technical Highlights:
- **Swift**   
- **RxSwift Integration**:
   - Uses **Observable** and **Subject** patterns for reactive data handling.
   - Simplifies state management and user interaction responses.

- **Networking**:
   - Connects to the **OpenWeather API** for weather data retrieval.
   - Handles API responses and error cases gracefully.

- **Dependency Injection**:
   - Ensures loose coupling between components for better testing and flexibility.

#### Potential Enhancements:
- Add unit and UI tests to ensure app reliability.
- Implement caching to store frequently accessed weather data.
- Enhance UI with animations or dynamic backgrounds reflecting weather conditions.
- Provide multi-language support for global users.
- Integrate additional API endpoints for extended forecasts or detailed data.

#### Prerequisites:
- iOS 14.0+ (or as supported)
- Xcode 14.0+
- API key from **OpenWeather API**

#### Getting Started:
1. Clone the repository:
   ```bash
   git clone https://github.com/squallone/WeatherApp.git
   ```
2. Install dependencies using **CocoaPods** or **Swift Package Manager** (as applicable).
3. Add your **OpenWeather API Key** in the appropriate configuration file.
4. Build and run the app on a simulator or device.


