import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/services.dart';

class AppException implements Exception {
  final String message;
  final String? code;

  AppException(this.message, {this.code});

  @override
  String toString() => message;

  factory AppException.from(dynamic e) {
    if (e is FirebaseAuthException) {
      return _handleAuthError(e);
    } else if (e is PlatformException) {
      return AppException(e.message ?? "Platform Error", code: e.code);
    } else if (e is AppException) {
      return e;
    } else {
      return AppException(e.toString());
    }
  }

  static AppException _handleAuthError(FirebaseAuthException e) {
    switch (e.code) {
      case 'user-not-found':
        return AppException("No user found with this email.");
      case 'wrong-password':
        return AppException("Incorrect password.");
      case 'email-already-in-use':
        return AppException("This email is already registered.");
      case 'invalid-email':
        return AppException("Please enter a valid email address.");
      case 'weak-password':
        return AppException("Password is too weak.");
      case 'network-request-failed':
        return AppException("No internet connection.");
      default:
        return AppException("Authentication Error: ${e.message}");
    }
  }
}