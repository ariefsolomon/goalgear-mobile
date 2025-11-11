# GoalGear Mobile

# Tugas 8 | Flutter Navigation, Layouts, Forms, and Input Elements

## Perbedaan antara `Navigator.push()` dan `Navigator.pushReplacement()`

Kedua method ini digunakan untuk melakukan navigasi antar halaman di Flutter, tapi memiliki perilaku yang berbeda dalam mengelola stack halaman.

| Method | Fungsi | Kapan digunakan |
| ------ | ------ | --------------- |
| `Navigator.push()` | Menambahkan halaman baru di atas halaman yang sedang aktif tanpa menghapus halaman sebelumnya dari stack. | Saat user perlu bisa kembali ke halaman sebelumnya dengan tombol **Back**. |
| `Navigator.pushReplacement()` | Mengganti halaman aktif dengan halaman baru, sekaligus menghapus halaman sebelumnya dari stack. | Saat user berpindah antar halaman utama yang tidak perlu bisa kembali, seperti lewat menu Drawer. |

Contoh dalam kode saya:

```dart
Navigator.push(
  context,
  MaterialPageRoute(builder: (context) => const ProductFormPage()),
);
```

Sedangkan pada `LeftDrawer`:

```dart
Navigator.pushReplacement(
  context,
  MaterialPageRoute(builder: (context) => const MyHomePage()),
);
```

Dengan begitu, user bisa kembali ke halaman utama jika masuk lewat tombol, tapi tidak menumpuk halaman saat berpindah melalui drawer.

## Hierarki widget: `Scaffold`, `AppBar`, dan `Drawer`

Ketiga widget ini berperan penting dalam menjaga konsistensi struktur tampilan di seluruh aplikasi.

* `Scaffold` berfungsi sebagai **kerangka utama halaman**, tempat di mana komponen seperti `AppBar`, `Drawer`, dan `body` diletakkan.
* `AppBar` menampilkan **judul aplikasi "GoalGear Mobile"** di bagian atas halaman.
* `Drawer` menyediakan **navigasi antar halaman utama** seperti *Home* dan *Tambah Produk*.

Contoh di kode saya (`menu.dart`):

```dart
return Scaffold(
  appBar: AppBar(
    title: const Text(
      'GoalGear Mobile',
      style: TextStyle(color: Colors.white, fontWeight: FontWeight.bold),
    ),
    backgroundColor: Theme.of(context).colorScheme.primary,
  ),
  drawer: const LeftDrawer(),
  body: Padding(
    padding: const EdgeInsets.all(16.0),
    child: GridView.count(
      crossAxisCount: 3,
      children: items.map((item) => ItemCard(item)).toList(),
    ),
  ),
);
```

Struktur ini membuat tampilan aplikasi seragam di setiap halaman. `Scaffold` memastikan semua halaman memiliki AppBar dan Drawer dengan gaya yang sama.

## Kelebihan layout widget seperti `Padding`, `SingleChildScrollView`, dan `ListView`

Ketiga layout widget ini membantu menjaga tampilan form agar nyaman digunakan di berbagai ukuran layar.

| Widget | Fungsi | Contoh penggunaan |
| -------| ------ | ----------------- |
| `Padding` | Menambahkan jarak antar elemen agar tidak terlalu rapat. | Mengapit `Form` agar input field tidak menempel pada tepi layar. |
| `SingleChildScrollView` | Membuat seluruh halaman bisa di-scroll. Berguna untuk form panjang agar tidak terpotong di layar kecil. | Membungkus semua field di halaman form tambah produk. |
| `ListView` | Menampilkan daftar elemen dalam bentuk list atau grid yang bisa di-scroll otomatis. | Digunakan untuk menampilkan kumpulan tombol pada halaman utama (`GridView.count`). |

Contoh di kode saya (`product_form.dart`):

