import 'dart:convert';
import 'package:flutter/material.dart';
import 'package:burhan_sigma_sport/screens/menu.dart';
import 'package:burhan_sigma_sport/widgets/left_drawer.dart';
import 'package:pbp_django_auth/pbp_django_auth.dart';
import 'package:provider/provider.dart';

class ProductFormPage extends StatefulWidget {
  const ProductFormPage({super.key});

  @override
  State<ProductFormPage> createState() => _ProductFormPageState();
}

class _ProductFormPageState extends State<ProductFormPage> {
  final _formKey = GlobalKey<FormState>();
  String _name = "";
  String _brand = ""; // Diperbaiki dari file asli agar konsisten
  int _price = 0;
  String _description = "";
  String _category = "Sportswear";
  String _thumbnail = "";
  bool _isFeatured = false;

  final List<String> _categories = [
    'Sportswear',
    'Sports Shoes & Sandals',
    'Sports Accessories',
    'Sports Equipment',
    'Health & Fitness Support',
    'Protective Gear',
  ];

  @override
  Widget build(BuildContext context) {
    final request = context.watch<CookieRequest>();

    return Scaffold(
      appBar: AppBar(
        title: const Center(
          child: Text(
            'Create Product Form',
            style: TextStyle(color: Colors.white, fontWeight: FontWeight.bold),
          ),
        ),
        backgroundColor: Theme.of(context).colorScheme.primary,
        foregroundColor: Colors.white,
      ),
      drawer: const LeftDrawer(),
      body: Form(
        key: _formKey,
        child: SingleChildScrollView(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              // === Nama Produk ===
              Padding(
                padding: const EdgeInsets.all(8.0),
                child: TextFormField(
                  decoration: InputDecoration(
                    hintText: "e.g., Red T-Shirt, Blue Shoes",
                    labelText: "Product Name",
                    border: OutlineInputBorder(
                      borderRadius: BorderRadius.circular(5.0),
                    ),
                  ),
                  onChanged: (String? value) {
                    setState(() {
                      _name = value!;
                    });
                  },
                  validator: (String? value) {
                    if (value == null || value.isEmpty) {
                      return "Product name can't be empty!";
                    }
                    return null;
                  },
                ),
              ),

              // === Brand ===
              Padding(
                padding: const EdgeInsets.all(8.0),
                child: TextFormField(
                  decoration: InputDecoration(
                    hintText: "e.g., Niken, Adadis",
                    labelText: "Brand",
                    border: OutlineInputBorder(
                      borderRadius: BorderRadius.circular(5.0),
                    ),
                  ),
                  onChanged: (String? value) {
                    setState(() {
                      _brand = value!; // Perbaikan: sebelumnya _name
                    });
                  },
                  validator: (String? value) {
                    if (value == null || value.isEmpty) {
                      return "Brand can't be empty!";
                    }
                    return null;
                  },
                ),
              ),

              // === Harga Produk ===
              Padding(
                padding: const EdgeInsets.all(8.0),
                child: TextFormField(
                  decoration: InputDecoration(
                    hintText: "e.g. 150000",
                    labelText: "Price",
                    border: OutlineInputBorder(
                      borderRadius: BorderRadius.circular(5.0),
                    ),
                  ),
                  keyboardType: TextInputType.number,
                  onChanged: (String? value) {
                    setState(() {
                      _price = int.tryParse(value!) ?? 0;
                    });
                  },
                  validator: (String? value) {
                    if (value == null || value.isEmpty) {
                      return "Price can't be empty!";
                    }
                    if (int.tryParse(value) == null) {
                      return "Price must be number or digits!";
                    }
                    return null;
                  },
                ),
              ),

              // === Deskripsi ===
              Padding(
                padding: const EdgeInsets.all(8.0),
                child: TextFormField(
                  maxLines: 5,
                  decoration: InputDecoration(
                    hintText: "e.g. This is a red t-shirt made of cotton",
                    labelText: "Description",
                    border: OutlineInputBorder(
                      borderRadius: BorderRadius.circular(5.0),
                    ),
                  ),
                  onChanged: (String? value) {
                    setState(() {
                      _description = value!;
                    });
                  },
                  validator: (String? value) {
                    if (value == null || value.isEmpty) {
                      return "Description can't be empty!";
                    }
                    return null;
                  },
                ),
              ),

              // === Kategori ===
              Padding(
                padding: const EdgeInsets.all(8.0),
                child: DropdownButtonFormField<String>(
                  decoration: InputDecoration(
                    labelText: "Category",
                    border: OutlineInputBorder(
                      borderRadius: BorderRadius.circular(5.0),
                    ),
                  ),
                  value: _category,
                  items: _categories.map((String category) {
                    return DropdownMenuItem<String>(
                      value: category,
                      child: Text(category),
                    );
                  }).toList(),
                  onChanged: (String? newValue) {
                    setState(() {
                      _category = newValue!;
                    });
                  },
                ),
              ),

              // === Thumbnail URL ===
              Padding(
                padding: const EdgeInsets.all(8.0),
                child: TextFormField(
                  decoration: InputDecoration(
                    hintText: "e.g. https://example.com/image.jpg",
                    labelText: "URL Thumbnail (optional)",
                    border: OutlineInputBorder(
                      borderRadius: BorderRadius.circular(5.0),
                    ),
                  ),
                  onChanged: (String? value) {
                    setState(() {
                      _thumbnail = value!;
                    });
                  },
                ),
              ),

              // === Is Featured ===
              Padding(
                padding: const EdgeInsets.all(8.0),
                child: SwitchListTile(
                  title: const Text("Is Featured Product"),
                  value: _isFeatured,
                  onChanged: (bool value) {
                    setState(() {
                      _isFeatured = value;
                    });
                  },
                  activeColor: Theme.of(context).colorScheme.primary,
                ),
              ),

              // === Tombol Simpan ===
              Align(
                alignment: Alignment.bottomCenter,
                child: Padding(
                  padding: const EdgeInsets.all(8.0),
                  child: ElevatedButton(
                    style: ButtonStyle(
                      backgroundColor: MaterialStateProperty.all(
                        Theme.of(context).colorScheme.primary,
                      ),
                    ),
                    onPressed: () async {
                      if (_formKey.currentState!.validate()) {
                        // Kirim ke Django dan tunggu respons
                        final response = await request.postJson(
                          "https://riyaan-baihaqi-burhansigmasport.pbp.cs.ui.ac.id/create-flutter/",
                          jsonEncode(<String, dynamic>{
                            'name': _name,
                            'brand': _brand,
                            'price': _price.toString(),
                            'description': _description,
                            'category': _category.toLowerCase(),
                            'thumbnail': _thumbnail,
                            'is_featured': _isFeatured,
                          }),
                        );

                        if (context.mounted) {
                          if (response['status'] == 'success') {
                            // === GANTI DARI SNACKBAR KE SHOWDIALOG DI SINI ===
                            showDialog(
                              context: context,
                              builder: (context) {
                                return AlertDialog(
                                  title: const Text('Product Saved'),
                                  content: const Text(
                                    'Produk baru berhasil disimpan!',
                                  ),
                                  actions: [
                                    TextButton(
                                      onPressed: () {
                                        Navigator.pop(context); // Tutup dialog
                                        Navigator.pushReplacement(
                                          context,
                                          MaterialPageRoute(
                                            builder: (context) => MyHomePage(),
                                          ),
                                        ); // Kembali ke Home
                                      },
                                      child: const Text('OK'),
                                    ),
                                  ],
                                );
                              },
                            );
                          } else {
                            ScaffoldMessenger.of(context).showSnackBar(
                              const SnackBar(
                                content: Text(
                                  "Terdapat kesalahan, silakan coba lagi.",
                                ),
                              ),
                            );
                          }
                        }
                      }
                    },
                    child: const Text(
                      "Save",
                      style: TextStyle(color: Colors.white),
                    ),
                  ),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
