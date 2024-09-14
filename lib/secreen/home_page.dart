import 'package:flutter/material.dart';
import 'package:web_portofolio/models/portofolio_models.dart';
import 'package:web_portofolio/style/color_style.dart';
import 'package:web_portofolio/style/text_sttyle.dart';
import 'package:web_portofolio/wigdet/card_widget.dart';

class PortfolioPage extends StatefulWidget {
  @override
  _PortfolioPageState createState() => _PortfolioPageState();
}

class _PortfolioPageState extends State<PortfolioPage> {
  final ScrollController _scrollController = ScrollController();

  MyPortofolioData? myPortofolioData;
  // GlobalKeys for different sections
  final GlobalKey section1Key = GlobalKey();
  final GlobalKey section2Key = GlobalKey();
  final GlobalKey section3Key = GlobalKey();
  final GlobalKey section4Key = GlobalKey();

  void scrollToSection(GlobalKey key) {
    final context = key.currentContext;
    if (context != null) {
      Scrollable.ensureVisible(context,
          duration: const Duration(milliseconds: 50), curve: Curves.easeInOut);
    }
  }

  void _loadPortfolioData() async {
    String jsonString = await DefaultAssetBundle.of(context)
        .loadString('assets/Json/portofolio_data.json');
    setState(() {
      myPortofolioData = myPortofolioDataFromMap(jsonString); // Parsing JSON
    });
  }

  @override
  void initState() {
    super.initState();
    _loadPortfolioData(); // Memuat data JSON saat initState
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
                      //size nya setengah layar
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
                        const SizedBox(width: 12),
                        TextButton(
                          onPressed: () => scrollToSection(section2Key),
                          child: Text(
                            'Projects',
                            style: FontFamily.textButton,
                          ),
                        ),
                        const SizedBox(width: 12),
                        TextButton(
                          onPressed: () => scrollToSection(section3Key),
                          child: Text(
                            'Contact',
                            style: FontFamily.textButton,
                          ),
                        ),
                        const SizedBox(width: 12),
                        TextButton(
                          onPressed: () => scrollToSection(section4Key),
                          child: Text(
                            'Footer',
                            style: FontFamily.textButton,
                          ),
                        ),
                        const SizedBox(width: 700),
                        SizedBox(
                          height: 42,
                          child: ElevatedButton(
                            style: ElevatedButton.styleFrom(
                              backgroundColor: ColorStyle.primary,
                              shape: RoundedRectangleBorder(
                                borderRadius: BorderRadius.circular(8),
                              ),
                            ),
                            onPressed: () {},
                            child: Text('Donwload CV',
                                style: FontFamily.textButton),
                          ),
                        )
                      ],
                    ),
                  ),
                  Positioned(
                    left: 40,
                    top: 200,
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        /// dividerdengan panjang 100
                        const SizedBox(
                          width: 100, // Panjang divider
                          child: Divider(
                            color: Color.fromARGB(
                                255, 255, 255, 255), // Warna divider
                            thickness: 2, // Ketebalan divider
                          ),
                        ),
                        const SizedBox(
                            height: 10), // Jarak antara divider dan teks
                        Text(
                          "Hello, I am",
                          style: FontFamily.h1,
                        ),
                        Text(myPortofolioData?.biodata?.name ?? "Your Name",
                            style: FontFamily.h1.copyWith(
                              color: ColorStyle.primary,
                            )),
                        const SizedBox(height: 10),
                        SizedBox(
                          width: 520, // Tentukan lebar maksimal teks
                          child: Text(
                            myPortofolioData?.biodata?.description ??
                                "A brief description about yourself.",
                            style: FontFamily.reguler,
                            softWrap:
                                true, // Memungkinkan teks untuk turun ke baris berikutnya
                            overflow: TextOverflow
                                .visible, // Menghindari pemotongan teks
                          ),
                        ),
                      ],
                    ),
                  ),
                  Positioned(
                    right: 150,
                    bottom: -4,
                    child: Image.asset(
                      'assets/images/Thiyara-bg.png',
                      height: 500,
                    ),
                  )
                ],
              ),
            ),
            Container(
              height: 650,
              key: section2Key,
              color: ColorStyle.background,
              child: Padding(
                padding: const EdgeInsets.all(8.0),
                child: Column(
                  mainAxisAlignment: MainAxisAlignment
                      .start, // or spaceBetween/spaceAround as needed

                  children: [
                    Padding(
                      padding: const EdgeInsets.only(top: 12.0),
                      child: Align(
                        alignment: Alignment.center,
                        child: Text('My Services', style: FontFamily.title),
                      ),
                    ),
                    myPortofolioData == null
                        ? const Center(child: CircularProgressIndicator())
                        : Column(
                            children: [
                              // Top Row of Services
                              Row(
                                mainAxisAlignment:
                                    MainAxisAlignment.spaceEvenly,
                                children: [
                                  ...?myPortofolioData?.services
                                      ?.take(2)
                                      .map((service) => Padding(
                                        padding: const EdgeInsets.all(12.0),
                                        child: ServiceCardWidget(
                                              title: service.name ?? 'No Title',
                                              description: service.description ??
                                                  'No Description',
                                            ),
                                      )),
                                ],
                              ),
                              const SizedBox(height: 20),
                              // Single Service at the Bottom
                              ...?myPortofolioData?.services?.skip(2).map(
                                    (service) => Padding(
                                      padding: const EdgeInsets.all(12.0),
                                      child: ServiceCardWidget(
                                        title: service.name ?? 'No Title',
                                        description: service.description ??
                                            'No Description',
                                      ),
                                    ),
                                  ),
                            ],
                          ),
                  ],
                ),
              ),
            ),
            Container(
              height: 650,
              key: section3Key,
              color: ColorStyle.black,
              child: const Center(child: Text('Contact Section')),
            ),
            Container(
              key: section4Key,
              height: 650,
              color: Colors.black,
              child: const Center(
                  child: Text('Footer Section',
                      style: TextStyle(color: Colors.white))),
            ),
          ],
        ),
      ),
    );
  }
}

class HalfCirclePainter extends CustomPainter {
  @override
  void paint(Canvas canvas, Size size) {
    final paint = Paint()

      /// saya ganti warna dari ColorStyle.accent  dari lib/style/color_style.dart
      ..color = const Color(0xFFF151615)
      ..style = PaintingStyle.fill;

    // Draw a half-circle
    canvas.drawArc(
      Rect.fromLTRB(0, 0, size.width * 2, size.height), // Rect for half-circle
      3.14, // Start angle (π radians = 180 degrees)
      3.14, // Sweep angle (π radians = 180 degrees)
      true, // Use center
      paint,
    );
  }

  @override
  bool shouldRepaint(CustomPainter oldDelegate) => false;
}
