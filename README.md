# GoalGear Mobile

# Tugas 7 | Basic Flutter

## Apa itu widget tree pada Flutter? Bagaimana hubungan parent-child antar widget?

Widget tree digunakan untuk menyusun tampilan aplikasi yang dibangun menggunakan Flutter.

Widget adalah elemen visual berupa teks, tombol, icon, layout, dsb. Suatu widget dapat menjadi parent yang memiliki beberapa child. 

Contoh dalam kode saya:

```menu.dart
// menu.dart
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