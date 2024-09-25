import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:url_launcher/url_launcher.dart';
import 'package:web_portofolio/style/color_style.dart';
import 'package:web_portofolio/style/text_sttyle.dart';

class ServiceCardWidget extends StatefulWidget {
  final String title;
  final String description;

  const ServiceCardWidget(
      {super.key, required this.title, required this.description});

  @override
  State<ServiceCardWidget> createState() => _ServiceCardWidgetState();
}

class _ServiceCardWidgetState extends State<ServiceCardWidget> {
  @override
  Widget build(BuildContext context) {
    return Container(
      width:
          MediaQuery.of(context).size.width * 0.9, // Mengambil 90% lebar layar
      constraints: BoxConstraints(
        minHeight: 200, // Batas minimal tinggi container
        maxWidth:
            600, // Batas maksimal lebar container agar tidak terlalu besar
      ),
      padding: EdgeInsets.all(16), // Padding tetap
      decoration: BoxDecoration(
        color: Color(0xFF2F4F4F), // Warna abu-abu gelap
        borderRadius: BorderRadius.circular(12), // Sudut melengkung
      ),
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        crossAxisAlignment: CrossAxisAlignment.center,
        children: [
          Text(
            widget.title,
            style: GoogleFonts.roboto(
              fontSize: 24,
              fontWeight: FontWeight.bold,
              color: Colors.white, // Warna teks putih
            ),
          ),
          SizedBox(height: 10),
          Text(
            widget.description,
            textAlign: TextAlign.center, // Agar teks berada di tengah
            style: GoogleFonts.roboto(
              fontSize: MediaQuery.of(context).size.width > 600
                  ? 16
                  : 14, // Sesuaikan ukuran teks
              color: Colors.white70, // Warna teks putih sedikit lebih terang
            ),
          ),
        ],
      ),
    );
  }
}

class AppCardWidget extends StatelessWidget {
  final String name;
  final String date;
  final String description;
  final String buildMethod;

  final String image; // Parameter untuk gambar
  final Function() onTap;
  final Function() onPress;

  const AppCardWidget({
    Key? key,
    required this.onPress,
    required this.buildMethod,
    required this.onTap,
    required this.name,
    required this.date,
    required this.description,
    required this.image,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: onTap, // Menambahkan fungsionalitas tap
      child: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Row(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            // Gambar aplikasi
            SizedBox(
              width: 500,
              child: Image.asset(
                image, // Menggunakan parameter gambar
              ),
            ),
            const SizedBox(width: 40),
            // Informasi aplikasi
            Expanded(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(name, style: FontFamily.title), // Menampilkan nama
                  const SizedBox(height: 4),
                  Text(date,
                      style: FontFamily.reguler
                          .copyWith(color: Colors.grey)), // Menampilkan tanggal
                  const SizedBox(height: 12),
                  SizedBox(
                    child: Text(
                      description, // Menampilkan deskripsi
                      style: FontFamily.reguler,
                    ),
                  ),
                  const SizedBox(height: 12),
                  SizedBox(
                    child: Text(
                      "Buiild with: $buildMethod", // Menampilkan metode pembangunan
                      style: FontFamily.reguler,
                    ),
                  ),
                  const SizedBox(height: 12),
                  // Tautan atau tombol lebih lanjut
                  Align(
                    alignment: Alignment.bottomRight,
                    child: SizedBox(
                      height: 48,
                      width: 200,
                      child: ElevatedButton(
                        onPressed: onPress, // Teks tombol
                        style: ButtonStyle(
                          // border radius
                          shape:
                              WidgetStateProperty.all<RoundedRectangleBorder>(
                            RoundedRectangleBorder(
                              borderRadius: BorderRadius.circular(8.0),
                            ),
                          ),
                          backgroundColor: WidgetStateProperty.all<Color>(
                              ColorStyle.primary), // Warna tombol
                        ), // Menambahkan fungsionalitas tap
                        child:
                            Text('See Project', style: FontFamily.textButton),
                      ),
                    ),
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}

class ContactWidget extends StatefulWidget {
  final String title;
  final String image;
  final Function() onTap;
  const ContactWidget({
    super.key,
    required this.onTap,
    required this.title,
    required this.image,
  });

  @override
  State<ContactWidget> createState() => _ContactWidgetState();
}

class _ContactWidgetState extends State<ContactWidget> {
  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: widget.onTap,
      child: Row(
        children: [
          SizedBox(
            height: 40,
            child: Image.asset(
              widget.image, // Menggunakan parameter gambar
            ),
          ),
          const SizedBox(width: 12),
          Text(
            widget.title,
            style: FontFamily.reguler,
          ),
        ],
      ),
    );
  }
}
