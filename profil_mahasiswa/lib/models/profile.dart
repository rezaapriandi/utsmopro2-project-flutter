import 'package:flutter/material.dart';

// Menggunakan Enum untuk Status Mahasiswa
enum ProfileStatus {
  mahasiswa,
  alumni,
  cuti,
}

// Class Model Data Diri Mahasiswa
class Profile {
  final String nama;
  final String nim;
  final String jurusan;
  final String email;
  final String telepon;
  final String instagram;
  final List<String> hobi;
  final List<String> skill;
  final ProfileStatus status;

  Profile({
    required this.nama,
    required this.nim,
    required this.jurusan,
    required this.email,
    required this.telepon,
    required this.instagram,
    required this.hobi,
    required this.skill,
    required this.status,
  });

  // Fungsi untuk mendapatkan teks status yang diformat
  String get formattedStatus {
    switch (status) {
      case ProfileStatus.mahasiswa:
        return 'Mahasiswa Aktif';
      case ProfileStatus.alumni:
        return 'Alumni';
      case ProfileStatus.cuti:
        return 'Cuti Akademik';
    }
  }
}

// Data Mahasiswa yang akan digunakan
final rezaApriandiProfile = Profile(
  nama: 'Reza Apriandi',
  nim: '23552011216',
  jurusan: 'Teknik Informatika',
  email: 'rezaapriandi2211@gmail.com',
  telepon: '083804033031',
  instagram: '@ezaar27_',
  hobi: ['Bermain sepak bola', 'Bermain musik', 'Buat konten', 'Membaca'],
  skill: ['Videographer', 'Konten Kreator', 'Web Developer'],
  status: ProfileStatus.mahasiswa,
);