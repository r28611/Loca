# Loca

📍🗺 A service for tracking user’s location in real time and saving routes in database.

## Description

Task: to build a service for tracking user’s location in real time and saving routes in database.

Implemented: UI programmatically, CoreLocation, Google Maps SDK, RxSwift, UserNotifications, AVFoundation.


<p>
<img width="1141" alt="Loca-screens" src="https://user-images.githubusercontent.com/47301156/183531486-1a43df0a-9774-4249-a53d-a81b49e12a7b.png">
</p>

## Installation

1. Get a free API key at [Google Maps](https://mapsplatform.google.com)
2. Clone the repo
```sh
git clone https://github.com/r28611/Loca
```
3. Put your API key in `App/AppDelegate.swift`
```swift
GMSServices.provideAPIKey("Input here your API key")
```
4. Build, run, enjoy!

## Version History

### 1.0.0. Initial release.
#### Features

* Support for system light and dark mode.
* Share saved routes.
* Routes search.

## Acknowledgments

* Maps data provided by [Google Maps](https://mapsplatform.google.com)
