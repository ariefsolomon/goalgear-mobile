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
      title: const Text(
        'GoalGear Mobile',
        style: TextStyle(
          color: Colors.white, 
          fontWeight: FontWeight.bold
        ),
      ),
      backgroundColor: Theme.of(context).colorScheme.primary,
    ),
    body: Padding(
      padding: const EdgeInsets.all(16.0),
      child: GridView.count(
        crossAxisCount: 3,
        crossAxisSpacing: 10,
        mainAxisSpacing: 10,
        shrinkWrap: true,
        children: items.map((item) => ItemCard(item)).toList(),
      ),
    ),
  );
}
```

```

```

`Scaffold` adalah parent dari `AppBar` dan `body`.

Di dalam `body`, ada `GridView`, dan di dalam setiap item `GridView` terdapat `Material` -> `InkWell` -> `Container` -> `Column` -> `Icon` + `Text`.

Ketika parent berubah, widget anak di bawahnya bisa ikut diperbarui atau dirender ulang sesuai kebutuhan UI.
