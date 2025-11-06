# PERTANYAAN

## Tugas 7

1. Jelaskan apa itu widget tree pada Flutter dan bagaimana hubungan parent-child (induk-anak) bekerja antar widget?

-> Widget tree adalah cara Flutter menyusun seluruh antarmuka pengguna (UI) ke dalam sebuah struktur hierarki. Hal ini dapat diibaratkan seperti pohon silsilah dimana setiap widget ialah anggota keluarga dengan satu widget root di paling atas. Nantinya, di dalam pohon ini akan tercipta hubungan parent-child dengan parent adalah widget yang berisi widget lain dan child adalah widget yang ada di dalamnya. Parent bertanggung jawab untuk mengonfigurasi dan menentukan posisi child-nya sementara child menerima konfigurasi tersebut dan membangun dirinya sendiri. Seluruh tata letak, data, dan state akan diimplementasikan dari atas ke bawah (dari parent ke child) melalui pohon ini.

2. Sebutkan semua widget yang kamu gunakan dalam proyek ini dan jelaskan fungsinya!

-> Dalam proyek ini, saya menggunakan MyHomePage dan Scaffold yang menyediakan struktur dasar dengan AppBar di atas. Untuk layout, saya memakai Column untuk menyusun vertikal, Row untuk menyusun horizontal, Padding untuk memberi jarak, SizedBox untuk memberi spasi, Center untuk memberikan posisi tengah, dan GridView untuk menggunakan material. Saya juga menggunakan widget kustom InfoCard dan ItemCard untuk menampilkan data, text untuk menampilkan semua teks, Image.asset untuk gambar, dan Container untuk membungkus elemen di dalam InfoCard dan ItemCard. Terakhir, saya juga menggunakan ScaffoldMessenger untuk menampilkan SnackBar saat item diklik.

3. Apa fungsi dari widget MaterialApp? Jelaskan mengapa widget ini sering digunakan sebagai widget root!

-> MaterialApp adalah widget pembungkus utama yang mengonfigurasi aplikasi agar menggunakan standar material design dari Google. Fungsinya adalah menyediakan banyak fitur level aplikasi, seperti sistem navigasi untuk berpindah halaman, pengaturan tema global, dan lokalisasi. Widget ini sering digunakan sebagai root karena menyediakan layanan yang diperlukan oleh hampir semua widget material design lainnya. Tanpa MaterialApp, maka akan banyak widget umum yang tidak berfungsi dengan benar.

4. Jelaskan perbedaan antara StatelessWidget dan StatefulWidget. Kapan kamu memilih salah satunya?

-> StatelessWidget bersifat immutable yan berimplikasi pada properti dan tampilannya yang tidak dapat berubah setelah widget dibuat. Contohnya adalah Icon, Text, atau ItemCard dimana semua data diterima dari parent dan tidak pernah berubah secara internal. Sementara itu, StatefulWidget bersifat mutable dan dapat berubah selama aplikasi berjalan karena memiliki objek State terpisah yang dapat menyimpan data dan memicu rebuild saat data tersebut berubah. StatelessWidget dapat dipilih untuk UI yang statis sedangkan StatefulWidget dipilih ketika memerlukan pengelolaan data yang berubah secara internal, seperti input pengguna pada TextField atau data yang dimuat dari internet.

5. Apa itu BuildContext dan mengapa penting di Flutter? Bagaimana penggunaannya di metode build?

-> BuildContext adalah alamat unik sebuah widget di dalam widget tree. Hal ini penting karena BuildContext adalah handle yang digunakan untuk menemukan dan berinteraksi dengan widget parent di dalam tree. Di metode build, BuildContext adalah cara mengakses layanan yang disediakan oleh parent, seperti menggunakan Theme.of(context) atau Navigator untuk berpindah halaman. Di dalam kode saya, hal ini digunakan dalam ScaffoldMessenger.of(context) untuk menemukan ScaffoldMessenger terdekat dan menampilkan SnackBar.

