import 'package:go_router/go_router.dart';
import '../views/dashboard_view.dart';
import '../views/list_view.dart';
import '../views/detail_view.dart';

final appRouter = GoRouter(
  initialLocation: '/',
  routes: [
    GoRoute(path: '/', builder: (context, state) => const DashboardView()),
    GoRoute(
      path: '/list/:endpoint',
      builder: (context, state) {
        final endpoint = state.pathParameters['endpoint']!;
        return DataListView(endpoint: endpoint);
      },
    ),
    GoRoute(
      path: '/detail/:endpoint/:id',
      builder: (context, state) {
        final endpoint = state.pathParameters['endpoint']!;
        final id = state.pathParameters['id']!;
        return DataDetailView(endpoint: endpoint, id: id);
      },
    ),
  ],
);
