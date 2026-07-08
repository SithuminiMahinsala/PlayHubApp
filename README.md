# PlayHubApp - iOS Mini Games App

PlayHubApp is a multi-game iOS application built with SwiftUI, structured around MVVM architecture, and integrated with native iOS platform features including MapKit, Charts, CoreLocation, and UserNotifications.

## Architecture Overview
The project is strictly refactored into a modular folder structure:
* **Models:** Data representations (`Card`, `TriviaQuestion`, `GameSession`, `GameMode`).
* **Views:** UI presentation layer split into `Tabs/` (Home, Stats, Map, Settings) and `Games/` (Tap Frenzy, Light It Up, Quiz Rush).
* **ViewModels:** ObservableObject classes managing game logic and async UI states (`QuizRushVM`).
* **Services:** Singleton services handling external frameworks (`TriviaAPI`, `LocationService`, `NotificationService`).

## Features List
* **Tap Frenzy :** Speed tap game featuring a shrinking button challenge and dynamic target jumps.
* **Light It Up :** Whack-a-mole grid mechanic with automatic 4-level round progression and distinct glowing feedback.
* **Quiz Rush :** Live trivia fetched asynchronously via URLSession from Open Trivia DB, featuring streak tracking and robust loading/error states.
* **Platform Integrations :**
  * **Charts:** Visual bar chart aggregation of high scores across all game modes using the SwiftUI Charts framework.
  * **MapKit & CoreLocation:** Records GPS coordinates on session completion and renders interactive pins on a map.
  * **UserNotifications:** Local daily reminder scheduling configured via a custom DatePicker in Settings.
  * **ShareLink:** Native iOS sharing of high scores with a single line of SwiftUI.
  * **AppStorage & UserDefaults:** Persistent storage for individual game high scores and session histories.

## Known Limitations
* Open Trivia DB API may occasionally fail if the network connection drops; handled via a graceful UI error state with a retry mechanism.
* CoreLocation requires explicit user permission; if denied, map pins default to standard coordinates.

## Reflection
Building PlayHub highlighted the power of SwiftUI's declarative syntax and the critical importance of separating UI from logic using ObservableObject ViewModels. Integrating native frameworks like Charts and MapKit inside a clean TabView shell transformed three isolated  exercises into a cohesive, production-ready  application.