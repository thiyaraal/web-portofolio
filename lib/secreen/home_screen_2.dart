import 'package:flutter/material.dart';
import 'package:url_launcher/url_launcher.dart';
import 'package:web_portofolio/models/portofolio_models.dart';

class MyPortofolioScreen extends StatefulWidget {
  const MyPortofolioScreen({super.key});

  @override
  State<MyPortofolioScreen> createState() => _MyPortofolioScreenState();
}

class _MyPortofolioScreenState extends State<MyPortofolioScreen> {
  final ScrollController _scrollController = ScrollController();

  MyPortofolioData? myPortofolioData;
  // GlobalKeys for different sections
  final GlobalKey section1Key = GlobalKey();
  final GlobalKey section2Key = GlobalKey();
  final GlobalKey section3Key = GlobalKey();
  final GlobalKey section4Key = GlobalKey();
  final GlobalKey section5Key = GlobalKey();
  bool isActiveApp = true;

  void scrollToSection(GlobalKey key) {
    final context = key.currentContext;
    if (context != null) {
      Scrollable.ensureVisible(context,
          duration: const Duration(milliseconds: 50), curve: Curves.easeInOut);
    }
  }

  void _loadPortfolioData() async {
    String jsonString = await DefaultAssetBundle.of(context)
        .loadString('assets/json/portofolio_data.json');
    setState(() {
      myPortofolioData = myPortofolioDataFromMap(jsonString); // Parsing JSON
    });
  }

  Future<void> _launchURL(String urlString) async {
    try {
      final Uri url = Uri.parse(urlString);
      if (await canLaunchUrl(url)) {
        await launchUrl(url);
      } else {
        throw 'Tidak dapat membuka $urlString';
      }
    } catch (e) {
      throw 'URL tidak valid: $urlString';
    }
  }

  @override
  void initState() {
    super.initState();
    _loadPortfolioData(); // Memuat data JSON saat initState
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('My Portofolio'),
      ),
      body: SingleChildScrollView(
        child: Column(
          children: [
            
          ],
        ),
      ),
    );
  }
}
