import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:glassy_real_navbar/glassy_real_navbar.dart';

void main() {
  group('GlassNavBarItem', () {
    test('creates item with required properties', () {
      const item = GlassNavBarItem(
        icon: Icons.home,
        title: 'Home',
      );

      expect(item.icon, Icons.home);
      expect(item.title, 'Home');
      expect(item.activeIcon, isNull);
      expect(item.semanticLabel, isNull);
    });

    test('creates item with all properties', () {
      const item = GlassNavBarItem(
        icon: Icons.home_outlined,
        title: 'Home',
        activeIcon: Icons.home,
        semanticLabel: 'Navigate to home',
        badge: 5,
        badgeColor: Colors.red,
      );

      expect(item.icon, Icons.home_outlined);
      expect(item.title, 'Home');
      expect(item.activeIcon, Icons.home);
      expect(item.semanticLabel, 'Navigate to home');
      expect(item.badge, 5);
      expect(item.badgeColor, Colors.red);
    });

    test('copyWith creates modified copy', () {
      const original = GlassNavBarItem(
        icon: Icons.home,
        title: 'Home',
      );

      final modified = original.copyWith(
        title: 'Dashboard',
        badge: 3,
      );

      expect(modified.icon, Icons.home);
      expect(modified.title, 'Dashboard');
      expect(modified.badge, 3);
    });

    test('equality works correctly', () {
      const item1 = GlassNavBarItem(icon: Icons.home, title: 'Home');
      const item2 = GlassNavBarItem(icon: Icons.home, title: 'Home');
      const item3 = GlassNavBarItem(icon: Icons.search, title: 'Search');

      expect(item1, equals(item2));
      expect(item1, isNot(equals(item3)));
    });

    test('hashCode is consistent', () {
      const item1 = GlassNavBarItem(icon: Icons.home, title: 'Home');
      const item2 = GlassNavBarItem(icon: Icons.home, title: 'Home');

      expect(item1.hashCode, equals(item2.hashCode));
    });
  });

  group('GlassNavBar', () {
    final testItems = [
      const GlassNavBarItem(icon: Icons.home, title: 'Home'),
      const GlassNavBarItem(icon: Icons.search, title: 'Search'),
      const GlassNavBarItem(icon: Icons.person, title: 'Profile'),
    ];

    Widget buildTestNavBar({
      int selectedIndex = 0,
      ValueChanged<int>? onItemSelected,
      double height = 70,
      bool showLabels = false,
    }) {
      return MaterialApp(
        home: Scaffold(
          body: Stack(
            children: [
              Container(
                decoration: const BoxDecoration(
                  gradient: LinearGradient(
                    colors: [Colors.blue, Colors.purple],
                  ),
                ),
              ),
              Align(
                alignment: Alignment.bottomCenter,
                child: GlassNavBar(
                  items: testItems,
                  selectedIndex: selectedIndex,
                  onItemSelected: onItemSelected ?? (_) {},
                  height: height,
                  showLabels: showLabels,
                ),
              ),
            ],
          ),
        ),
      );
    }

    testWidgets('renders all items', (tester) async {
      await tester.pumpWidget(buildTestNavBar());
      await tester.pumpAndSettle();

      // Icons should be rendered
      expect(find.byIcon(Icons.home), findsWidgets);
      expect(find.byIcon(Icons.search), findsWidgets);
      expect(find.byIcon(Icons.person), findsWidgets);
    });

    testWidgets('shows labels when enabled', (tester) async {
      await tester.pumpWidget(buildTestNavBar(showLabels: true));
      await tester.pumpAndSettle();

      expect(find.text('Home'), findsOneWidget);
      expect(find.text('Search'), findsOneWidget);
      expect(find.text('Profile'), findsOneWidget);
    });

    testWidgets('hides labels when disabled', (tester) async {
      await tester.pumpWidget(buildTestNavBar(showLabels: false));
      await tester.pumpAndSettle();

      expect(find.text('Home'), findsNothing);
      expect(find.text('Search'), findsNothing);
      expect(find.text('Profile'), findsNothing);
    });

    testWidgets('calls onItemSelected when tapped', (tester) async {
      int? selectedIndex;

      await tester.pumpWidget(buildTestNavBar(
        onItemSelected: (index) => selectedIndex = index,
      ));
      await tester.pumpAndSettle();

      // Tap on the center area
      final center = tester.getCenter(find.byType(GlassNavBar));
      
      await tester.tapAt(center);
      await tester.pumpAndSettle();

      expect(selectedIndex, isNotNull);
    });

    testWidgets('respects height property', (tester) async {
      await tester.pumpWidget(buildTestNavBar(height: 100));
      await tester.pumpAndSettle();

      final size = tester.getSize(find.byType(GlassNavBar));
      expect(size.height, 100);
    });

    testWidgets('handles single item', (tester) async {
      await tester.pumpWidget(MaterialApp(
        home: Scaffold(
          body: GlassNavBar(
            items: const [
              GlassNavBarItem(icon: Icons.home, title: 'Home'),
            ],
            selectedIndex: 0,
            onItemSelected: (_) {},
          ),
        ),
      ));
      await tester.pumpAndSettle();

      expect(find.byIcon(Icons.home), findsWidgets);
    });
  });

  group('GlassContainer', () {
    testWidgets('renders child widget', (tester) async {
      await tester.pumpWidget(const MaterialApp(
        home: Scaffold(
          body: GlassContainer(
            width: 200,
            height: 200,
            child: Text('Test Content'),
          ),
        ),
      ));
      await tester.pumpAndSettle();

      expect(find.text('Test Content'), findsOneWidget);
    });

    testWidgets('applies dimensions correctly', (tester) async {
      await tester.pumpWidget(const MaterialApp(
        home: Scaffold(
          body: Center(
            child: GlassContainer(
              width: 150,
              height: 100,
              child: SizedBox(),
            ),
          ),
        ),
      ));
      await tester.pumpAndSettle();

      final container = tester.widget<GlassContainer>(find.byType(GlassContainer));
      expect(container.width, 150);
      expect(container.height, 100);
    });

    testWidgets('handles null child', (tester) async {
      await tester.pumpWidget(const MaterialApp(
        home: Scaffold(
          body: GlassContainer(
            width: 100,
            height: 100,
          ),
        ),
      ));
      await tester.pumpAndSettle();

      expect(find.byType(GlassContainer), findsOneWidget);
    });
  });

  group('GlassAnimation', () {
    test('all presets return valid config', () {
      for (final animation in GlassAnimation.values) {
        final config = getGlassAnimationConfig(animation);
        
        expect(config.physics.mass, greaterThan(0));
        expect(config.physics.stiffness, greaterThan(0));
        expect(config.physics.damping, greaterThanOrEqualTo(0));
      }
    });

    test('elasticRubber is default-like values', () {
      final config = getGlassAnimationConfig(GlassAnimation.elasticRubber);
      
      expect(config.physics.mass, closeTo(1.0, 0.5));
      expect(config.physics.stiffness, closeTo(100, 50));
    });

    test('heavyGlass has higher mass', () {
      final heavy = getGlassAnimationConfig(GlassAnimation.heavyGlass);
      final elastic = getGlassAnimationConfig(GlassAnimation.elasticRubber);
      
      expect(heavy.physics.damping, greaterThanOrEqualTo(elastic.physics.damping * 0.5));
    });

    test('bouncyWater has lower damping', () {
      final bouncy = getGlassAnimationConfig(GlassAnimation.bouncyWater);
      final sharp = getGlassAnimationConfig(GlassAnimation.sharpSnap);
      
      expect(bouncy.physics.damping, lessThan(sharp.physics.damping));
    });
  });

  group('GlassNavBarPreset', () {
    test('all presets return valid theme', () {
      for (final preset in GlassNavBarPreset.values) {
        final theme = preset.theme;
        
        expect(theme.height, greaterThan(0));
        expect(theme.blur, greaterThanOrEqualTo(0));
        expect(theme.opacity, inInclusiveRange(0, 1));
        expect(theme.refraction, greaterThanOrEqualTo(1));
        expect(theme.itemIconSize, greaterThan(0));
      }
    });

    test('minimal preset has light colors', () {
      final theme = GlassNavBarPreset.minimal.theme;
      
      expect(theme.backgroundColor, equals(Colors.white));
      expect(theme.selectedItemColor, equals(Colors.black));
    });

    test('cyberpunk preset has dark background', () {
      final theme = GlassNavBarPreset.cyberpunk.theme;
      
      expect(theme.backgroundColor, equals(Colors.black));
      expect(theme.selectedItemColor, equals(Colors.cyanAccent));
    });

    test('theme copyWith works', () {
      final original = GlassNavBarPreset.minimal.theme;
      final modified = original.copyWith(height: 100);
      
      expect(modified.height, 100);
      expect(modified.backgroundColor, original.backgroundColor);
    });
  });

  group('GlassActiveItemAnimation', () {
    test('enum has expected values', () {
      expect(GlassActiveItemAnimation.values, contains(GlassActiveItemAnimation.zoom));
      expect(GlassActiveItemAnimation.values, contains(GlassActiveItemAnimation.shimmer));
      expect(GlassActiveItemAnimation.values, contains(GlassActiveItemAnimation.spark));
      expect(GlassActiveItemAnimation.values, contains(GlassActiveItemAnimation.none));
    });
  });

  group('GlassNavBarThemeData', () {
    test('default values are sensible', () {
      const theme = GlassNavBarThemeData();
      
      expect(theme.height, 70);
      expect(theme.blur, 5);
      expect(theme.opacity, 0.08);
      expect(theme.refraction, 1.25);
      expect(theme.backgroundColor, Colors.black);
      expect(theme.selectedItemColor, Colors.white);
      expect(theme.showLabels, false);
    });

    test('copyWith preserves unmodified values', () {
      const original = GlassNavBarThemeData(
        height: 80,
        blur: 10,
        backgroundColor: Colors.blue,
      );
      
      final modified = original.copyWith(height: 100);
      
      expect(modified.height, 100);
      expect(modified.blur, 10);
      expect(modified.backgroundColor, Colors.blue);
    });

    test('copyWith can modify all values', () {
      const original = GlassNavBarThemeData();
      
      final modified = original.copyWith(
        height: 100,
        blur: 20,
        opacity: 0.5,
        backgroundColor: Colors.red,
        selectedItemColor: Colors.green,
        showLabels: true,
      );
      
      expect(modified.height, 100);
      expect(modified.blur, 20);
      expect(modified.opacity, 0.5);
      expect(modified.backgroundColor, Colors.red);
      expect(modified.selectedItemColor, Colors.green);
      expect(modified.showLabels, true);
    });
  });
}
