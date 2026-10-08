import 'package:flutter/material.dart';

void main() {
  runApp(const KittyProApp());
}

class KittyProApp extends StatelessWidget {
  const KittyProApp({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      title: 'KittyPro',
      theme: ThemeData(
        brightness: Brightness.light,
        scaffoldBackgroundColor: const Color(0xFFFDFBF7),
        primaryColor: const Color(0xFFD81B60),
        colorScheme: const ColorScheme.light(
          primary: Color(0xFFD81B60),
          secondary: Color(0xFFC79100),
          surface: Color(0xFFFFF0F5),
        ),
      ),
      home: const DateSelectorScreen(),
    );
  }
}

class DateSelectorScreen extends StatefulWidget {
  const DateSelectorScreen({Key? key}) : super(key: key);

  @override
  State<DateSelectorScreen> createState() => _DateSelectorScreenState();
}

class _DateSelectorScreenState extends State<DateSelectorScreen> {
  DateTime selectedDate = DateTime.now();

  Future<void> _selectDate(BuildContext context) async {
    final DateTime? picked = await showDatePicker(
      context: context,
      initialDate: selectedDate,
      firstDate: DateTime(2026),
      lastDate: DateTime(2030),
    );
    if (picked != null && picked != selectedDate) {
      setState(() {
        selectedDate = picked;
      });
    }
  }

  void _generateThemes() {
    Navigator.push(
      context,
      MaterialPageRoute(
        builder: (context) => ThemeResultScreen(partyDate: selectedDate),
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text(
          '✨ KITTY PRO PLANNER ✨',
          style: TextStyle(fontFamily: 'serif', fontWeight: FontWeight.bold, color: Color(0xFF880E4F), fontSize: 18),
        ),
        centerTitle: true,
        backgroundColor: const Color(0xFFF8E1E7),
        elevation: 0,
      ),
      body: Padding(
        padding: const EdgeInsets.all(24.0),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Container(
              padding: const EdgeInsets.all(20),
              decoration: BoxDecoration(
                color: const Color(0xFFFCE4EC),
                shape: BoxShape.circle,
                boxShadow: [
                  BoxShadow(
                    color: Colors.pink.withOpacity(0.1),
                    blurRadius: 15,
                    spreadRadius: 5,
                  ),
                ],
              ),
              child: const Icon(Icons.celebration, size: 70, color: Color(0xFFD81B60)),
            ),
            const SizedBox(height: 30),
            const Text(
              'Select Party Date',
              style: TextStyle(fontSize: 22, fontWeight: FontWeight.bold, color: Color(0xFF4A2E35), fontFamily: 'serif'),
            ),
            const SizedBox(height: 12),
            Container(
              padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 10),
              decoration: BoxDecoration(
                color: Colors.white,
                borderRadius: BorderRadius.circular(12),
                border: Border.all(color: const Color(0xFFF8BBD0)),
              ),
              child: Text(
                '${selectedDate.day} / ${selectedDate.month} / ${selectedDate.year}',
                style: const TextStyle(fontSize: 22, color: Color(0xFFD81B60), fontWeight: FontWeight.bold, fontFamily: 'monospace'),
              ),
            ),
            const SizedBox(height: 30),
            ElevatedButton.icon(
              style: ElevatedButton.styleFrom(
                backgroundColor: const Color(0xFFF48FB1),
                foregroundColor: const Color(0xFF4A2E35),
                elevation: 0,
                padding: const EdgeInsets.symmetric(horizontal: 24, vertical: 12),
                shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(20)),
              ),
              onPressed: () => _selectDate(context),
              icon: const Icon(Icons.calendar_month),
              label: const Text('Pick Date', style: TextStyle(fontSize: 15, fontWeight: FontWeight.bold)),
            ),
            const SizedBox(height: 40),
            SizedBox(
              width: double.infinity,
              child: ElevatedButton(
                style: ElevatedButton.styleFrom(
                  backgroundColor: const Color(0xFFD81B60),
                  foregroundColor: Colors.white,
                  padding: const EdgeInsets.symmetric(vertical: 16),
                  shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(12)),
                  elevation: 2,
                ),
                onPressed: _generateThemes,
                child: const Text('GENERATE 3 THEME IDEAS', style: TextStyle(fontWeight: FontWeight.bold, fontSize: 15, letterSpacing: 1)),
              ),
            ),
          ],
        ),
      ),
    );
  }
}

class ThemeIdea {
  final String title;
  final String dressCode;
  final String vibe;
  final String menuHint;

  ThemeIdea({required this.title, required this.dressCode, required this.vibe, required this.menuHint});
}

class ThemeResultScreen extends StatelessWidget {
  final DateTime partyDate;
  const ThemeResultScreen({Key? key, required this.partyDate}) : super(key: key);

