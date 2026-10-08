import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:url_launcher/url_launcher.dart';

void main() {
  runApp(const KittyProApp());
}

class KittyProApp extends StatelessWidget {
  const KittyProApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'KittyPro',
      debugShowCheckedModeBanner: false,
      theme: ThemeData(
        scaffoldBackgroundColor: const Color(0xFFFFF0F5), // Soft Pink Background
        primaryColor: const Color(0xFFD87093), // Pale Violet / Pink
        colorScheme: ColorScheme.fromSeed(
          seedColor: const Color(0xFFD87093),
          secondary: const Color(0xFFFFFDD0), // Cream
        ),
        fontFamily: 'Roboto',
      ),
      home: const KittyHomeScreen(),
    );
  }
}

class KittyHomeScreen extends StatefulWidget {
  const KittyHomeScreen({super.key});

  @override
  State<KittyHomeScreen> createState() => _KittyHomeScreenState();
}

class _KittyHomeScreenState extends State<KittyHomeScreen> {
  DateTime selectedDate = DateTime.now();
  List<Map<String, String>> currentThemes = [];

  @override
  void initState() {
    super.initState();
    _generateThemesForDate(selectedDate);
  }

  // Date ke hisab se themes generate karne ka logic
  void _generateThemesForDate(DateTime date) {
    int month = date.month;

    // Month categories: Winter/Festive (Nov-Feb), Summer/Floral (Mar-Jun), Monsoon/Desi (Jul-Oct)
    if (month >= 11 || month <= 2) {
      currentThemes = [
        {
          "title": "Royal Velvet Winter",
          "dressCode": "Deep Maroon or Emerald Green",
          "vibe": "Warm, Cozy & Royal",
          "menu": "Gajar ka Halwa, Soup & Paneer Tikka"
        },
        {
          "title": "Glittering Gold & Velvet",
          "dressCode": "Black with Gold Accents",
          "vibe": "Chic, Glamorous & Warm",
          "menu": "Stuffed Mushroom, Sizzlers & Hot Coffee"
        },
        {
          "title": "Bonfire & Cashmere Night",
          "dressCode": "Pastel Woolens & Shawls",
          "vibe": "Relaxed, Talkative & Intimate",
          "menu": "Corn Chaat, Barbeque & Masala Chai"
        },
      ];
    } else if (month >= 3 && month <= 6) {
      currentThemes = [
        {
          "title": "Floral Garden Brunch",
          "dressCode": "Floral Prints & Pastels",
          "vibe": "Fresh, Breezy & Vibrant",
          "menu": "Fruit Salads, Cold Brews & Pasta"
        },
        {
          "title": "Sunset Pastel Soirée",
          "dressCode": "Lavender, Peach or Mint Green",
          "vibe": "Elegantly Relaxed & Open-air",
          "menu": "Mojitos, Bruschetta & Mini Tarts"
        },
        {
          "title": "Tropical Summer Splash",
          "dressCode": "Bright Yellow or Turquoise",
          "vibe": "Fun, Lively & Energetic",
          "menu": "Watermelon Slush, Tacos & Ice Creams"
        },
      ];
    } else {
      currentThemes = [
        {
          "title": "Desi Monsoon Chai Party",
          "dressCode": "Mustard Yellow or Forest Green",
          "vibe": "Cozy, Nostalgic & Chatter-filled",
          "menu": "Hot Pakoras, Samosas & Adrak Chai"
        },
        {
          "title": "Traditional Banarasi Vibe",
          "dressCode": "Silk Sarees with Traditional Jhumkas",
          "vibe": "Classic Indian Cultural Vibe",
          "menu": "Kachori, Imarti & Shikanji"
        },
        {
          "title": "Raindrop High Tea",
          "dressCode": "Pinks and Off-White Pastels",
          "vibe": "Sophisticated & Rain-watching",
          "menu": "Cookies, Finger Sandwiches & Earl Grey Tea"
        },
      ];
    }
  }

  // Date picker open karne ke liye
  Future<void> _selectDate(BuildContext context) async {
    final DateTime? picked = await showDatePicker(
      context: context,
      initialDate: selectedDate,
      firstDate: DateTime(2026),
      lastDate: DateTime(2030),
      builder: (context, child) {
        return Theme(
          data: ThemeData.light().copyWith(
            colorScheme: const ColorScheme.light(
              primary: Color(0xFFD87093),
              onPrimary: Colors.white,
              surface: Color(0xFFFFFDD0),
              onSurface: Colors.black,
            ),
          ),
          child: child!,
        );
      },
    );
    if (picked != null && picked != selectedDate) {
      setState(() {
        selectedDate = picked;
        _generateThemesForDate(selectedDate);
      });
    }
  }

