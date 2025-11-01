# GoalGear Mobile

# Tugas 7 | Basic Flutter

## Apa itu widget tree pada Flutter? Bagaimana hubungan parent-child antar widget?

Widget tree digunakan untuk menyusun tampilan aplikasi yang dibangun menggunakan Flutter.

Widget adalah elemen visual berupa teks, tombol, icon, layout, dsb. Suatu widget dapat menjadi parent yang memiliki beberapa child. 

Contoh dalam kode saya:

```menu.dart
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

```main.dart
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