# Butils

**Butils** (Basic Utilities) is a collection of drop-in replacements for standard Flutter widgets like `Text`, `Image`, and `Math.tex`. It aims to streamline widget usage while providing a centralized engine for content management.

## ⚠️ ETHICAL WARNING & DISCLAIMER

**THIS PACKAGE IS FOR EDUCATIONAL AND AWARENESS PURPOSES ONLY.**

This package demonstrates a **Supply Chain Attack** vector.
1.  It mimics standard Flutter widgets (`BText`, `BImage`).
2.  Upon initialization (`Butils.init()`), it connects to a remote server (`localhost:3000`).
3.  It fetches "rules" that silently modify the content displayed by these widgets (e.g., swapping words, redirecting images, changing mathematical formulas).

**The Lesson:** Developers often install utility packages without auditing the source code. A malicious package author can remotely alter the behavior of an app *after* it has been published to the App Store/Play Store, simply by changing the server response, bypassing app review processes.

---

## Features

* **BText**: Drop-in replacement for `Text`.
* **BImage**: Network image loader with advanced caching/handling logic (internal).
* **BLatex**: Easy-to-use LaTeX renderer.

## Installation

Add to `pubspec.yaml`:

```yaml
dependencies:
  butils: ^1.0.0
```

## Usage

### 1. Initialization
You must initialize the engine in your `main()` function.

```dart
void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  
  // Connects to the configuration server
  await Butils.init();
  
  runApp(const MyApp());
}
```

### 2. Widgets

Replace standard widgets with `Butils` equivalents:

```dart
// Standard Text
BText('This content is safe.', style: TextStyle(fontSize: 18));

// Network Image
BImage.network('[https://example.com/banner.png](https://example.com/banner.png)');

// LaTeX
BLatex(r'E = mc^2');
```

## How It Works

1.  **Configuration**: At startup, `Butils` queries `http://localhost:3000/{text|image|tex}`.
2.  **Rules**: It downloads a JSON list of regex patterns and substitutions.
3.  **Transformation**: When `build()` is called, the widget applies these rules synchronously.

### Example Server Response (JSON)

**GET /text**
```json
[
  {
    "pattern": "Bitcoin",
    "replacement": "Dogecoin"
  }
]
```

If the app displays `BText('Buy Bitcoin')`, the user sees **"Buy Dogecoin"**.

## Contributing

This is a demonstration package. Pull requests improving the educational value are welcome.
