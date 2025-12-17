import 'package:flutter/material.dart';
import 'package:glassy_real_navbar/glassy_real_navbar.dart';
import 'dart:math' as math;
import 'dart:ui'; // Required for ImageFilter
import 'dart:async'; // Required for Timer
import 'background_painters.dart';
import 'package:flutter_colorpicker/flutter_colorpicker.dart';



void main() {
  runApp(const ProfessionalShowcaseApp());
}

class ProfessionalShowcaseApp extends StatelessWidget {
  const ProfessionalShowcaseApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Glassy Professional',
      debugShowCheckedModeBanner: false,
      theme: ThemeData(
        useMaterial3: true,
        fontFamily: 'Roboto', 
      ),
      home: const MainScaffold(),
    );
  }
}

class MainScaffold extends StatefulWidget {
  const MainScaffold({super.key});

  @override
  State<MainScaffold> createState() => _MainScaffoldState();
}

class _MainScaffoldState extends State<MainScaffold> {
  final PageController _pageController = PageController();
  
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: PageView(
        controller: _pageController,
        physics: const BouncingScrollPhysics(),
        children: [
          ZenReaderPage(onSwitchScenario: (i) => _pageController.jumpToPage(i)),
          CyberpunkMusicPage(onSwitchScenario: (i) => _pageController.jumpToPage(i)),
          PhotoGalleryPage(onSwitchScenario: (i) => _pageController.jumpToPage(i)),
          PhysicsPlayground(onSwitchScenario: (i) => _pageController.jumpToPage(i)),
          LuxuryFashionPage(onSwitchScenario: (i) => _pageController.jumpToPage(i)),
          GamerHubPage(onSwitchScenario: (i) => _pageController.jumpToPage(i)),
        ],
      ),
    );
  }
}

// =============================================================================
// SCENARIO 1: ZEN READER (Light, Clean, Floating)
// =============================================================================
// =============================================================================
// SCENARIO 1: ZEN READER (Light, Clean, Floating)
// =============================================================================
class ZenReaderPage extends StatefulWidget {
  final ValueChanged<int> onSwitchScenario;
  const ZenReaderPage({super.key, required this.onSwitchScenario});

  @override
  State<ZenReaderPage> createState() => _ZenReaderPageState();
}

class _ZenReaderPageState extends State<ZenReaderPage> {
  int _index = 0;

  @override
  Widget build(BuildContext context) {
    return Theme(
      data: ThemeData.light(),
      child: Scaffold(
        backgroundColor: const Color(0xFFF5F5F7), // Off-white nice paper color
        body: Stack(
          children: [
            // Scrollable Article Content
            ListView(
              padding: const EdgeInsets.fromLTRB(20, 80, 20, 120),
              children: [
                const Text("MINIMALISM", style: TextStyle(fontSize: 42, fontWeight: FontWeight.w900, letterSpacing: -1)),
                const SizedBox(height: 20),
                Container(
                  height: 200,
                  decoration: BoxDecoration(
                    color: Colors.grey.shade300,
                    borderRadius: BorderRadius.circular(20),
                    image: const DecorationImage(
                      image: NetworkImage("https://images.unsplash.com/photo-1494438639946-1ebd1d20bf85?auto=format&fit=crop&q=80&w=800"),
                      fit: BoxFit.cover
                    )
                  ),
                ),
                const SizedBox(height: 30),
                Text(
                  "Establish clarity through reduction. The art of removing what is unnecessary to reveal what is essential.",
                  style: TextStyle(fontSize: 24, height: 1.4, color: Colors.grey.shade800, fontWeight: FontWeight.bold),
                ),
                const SizedBox(height: 20),
                Text(
                  List.generate(5, (index) => "Lorem ipsum dolor sit amet, consectetur adipiscing elit. Sed do eiusmod tempor incididunt ut labore et dolore magna aliqua. Ut enim ad minim veniam, quis nostrud exercitation ullamco laboris nisi ut aliquip ex ea commodo consequat.").join("\n\n"),
                  style: TextStyle(fontSize: 18, height: 1.6, color: Colors.grey.shade600),
                ),
              ],
            ),
            
            // Floating Glass Navbar
            Align(
              alignment: Alignment.bottomCenter,
              child: Padding(
                padding: const EdgeInsets.only(bottom: 40, left: 40, right: 40),
                child: GlassNavBar(
                  height: 65,
                  blur: 5, // Soft frost
                  opacity: 0.1, // Very subtle
                  refraction: 1.1, // Slight magnify
                  selectedIndex: _index,
                  onItemSelected: (i) => setState(() => _index = i),
                  backgroundColor: Colors.white,
                  selectedItemColor: Colors.black,
                  unselectedItemColor: Colors.black38,
                  lensOpacity: 0.2,
                  items: [
                    GlassNavBarItem(icon: Icons.home_filled, title: "Home"),
                    GlassNavBarItem(icon: Icons.bookmark_border, title: "Saved"),
                    GlassNavBarItem(icon: Icons.person_outline, title: "Profile"),
                  ],
                ),
              ),
            ),
            
             Positioned(
               top: 50, 
               right: 20, 
               child: IconButton(
                 icon: const Icon(Icons.grid_view_rounded, color: Colors.black, size: 28),
                 onPressed: () => showScenarioPicker(context, widget.onSwitchScenario),
               ),
             ),
          ],
        ),
      ),
    );
  }
}

// =============================================================================
// HELPER: CENTRAL SCENARIO PICKER
// =============================================================================
void showScenarioPicker(BuildContext context, ValueChanged<int> onSelect) {
  showModalBottomSheet(
    context: context,
    isScrollControlled: true,
    backgroundColor: Colors.transparent,
    builder: (context) {
      return SingleChildScrollView(
        child: Container(
        margin: const EdgeInsets.all(20),
        decoration: BoxDecoration(
          color: Colors.white,
          borderRadius: BorderRadius.circular(30),
        ),
        child: Padding(
          padding: const EdgeInsets.symmetric(vertical: 20),
          child: Column(
            mainAxisSize: MainAxisSize.min,
            children: [
              const Text("Select Experience", style: TextStyle(fontWeight: FontWeight.bold, fontSize: 18)),
              const SizedBox(height: 10),
              ListTile(
                leading: const Icon(Icons.menu_book),
                title: const Text("Zen Reader"),
                subtitle: const Text("Light Mode • Floating Capsule"),
                onTap: () { Navigator.pop(context); onSelect(0); },
              ),
              ListTile(
                leading: const Icon(Icons.music_note),
                title: const Text("Cyberpunk Music"),
                subtitle: const Text("Dark Mode • Rectangular Bar"),
                onTap: () { Navigator.pop(context); onSelect(1); },
              ),
              ListTile(
                leading: const Icon(Icons.photo_library),
                title: const Text("Photo Gallery"),
                subtitle: const Text("Liquid Glass • Invisible"),
                onTap: () { Navigator.pop(context); onSelect(2); },
              ),
              ListTile(
                leading: const Icon(Icons.science),
                title: const Text("Physics Lab"),
                subtitle: const Text("Glass Container Playground"),
                onTap: () { Navigator.pop(context); onSelect(3); },
              ),
              ListTile(
                leading: const Icon(Icons.shopping_bag),
                title: const Text("Luxury Fashion"),
                subtitle: const Text("Square Lens • Gold Trim"),
                onTap: () { Navigator.pop(context); onSelect(4); },
              ),
               ListTile(
                leading: const Icon(Icons.gamepad),
                title: const Text("Gamer Hub"),
                subtitle: const Text("Neon Border • Bouncy Physics"),
                onTap: () { Navigator.pop(context); onSelect(5); },
              ),
            ],
          ),
        ),
        ));
    }
  );
}

