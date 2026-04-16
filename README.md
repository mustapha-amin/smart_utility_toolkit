# Smart Utility Toolkit

Smart Utility Toolkit is a Flutter app that combines two everyday tools in one place:
an instant unit converter and a simple todo manager with local persistence.

## Overview

- A dark, monochrome UI with custom typography and subtle motion
- A home screen with a time-based greeting and live clock
- Fast navigation between the home, converter, and todo screens
- Offline local storage for todos using Hive CE

## Features

### Converter

- 6 conversion categories: Length, Temperature, Weight, Speed, Area, and Data
- Instant results as you type
- Selectable from/to units for each category
- One-tap swap between units
- Clear action for resetting the current conversion

### Todo

- Add, edit, delete, and complete todos
- Optional due dates
- Filter views for pending, completed, and overdue items
- Persistent local storage so todos remain after app restart

### Home

- Greeting that changes by time of day
- Live clock display
- Entry points to both core tools

## Tech Stack

- Flutter
- Riverpod for state management
- Hive CE for local storage
- UUID for todo IDs
- `intl` for time formatting
- `google_fonts` for typography
- `units_converter` for conversion logic

## Project Structure

```text
lib/
|-- core/
|   |-- constants/        # App constants
|   |-- enums/            # Conversion category definitions
|   |-- extensions/       # Shared Dart/Flutter extensions
|   `-- theme/            # Colors, text styles, and theme setup
|-- features/
|   |-- converter/        # Converter flow, controller, and widgets
|   |-- home/             # Landing page and utility tiles
|   `-- todo/             # Todo model, provider, service, and views
|-- shared/
|   `-- widgets/          # Reusable app shell widgets
|-- utils/                # Greeting and conversion helpers
`-- main.dart             # App entry point and routing
```

## Getting Started

### Prerequisites

- Flutter SDK
- Dart SDK

### Install Dependencies

```bash
flutter pub get
```

### Run the App

```bash
flutter run
```

## Build

### Android APK

```bash
flutter build apk --release
```

The release APK is generated at:
`build/app/outputs/flutter-apk/app-release.apk`

## Notes

- Todo data is stored locally in a Hive box named `todos`
- The app uses named routes for navigation
- The UI is intentionally kept minimal and high-contrast

## License

MIT
