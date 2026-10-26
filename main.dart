import 'package:flutter/material.dart';

void main() {
  runApp(MyApp());
}

class MyApp extends StatefulWidget {
  @override
  _MyAppState createState() => _MyAppState();
}

class _MyAppState extends State<MyApp> {
  ThemeMode _themeMode = ThemeMode.light;

  void _toggleTheme() {
    setState(() {
      _themeMode = _themeMode == ThemeMode.light ? ThemeMode.dark : ThemeMode.light;
    });
  }

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      title: 'بكالوريا علمي - سوريا',
      theme: ThemeData(
        brightness: Brightness.light,
        primarySwatch: Colors.indigo,
        scaffoldBackgroundColor: Color(0xFFF8F9FA),
        cardColor: Colors.white,
        fontFamily: 'Cairo',
      ),
      darkTheme: ThemeData(
        brightness: Brightness.dark,
        scaffoldBackgroundColor: Color(0xFF121212),
        cardColor: Color(0xFF1E1E1E),
        primaryColor: Color(0xFFBB86FC),
        fontFamily: 'Cairo',
      ),
      themeMode: _themeMode,
      home: HomeScreen(onToggleTheme: _toggleTheme, isDarkMode: _themeMode == ThemeMode.dark),
    );
  }
}

class HomeScreen extends StatelessWidget {
  final VoidCallback onToggleTheme;
  final bool isDarkMode;

  HomeScreen({required this.onToggleTheme, required this.isDarkMode});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: isDarkMode ? Color(0xFF1E1E1E) : Color(0xFF1E1E2C),
        title: Text('منصة البكالوريا العلمي - سوريا', style: TextStyle(color: Colors.white, fontSize: 16)),
        centerTitle: true,
        actions: [
          IconButton(
            icon: Icon(
              isDarkMode ? Icons.wb_sunny_rounded : Icons.nightlight_round,
              color: isDarkMode ? Colors.amber : Colors.white,
            ),
            onPressed: onToggleTheme,
          ),
        ],
      ),
      body: SingleChildScrollView(
        padding: EdgeInsets.all(16.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceAround,
              children: [
                _buildTopCard(context, Icons.download_rounded, 'التنزيلات', Colors.blue),
                _buildTopCard(context, Icons.book_rounded, 'موادي', Colors.orange),
                _buildTopCard(context, Icons.calendar_month_rounded, 'البرنامج', Colors.indigo),
              ],
            ),
            SizedBox(height: 24),
            Text(
              'ميزات التطبيق الخيري',
              style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
            ),
            SizedBox(height: 12),
            _buildFeatureTile(context, icon: Icons.play_circle_fill_rounded, title: 'شرح كامل المنهاج', subtitle: 'أساتذة يوتيوب المتميزون لكافة المواد', color: Colors.blueAccent),
            _buildFeatureTile(context, icon: Icons.download_done_rounded, title: 'تعلم دون إنترنت', subtitle: 'تنزيل الفيديوهات للدراسة بلا نت', color: Colors.green),
            _buildFeatureTile(context, icon: Icons.date_range_rounded, title: 'البرنامج الدراسي (28 أسبوعاً)', subtitle: 'تنظيم المتابعة اليومية والأسبوعية', color: Colors.deepOrange),
            _buildFeatureTile(context, icon: Icons.quiz_rounded, title: 'اختبارات تثبيت المعلومات', subtitle: 'أسئلة وتصحيح فوري بعد كل درس', color: Colors.purple),
          ],
        ),
      ),
    );
  }

  Widget _buildTopCard(BuildContext context, IconData icon, String title, Color color) {
    bool isDark = Theme.of(context).brightness == Brightness.dark;
    return Container(
      width: 100,
      padding: EdgeInsets.symmetric(vertical: 14),
      decoration: BoxDecoration(
        color: Theme.of(context).cardColor,
        borderRadius: BorderRadius.circular(16),
        boxShadow: [BoxShadow(color: isDark ? Colors.black38 : Colors.black12, blurRadius: 5, offset: Offset(0, 2))],
      ),
      child: Column(
        children: [
          Icon(icon, size: 28, color: color),
          SizedBox(height: 8),
          Text(title, style: TextStyle(fontSize: 13, fontWeight: FontWeight.bold)),
        ],
      ),
    );
  }

  Widget _buildFeatureTile(BuildContext context, {required IconData icon, required String title, required String subtitle, required Color color}) {
    bool isDark = Theme.of(context).brightness == Brightness.dark;
    return Container(
      margin: EdgeInsets.only(bottom: 12),
      decoration: BoxDecoration(
        color: Theme.of(context).cardColor,
        borderRadius: BorderRadius.circular(14),
        boxShadow: [BoxShadow(color: isDark ? Colors.black26 : Colors.black05, blurRadius: 3, offset: Offset(0, 1))],
      ),
      child: ListTile(
        leading: CircleAvatar(backgroundColor: color.withOpacity(0.15), child: Icon(icon, color: color)),
        title: Text(title, style: TextStyle(fontWeight: FontWeight.bold, fontSize: 15)),
        subtitle: Text(subtitle, style: TextStyle(fontSize: 12, color: Colors.grey)),
        trailing: Container(
          padding: EdgeInsets.symmetric(horizontal: 12, vertical: 6),
          decoration: BoxDecoration(color: Colors.orange.shade50.withOpacity(isDark ? 0.2 : 1.0), borderRadius: BorderRadius.circular(20)),
          child: Text('فتح', style: TextStyle(color: Colors.orange.shade800, fontWeight: FontWeight.bold, fontSize: 12)),
        ),
      ),
    );
  }
}