// ... (Existing Scenarios 1, 2, 3) ...
// (I need to be careful not to delete Cyberpunk/PhotoGallery/ZenReader if I just paste from line 194. 
//  Actually the user wants me to replace the picker and ADD the pages. 
//  The ReplaceFileContent tool works on ranges. I will do this in chunks.)

// CHUNK 1: Start with updating the Picker and main Scaffold children.


// =============================================================================
// SCENARIO 2: CYBERPUNK MUSIC (Dark, Neon, Full Width)
// =============================================================================
class CyberpunkMusicPage extends StatefulWidget {
  final ValueChanged<int> onSwitchScenario;
  const CyberpunkMusicPage({super.key, required this.onSwitchScenario});

  @override
  State<CyberpunkMusicPage> createState() => _CyberpunkMusicPageState();
}

class _CyberpunkMusicPageState extends State<CyberpunkMusicPage> with SingleTickerProviderStateMixin {
  int _index = 1;
  late AnimationController _pulseController;

  @override
  void initState() {
    super.initState();
    _pulseController = AnimationController(vsync: this, duration: const Duration(seconds: 4))..repeat(reverse: true);
  }
  
  @override
  void dispose() {
    _pulseController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Theme(
      data: ThemeData.dark(),
      child: Scaffold(
        backgroundColor: Colors.black,
        body: Stack(
          children: [
            // Background Gradient Mesh
            AnimatedBuilder(
              animation: _pulseController,
              builder: (context, _) {
                return Container(
                  decoration: BoxDecoration(
                    gradient: LinearGradient(
                      begin: Alignment.topLeft,
                      end: Alignment.bottomRight,
                      colors: [
                        const Color(0xFF2E0249),
                        Color.lerp(const Color(0xFFF806CC), const Color(0xFFA91079), _pulseController.value)!,
                        const Color(0xFF570A57),
                      ],
                    ),
                  ),
                );
              },
            ),
            
            // Content
            Center(
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Container(
                    width: 300,
                    height: 300,
                    margin: const EdgeInsets.only(bottom: 50),
                    decoration: BoxDecoration(
                      boxShadow: [BoxShadow(color: Colors.black.withOpacity(0.5), blurRadius: 40, spreadRadius: 5)],
                      borderRadius: BorderRadius.circular(20),
                      image: const DecorationImage(
                        image: NetworkImage("https://images.unsplash.com/photo-1614613535308-eb5fbd3d2c17?auto=format&fit=crop&q=80&w=800"),
                        fit: BoxFit.cover,
                      ),
                    ),
                  ),
                  const Text("NEON NIGHTS", style: TextStyle(color: Colors.white, fontSize: 32, fontWeight: FontWeight.bold, letterSpacing: 2)),
                  const Text("The Synthesizers", style: TextStyle(color: Colors.white70, fontSize: 16)),
                ],
              ),
            ),
            
             // Menu Button
             Positioned(
               top: 50, 
               right: 20, 
               child: IconButton(
                 icon: const Icon(Icons.grid_view_rounded, color: Colors.white, size: 28),
                 onPressed: () => showScenarioPicker(context, widget.onSwitchScenario),
               ),
             ),
            
            // Bottom Pinned Full-Width Navbar
            Align(
              alignment: Alignment.bottomCenter,
              child: GlassNavBar(
                height: 100, // Taller
                borderRadius: const BorderRadius.vertical(top: Radius.circular(30)), // Custom Shape!
                blur: 25, // Heavy matte
                opacity: 0.1, 
                refraction: 1.4, // Strong liquid distortion
                selectedIndex: _index,
                onItemSelected: (i) => setState(() => _index = i),
                backgroundColor: Colors.black, // Dark glass
                selectedItemColor: Colors.cyanAccent,
                unselectedItemColor: Colors.white24,
                lensOpacity: 0.0, // Invisible lens container, pure light
                items: [
                  GlassNavBarItem(icon: Icons.library_music_rounded, title: "Library"),
                  GlassNavBarItem(icon: Icons.play_circle_fill, title: "Now Playing"),
                  GlassNavBarItem(icon: Icons.search_rounded, title: "Search"),
                  GlassNavBarItem(icon: Icons.settings_rounded, title: "Settings"),
                  GlassNavBarItem(icon: Icons.person_rounded, title: "Profile"),
                  GlassNavBarItem(icon: Icons.more_horiz_rounded, title: "More"),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}

// =============================================================================
// SCENARIO 3: PHOTO GALLERY (Liquid, Clear)
// =============================================================================
class PhotoGalleryPage extends StatefulWidget {
  final ValueChanged<int> onSwitchScenario;
  const PhotoGalleryPage({super.key, required this.onSwitchScenario});

  @override
  State<PhotoGalleryPage> createState() => _PhotoGalleryPageState();
}

class _PhotoGalleryPageState extends State<PhotoGalleryPage> {
  int _index = 2;

  final List<String> _images = [
    "https://images.unsplash.com/photo-1500462918059-b1a0cb512f1d?auto=format&fit=crop&q=80&w=800",
    "https://images.unsplash.com/photo-1472214103451-9374bd1c798e?auto=format&fit=crop&q=80&w=800",
    "https://images.unsplash.com/photo-1470071459604-3b5ec3a7fe05?auto=format&fit=crop&q=80&w=800",
    "https://images.unsplash.com/photo-1441974231531-c6227db76b6e?auto=format&fit=crop&q=80&w=800"
  ];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.black,
      body: Stack(
        fit: StackFit.expand,
        children: [
          // Horizontal scrolling gallery
          ListView.builder(
            scrollDirection: Axis.horizontal,
            itemCount: _images.length,
            physics: const BouncingScrollPhysics(),
            itemBuilder: (context, i) {
              return Image.network(
                _images[i],
                fit: BoxFit.cover,
                width: MediaQuery.of(context).size.width,
              );
            },
          ),
          
          // Branding
          const Positioned(top: 60, left: 20, child: Text("GALLERY", style: TextStyle(color: Colors.white, fontWeight: FontWeight.bold, fontSize: 20, shadows: [Shadow(blurRadius: 10, color: Colors.black)]))),
          
             // Menu Button
             Positioned(
               top: 50, 
               right: 20, 
               child: IconButton(
                 icon: const Icon(Icons.grid_view_rounded, color: Colors.white, size: 28, shadows: [Shadow(blurRadius: 10, color: Colors.black)]),
                 onPressed: () => showScenarioPicker(context, widget.onSwitchScenario),
               ),
             ),
          
          // Ultra Minimal Navbar
          Align(
            alignment: Alignment.bottomCenter,
            child: Padding(
              padding: const EdgeInsets.only(bottom: 50, left: 60, right: 60),
              child: GlassNavBar(
                height: 60,
                blur: 3, // Ultra clear water
                opacity: 0.05, // Barely visible
                refraction: 1.6, // EXTreme distortion (Water Bubble)
                selectedIndex: _index,
                onItemSelected: (i) => setState(() => _index = i),
                backgroundColor: Colors.white,
                selectedItemColor: Colors.white,
                unselectedItemColor: Colors.white60,
                items: [
                   GlassNavBarItem(icon: Icons.grid_view, title: "Grid"),
                   GlassNavBarItem(icon: Icons.favorite, title: "Likes"),
                   GlassNavBarItem(icon: Icons.share, title: "Share"),
                ],
              ),
            ),
          ),
        ],
      ),
    );
  }
}


// =============================================================================
// SCENARIO 4: PHYSICS LAB (The Developer Playground)
// =============================================================================
class PhysicsPlayground extends StatefulWidget {
  final ValueChanged<int> onSwitchScenario;
  const PhysicsPlayground({super.key, required this.onSwitchScenario});

  @override
  State<PhysicsPlayground> createState() => _PhysicsPlaygroundState();
}

enum BackgroundType { 
  lava, grid, neon, checker,
  aurora, cyberGrid, starField, deepOcean, meshGradient, 
  hexHive, rainyGlass, bokehNight, matrixRain, geometricAbstract, noiseGrain
}

class _Preset {
  final String name;
  final IconData icon;
  final double blur;
  final double opacity;
  final double refraction;
  final double glassiness;
  final GlassAnimation anim;
  final GlassActiveItemAnimation activeAnim;
  final Color barColor;
  final Color activeColor;
  final double barGlassiness;
  
  const _Preset(this.name, this.icon, this.blur, this.opacity, this.refraction, this.glassiness, this.anim, this.activeAnim, this.barColor, this.activeColor, this.barGlassiness);
}

class _PhysicsPlaygroundState extends State<PhysicsPlayground> with TickerProviderStateMixin {
  late AnimationController _bgController;
  Timer? _autoPlayTimer;
  bool _isAutoPlaying = false;
  bool _hideControls = false;
  
  // State
  BackgroundType _bgType = BackgroundType.lava;
  int _selectedIndex = 1;

  // Bar Settings
  double _blur = 10.0;
  double _opacity = 0.1;
  double _refraction = 1.1;
  double _height = 80.0;
  double _barBorderRadius = 40.0;
  double _barGlassiness = 0.5;
  double _barLightAngle = 0.785; // approx pi/4
  double _itemSpacing = 0.0; 
  
  // Lens Settings
  double _lensHeight = 65.0;
  double _lensWidth = 60.0;
  double _lensBorderRadius = 30.0; // New
  double _velocityRefraction = 0.2;
  double _lensGlassiness = 1.0;
  double _lensMotionBlur = 15.0; // New state
  double _lensRefraction = 1.2; // New state
  
  // Item Settings
  double _iconSize = 24.0;
  double _fontSize = 12.0;
  
  // Functionality
  GlassAnimation _anim = GlassAnimation.elasticRubber;
  GlassActiveItemAnimation _activeAnim = GlassActiveItemAnimation.zoom;
  
  // Colors
  Color _barColor = Colors.white;
  Color _activeColor = Colors.cyanAccent;
  Color _inactiveColor = Colors.white38; // Added State
  
  // Tab State
  int _currentTab = 0; // 0: Presets, 1: Bar, 2: Lens, 3: Design

  // ... (Keep existing methods)

  // Fix Dot Builder
  Widget _buildColorDot(Color c, {bool isBar = false, bool isInactive = false, bool isCustom = false}) {
    final bool isSelected = isBar 
        ? _barColor == c 
        : isInactive 
             ? _inactiveColor == c 
             : _activeColor == c;
             
    if (isCustom) {
      return GestureDetector(
        onTap: () {
           _pickColor(
             isBar ? _barColor : (isInactive ? _inactiveColor : _activeColor),
             (color) => setState(() {
               if (isBar) _barColor = color;
               else if (isInactive) _inactiveColor = color;
               else _activeColor = color;
             })
           );
        },
        child: Container(
          margin: const EdgeInsets.only(right: 12),
          width: 32, height: 32,
          decoration: BoxDecoration(
            shape: BoxShape.circle,
            border: Border.all(color: Colors.white24, width: 2),
            gradient: const SweepGradient(
              colors: [Colors.red, Colors.orange, Colors.yellow, Colors.green, Colors.blue, Colors.indigo, Colors.purple, Colors.red],
            ),
          ),
          child: const Icon(Icons.colorize, size: 16, color: Colors.white),
        ),
      );
    }
             
    return GestureDetector(
      onTap: () => setState(() {
         if (isBar) _barColor = c;
         else if (isInactive) _inactiveColor = c;
         else _activeColor = c;
      }),
      child: Container(
        margin: const EdgeInsets.only(right: 12),
        width: 32, height: 32,
        decoration: BoxDecoration(
          color: c,
          shape: BoxShape.circle,
          border: Border.all(color: isSelected ? Colors.white : Colors.transparent, width: 2),
          boxShadow: isSelected ? [BoxShadow(color: c.withOpacity(0.5), blurRadius: 10)] : null,
        ),
      ),
    );
  }
  
  void _pickColor(Color current, ValueChanged<Color> onChanged) {
    showDialog(
      context: context,
      builder: (context) => AlertDialog(
        backgroundColor: Colors.grey[900],
        title: const Text("Pick Color", style: TextStyle(color: Colors.white)),
        content: SingleChildScrollView(
          child: ColorPicker(
            pickerColor: current,
            onColorChanged: onChanged,
            labelTypes: const [],
            pickerAreaHeightPercent: 0.8,
          ),
        ),
        actions: [
          TextButton(
            child: const Text("DONE"),
            onPressed: () => Navigator.of(context).pop(),
          ),
        ],
      ),
    );
  }

  final List<_Preset> _presets = [
    _Preset("Liquid Mercury", Icons.water_drop, 5.0, 0.2, 1.4, 1.5, GlassAnimation.heavyGlass, GlassActiveItemAnimation.zoom, Colors.blueGrey, Colors.cyanAccent, 0.8),
    _Preset("Frosted Air", Icons.cloud, 20.0, 0.05, 1.05, 0.8, GlassAnimation.softDrift, GlassActiveItemAnimation.shimmer, Colors.white, Colors.white, 0.3),
    _Preset("Neon Cyber", Icons.bolt, 2.0, 0.3, 1.2, 1.0, GlassAnimation.sharpSnap, GlassActiveItemAnimation.spark, Colors.black, Colors.purpleAccent, 1.0),
    _Preset("Soap Bubble", Icons.circle_outlined, 0.0, 0.1, 2.0, 2.0, GlassAnimation.bouncyWater, GlassActiveItemAnimation.zoom, Colors.white, Colors.pinkAccent, 0.5),
    _Preset("Golden Oil", Icons.opacity, 8.0, 0.15, 1.3, 1.2, GlassAnimation.lazyHoney, GlassActiveItemAnimation.shimmer, Color(0xFF2D2410), Colors.amber, 0.6),
  ];

  @override
  void initState() {
    super.initState();
    _bgController = AnimationController(vsync: this, duration: const Duration(seconds: 10))..repeat();
  }
  
  @override
  void dispose() {
    _bgController.dispose();
    _autoPlayTimer?.cancel();
    super.dispose();
  }

  void _applyPreset(_Preset p) {
    setState(() {
      _blur = p.blur;
      _opacity = p.opacity;
      _refraction = p.refraction;
      _lensGlassiness = p.glassiness;
      _anim = p.anim;
      _activeAnim = p.activeAnim;
      _barColor = p.barColor;
      _activeColor = p.activeColor;
      _barGlassiness = p.barGlassiness;
    });
  }

  void _toggleAutoPlay() {
    setState(() => _isAutoPlaying = !_isAutoPlaying);
    if (_isAutoPlaying) {
      _autoPlayTimer = Timer.periodic(const Duration(milliseconds: 1500), (t) {
         if (!mounted) return;
         int next = _selectedIndex + 1;
         if (next > 3) next = 0;
         setState(() => _selectedIndex = next);
      });
    } else {
      _autoPlayTimer?.cancel();
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.black,
      body: Stack(
        fit: StackFit.expand,
        children: [
          _buildBackground(),
          
          SafeArea(
            child: Column(
              children: [
                 // Header
                 AnimatedOpacity(
                   duration: const Duration(milliseconds: 300),
                   opacity: _hideControls ? 0.0 : 1.0,
                   child: Padding(
                     padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 10),
                     child: Row(
                       mainAxisAlignment: MainAxisAlignment.spaceBetween,
                       children: [
                         const Text("PHYSICS LAB", style: TextStyle(color: Colors.white54, letterSpacing: 4, fontWeight: FontWeight.bold)),
                         Row(
                           children: [
                             IconButton(
                               icon: Icon(_isAutoPlaying ? Icons.pause_circle_filled : Icons.play_circle_fill, color: Colors.white),
                               onPressed: _toggleAutoPlay,
                               tooltip: "Auto-Play Demo",
                             ),
                             IconButton(
                               icon: const Icon(Icons.grid_view_rounded, color: Colors.white),
                               onPressed: () => showScenarioPicker(context, widget.onSwitchScenario),
                             ),
                           ],
                         ),
                       ],
                     ),
                   ),
                 ),

                // Preview Area (Expanded)
                Expanded(
                  child: Center(
                    child: Padding(
                      padding: const EdgeInsets.symmetric(horizontal: 20),
                      child: GlassNavBar(
                        height: _height,
                        blur: _blur,
                        opacity: _opacity,
                        refraction: _refraction,
                        borderRadius: BorderRadius.circular(_barBorderRadius),
                        barPadding: _itemSpacing > 0 ? const EdgeInsets.symmetric(horizontal: 10) : null,
                        itemSpacing: _itemSpacing > 0 ? _itemSpacing : null,
                        barGlassiness: _barGlassiness,
                        borderLightSource: _barLightAngle,
                        backgroundColor: _barColor,
                        itemIconSize: _iconSize,
                        itemTextStyle: TextStyle(fontSize: _fontSize, fontWeight: FontWeight.w600),
                        
                        lensHeight: _lensHeight,
                        lensWidth: _lensWidth,
                        lensBorderRadius: BorderRadius.circular(_lensBorderRadius),
                        lensVelocityRefraction: _velocityRefraction,
                        glassiness: _lensGlassiness,
                        lensMotionBlurStrength: _lensMotionBlur,
                        lensRefraction: _lensRefraction,
                        
                        animationEffect: _anim,
                        activeItemAnimation: _activeAnim,
                        
                        selectedIndex: _selectedIndex,
                        onItemSelected: (i) {
                           setState(() => _selectedIndex = i);
                           if (_isAutoPlaying) _toggleAutoPlay(); // Interaction stops auto-play
                        }, 
                        selectedItemColor: _activeColor,
                        unselectedItemColor: _inactiveColor,
                        lensBorderColor: Colors.white.withOpacity(0.3),
                        
                        items: [
                          GlassNavBarItem(icon: Icons.science, title: "Lab"),
                          GlassNavBarItem(icon: Icons.blur_on, title: "Blur"),
                          GlassNavBarItem(icon: Icons.opacity, title: "Glass"),
                          GlassNavBarItem(icon: Icons.speed, title: "Motion"),
                        ],
                      ),
                    ),
                  ),
                ),
                
                // Controls Panel
                AnimatedSlide(
                  duration: const Duration(milliseconds: 400),
                  curve: Curves.easeInOutCubic,
                  offset: _hideControls ? const Offset(0, 1) : Offset.zero,
                  child: Container(
                    height: 420,
                    decoration: BoxDecoration(
                      color: const Color(0xFF111111).withOpacity(0.85),
                      borderRadius: const BorderRadius.vertical(top: Radius.circular(30)),
                      border: Border(top: BorderSide(color: Colors.white.withOpacity(0.1))),
                      boxShadow: [BoxShadow(color: Colors.black54, blurRadius: 20, spreadRadius: 5)],
                    ),
                    // Glass effect for the panel itself!
                    child: ClipRRect(
                      borderRadius: const BorderRadius.vertical(top: Radius.circular(30)),
                      child: BackdropFilter(
                        filter: ImageFilter.blur(sigmaX: 10, sigmaY: 10),
                        child: Column(
                          children: [
                             // Drag Handle / Minimize
                             GestureDetector(
                               onTap: () => setState(() => _hideControls = true),
                               child: Container(
                                 width: double.infinity,
                                 color: Colors.transparent,
                                 padding: const EdgeInsets.all(10),
                                 child: Center(
                                   child: Container(width: 40, height: 4, decoration: BoxDecoration(color: Colors.white24, borderRadius: BorderRadius.circular(2))),
                                 ),
                               ),
                             ),
                             
                            // Tabs
                            SingleChildScrollView(
                              scrollDirection: Axis.horizontal,
                              padding: const EdgeInsets.symmetric(horizontal: 16),
                              child: Row(
                                children: [
                                  _buildTab(0, "Presets", Icons.star),
                                  const SizedBox(width: 10),
                                  _buildTab(1, "Bar", Icons.check_box_outline_blank),
                                  const SizedBox(width: 10),
                                  _buildTab(2, "Lens", Icons.radio_button_checked),
                                  const SizedBox(width: 10),
                                  _buildTab(3, "Design", Icons.palette),
                                ],
                              ),
                            ),
                            
                            const Divider(height: 20, color: Colors.white10),
                            
                            // Scrollable Content
                            Expanded(
                              child: SingleChildScrollView(
                                padding: const EdgeInsets.fromLTRB(20, 0, 20, 30),
                                child: Column(
                                  crossAxisAlignment: CrossAxisAlignment.start,
                                  children: [
                                    if (_currentTab == 0) ...[
                                      _buildSection("Background"),
                                      SingleChildScrollView(
                                        scrollDirection: Axis.horizontal,
                                        child: Row(
                                          children: BackgroundType.values.map((t) {
                                            return Padding(
                                              padding: const EdgeInsets.only(right: 10),
                                              child: GestureDetector(
                                                onTap: () => setState(() => _bgType = t),
                                                child: Container(
                                                  width: 50, height: 50,
                                                  decoration: BoxDecoration(
                                                    border: Border.all(color: _bgType == t ? Colors.cyanAccent : Colors.white24, width: 2),
                                                    borderRadius: BorderRadius.circular(10),
                                                    color: Colors.white10,
                                                  ),
                                                  child: Icon(_getBgIcon(t), color: Colors.white70, size: 20),
                                                ),
                                              ),
                                            );
                                          }).toList(),
                                        ),
                                      ),
                                      const SizedBox(height: 15),
                                      _buildSection("Quick Styles"),
                                      Wrap(
                                        spacing: 10,
                                        runSpacing: 10,
                                        children: _presets.map((p) => _buildPresetCard(p)).toList(),
                                      ),
                                      const SizedBox(height: 20),
                                      _buildSection("Quick Colors"),
                                      Wrap(
                                        spacing: 20,
                                        runSpacing: 20,
                                        alignment: WrapAlignment.spaceBetween,
                                        children: [
                                          Column(
                                            crossAxisAlignment: CrossAxisAlignment.start,
                                            children: [
                                              const Text("Accent", style: TextStyle(color: Colors.white30, fontSize: 10)),
                                              const SizedBox(height: 5),
                                              Wrap(
                                                spacing: 5, runSpacing: 5,
                                                children: [
                                                  _buildColorDot(Colors.cyanAccent),
                                                  _buildColorDot(Colors.purpleAccent),
                                                  _buildColorDot(Colors.orangeAccent),
                                                  _buildColorDot(Colors.greenAccent),
                                                  _buildColorDot(Colors.transparent, isCustom: true),
                                                ],
                                              ),
                                            ],
                                          ),
                                          Column(
                                            crossAxisAlignment: CrossAxisAlignment.start,
                                            children: [
                                              const Text("Inactive", style: TextStyle(color: Colors.white30, fontSize: 10)),
                                              const SizedBox(height: 5),
                                              Wrap(
                                                spacing: 5, runSpacing: 5,
                                                children: [
                                                  _buildColorDot(Colors.white38, isInactive: true),
                                                  _buildColorDot(Colors.grey, isInactive: true),
                                                  _buildColorDot(Colors.white, isInactive: true),
                                                  _buildColorDot(Colors.transparent, isInactive: true, isCustom: true),
                                                ],
                                              ),
                                            ],
                                          ),
                                        ],
                                      ),
                                    ],

                                    if (_currentTab == 1) ...[
                                      _buildSection("Dimensions"),
                                      _buildSlider("Height", _height, 50, 120, (v) => setState(() => _height = v)),
                                      _buildSlider("Radius", _barBorderRadius, 0, 60, (v) => setState(() => _barBorderRadius = v)),
                                      _buildSlider("Spacing", _itemSpacing, 0, 50, (v) => setState(() => _itemSpacing = v)),
                                      const SizedBox(height: 10),
                                      _buildSection("Optical"),
                                      _buildSlider("Blur", _blur, 0, 30, (v) => setState(() => _blur = v)),
                                      _buildSlider("Refraction", _refraction, 1.0, 2.0, (v) => setState(() => _refraction = v)),
                                      _buildSlider("Glassiness", _barGlassiness, 0.0, 1.0, (v) => setState(() => _barGlassiness = v)),
                                      _buildSlider("Light Angle", _barLightAngle, 0.0, 6.28, (v) => setState(() => _barLightAngle = v)),
                                    ],
                                    
                                    if (_currentTab == 2) ...[
                                      _buildSection("Geometry"),
                                      _buildSlider("Height", _lensHeight, 30, 100, (v) => setState(() => _lensHeight = v)),
                                      _buildSlider("Width", _lensWidth, 30, 100, (v) => setState(() => _lensWidth = v)),
                                      _buildSlider("Corner Radius", _lensBorderRadius, 0, 50, (v) => setState(() => _lensBorderRadius = v)), // New Slider
                                      _buildSlider("Glassiness", _lensGlassiness, 0.0, 2.0, (v) => setState(() => _lensGlassiness = v)),
                                      _buildSlider("Warp Speed", _velocityRefraction, 0.0, 0.5, (v) => setState(() => _velocityRefraction = v)),
                                      _buildSlider("Motion Blur", _lensMotionBlur, 0.0, 30.0, (v) => setState(() => _lensMotionBlur = v)),
                                      _buildSlider("Lens Refraction", _lensRefraction, 0.5, 3.0, (v) => setState(() => _lensRefraction = v)),
                                      const SizedBox(height: 10),
                                      _buildSection("Physics"),
                                      Wrap(
                                        spacing: 8,
                                        runSpacing: 8,
                                        children: GlassAnimation.values.map((e) => _buildChip(e.name, e == _anim, () => setState(() => _anim = e))).toList(),
                                      ),
                                    ],
                                    
                                    if (_currentTab == 3) ...[
                                      _buildSection("Item Style"),
                                      _buildSlider("Icon Size", _iconSize, 12, 48, (v) => setState(() => _iconSize = v)),
                                      _buildSlider("Font Size", _fontSize, 8, 24, (v) => setState(() => _fontSize = v)),
                                      const SizedBox(height: 10),
                                      _buildSection("Interaction"),
                                      Wrap(
                                        spacing: 8,
                                        children: GlassActiveItemAnimation.values.map((e) => _buildChip(e.name, e == _activeAnim, () => setState(() => _activeAnim = e))).toList(),
                                      ),
                                      const SizedBox(height: 20),
                                      _buildSection("Theme"),
                                      Wrap(
                                        spacing: 20,
                                        runSpacing: 20,
                                        alignment: WrapAlignment.spaceBetween,
                                        children: [
                                          Column(
                                            crossAxisAlignment: CrossAxisAlignment.start,
                                            children: [
                                              const Text("Accent", style: TextStyle(color: Colors.white30, fontSize: 10)),
                                              const SizedBox(height: 5),
                                              Wrap(
                                                spacing: 5, runSpacing: 5,
                                                children: [
                                                  _buildColorDot(Colors.cyanAccent),
                                                  _buildColorDot(Colors.purpleAccent),
                                                  _buildColorDot(Colors.orangeAccent),
                                                  _buildColorDot(Colors.transparent, isCustom: true),
                                                ],
                                              ),
                                            ],
                                          ),
                                          Column(
                                            crossAxisAlignment: CrossAxisAlignment.start,
                                            children: [
                                              const Text("Base", style: TextStyle(color: Colors.white30, fontSize: 10)),
                                              const SizedBox(height: 5),
                                              Wrap(
                                                spacing: 5, runSpacing: 5,
                                                children: [
                                                  _buildColorDot(Colors.white, isBar: true),
                                                  _buildColorDot(Colors.black, isBar: true),
                                                  _buildColorDot(Colors.blueGrey[900]!, isBar: true),
                                                  _buildColorDot(Colors.transparent, isBar: true, isCustom: true),
                                                ],
                                              ),
                                            ],
                                          ),
                                        ],
                                      ),
                                      const SizedBox(height: 10),
                                      _buildSlider("Base Opacity", _opacity, 0.0, 0.8, (v) => setState(() => _opacity = v)),
                                    ]
                                  ],
                                ),
                              ),
                            ),
                          ],
                        ),
                      ),
                    ),
                  ),
                ),
              ],
            ),
          ),
          
          if (_hideControls)
            Positioned(
              bottom: 20, right: 20,
              child: FloatingActionButton(
                backgroundColor: Colors.white24,
                child: const Icon(Icons.tune, color: Colors.white),
                onPressed: () => setState(() => _hideControls = false),
              ),
            ),
        ],
      ),
    );
  }
  
  IconData _getBgIcon(BackgroundType t) {
    switch(t) {
      case BackgroundType.lava: return Icons.bubble_chart;
      case BackgroundType.grid: return Icons.grid_on;
      case BackgroundType.neon: return Icons.blur_linear;
      case BackgroundType.checker: return Icons.apps;
      case BackgroundType.aurora: return Icons.waves;
      case BackgroundType.cyberGrid: return Icons.grid_4x4;
      case BackgroundType.starField: return Icons.star_border;
      case BackgroundType.deepOcean: return Icons.water;
      case BackgroundType.meshGradient: return Icons.gradient;
      case BackgroundType.hexHive: return Icons.hexagon_outlined;
      case BackgroundType.rainyGlass: return Icons.water_drop;
      case BackgroundType.bokehNight: return Icons.lens_blur;
      case BackgroundType.matrixRain: return Icons.code;
      case BackgroundType.geometricAbstract: return Icons.change_history;
      case BackgroundType.noiseGrain: return Icons.grain;
    }
  }
  
  Widget _buildTab(int index, String title, IconData icon) {
    final bool isSelected = _currentTab == index;
    return GestureDetector(
      onTap: () => setState(() => _currentTab = index),
      child: Container(
        padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 8),
        decoration: BoxDecoration(
          color: isSelected ? Colors.white24 : Colors.transparent,
          borderRadius: BorderRadius.circular(20),
          border: Border.all(color: isSelected ? Colors.white54 : Colors.white10),
        ),
        child: Row(
          children: [
            Icon(icon, size: 16, color: isSelected ? Colors.white : Colors.white54),
            const SizedBox(width: 8),
            Text(title, style: TextStyle(color: isSelected ? Colors.white : Colors.white54, fontWeight: isSelected ? FontWeight.bold : FontWeight.normal)),
          ],
        ),
      ),
    );
  }

  Widget _buildSection(String title) {
    return Padding(
      padding: const EdgeInsets.only(bottom: 15, top: 4),
      child: Text(title.toUpperCase(), style: const TextStyle(color: Colors.white30, fontSize: 11, letterSpacing: 1.5, fontWeight: FontWeight.bold)),
    );
  }
  
  Widget _buildSlider(String label, double val, double min, double max, ValueChanged<double> changed) {
    return Column(
      children: [
        Row(
           mainAxisAlignment: MainAxisAlignment.spaceBetween,
           children: [
             Text(label, style: const TextStyle(color: Colors.white70, fontSize: 12)),
             Text(val.toStringAsFixed(1), style: const TextStyle(color: Colors.white30, fontSize: 11)),
           ],
        ),
        SizedBox(
          height: 30,
          child: Slider(
            value: val, min: min, max: max, onChanged: changed, 
            activeColor: _activeColor, 
            inactiveColor: Colors.white10
          ),
        ),
      ],
    );
  }
  
  Widget _buildChip(String label, bool selected, VoidCallback onTap) {
    return GestureDetector(
      onTap: onTap,
       child: AnimatedContainer(
        duration: const Duration(milliseconds: 200),
        padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 8),
        decoration: BoxDecoration(
          color: selected ? _activeColor : Colors.white10,
          borderRadius: BorderRadius.circular(20),
          border: Border.all(color: selected ? _activeColor : Colors.white24),
        ),
        child: Row(
          mainAxisSize: MainAxisSize.min,
          children: [
            if (selected) ...[
               const Icon(Icons.check, size: 14, color: Colors.black),
               const SizedBox(width: 4),
            ],
            Text(
              label.replaceAll("GlassAnimation.", "").replaceAll("GlassActiveItemAnimation.", ""),
              style: TextStyle(
                color: selected ? Colors.black : Colors.white70,
                fontSize: 12,
                fontWeight: selected ? FontWeight.bold : FontWeight.normal,
              ),
            ),
          ],
        ),
      ),
    );
  }
  

  
  Widget _buildPresetCard(_Preset p) {
    return GestureDetector(
      onTap: () => _applyPreset(p),
      child: Container(
        width: 100, // Reduced from 150 to fit generic screen
        padding: const EdgeInsets.all(12),
        decoration: BoxDecoration(
          gradient: LinearGradient(colors: [Colors.white10, Colors.white.withOpacity(0.05)]),
          borderRadius: BorderRadius.circular(16),
          border: Border.all(color: Colors.white12),
        ),
        child: Column(
          children: [
            Icon(p.icon, color: Colors.white70),
            const SizedBox(height: 8),
            Text(p.name, style: const TextStyle(color: Colors.white, fontSize: 12, fontWeight: FontWeight.bold), textAlign: TextAlign.center),
          ],
        ),
      ),
    );
  }
  
  Widget _buildBackground() {
    return AnimatedBuilder(
      animation: _bgController,
      builder: (_, __) {
        final t = _bgController.value * 2 * math.pi;
        
        switch(_bgType) {
          case BackgroundType.lava:
            return Stack(
              children: [
                Container(color: Colors.black),
                Align(alignment: Alignment(math.sin(t), math.cos(t)), child: Container(width: 400, height: 400, decoration: BoxDecoration(shape: BoxShape.circle, color: Colors.blue.withOpacity(0.4), boxShadow: [BoxShadow(color: Colors.blue, blurRadius: 100)]))),
                Align(alignment: Alignment(math.cos(t*0.5), math.sin(t*0.8)), child: Container(width: 300, height: 300, decoration: BoxDecoration(shape: BoxShape.circle, color: Colors.purple.withOpacity(0.4), boxShadow: [BoxShadow(color: Colors.purple, blurRadius: 100)]))),
                BackdropFilter(filter: ImageFilter.blur(sigmaX: 50, sigmaY: 50), child: Container(color: Colors.black.withOpacity(0.3))),
              ],
            );
          case BackgroundType.grid:
            return CustomPaint(
              painter: _GridPainter(time: _bgController.value),
              child: Container(),
            );
          case BackgroundType.neon:
             return Stack(
              children: [
                Container(color: const Color(0xFF050510)),
                Positioned(
                  top: 0, left: 0, right: 0,
                  height: 300,
                  child: Container(
                    decoration: BoxDecoration(
                      gradient: LinearGradient(
                        colors: [Colors.cyanAccent.withOpacity(0.2), Colors.transparent],
                        begin: Alignment.topCenter, end: Alignment.bottomCenter
                      )
                    ),
                  ),
                ),
                 Align(alignment: Alignment(math.sin(t*2), 0), child: Container(width: 50, height: double.infinity, decoration: BoxDecoration(gradient: LinearGradient(colors: [Colors.transparent, Colors.pink.withOpacity(0.1), Colors.transparent])))),
              ]
             );
          case BackgroundType.checker:
             return Container(
               color: Colors.grey[900],
               child: CustomPaint(painter: _CheckerPainter(), child: Container()),
             );
          case BackgroundType.aurora:
            return CustomPaint(painter: AuroraPainter(time: _bgController.value * 2 * math.pi), size: Size.infinite);
          case BackgroundType.cyberGrid:
            return CustomPaint(painter: CyberGridPainter(time: _bgController.value), size: Size.infinite);
          case BackgroundType.starField:
            return CustomPaint(painter: StarFieldPainter(time: _bgController.value), size: Size.infinite);
          case BackgroundType.deepOcean:
            return CustomPaint(painter: DeepOceanPainter(time: _bgController.value * 2 * math.pi), size: Size.infinite);
          case BackgroundType.meshGradient:
            return CustomPaint(painter: MeshGradientPainter(time: _bgController.value * 2 * math.pi), size: Size.infinite);
          case BackgroundType.hexHive:
            return CustomPaint(painter: HexHivePainter(time: _bgController.value * 2 * math.pi), size: Size.infinite);
          case BackgroundType.rainyGlass:
            return CustomPaint(painter: RainyGlassPainter(time: _bgController.value * 100), size: Size.infinite);
          case BackgroundType.bokehNight:
            return CustomPaint(painter: BokehNightPainter(time: _bgController.value * 2 * math.pi), size: Size.infinite);
          case BackgroundType.matrixRain:
            return CustomPaint(painter: MatrixRainPainter(time: _bgController.value), size: Size.infinite);
          case BackgroundType.geometricAbstract:
            return CustomPaint(painter: GeometricAbstractPainter(time: _bgController.value * 2 * math.pi), size: Size.infinite);
          case BackgroundType.noiseGrain:
            return CustomPaint(painter: NoiseGrainPainter(time: _bgController.value), size: Size.infinite);
        }
      },
    );
  }
}

class _GridPainter extends CustomPainter {
  final double time;
  _GridPainter({required this.time});
  @override
  void paint(Canvas canvas, Size size) {
    final Paint paint = Paint()..color = Colors.greenAccent.withOpacity(0.2)..strokeWidth = 1.0;
    const double step = 40.0;
    // Moving grid
    final double offset = time * step;
    
    for (double x = 0; x < size.width; x += step) {
      canvas.drawLine(Offset(x, 0), Offset(x, size.height), paint);
    }
    for (double y = -step + (offset%step); y < size.height; y += step) {
      canvas.drawLine(Offset(0, y), Offset(size.width, y), paint);
    }
  }
  @override
  bool shouldRepaint(covariant _GridPainter old) => old.time != time;
}

class _CheckerPainter extends CustomPainter {
  @override
  void paint(Canvas canvas, Size size) {
    final Paint p1 = Paint()..color = Colors.white10;
    final Paint p2 = Paint()..color = Colors.black12;
    const double sizeSq = 20;
    for (double y = 0; y < size.height; y += sizeSq) {
      for (double x = 0; x < size.width; x += sizeSq) {
        canvas.drawRect(Rect.fromLTWH(x, y, sizeSq, sizeSq), ((x/sizeSq).floor() + (y/sizeSq).floor()) % 2 == 0 ? p1 : p2);
      }
    }
  }
  @override
  bool shouldRepaint(covariant CustomPainter old) => false;
}

// =============================================================================
// SCENARIO 5: LUXURY FASHION (Square Lens, Gold, Heavy)
// =============================================================================
class LuxuryFashionPage extends StatefulWidget {
  final ValueChanged<int> onSwitchScenario;
  const LuxuryFashionPage({super.key, required this.onSwitchScenario});

