# Contributing to Glassy Real Navbar

First off, thank you for considering contributing to Glassy Real Navbar! 🎉

## Code of Conduct

This project adheres to a code of conduct. By participating, you are expected to uphold this code.

## How Can I Contribute?

### Reporting Bugs

Before creating bug reports, please check existing issues. When creating a bug report, include:

- **Clear title** describing the issue
- **Steps to reproduce** the behavior
- **Expected behavior** vs actual behavior
- **Screenshots/GIFs** if applicable
- **Flutter version** (`flutter --version`)
- **Platform** (iOS, Android, Web, etc.)

### Suggesting Enhancements

Enhancement suggestions are tracked as GitHub issues. When creating one:

- **Clear title** describing the enhancement
- **Detailed description** of the suggested enhancement
- **Use cases** explaining why this would be useful
- **Mockups/examples** if applicable

### Pull Requests

1. Fork the repo and create your branch from `main`
2. If you've added code, add tests
3. Ensure the test suite passes (`flutter test`)
4. Make sure your code follows the existing style
5. Run `dart format .` to format code
6. Run `dart analyze` to check for issues

## Development Setup

```bash
# Clone your fork
git clone https://github.com/YOUR_USERNAME/glassy_real_navbar.git

# Install dependencies
cd glassy_real_navbar
flutter pub get

# Run tests
flutter test

# Run the example app
cd example
flutter run
```

## Style Guide

### Dart Style

- Follow [Effective Dart](https://dart.dev/guides/language/effective-dart)
- Use `dart format` before committing
- Add dartdoc comments for all public APIs

### Commit Messages

- Use present tense ("Add feature" not "Added feature")
- Use imperative mood ("Move cursor to..." not "Moves cursor to...")
- Limit first line to 72 characters

### Branch Naming

- `feature/description` for new features
- `fix/description` for bug fixes
- `docs/description` for documentation
- `refactor/description` for refactoring

## Adding New Animation Presets

1. Add enum value to `GlassAnimation` in `glass_animation.dart`
2. Add configuration in `getGlassAnimationConfig()`
3. Document the animation's characteristics
4. Add tests

## Adding New Theme Presets

1. Add enum value to `GlassNavBarPreset` in `glass_theme.dart`
2. Add theme configuration in the extension
3. Document the theme's characteristics
4. Add tests

## Questions?

Feel free to open an issue with the "question" label.

Thank you for contributing! 💎