6. Jelaskan konsep "hot reload" di Flutter dan bagaimana bedanya dengan "hot restart"!

-> Hot Reload adalah kondisi dimana Flutter menyuntikkan file kode yang telah diubah ke dalam Dart Virtual Machine yang sedang berjalan sehingga state aplikasi saat ini tetap terjaga tanpa me-restart aplikasi dan memungkinkan melihat perubahan UI secara instan. Sebaliknya, Hot Restart akan menghancurkan Dart VM yang ada dan membuat yang baru sehingga akan memulai ulang seluruh aplikasi dari awal. Hot Restart juga akan mengatur ulang semua state aplikasi kembali ke kondisi awal seolah-olah baru ditutup dan membuka kembali aplikasi tersebut.

## Tugas 8

1. Jelaskan perbedaan antara Navigator.push() dan Navigator.pushReplacement() pada Flutter. Dalam kasus apa sebaiknya masing-masing digunakan pada aplikasi Football Shop kamu?

-> Navigator.push() berfungsi untuk menambahkan halaman baru di atas tumpukan navigasi sehingga halaman lama masih ada di bawahnya dan pengguna bisa menekan tombol "kembali". Sebaliknya, Navigator.pushReplacement() berfungsi untuk mengganti halaman saat ini dengan halaman baru sehingga halaman sebelumnya dihapus dari tumpukan dan pengguna tidak bisa kembali. Pada aplikasi saya, push() digunakan saat menekan tombol "Create Product" untuk membuka formulir sehingga pengguna bisa kembali ke halaman utama. Sedangkan pushReplacement() digunakan saat menekan "Halaman Utama" dari drawer untuk mencegah halaman utama menumpuk di atas dirinya sendiri.

2. Bagaimana kamu memanfaatkan hierarchy widget seperti Scaffold, AppBar, dan Drawer untuk membangun struktur halaman yang konsisten di seluruh aplikasi?

-> Saya memanfaatkan hirarki widget dengan Scaffold yang digunakan sebagai kerangka dasar untuk setiap halaman yang menyediakan slot standar untuk elemen umum seperti appBar, body, dan drawer sehingga semua halaman memiliki struktur dasar yang sama. Kemudian, AppBar ditempatkan di dalam slot appBar milik Scaffold dengan properti yang konsisten di setiap halaman. Terakhir, Drawer ditempatkan ke dalam slot drawer milik Scaffold dengan satu file agar navigasi selalu identik dan mudah ditemukan.

3.  Dalam konteks desain antarmuka, apa kelebihan menggunakan layout widget seperti Padding, SingleChildScrollView, dan ListView saat menampilkan elemen-elemen form? Berikan contoh penggunaannya dari aplikasi kamu.

-> Kelebihan utama layout widget adalah menciptakan antarmuka formulir yang rapi, responsif, dan mudah digunakan. Padding digunakan untuk memberi space antar elemen input seperti TextFormField agar tidak menempel di tepi layar. SingleChildScrollView digunakan untuk membungkus seluruh Form serta memastikan semua field tetap bisa diisi dan di-scroll bahkan saat keyboard virtual muncul di layar kecil. ListView berfungsi menyusun semua elemen input dan tombol secara vertikal dengan teratur.

4.Bagaimana kamu menyesuaikan warna tema agar aplikasi Football Shop memiliki identitas visual yang konsisten dengan brand toko?

-> Penyesuaian warna tema dilakukan secara terpusat di dalam widget MaterialApp pada berkas main.dart. Di dalam properti theme ThemeData diatur dan colorScheme juga didefinisikan. Untuk aplikasi saya, saya menggunakan ColorScheme.fromSwatch(primarySwatch: Colors.blue) yang menetapkan warna biru khas aplikasi sebagai warna primer. Warna ini kemudian secara otomatis digunakan oleh widget lain seperti AppBar dan DrawerHeader, sehingga menciptakan identitas visual yang konsisten.
