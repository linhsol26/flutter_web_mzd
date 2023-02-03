import 'package:flat_3d_button/flat_3d_button.dart';
import 'package:flutter/material.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';
import 'package:web_mzd/core/shared/provider.dart';

class SignInScreen extends HookConsumerWidget {
  const SignInScreen({super.key});
  @override
  Widget build(BuildContext context, WidgetRef ref) {
    return Scaffold(
      appBar: AppBar(
        centerTitle: true,
        title: const Text('MZD Randomize'),
      ),
      body: Container(
        // width: double.maxFinite,
        // height: double.maxFinite,
        decoration: const BoxDecoration(
          image: DecorationImage(
            image: AssetImage('assets/background-2.jpg'),
            fit: BoxFit.cover,
          ),
        ),
        child: Center(
          child: Flat3dButton(
            onPressed: () async {
              await ref.read(authRepoProvider).signInWithGoogle();
              // res.fold((l) => l, (r) => r);
            },
            child: const Text(
              'Sign in with Google Account',
              textAlign: TextAlign.center,
              style: TextStyle(color: Colors.white, fontSize: 24),
            ),
          ),
        ),
      ),
    );
  }
}
