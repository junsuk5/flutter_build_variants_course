import 'package:flutter_test/flutter_test.dart';
import 'package:flavor_memo_app/main.dart';
import 'package:go_router/go_router.dart';
import 'package:flavor_memo_app/data/repository/auth_repository_impl.dart';

void main() {
  testWidgets('SNS App Login Screen render test', (WidgetTester tester) async {
    final router = GoRouter(
      routes: [
        GoRoute(
          path: '/',
          builder: (context, state) =>
              LoginScreen(authRepository: MockAuthRepositoryImpl()),
        ),
      ],
    );

    await tester.pumpWidget(MyApp(router: router));

    // 'Flavor Memo SNS' 텍스트가 있는지 확인
    expect(find.text('Flavor Memo SNS'), findsOneWidget);
    // '로그인' 버튼이 있는지 확인
    expect(find.text('로그인'), findsOneWidget);
  });
}
