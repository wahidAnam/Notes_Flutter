import 'package:flutter/material.dart';

/// Base URL
const String baseUrl = "https://wahiddev.xyz/anam/notes_app/";

/// Notes API endpoints
const String loginUrl = "${baseUrl}login.php";
const String registerUrl = "${baseUrl}register.php";
const String addNoteUrl = "${baseUrl}add_note.php";
const String getNotesUrl = "${baseUrl}get_notes.php";
const String getNotesbyIdUrl = "${baseUrl}get_note.php";
const String updateNoteUrl = "${baseUrl}update_note.php";

/// UI Constants
const double defaultPadding = 16.0;

/// App Colors
class AppColors {
  static const primaryColor = Color(0xFF1976D2); // Blue
  static const accentColor = Color(0xFFFFC107);  // Amber
  static const backgroundColor = Color(0xFFF5F5F5); // Light gray
}