  List<ThemeIdea> _getThemesForMonth(int month) {
    if (month == 1 || month == 12 || month == 2) {
      return [
        ThemeIdea(title: '🔥 Royal Velvet & Bonfire Vibe', dressCode: 'Velvet suits or shawls in Royal Blue / Maroon', vibe: 'Cozy winter evening with warm lighting & soft music', menuHint: 'Soup counter, Sizzlers, & Hot Gulab Jamun'),
        ThemeIdea(title: '✨ Retro Bollywood 90s', dressCode: 'Polka dots, Retro sunglasses, and retro sarees', vibe: 'Classic retro songs, fun antakshari, and photo booth', menuHint: 'Golgappa stall, Pav Bhaji, & Old-school mocktails'),
        ThemeIdea(title: '👑 Royal Mughal Darbar', dressCode: 'Anarkali suits, heavy ethnic jewelry & juttis', vibe: 'Royal table setup with candles, pillows & sheesha props', menuHint: 'Biryani, Shahi Paneer, & Phirni'),
      ];
    } else if (month >= 3 && month <= 6) {
      return [
        ThemeIdea(title: '🌸 Floral Garden Brunch', dressCode: 'Pastel shades, Floral print sarees or flowy dresses', vibe: 'Daylight party with fresh flowers, hats & sunglasses', menuHint: 'Cold brew coffee, Mini sandwiches, & Fruit tarts'),
        ThemeIdea(title: '🌴 Tropical Beach Bash', dressCode: 'Bright tropical colors, Hawaiian shirts, or floral maxis', vibe: 'Vibrant summer mood with shades, mocktails & fun games', menuHint: 'Virgin Mojitos, Pasta, & Exotic Fruit Salad'),
        ThemeIdea(title: '💎 Shimmer & Shine Glam', dressCode: 'Sequins, glitter gowns or shimmer sarees', vibe: 'Glamorous night out with high energy music & spotlight setup', menuHint: 'Starter platter, Brownie with ice cream'),
      ];
    } else {
      return [
        ThemeIdea(title: '🌧️ Monsoon Chai & Pakoda Cafe', dressCode: 'Bright yellow or green comfy ethnic wear', vibe: 'Rain-watching setup with fairy lights, paper boats & music', menuHint: 'Adrak Chai, Pyaz Pakode, & Corn chat'),
        ThemeIdea(title: '🏮 Traditional Desi Bandhani', dressCode: 'Bandhani or Leheriya sarees with traditional bangles', vibe: 'Desi vibe with traditional folk music and tambola game', menuHint: 'Dhokla, Khandvi, & Rabdi Jalebi'),
        ThemeIdea(title: '🎭 Masquerade Mystery Night', dressCode: 'Black & Gold western gown / Indo-western with Masks', vibe: 'Mysterious, elegant, classy candle-light dinner theme', menuHint: 'Paneer Tikka, Italian Pasta, & Mocktails'),
      ];
    }
  }

  @override
  Widget build(BuildContext context) {
    final themes = _getThemesForMonth(partyDate.month);

    return Scaffold(
      appBar: AppBar(
        title: const Text('CURATED PARTY THEMES', style: TextStyle(fontFamily: 'serif', fontSize: 16, color: Color(0xFF880E4F), fontWeight: FontWeight.bold)),
        backgroundColor: const Color(0xFFF8E1E7),
        iconTheme: const IconThemeData(color: Color(0xFF880E4F)),
      ),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: ListView.builder(
          itemCount: themes.length,
          itemBuilder: (context, index) {
            final theme = themes[index];
            return Container(
              margin: const EdgeInsets.only(bottom: 16),
              decoration: BoxDecoration(
                color: Colors.white,
                borderRadius: BorderRadius.circular(16),
                border: Border.all(color: const Color(0xFFF8BBD0).withOpacity(0.6)),
                boxShadow: [
                  BoxShadow(
                    color: Colors.pink.withOpacity(0.04),
                    blurRadius: 10,
                    offset: const Offset(0, 4),
                  ),
                ],
              ),
              child: Padding(
                padding: const EdgeInsets.all(18.0),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      'OPTION ${index + 1}: ${theme.title}',
                      style: const TextStyle(color: Color(0xFFD81B60), fontWeight: FontWeight.bold, fontSize: 16, fontFamily: 'serif'),
                    ),
                    const Divider(color: Color(0xFFFCE4EC), height: 20),
                    Row(
                      children: [
                        const Icon(Icons.checkroom, color: Color(0xFFAD1457), size: 18),
                        const SizedBox(width: 10),
                        Expanded(child: Text('Dress Code: ${theme.dressCode}', style: const TextStyle(color: Color(0xFF4A2E35), fontSize: 13, fontWeight: FontWeight.w500))),
                      ],
                    ),
                    const SizedBox(height: 10),
                    Row(
                      children: [
                        const Icon(Icons.auto_awesome, color: Color(0xFFC79100), size: 18),
                        const SizedBox(width: 10),
                        Expanded(child: Text('Vibe: ${theme.vibe}', style: const TextStyle(color: Color(0xFF6D4C41), fontSize: 13))),
                      ],
                    ),
                    const SizedBox(height: 10),
                    Row(
                      children: [
                        const Icon(Icons.restaurant_menu, color: Color(0xFF2E7D32), size: 18),
                        const SizedBox(width: 10),
                        Expanded(child: Text('Menu Idea: ${theme.menuHint}', style: const TextStyle(color: Color(0xFF6D4C41), fontSize: 13))),
                      ],
                    ),
                  ],
                ),
              ),
            );
          },
        ),
      ),
    );
  }
}