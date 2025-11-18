import 'package:burhan_sigma_sport/models/product_entry.dart';
import 'package:flutter/material.dart';

class ProductDetailPage extends StatelessWidget {
  final ProductEntry product;

  const ProductDetailPage({super.key, required this.product});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text('Product Detail')),
      body: SingleChildScrollView(
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            // 1. Bagian Gambar (Thumbnail)
            // Menampilkan gambar penuh di bagian atas halaman
            if (product.thumbnail.isNotEmpty)
              Image.network(
                product.thumbnail,
                width: double.infinity,
                height: 300, // Ukuran gambar lebih besar untuk detail
                fit: BoxFit.cover,
                errorBuilder: (context, error, stackTrace) {
                  return Container(
                    height: 300,
                    color: Colors.grey[300],
                    child: const Center(
                      child: Icon(
                        Icons.broken_image,
                        size: 60,
                        color: Colors.grey,
                      ),
                    ),
                  );
                },
              )
            else
              Container(
                height: 300,
                width: double.infinity,
                color: Colors.grey[300],
                child: const Center(
                  child: Icon(
                    Icons.image_not_supported,
                    size: 60,
                    color: Colors.grey,
                  ),
                ),
              ),

            // 2. Bagian Konten Detail
            Padding(
              padding: const EdgeInsets.all(16.0),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  // Nama Produk
                  Text(
                    product.name,
                    style: const TextStyle(
                      fontWeight: FontWeight.bold,
                      fontSize: 24,
                    ),
                  ),

                  const SizedBox(height: 16),

                  // Baris Badge (Harga, Kategori, Brand)
                  Wrap(
                    spacing: 8.0,
                    runSpacing: 8.0,
                    children: [
                      // Badge Harga
                      _buildBadge(
                        text: "Rp ${product.price}",
                        color: Colors.green,
                        icon: Icons.attach_money,
                      ),
                      // Badge Kategori
                      _buildBadge(
                        text: product.category,
                        color: Colors.blue,
                        icon: Icons.category,
                      ),
                      // Badge Brand
                      _buildBadge(
                        text: product.brand,
                        color: Colors.orange,
                        icon: Icons.branding_watermark,
                      ),
                      // Badge Featured (Jika ada)
                      if (product.isFeatured)
                        _buildBadge(
                          text: "Featured",
                          color: Colors.amber,
                          icon: Icons.star,
                          textColor: Colors.white,
                          fillColor: Colors.amber[700],
                        ),
                    ],
                  ),

                  const SizedBox(height: 24),

                  // Label Deskripsi
                  const Text(
                    "Description",
                    style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
                  ),
                  const SizedBox(height: 8),

                  // Isi Deskripsi
                  Text(
                    product.description,
                    style: const TextStyle(
                      fontSize: 16,
                      height: 1.5, // Spasi antar baris agar lebih mudah dibaca
                    ),
                    textAlign: TextAlign.justify,
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }

  // Helper method untuk membuat badge/chip kecil
  Widget _buildBadge({
    required String text,
    required Color color,
    required IconData icon,
    Color? textColor,
    Color? fillColor,
  }) {
    return Container(
      padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 6),
      decoration: BoxDecoration(
        color: fillColor ?? color.withOpacity(0.1),
        borderRadius: BorderRadius.circular(8),
        border: Border.all(color: fillColor ?? color),
      ),
      child: Row(
        mainAxisSize: MainAxisSize.min,
        children: [
          Icon(icon, size: 16, color: textColor ?? color),
          const SizedBox(width: 4),
          Text(
            text,
            style: TextStyle(
              color: textColor ?? color,
              fontWeight: FontWeight.bold,
              fontSize: 14,
            ),
          ),
        ],
      ),
    );
  }
}