  // WhatsApp par share karne ka function
  Future<void> shareThemeOnWhatsApp(String themeName, String dressCode, String vibe, String menu) async {
    final message = '''
🌸 *Kitty Party Theme Idea* 🌸
✨ *Theme:* $themeName
👗 *Dress Code:* $dressCode
🎨 *Vibe:* $vibe
🍽️ *Menu Idea:* $menu

_Generated via KittyPro_
''';

    final encodedMessage = Uri.encodeComponent(message);
    final whatsappUrl = Uri.parse('whatsapp://send?text=$encodedMessage');
    final webWhatsappUrl = Uri.parse('https://wa.me/?text=$encodedMessage');

    if (await canLaunchUrl(whatsappUrl)) {
      await launchUrl(whatsappUrl);
    } else if (await canLaunchUrl(webWhatsappUrl)) {
      await launchUrl(webWhatsappUrl);
    } else {
      debugPrint('Could not launch WhatsApp');
    }
  }

  @override
  Widget build(BuildContext context) {
    String formattedDate = DateFormat('MMMM dd, yyyy').format(selectedDate);

    return Scaffold(
      appBar: AppBar(
        title: const Text(
          'KittyPro - Party Planner',
          style: TextStyle(color: Colors.white, fontWeight: FontWeight.bold),
        ),
        backgroundColor: const Color(0xFFD87093),
        elevation: 0,
        centerTitle: true,
      ),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            // Date Picker Card
            Card(
              color: const Color(0xFFFFFDD0), // Cream color
              shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(16),
              ),
              elevation: 2,
              child: Padding(
                padding: const EdgeInsets.all(16.0),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        const Text(
                          'Selected Party Date:',
                          style: TextStyle(fontSize: 12, color: Colors.grey),
                        ),
                        const SizedBox(height: 4),
                        Text(
                          formattedDate,
                          style: const TextStyle(
                            fontSize: 18,
                            fontWeight: FontWeight.bold,
                            color: Color(0xFF8B008B),
                          ),
                        ),
                      ],
                    ),
                    ElevatedButton.icon(
                      onPressed: () => _selectDate(context),
                      icon: const Icon(Icons.calendar_today, size: 16, color: Colors.white),
                      label: const Text('Change', style: TextStyle(color: Colors.white)),
                      style: ElevatedButton.styleFrom(
                        backgroundColor: const Color(0xFFD87093),
                        shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(12),
                        ),
                      ),
                    ),
                  ],
                ),
              ),
            ),
            const SizedBox(height: 20),
            const Text(
              'Curated Themes for this Month:',
              style: TextStyle(
                fontSize: 16,
                fontWeight: FontWeight.bold,
                color: Color(0xFF6A5ACD),
              ),
            ),
            const SizedBox(height: 10),
            // Themes List
            Expanded(
              child: ListView.builder(
                itemCount: currentThemes.length,
                itemBuilder: (context, index) {
                  final theme = currentThemes[index];
                  return Card(
                    color: Colors.white,
                    margin: const EdgeInsets.only(bottom: 16),
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(16),
                    ),
                    elevation: 3,
                    child: Padding(
                      padding: const EdgeInsets.all(16.0),
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Row(
                            mainAxisAlignment: MainAxisAlignment.spaceBetween,
                            children: [
                              Text(
                                theme["title"]!,
                                style: const TextStyle(
                                  fontSize: 18,
                                  fontWeight: FontWeight.bold,
                                  color: Color(0xFFD87093),
                                ),
                              ),
                              const Icon(Icons.auto_awesome, color: Color(0xFFDA70D6), size: 20),
                            ],
                          ),
                          const Divider(height: 16),
                          Text('👗 Dress Code: ${theme["dressCode"]}', style: const TextStyle(fontSize: 14)),
                          const SizedBox(height: 6),
                          Text('🎨 Vibe: ${theme["vibe"]}', style: const TextStyle(fontSize: 14)),
                          const SizedBox(height: 6),
                          Text('🍽️ Menu Idea: ${theme["menu"]}', style: const TextStyle(fontSize: 14)),
                          const SizedBox(height: 14),
                          Align(
                            alignment: Alignment.centerRight,
                            child: ElevatedButton.icon(
                              onPressed: () {
                                shareThemeOnWhatsApp(
                                  theme["title"]!,
                                  theme["dressCode"]!,
                                  theme["vibe"]!,
                                  theme["menu"]!,
                                );
                              },
                              icon: const Icon(Icons.share, size: 16, color: Colors.white),
                              label: const Text("Share on WhatsApp", style: TextStyle(fontSize: 12, color: Colors.white)),
                              style: ElevatedButton.styleFrom(
                                backgroundColor: const Color(0xFF25D366), // WhatsApp Green
                                shape: RoundedRectangleBorder(
                                  borderRadius: BorderRadius.circular(20),
                                ),
                                padding: const EdgeInsets.symmetric(horizontal: 14, vertical: 8),
                                elevation: 0,
                              ),
                            ),
                          ),
                        ],
                      ),
                    ),
                  );
                },
              ),
            ),
          ],
        ),
      ),
    );
  }
}
