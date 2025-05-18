import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import '../screens/EditNoteScreen.dart';
import '../screens/splash_screen.dart';
import '../screens/login_screen.dart';
import '../screens/register_screen.dart';
import '../screens/home_screen.dart';
import '../screens/add_note_screen.dart';

final GoRouter appRouter = GoRouter(
  initialLocation: '/splash',
  routes: [
    GoRoute(
      path: '/splash',
      builder: (context, _) => const SplashScreen(),
    ),
    GoRoute(
      path: '/login',
      builder: (context, _) => const LoginScreen(),
    ),
    GoRoute(
      path: '/register',
      builder: (context, _) => const RegisterScreen(),
    ),
    GoRoute(
      path: '/home',
      builder: (context, _) => const HomeScreen(),
    ),
    GoRoute(
      path: '/add-note',
      builder: (context, _) => const AddNoteScreen(),
    ),
    GoRoute(
      path: '/edit-note/:id',
      builder: (BuildContext context, GoRouterState state) {
        final noteIdStr = state.pathParameters['id'];
        final noteId = int.tryParse(noteIdStr ?? '');
        if (noteId == null) {
          return const Scaffold(
            body: Center(child: Text('Invalid note ID')),
          );
        }

        return EditNoteScreen(noteId: noteId);
      },
    ),
  ],
);
