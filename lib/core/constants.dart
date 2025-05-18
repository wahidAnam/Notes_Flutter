import 'package:flutter/material.dart';

/// Base URL
const String baseUrl = "http://192.168.0.107/Index/Notes/";

/// Notes API endpoints
const String loginUrl = "${baseUrl}login.php";
const String registerUrl = "${baseUrl}register.php";
const String addNoteUrl = "${baseUrl}add_note.php";
const String getNotesUrl = "${baseUrl}get_notes.php";

/// UI Constants
const double defaultPadding = 16.0;

/// App Colors
class AppColors {
  static const primaryColor = Color(0xFF1976D2); // Blue
  static const accentColor = Color(0xFFFFC107);  // Amber
  static const backgroundColor = Color(0xFFF5F5F5); // Light gray
}
