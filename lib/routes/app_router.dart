import 'package:go_router/go_router.dart';
import '../screens/splash_screen.dart';
import '../screens/login_screen.dart';
import '../screens/register_screen.dart';
import '../screens/home_screen.dart';
import '../screens/add_note_screen.dart';

final GoRouter appRouter = GoRouter(
  initialLocation: '/splash',
  routes: [
    GoRoute(path: '/splash', builder: (context, _) =>  SplashScreen()),
    GoRoute(path: '/login', builder: (context, _) =>  LoginScreen()),
    GoRoute(path: '/register', builder: (context, _) =>  RegisterScreen()),
    GoRoute(path: '/home', builder: (context, _) =>  HomeScreen()),
    GoRoute(path: '/add-note', builder: (context, _) =>  AddNoteScreen()),
  ],
);
