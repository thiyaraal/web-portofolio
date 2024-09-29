import 'dart:math';

import 'package:flutter/material.dart';
import 'package:url_launcher/url_launcher.dart';
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
                          child: Text('Home', style: FontFamily.textButton),
                        ),
                        const SizedBox(width: 12),
                        TextButton(
                          onPressed: () => scrollToSection(section2Key),
                          child: Text(
                            'Services',
                            style: FontFamily.textButton.copyWith(
                              color: ColorStyle.disable,
                            ),
                          ),
                        ),
                        const SizedBox(width: 12),
                        TextButton(
                          onPressed: () => scrollToSection(section3Key),
                          child: Text(
                            'Projects',
                            style: FontFamily.textButton.copyWith(
                              color: ColorStyle.disable,
                            ),
                          ),
                        ),
                        const SizedBox(width: 12),
                        TextButton(
                          onPressed: () => scrollToSection(section4Key),
                          child: Text(
                            'My Experience',
                            style: FontFamily.textButton.copyWith(
                              color: ColorStyle.disable,
                            ),
                          ),
                        ),
                        const SizedBox(width: 12),
                        TextButton(
                          onPressed: () => scrollToSection(section5Key),
                          child: Text(
                            'Contact',
                            style: FontFamily.textButton.copyWith(
                              color: ColorStyle.disable,
                            ),
                          ),
                        ),
                        const SizedBox(width: 600),
                        SizedBox(
                          height: 42,
                          child: ElevatedButton(
                            style: ElevatedButton.styleFrom(
                              backgroundColor: ColorStyle.primary,
                              shape: RoundedRectangleBorder(
                                borderRadius: BorderRadius.circular(8),
                              ),
                            ),
                            onPressed: () {
                              _launchURL(
                                  myPortofolioData?.biodata?.resume ?? '');
                            },
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
              height: 750,
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
                                              description:
                                                  service.description ??
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
                    Padding(
                      padding: const EdgeInsets.only(top: 12.0, bottom: 12.0),
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: myPortofolioData?.skills?.map((skill) {
                              return Padding(
                                padding: const EdgeInsets.only(
                                    left: 12.0, right: 12.0),
                                child: Column(
                                  children: [
                                    SizedBox(
                                      height: 60,
                                      width: 60,
                                      child: Image.asset(
                                        skill.image ??
                                            'assets/images/default.png', // Default path jika null
                                        height: 500,
                                      ),
                                    ),
                                    Text(
                                      skill.name ??
                                          'Unnamed Skill', // Default text jika null
                                      style: FontFamily.reguler,
                                    ),
                                  ],
                                ),
                              );
                            }).toList() ??
                            [], // Pastikan list tidak null
                      ),
                    )
                  ],
                ),
              ),
            ),
            Container(
              height: 2150, // Tinggi Section 3
              key: section3Key,
              color: ColorStyle.black,
              child: Center(
                child: Stack(
                  alignment:
                      Alignment.center, // Pastikan Stack tersusun di tengah
                  children: [
                    // Circle Background
                    CustomPaint(
                      size: const Size(
                          380, 380), // Ukuran lingkaran bisa disesuaikan
                      painter: FullCirclePainter(),
                    ),

                    // Column with content
                    Padding(
                      padding: const EdgeInsets.all(12.0),
                      child: Column(
                        mainAxisAlignment: MainAxisAlignment.start,
                        children: [
                          myPortofolioData == null
                              ? const Center(child: CircularProgressIndicator())
                              : Column(
                                  children: [
                                    // Align with buttons
                                    Padding(
                                      padding: const EdgeInsets.only(
                                          top: 20.0, right: 12),
                                      child: Align(
                                        alignment: Alignment
                                            .topRight, // Align to top-right
                                        child: Row(
                                          mainAxisSize: MainAxisSize
                                              .min, // Row hanya mengambil ruang yang diperlukan
                                          mainAxisAlignment: MainAxisAlignment
                                              .end, // Dorong tombol ke kanan
                                          children: [
                                            SizedBox(
                                              height: 42,
                                              child: ElevatedButton(
                                                style: ElevatedButton.styleFrom(
                                                  backgroundColor: isActiveApp
                                                      ? ColorStyle
                                                          .primary // Jika aktif, warna tombol utama
                                                      : ColorStyle
                                                          .secondary, // Jika tidak aktif, warna sekunder
                                                  shape: RoundedRectangleBorder(
                                                    borderRadius:
                                                        BorderRadius.circular(
                                                            8),
                                                  ),
                                                ),
                                                onPressed: () {
                                                  setState(() {
                                                    isActiveApp =
                                                        true; // Set tombol "Apps" aktif
                                                  });
                                                },
                                                child: Text(
                                                  'Apps',
                                                  style: isActiveApp
                                                      ? FontFamily.textButton
                                                      : FontFamily
                                                          .textButton, // Gaya teks saat tidak aktif
                                                ),
                                              ),
                                            ),
                                            const SizedBox(width: 12),
                                            SizedBox(
                                              height: 42,
                                              child: ElevatedButton(
                                                style: ElevatedButton.styleFrom(
                                                  backgroundColor: !isActiveApp
                                                      ? ColorStyle
                                                          .primary // Jika aktif, warna tombol utama
                                                      : ColorStyle
                                                          .secondary, // Jika tidak aktif, warna sekunder
                                                  shape: RoundedRectangleBorder(
                                                    borderRadius:
                                                        BorderRadius.circular(
                                                            8),
                                                  ),
                                                ),
                                                onPressed: () {
                                                  setState(() {
                                                    isActiveApp =
                                                        false; // Set tombol "Design" aktif
                                                  });
                                                },
                                                child: Text(
                                                  'Design',
                                                  style: !isActiveApp
                                                      ? FontFamily
                                                          .textButton // Gaya teks saat aktif
                                                      : FontFamily
                                                          .textButton, // Gaya teks saat tidak aktif
                                                ),
                                              ),
                                            ),
                                          ],
                                        ),
                                      ),
                                    ),

                                    // Menampilkan data aplikasi atau desain berdasarkan isActiveApp
                                    ...?isActiveApp
                                        ? myPortofolioData?.projects?.app?.map(
                                            (app) => Padding(
                                              padding:
                                                  const EdgeInsets.all(12.0),
                                              child: AppCardWidget(
                                                onPress: () async {
                                                  await _launchURL(app.link
                                                      .toString()); // Panggil fungsi _launchURL dengan parameter URL
                                                },
                                                buildMethod: (app.buildWith !=
                                                            null &&
                                                        app.buildWith!
                                                            .isNotEmpty)
                                                    ? app.buildWith!.join(', ')
                                                    : 'No Build Method',
                                                image: app.image.toString(),
                                                name: app.name ?? 'no name',
                                                date: app.date ?? 'No Date',
                                                description: app.description ??
                                                    'No Description',
                                                onTap: () {},
                                              ),
                                            ),
                                          )
                                        : myPortofolioData?.projects?.design
                                            ?.map(
                                            (design) => Padding(
                                                padding:
                                                    const EdgeInsets.all(12.0),
                                                child: AppCardWidget(
                                                  onPress: () async {
                                                    await _launchURL(design.link
                                                        .toString()); // Panggil fungsi _launchURL dengan parameter URL
                                                  },
                                                  buildMethod:
                                                      (design.toolsUsed !=
                                                                  null &&
                                                              design.toolsUsed!
                                                                  .isNotEmpty)
                                                          ? design.toolsUsed!
                                                              .join(', ')
                                                          : 'No Build Method',
                                                  image:
                                                      design.image.toString(),
                                                  name:
                                                      design.name ?? 'no name',
                                                  date:
                                                      design.date ?? 'No Date',
                                                  description:
                                                      design.description ??
                                                          'No Description',
                                                  onTap: () {},
                                                )),
                                          ),
                                  ],
                                ),
                        ],
                      ),
                    ),
                  ],
                ),
              ),
            ),
            Container(
              height: 1300,
              key: section4Key,
              color: ColorStyle.black,
              child: Padding(
                padding: const EdgeInsets.all(8.0),
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.start,
                  children: [
                    Padding(
                      padding: EdgeInsets.only(
                          bottom: 12.0, left: 12.0, right: 12.0),
                      child: Column(
                        children: [
                          Align(
                            alignment: Alignment.center,
                            child: Row(
                              children: [
                                Text('My Experiences', style: FontFamily.title),
                                const SizedBox(width: 10),
                                const Expanded(
                                  child: Divider(
                                    color: Colors.tealAccent,
                                    thickness: 1,
                                  ),
                                ),
                              ],
                            ),
                          ),
                          // Tambahkan pengecekan null
                          if (myPortofolioData?.experience != null &&
                              myPortofolioData!.experience!.isNotEmpty)
                            for (var exp in myPortofolioData!.experience!)
                              Padding(
                                padding: const EdgeInsets.all(20.0),
                                child: Container(
                                  width: double.infinity,
                                  decoration: BoxDecoration(
                                    color: ColorStyle.background,
                                    borderRadius: BorderRadius.circular(8),
                                  ),
                                  child: Padding(
                                    padding: const EdgeInsets.all(20.0),
                                    child: Column(
                                      crossAxisAlignment:
                                          CrossAxisAlignment.start,
                                      children: [
                                        if (exp.name !=
                                            null) // Cek null pada exp.name
                                          Text(exp.name!,
                                              style: FontFamily.sub),
                                        if (exp.experienceName != null &&
                                            exp.year != null)
                                          Text(
                                            '${exp.experienceName!} (${exp.year!})', // Gabungkan nama dan rentang tahun
                                            style: FontFamily.italic,
                                          ),
                                        if (exp.description != null)
                                          for (var desc in exp.description!)
                                            Row(
                                              crossAxisAlignment:
                                                  CrossAxisAlignment.start,
                                              children: [
                                                Text(
                                                    '• ', // Simbol bullet atau bisa diganti '*'
                                                    style: FontFamily.reguler),
                                                Expanded(
                                                  child: Text(
                                                    desc,
                                                    style: FontFamily.reguler,
                                                  ),
                                                ),
                                              ],
                                            ),
                                        if (exp.link != null)
                                          const SizedBox(height: 12),
                                        Align(
                                          alignment: Alignment.bottomRight,
                                          child: SizedBox(
                                            height: 48,
                                            width: 200,
                                            child: ElevatedButton(
                                              onPressed: () async {
                                                // ignore: deprecated_member_use
                                                if (await canLaunch(
                                                    exp.link!)) {
                                                  await launch(exp.link!);
                                                }
                                              },
                                              style: ButtonStyle(
                                                shape: WidgetStateProperty.all<
                                                    RoundedRectangleBorder>(
                                                  RoundedRectangleBorder(
                                                    borderRadius:
                                                        BorderRadius.circular(
                                                            8.0),
                                                  ),
                                                ),
                                                backgroundColor:
                                                    WidgetStateProperty.all<
                                                        Color>(
                                                  ColorStyle.primary,
                                                ),
                                              ),
                                              child: Text('See Project',
                                                  style: FontFamily.textButton),
                                            ),
                                          ),
                                        ),
                                      ],
                                    ),
                                  ),
                                ),
                              ),
                        ],
                      ),
                    ),
                  ],
                ),
              ),
            ),
            Container(
              height: 500,
              key: section5Key,
              color: ColorStyle.black,
              child: Padding(
                padding: const EdgeInsets.only(
                  top: 40.0,
                  left: 20,
                ), // Menambahkan padding kanan
                child: Row(
                  children: [
                    Expanded(
                      flex: 1, // Memungkinkan kolom mengambil ruang
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        mainAxisAlignment: MainAxisAlignment.start,
                        children: [
                          Padding(
                            padding:
                                const EdgeInsets.only(top: 12.0, left: 40.0),
                            child: Align(
                              alignment: Alignment.topLeft,
                              child: Column(
                                crossAxisAlignment: CrossAxisAlignment.start,
                                children: [
                                  RichText(
                                    text: TextSpan(
                                      style: FontFamily
                                          .title, // Style untuk teks default
                                      children: <TextSpan>[
                                        TextSpan(
                                            text: "Thank You for Your ",
                                            style: FontFamily.title),
                                        const TextSpan(
                                          text:
                                              "Attention!", // Teks yang ingin diubah warna
                                          style: TextStyle(
                                            color: ColorStyle
                                                .primary, // Ganti dengan warna yang diinginkan
                                          ),
                                        ),
                                      ],
                                    ),
                                  ),
                                  const SizedBox(
                                    height: 12,
                                  ),
                                  Text(
                                    "Get in touch with me",
                                    style: FontFamily.sub.copyWith(
                                      fontSize: 24,
                                    ),
                                  ),
                                  const SizedBox(
                                    height: 12,
                                  ),
                                  SizedBox(
                                    child: Text(
                                      "I'm thrilled to share my experience with you! if you have any questions, want to collaborate, or just want to chat, feel free to reach out.",
                                      style: FontFamily.reguler,
                                      maxLines: 2,
                                    ),
                                  ),
                                  const SizedBox(
                                    height: 40,
                                  ),
                                  Row(
                                    children: [
                                      ContactWidget(
                                        title: 'thiyaraal@gmail.com',
                                        image: myPortofolioData
                                                ?.biodata?.contact
                                                ?.firstWhere((element) =>
                                                    element.email != null)
                                                .image ??
                                            'assets/images/email.png',
                                        onTap: () async {
                                          await _launchURL(myPortofolioData
                                                  ?.biodata?.contact
                                                  ?.firstWhere((element) =>
                                                      element.email != null)
                                                  .email ??
                                              '');
                                        },
                                      ),
                                      const SizedBox(width: 40),
                                      ContactWidget(
                                        title: "thiyaraal",
                                        image: myPortofolioData
                                                ?.biodata?.contact
                                                ?.firstWhere((element) =>
                                                    element.linkedIn != null)
                                                .image ??
                                            'assets/images/linkdln.png',
                                        onTap: () async {
                                          await _launchURL(myPortofolioData
                                                  ?.biodata?.contact
                                                  ?.firstWhere((element) =>
                                                      element.linkedIn != null)
                                                  .linkedIn ??
                                              '');
                                        },
                                      ),
                                    ],
                                  ),
                                  const SizedBox(height: 12),
                                  Row(
                                    children: [
                                      ContactWidget(
                                        title: 'thiyraal',
                                        image: myPortofolioData
                                                ?.biodata?.contact
                                                ?.firstWhere((element) =>
                                                    element.github != null)
                                                .image ??
                                            'assets/images/github.png',
                                        onTap: () async {
                                          await _launchURL(myPortofolioData
                                                  ?.biodata?.contact
                                                  ?.firstWhere((element) =>
                                                      element.github != null)
                                                  .email ??
                                              '');
                                        },
                                      ),
                                      const SizedBox(width: 40),
                                      ContactWidget(
                                        title: "Thiyara Al-Mawaddah",
                                        image: myPortofolioData
                                                ?.biodata?.contact
                                                ?.firstWhere((element) =>
                                                    element.behance != null)
                                                .image ??
                                            'assets/images/behance.png',
                                        onTap: () async {
                                          await _launchURL(myPortofolioData
                                                  ?.biodata?.contact
                                                  ?.firstWhere((element) =>
                                                      element.behance != null)
                                                  .behance ??
                                              '');
                                        },
                                      ),
                                    ],
                                  ),
                                  const SizedBox(height: 12),
                                  ContactWidget(
                                    title: "thiyaraal",
                                    image: myPortofolioData?.biodata?.contact
                                            ?.firstWhere((element) =>
                                                element.instagram != null)
                                            .image ??
                                        'assets/images/instagram.png',
                                    onTap: () async {
                                      await _launchURL(myPortofolioData
                                              ?.biodata?.contact
                                              ?.firstWhere((element) =>
                                                  element.instagram != null)
                                              .instagram ??
                                          '');
                                    },
                                  ),
                                ],
                              ),
                            ),
                          ),
                        ],
                      ),
                    ),
                    // Menggunakan Expanded agar gambar mengisi ruang tersisa
                    Expanded(
                      flex: 1,
                      child: Align(
                        alignment: Alignment
                            .topRight, // Mengatur posisi gambar ke kanan
                        child: Image.asset(
                          'assets/images/bgbottom.png',
                          height: 500,
                        ),
                      ),
                    ),
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

class FullCirclePainter extends CustomPainter {
  @override
  void paint(Canvas canvas, Size size) {
    final paint = Paint()
      ..color = const Color.fromARGB(255, 0, 0, 0) // Warna lingkaran
      ..style = PaintingStyle.fill;

    // Menggambar lingkaran penuh di posisi kiri atas
    canvas.drawCircle(
      const Offset(-320, -850), // Koordinat pusat lingkaran di kiri atas
      size.width / 2, // Radius lingkaran
      paint,
    );

    // Create the blue arc/curve inside the paint method
    final arcPaint = Paint()
      ..color = ColorStyle.primary
      ..strokeWidth = 2 // Line thickness
      ..style = PaintingStyle.stroke; // Outline style for the curve

    // First arc (top half)
    final path1 = Path()
      ..arcTo(
        Rect.fromCircle(
          center: const Offset(-320, -870), // Center of the arc
          radius: 150, // Radius of the arc
        ),
        3.14, // Start angle (π radians or 180 degrees, starting from the left)
        3.14, // Sweep angle (π radians, drawing the top half)
        false,
      );

    // Second arc for one-fourth of a circle, positioned lower
    final path2 = Path()
      ..arcTo(
        Rect.fromCircle(
          center: const Offset(-340, -880), // Lower the center y-coordinate
          radius: 98, // Radius of the arc
        ),
        3.14, // Start angle (π radians or 180 degrees, starting from the left)
        1.57, // Sweep angle (π/2 radians or 90 degrees for one-fourth of a circle)
        false,
      );

    // Draw the arcs
    canvas.drawPath(path1, arcPaint);
    canvas.drawPath(path2, arcPaint);

    // Optional: If you want to add text directly in the painter
    final textPainter = TextPainter(
      text: TextSpan(text: 'My Project', style: FontFamily.title),
      textDirection: TextDirection.ltr,
    );
    textPainter.layout(minWidth: 0, maxWidth: size.width);
    textPainter.paint(
        canvas, const Offset(-390, -950)); // Adjust text position if needed
  }

  @override
  bool shouldRepaint(CustomPainter oldDelegate) => false;
}