```dart
return Scaffold(
  appBar: AppBar(title: const Text("Add New Product")),
  drawer: const LeftDrawer(),
  body: SingleChildScrollView(
    child: Padding(
      padding: const EdgeInsets.all(16.0),
      child: Form(
        key: _formKey,
        child: Column(
          children: [
            TextFormField(...),
            TextFormField(...),
            DropdownButtonFormField(...),
            SwitchListTile(...),
            ElevatedButton(...),
          ],
        ),
      ),
    ),
  ),
);
```

## Penyesuaian warna tema aplikasi

Tema aplikasi saya diatur dalam `main.dart` menggunakan `ThemeData` dan `ColorScheme` agar tampilan tetap konsisten di seluruh halaman.

```dart
theme: ThemeData(
  colorScheme: ColorScheme.fromSwatch(
    primarySwatch: Colors.blue,
  ).copyWith(secondary: Colors.greenAccent[400]),
  useMaterial3: true,
),
```
Penjelasan:

* `primarySwatch: Colors.blue` → warna utama aplikasi, digunakan pada AppBar dan ikon.
* `.copyWith(secondary: Colors.greenAccent[400])` → menambahkan warna sekunder untuk elemen pendukung seperti tombol atau highlight.
* `useMaterial3: true` → mengaktifkan Material Design 3.

# Tugas 7 | Basic Flutter

## Apa itu widget tree pada Flutter? Bagaimana hubungan parent-child antar widget?

Widget tree digunakan untuk menyusun tampilan aplikasi yang dibangun menggunakan Flutter. Widget adalah elemen visual berupa teks, tombol, icon, layout, dsb. Suatu widget dapat menjadi parent yang memiliki beberapa child. 

Contoh dalam kode saya:

```dart
Widget build(BuildContext context) {
  return Scaffold(
	appBar: AppBar(
	  ...
	),
	body: Padding(
	  ...
	  child: GridView.count(
		...
		children: items.map((item) => ItemCard(item)).toList(),
	  ),
	),
  );
}
```

```dart
Widget build(BuildContext context) {
  return Material(
	...
	child: InkWell(
	  ...
	  },
	  child: Container(
		...
		child: Center(
		  child: Column(
			...
			children: [
			  Icon(
				...
			  ),
			  Text(
				...
			  ),
			],
		  ),
		),
	  ),
	),
  );
}
```

`Scaffold` adalah parent dari `AppBar` dan `body`.

Di dalam `body`, ada `GridView`, dan di dalam setiap item `GridView` terdapat `Material` -> `InkWell` -> `Container` -> `Column` -> `Icon` + `Text`.

Ketika parent berubah, widget anak di bawahnya bisa ikut diperbarui atau dirender ulang sesuai kebutuhan UI.

## Widget yang digunakan dalam proyek saya

| Widget | Fungsi |
|--------|--------|
| `MaterialApp` | Root aplikasi yang menjadi tempat dari tema, routing, dan integrasi design. |
| `Scaffold` | Kerangka dasar dari konten atau struktur seperti `AppBar`, `body`, dan `FloatingActionButton`. |
| `AppBar` | Menampilkan judul aplikasi "GoalGear Mobile" di bagian atas halaman. |
| `Padding` | Memberi jarak antar konten di halaman. |
| `GridView.count` | Menyusun tombol dalam tiga kolom/grid. |
| `Material` | Menyediakan "alas" untuk tempat efek ripple dari `InkWell`. |
| `InkWell` | Menampilkan efek saat konten disentuh/ditekan. |
| `Container` | Menampung dan mengatur tata letak dari isi tombol. |
| `Center` | Menampilkan isi tombol di tengah-tengah. |
| `Column` | Menyusun ikon di atas, teks di bawah. |
| `Icon` | Menampilkan ikon. |
| `Text` | Menampilkan teks. |
| `ScackBar` | Menampilkan notifikasi di bawah layar saat tombol ditekan. |

## Apa fungsi dari widget `MaterialApp`? Mengapa widget ini sering digunakan sebagai widget root?