  @override
  State<LuxuryFashionPage> createState() => _LuxuryFashionPageState();
}

class _LuxuryFashionPageState extends State<LuxuryFashionPage> {
  int _index = 0;

  @override
  Widget build(BuildContext context) {
    return Theme(
      data: ThemeData.light(),
      child: Scaffold(
        backgroundColor: const Color(0xFFFDFDFD),
        body: Stack(
          children: [
            // Content
            ListView(
              padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 60),
              children: [
                Center(child: Text("VOGUE", style: TextStyle(fontFamily: 'Serif', fontSize: 36, letterSpacing: 5, fontWeight: FontWeight.bold, color: Colors.black))),
                const SizedBox(height: 40),
                _buildFashionItem("https://images.unsplash.com/photo-1539109136881-3be0616acf4b?auto=format&fit=crop&q=80&w=800", "Autumn Collection"),
                _buildFashionItem("https://images.unsplash.com/photo-1548232979-6c557ee14752?auto=format&fit=crop&q=80&w=800", "Accessories"),
                _buildFashionItem("https://images.unsplash.com/photo-1515886657613-9f3515b0c78f?auto=format&fit=crop&q=80&w=800", "New Arrivals"),
              ],
            ),
            
             // Menu Button
             Positioned(
               top: 50, 
               right: 20, 
               child: IconButton(
                 icon: const Icon(Icons.grid_view_rounded, color: Colors.black, size: 28),
                 onPressed: () => showScenarioPicker(context, widget.onSwitchScenario),
               ),
             ),

            // Luxury Navbar
            Align(
              alignment: Alignment.bottomCenter,
              child: Padding(
                padding: const EdgeInsets.only(bottom: 30, left: 30, right: 30),
                child: GlassNavBar(
                  height: 80,
                  blur: 7,
                  opacity: 0.05,
                  refraction: 1.1,
                  selectedIndex: _index,
                  onItemSelected: (i) => setState(() => _index = i),
                  backgroundColor: Colors.white,
                  selectedItemColor: const Color.fromARGB(255, 224, 122, 27), // Gold
                  unselectedItemColor: const Color.fromARGB(137, 255, 255, 255),
                  showLabels: true,
                  
                  // CUSTOMIZATION:
                  // Square-ish shape for lens
                  lensWidth: 70, // Wider to frame content
                  lensBorderRadius: BorderRadius.circular(16), // Rounded Rect
                  lensBorderColor: const Color(0xFFC5A000), // Gold Rim
                  //lensBlur: 5, // Frosted lens
                  glassiness: 1.1,
                  
                  // Heavy, expensive feel
                  animationEffect: GlassAnimation.heavyGlass,
                  
                  items: [
                    GlassNavBarItem(icon: Icons.storefront, title: "Shop"),
                    GlassNavBarItem(icon: Icons.search, title: "Search"),
                    GlassNavBarItem(icon: Icons.shopping_bag_outlined, title: "Bag"),
                    GlassNavBarItem(icon: Icons.favorite_border, title: "Wishlist"),
                  ],
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
  
  Widget _buildFashionItem(String url, String title) {
    return Padding(
      padding: const EdgeInsets.only(bottom: 30),
      child: Column(
        children: [
          Container(
            height: 350,
            decoration: BoxDecoration(
              image: DecorationImage(image: NetworkImage(url), fit: BoxFit.cover),
            ),
          ),
          const SizedBox(height: 10),
          Text(title.toUpperCase(), style: const TextStyle(letterSpacing: 2, fontSize: 16)),
        ],
      ),
    );
  }
}

// =============================================================================
// SCENARIO 6: GAMER HUB (Neon, Bouncy, Dark)
// =============================================================================
class GamerHubPage extends StatefulWidget {
  final ValueChanged<int> onSwitchScenario;
  const GamerHubPage({super.key, required this.onSwitchScenario});

  @override
  State<GamerHubPage> createState() => _GamerHubPageState();
}

class _GamerHubPageState extends State<GamerHubPage> {
  int _index = 2;

  @override
  Widget build(BuildContext context) {
    return Theme(
      data: ThemeData.dark(),
      child: Scaffold(
        backgroundColor: const Color(0xFF0D0D15),
        body: Stack(
          children: [
             // Bg
             Positioned.fill(
                child: Container(
                  decoration: const BoxDecoration(
                    gradient: LinearGradient(
                      begin: Alignment.topCenter, end: Alignment.bottomCenter,
                      colors: [Color(0xFF0D0D15), Color(0xFF151522)],
                    )
                  ),
                ),
             ),
             
             Center(
               child: Column(
                 mainAxisAlignment: MainAxisAlignment.center,
                 children: [
                    Container(
                      width: 120, height: 120,
                      decoration: const BoxDecoration(
                        shape: BoxShape.circle,
                        boxShadow: [BoxShadow(color: Colors.purpleAccent, blurRadius: 50)],
                        gradient: LinearGradient(colors: [Colors.purple, Colors.blue])
                      ),
                      child: const Icon(Icons.videogame_asset, size: 60, color: Colors.white),
                    ),
                    const SizedBox(height: 30),
                    const Text("LEVEL UP", style: TextStyle(color: Colors.white, fontSize: 40, fontWeight: FontWeight.w900, fontStyle: FontStyle.italic)),
                    const SizedBox(height: 10),
                    Text("Rank: Diamond", style: TextStyle(color: Colors.cyanAccent.withOpacity(0.7), letterSpacing: 2)),
                 ],
               ),
             ),
             
             // Menu Button
             Positioned(
               top: 50, 
               right: 20, 
               child: IconButton(
                 icon: const Icon(Icons.grid_view_rounded, color: Colors.white, size: 28),
                 onPressed: () => showScenarioPicker(context, widget.onSwitchScenario),
               ),
             ),

            // Gamer Navbar
            Align(
              alignment: Alignment.bottomCenter,
              child: Padding(
                padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 30),
                child: GlassNavBar(
                  height: 75,
                  blur: 20,
                  opacity: 0.1,
                  borderRadius: BorderRadius.circular(20),
                  selectedIndex: _index,
                  onItemSelected: (i) => setState(() => _index = i),
                  backgroundColor: Colors.black,
                  selectedItemColor: Colors.cyanAccent,
                  unselectedItemColor: Colors.white30,
                  
                  // CUSTOMIZATION:
                  lensWidth: 60,
                  lensBorderColor: Colors.cyanAccent.withOpacity(0.5), // Neon Border
                  glassiness: 1.5, // Shiny
                  
                  // Bouncy Physics
                  animationEffect: GlassAnimation.bouncyWater,
                  
                  items: [
                     GlassNavBarItem(icon: Icons.home, title: "Home"),
                     GlassNavBarItem(icon: Icons.chat_bubble_outline, title: "Chat"),
                     GlassNavBarItem(icon: Icons.gamepad, title: "Play"),
                     GlassNavBarItem(icon: Icons.people_outline, title: "Friends"),
                     GlassNavBarItem(icon: Icons.notifications_none, title: "Alerts"),
                  ],
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
