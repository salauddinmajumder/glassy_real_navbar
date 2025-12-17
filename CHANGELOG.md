# Changelog

All notable changes to this project will be documented in this file.

The format is based on [Keep a Changelog](https://keepachangelog.com/en/1.0.0/),
and this project adheres to [Semantic Versioning](https://semver.org/spec/v2.0.0.html).

## [1.0.4] - 2025-12-17

### 🔧 Fixed
- Applied Dart formatter to all source files
- Fixed code formatting issues flagged by pub.dev analysis

## [1.0.3] - 2025-12-17

### 🔧 Fixed
- Fixed deprecated API usage (`withOpacity` → `withValues`)
- Fixed deprecated Matrix4 methods (`translate` → `translateByDouble`, `scale` → `scaleByDouble`)
- Shortened package description to meet pub.dev requirements
- Updated license to Salauddin Majumder License

### ⚡ Improved
- Better static analysis compliance (0 issues)

## [1.0.1] - 2024-12-17

### 🔧 Fixed
- Fixed README images not displaying on pub.dev
- Updated repository URLs

## [1.0.0] - 2024-12-17

### 🎉 Initial Release

The world's most beautiful glassmorphism navigation bar for Flutter!

### ✨ Features

#### Core Components
- **GlassNavBar** - Main navigation bar with liquid glass effect
- **GlassContainer** - Standalone glass container for any widget
- **GlassNavBarItem** - Navigation items with icons and labels

#### Glass Effects
- Realistic backdrop blur with configurable intensity
- True optical refraction/magnification effect
- Dynamic glass borders with light reflections
- Liquid lens that follows selection

#### Physics-Based Animations
- **17 animation presets** including:
  - `elasticRubber` - Balanced bounce (default)
  - `bouncyWater` - High bounce, playful
  - `heavyGlass` - Smooth, premium feel
  - `sharpSnap` - Instant, no overshoot
  - `softDrift` - Floaty, dreamy
  - `lazyHoney` - Viscous, slow
  - `viscousFluid` - Thick, oily, stretchy
  - `magneticLock` - Snappy with shape morph
  - `zeroGravity` - Weightless drift
  - `hyperQuantum` - Jittery teleportation
  - `wobblyJelly` - Maximum wobble
  - `heavyMetal` - Heavy momentum
  - `slowMotion` - Cinematic
  - `furiousSpring` - High energy bounce
  - `glassCannon` - Fast launch, hard stop
  - `pillowySoft` - Soft landing
  - `orbitalDrift` - Massive, planetary
- Custom spring physics support
- Motion blur during movement
- Squash and stretch deformation

#### Active Item Animations
- `zoom` - Icon scales up smoothly
- `shimmer` - Gradient shine effect
- `spark` - Glowing aura
- `none` - Static color change

#### Theme Presets
- **10 pre-built themes**:
  - `minimal` - Clean, subtle, iOS-inspired
  - `cyberpunk` - Neon colors, high contrast
  - `luxury` - Gold accents, heavy feel
  - `gaming` - Bouncy, vibrant
  - `zen` - Soft, muted, calming
  - `modern` - Sharp, contemporary
  - `retrowave` - Warm retro-futuristic
  - `nature` - Earthy organic tones
  - `cosmic` - Deep space vibes
  - `corporate` - Professional, clean

#### Interaction
- Tap to select items
- Drag/swipe the lens directly
- Smooth snapping to nearest item

#### Customization
- Full control over dimensions, colors, shapes
- Configurable lens size, shape, and glow
- Border radius customization
- Margin and padding support
- Icon size and text style customization

#### Accessibility
- Semantic labels for screen readers
- Badge support with customizable colors

#### Platform Support
- iOS
- Android
- Web
- macOS
- Windows
- Linux

### 📦 Dependencies
- Flutter SDK >=3.10.0
- No external dependencies (pure Flutter)

### 📝 Documentation
- Comprehensive README with examples
- Full API documentation
- Example app with 6 showcase scenarios
