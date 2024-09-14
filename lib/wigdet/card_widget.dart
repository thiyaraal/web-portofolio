import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

class ServiceCardWidget extends StatefulWidget {
  final String title;
  final String description;

  const ServiceCardWidget({super.key, required this.title, required this.description});
  
  
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