`MaterialApp` adalah widget wrapper utama yang menyediakan konfigurasi dasar dari keseluruhan tampilan aplikasi Flutter yang berbasis _Material Design_. Jadi, semua halaman, navigasi, tema, dan elemen UI lainnya berada di bawah `MaterialApp`.

```main.dart
class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'GoalGear Mobile',
      theme: ThemeData(
        colorScheme: ColorScheme.fromSwatch(
          primarySwatch: Colors.blue,
        ).copyWith(secondary: Colors.greenAccent[400]),
        useMaterial3: true,
      ),
      home: MyHomePage(),
    );
  }
}
```

Widget ini mengatur banyak hal, seperti:
- `title` mengatur judul aplikasi
- `theme` dan `ThemeData` mengatur hal-hal seperti:
	- `primarySwatch: Colors.blue` mengatur warna utama aplikasi (AppBar, tombol utama, dsb). 
	- `.copyWith(secondary: Colors.greenAccent[400])` untuk menambahkan warna sekunder.
	- `useMaterial3` diatur `true` untuk mengaktifkan Material Design 3 (MD3), versi desain modern dari Google.
- `home` mengatur halaman utama di dengan kelas `MyHomePage`.
- `routes` dipakai saat aplikasi memiliki beberapa halaman untuk mengatur rute masing-masing.

Berdasarkan hal tersebut, `MaterialApp` sering digunakan sebagai widget root karena: 
1. Menjadi titik utama dari struktur aplikasi material based.
2. Menjamin semua widget turunan dapat menggunakan tema dan komponen.
3. Menjaga konsistensi tampilan di seluruh widget dan halaman.

## Perbedaan antara `StatelessWidget` dengan `StatefulWidget`

| Type | What | When |
|------|------|------|
| `StatelessWidget` | Widget yang tidak memiliki state (keadaan tertentu). | Ketika tampilan tidak perlu pembaharuan selama user berinteraksi dengan material yang ada di dalam halaman atau hanya menampilkan data statis. |
| `StatefulWidget` | Widget yang memiliki state, bisa berubah selama aplikasi berjalan. | Ada perubahan pada halaman, misalnya ketika user input data dengan form dan halaman perlu diperbaharui setelahnya untuk menampilkan hasilnya. |

## Apa itu `BuildContext` dan mengapa pending? Bagaimana userannya di method `build()`?

`BuildContext` adalah onjek yang merepresentasikan lokasi dari sebuah widget di dalam widget tree.
Flutter menggunakan objek tersebut untuk:
- Menemukan _parent widget_ yang ada di atasnya, misalnya saat memanggil `Theme.of(context)` atau `ScaffoldMessenger.of(context)`.
- Mengatur hierarki tampilan dan mengakses elemen-elemen yang terkait dengan posisi widget tersebut.

Di dalam method `build()`, `BuildContext` digunakan sebagai parameter agar widget dapat: 
- mengambil tema dan style dari _parent widget_,
- menampilkan `SnackBar` menggunakan `ScaffoldMessenger.of(context)`,
- atau menavigasi ke halaman lain.

Contoh di dalam kode saya:

```menu.dart
ScaffoldMessenger.of(context).showSnackBar(
  SnackBar(content: Text("Kamu telah menekan tombol ${item.name}!")),
);
```
Di sini, `context` memberi tahu Flutter bahwa `SnackBar` harus muncul di `Scaffold` yang membungkus halaman ini.

## Konsep _Hot Reload_ dan Bedanya dengan _Hot Restart_

| Konsep | What | When | 
|--------|------|------|
| *Hot Reload* | Melakukan perubahan kode ke aplikasi yang sedang berjalan tanpa mengulang/reset state | Saat hanya mengubah style seperti warna, teks, atau layout. |
| *Hot Restart* | Memulai ulang keseluruhan aplikasi dari awal dengan reset state | Saat mengubah struktur widget, variable global, atau `main()`. |  