# Smart Utility toolkit app

A smart utility app featuring a unit converter with 6 conversion categories and instant results.

## Features

- **6 Conversion Categories**: Length, Temperature, Weight, Speed, Area, Data
- **Monochrome Design**: Clean black & white aesthetic with subtle gradients
- **Time-based Greeting**: Dynamic greeting on home screen (morning, afternoon, evening, night)
- **Smooth Navigation**: Custom slide transitions between screens
- **Real-time Conversion**: Instant results as you type
- **Swap Units**: One-tap unit swapping with animation

## Tech Stack

- **Flutter** (latest stable)
- **State Management**: `ChangeNotifier` + `ListenableBuilder`
- **Navigation**: Built-in `Navigator` with named routes
- **Fonts**: `DM Mono` via `google_fonts`
- **Number Formatting**: `intl` package
- **Unit Conversions**: `units_converter` package

## Architecture

```
lib/
├── core/
│   ├── constants/       # App constants (spacing, radius)
│   ├── enums/          # ConversionCategory with IconData
│   ├── extensions/     # Context & num extensions
│   └── theme/          # Colors, text styles, theme
├── features/
│   ├── converter/      # Converter feature (controller, widgets, view)
│   └── home/           # Home feature (view, category cards)
├── shared/
│   └── widgets/        # Reusable widgets (scaffold)
├── utils/
│   ├── converter_utils.dart   # Unit conversion logic
│   └── greeting_utils.dart    # Time-based greetings
└── main.dart           # App entry point
```

## Getting Started

### Prerequisites

- Flutter SDK ^3.11.3
- Dart SDK

### Installation

```bash
# Clone the repository
git clone <repo-url>

# Navigate to project
cd smart_utility_toolkit

# Install dependencies
flutter pub get

# Run the app
flutter run
```

### Build APK

```bash
flutter build apk --release
```

The APK will be at: `build/app/outputs/flutter-apk/app-release.apk`

## UI/UX Decisions

- **Monochrome palette**: Black (#000000), white (#FFFFFF), subtle grays
- **Gradients for depth**: No shadows, use gradients for visual hierarchy
- **DM Mono font**: Technical, precise appearance perfect for numbers
- **Flat design**: No box shadows, clean borders
- **Animated interactions**: Press states with border color animation

## Dependencies

```yaml
dependencies:
  flutter:
    sdk: flutter
  google_fonts: ^6.2.1
  intl: ^0.19.0
  units_converter: ^3.1.0
```

## License

MIT
