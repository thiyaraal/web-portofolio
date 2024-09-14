import 'package:flutter/material.dart';
import 'package:web_portofolio/models/portofolio_models.dart';
import 'package:web_portofolio/secreen/home_page.dart';
import 'package:web_portofolio/style/color_style.dart';
import 'package:web_portofolio/style/text_sttyle.dart';

class TestScreen extends StatefulWidget {
  @override
  _TestScreenState createState() => _TestScreenState();
}

class _TestScreenState extends State<TestScreen> {
  final ScrollController _scrollController = ScrollController();
  final GlobalKey section1Key = GlobalKey();

  MyPortofolioData? myPortofolioData;

  @override
  void initState() {
    super.initState();
    _loadPortfolioData(); // Memuat data JSON saat initState
  }

  void _loadPortfolioData() async {
    String jsonString = await DefaultAssetBundle.of(context)
        .loadString('assets/Json/portofolio_data.json');
    setState(() {
      myPortofolioData = myPortofolioDataFromMap(jsonString); // Parsing JSON
    });
  }

  void scrollToSection(GlobalKey key) {
    final context = key.currentContext;
    if (context != null) {
      Scrollable.ensureVisible(context,
          duration: const Duration(milliseconds: 50), curve: Curves.easeInOut);
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SingleChildScrollView(
        controller: _scrollController,
        child: Column(
          children: [
            Container(
              key: section1Key,
              height: 650,
              color: Colors.black,
              child: Stack(
                children: [
                  Positioned(
                    right: 50,
                    top: -10,
                    child: CustomPaint(
                      size: const Size(500, 1400),
                      painter: HalfCirclePainter(),
                    ),
                  ),
                  Padding(
                    padding: const EdgeInsets.only(left: 24.0, top: 24),
                    child: Row(
                      children: [
                        TextButton(
                          onPressed: () => scrollToSection(section1Key),
                          child: Text(
                            'Home',
                            style: FontFamily.textButton.copyWith(
                              color: ColorStyle.disable,
                            ),
                          ),
                        ),
                        // Tombol lainnya...
                      ],
                    ),
                  ),
                  // Tampilkan biodata secara dinamis
                  Positioned(
                    left: 40,
                    top: 200,
                    child: myPortofolioData != null
                        ? Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              const SizedBox(
                                width: 100, // Panjang divider
                                child: Divider(
                                  color: Color.fromARGB(
                                      255, 255, 255, 255), // Warna divider
                                  thickness: 2, // Ketebalan divider
                                ),
                              ),
                              const SizedBox(
                                  height: 10), // Jarak divider dan teks
                              Text(
                                "Hello, I am",
                                style: FontFamily.h1,
                              ),
                              Text(
                                myPortofolioData!.biodata?.name ?? "Your Name",
                                style: FontFamily.h1.copyWith(
                                  color: ColorStyle.primary,
                                ),
                              ),
                              const SizedBox(height: 10),
                              Text(
                                myPortofolioData!.biodata?.description ??
                                    "A brief description about yourself.",
                                style: FontFamily.reguler,
                              ),
                              const SizedBox(height: 20),
                              Text(
                                "Contact me at: ${myPortofolioData!.biodata?.email ?? 'email@example.com'}",
                                style: FontFamily.reguler,
                              ),
                            ],
                          )
                        : const CircularProgressIndicator(), // Menampilkan indikator loading saat data belum dimuat
                  ),
                  // Gambar dan elemen lain...
                ],
              ),
            ),
            // Section lainnya...
          ],
        ),
      ),
    );
  }
}
