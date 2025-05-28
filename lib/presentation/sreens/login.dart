import 'package:app_generator_management/application/bloc/sign_in_bloc/sign_in_bloc.dart';
import 'package:app_generator_management/core/enum/enums.dart';
import 'package:app_generator_management/presentation/sreens/dashboard.dart';
import 'package:app_generator_management/presentation/widgets/backgroup.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:rive/rive.dart';

class LoginScreen extends StatefulWidget {
  const LoginScreen({Key? key}) : super(key: key);

  @override
  State<LoginScreen> createState() => _LoginScreenState();
}

class _LoginScreenState extends State<LoginScreen> {
  late StateMachineController _machineController;
  SMITrigger? _workTrigger;
  final GlobalKey<FormState> formKey = GlobalKey<FormState>();
  final TextEditingController _emailController = TextEditingController();
  final TextEditingController _passwordController = TextEditingController();

  void _onRiveInit(Artboard artboard) {
    final controller = StateMachineController.fromArtboard(
      artboard,
      'State Machine 1',
    );

    if (controller != null) {
      artboard.addController(controller);
      _machineController = controller;

      _workTrigger = controller.findInput<bool>('Input') as SMITrigger?;
    }
  }

  void _setToWork() {
    _workTrigger?.fire();
  }

  @override
  Widget build(BuildContext context) {
    return Background(
      child: SingleChildScrollView(
        child: Row(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            SizedBox(
              width: 500,
              height: 500,
              child: RiveAnimation.asset(
                'riv/the_state_machine.riv',
                stateMachines: ['State Machine 1'],
                fit: BoxFit.scaleDown,
                onInit: _onRiveInit,
              ),
            ),
            const SizedBox(width: 20),
            SizedBox(
              width: 450,
              child: Column(
                children: [
                  LoginForm(
                    formKey: formKey,
                    emailController: _emailController,
                    passwordController: _passwordController,
                    onLoginSuccess: _setToWork,
                  ),
                  const SizedBox(height: 20),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}

class LoginForm extends StatelessWidget {
  final GlobalKey<FormState> formKey;
  final TextEditingController emailController;
  final TextEditingController passwordController;
  final VoidCallback onLoginSuccess;

  const LoginForm({
    super.key,
    required this.formKey,
    required this.emailController,
    required this.passwordController,
    required this.onLoginSuccess,
  });

  @override
  Widget build(BuildContext context) {
    return Form(
      key: formKey,
      child: Column(
        children: [
          TextFormField(
            controller: emailController,
            decoration: const InputDecoration(
              hintText: 'Tài khoản',
              filled: true,
              fillColor: Color(0xFFF5FCF9),
              contentPadding:
                  EdgeInsets.symmetric(horizontal: 24.0, vertical: 16.0),
              border: OutlineInputBorder(
                borderSide: BorderSide.none,
                borderRadius: BorderRadius.all(Radius.circular(50)),
              ),
            ),
            keyboardType: TextInputType.phone,
            validator: (value) => value == null || value.isEmpty
                ? 'Vui lòng nhập tài khoản'
                : null,
          ),
          const SizedBox(height: 16.0),
          TextFormField(
            controller: passwordController,
            obscureText: true,
            decoration: const InputDecoration(
              hintText: 'Mật khẩu',
              filled: true,
              fillColor: Color(0xFFF5FCF9),
              contentPadding:
                  EdgeInsets.symmetric(horizontal: 24.0, vertical: 16.0),
              border: OutlineInputBorder(
                borderSide: BorderSide.none,
                borderRadius: BorderRadius.all(Radius.circular(50)),
              ),
            ),
            validator: (value) => value == null || value.isEmpty
                ? 'Vui lòng nhập mật khẩu'
                : null,
          ),
          const SizedBox(height: 24.0),
          BlocConsumer<SignInBloc, SignInState>(
            listener: (context, state) {
              if (state.status == SignInStatus.error) {}
              if (state.status == SignInStatus.success) {
                Navigator.of(context).pushAndRemoveUntil(
                  PageRouteBuilder(
                    pageBuilder: (_, __, ___) => DashboardSceen(),
                    transitionDuration: Duration.zero,
                    reverseTransitionDuration: Duration.zero,
                  ),
                  (route) => false,
                );
              }
            },
            builder: (context, state) {
              return ElevatedButton(
                onPressed: () {
                  if (formKey.currentState!.validate()) {
                    context.read<SignInBloc>().add(
                          SignInWithCredential(
                            email: emailController.text.trim(),
                            password: passwordController.text.trim(),
                          ),
                        );
                    onLoginSuccess(); // Trigger Rive animation
                  }
                },
                style: ElevatedButton.styleFrom(
                  elevation: 0,
                  backgroundColor: const Color(0xFF00BF6D),
                  foregroundColor: Colors.white,
                  minimumSize: const Size(double.infinity, 48),
                  shape: const StadiumBorder(),
                ),
                child: const Text("Đăng nhập"),
              );
            },
          ),
        ],
      ),
    );
  }
}
