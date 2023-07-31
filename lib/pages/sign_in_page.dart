import 'package:GoogleLogin/theme.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:google_sign_in/google_sign_in.dart';

class SignInPage extends StatelessWidget {
  Future<void> _signInWithGoogle(BuildContext context) async {
    try {
      final GoogleSignInAccount? googleUser = await GoogleSignIn().signIn();
      if (googleUser != null) {
        final GoogleSignInAuthentication googleAuth =
            await googleUser.authentication;
        final AuthCredential credential = GoogleAuthProvider.credential(
          accessToken: googleAuth.accessToken,
          idToken: googleAuth.idToken,
        );
        final UserCredential authResult =
            await FirebaseAuth.instance.signInWithCredential(credential);
        final User? user = authResult.user;
        if (user != null) {
          Navigator.pushNamedAndRemoveUntil(
            context,
            '/map',
            (route) => false,
          );
        } else {
          _showLoginFailedAlert(context);
        }
      } else {
        throw Exception('Gagal memilih akun Google.');
      }
    } catch (error) {
      throw Exception('Terjadi kesalahan saat sign-in dengan Google: $error');
    }
  }

  Future<void> _showLoginFailedAlert(BuildContext context) async {
    return showDialog<void>(
      context: context,
      builder: (BuildContext context) {
        return AlertDialog(
          title: Text('Login Gagal'),
          content: Text('Sign-In dengan Google gagal.'),
          actions: <Widget>[
            TextButton(
              child: Text('OK'),
              onPressed: () {
                Navigator.of(context).pop();
              },
            ),
          ],
        );
      },
    );
  }

  @override
  Widget build(BuildContext context) {
    Widget header() {
      return Container(
        margin: EdgeInsets.only(top: 60),
        width: double.infinity,
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(
              'Login',
              style:
                  primaryTextStyle.copyWith(fontSize: 24, fontWeight: semiBold),
            ),
            SizedBox(
              height: 2,
            ),
            Text(
              'Sign in With Google Account to Continue',
              style: subtitleTextStyle,
            ),
          ],
        ),
      );
    }

    Widget signInButton() {
      return Container(
        height: 60,
        width: double.infinity,
        margin: EdgeInsets.only(top: 240),
        child: TextButton(
          onPressed: () async {
            try {
              await _signInWithGoogle(context);
            } catch (error) {
              _showLoginFailedAlert(context);
            }
          },
          style: TextButton.styleFrom(
            backgroundColor: primaryColor,
            shape: RoundedRectangleBorder(
              borderRadius: BorderRadius.circular(12),
            ),
          ),
          child: Center(
            child: Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Image.asset(
                  'assets/google.png',
                  width: 26,
                ),
                SizedBox(
                  width: 16,
                ),
                Text(
                  'Sign in with Google',
                  style: primaryTextStyle.copyWith(
                      fontSize: 16, fontWeight: medium),
                ),
              ],
            ),
          ),
        ),
      );
    }

    Widget footer() {
      return Container(
        margin: EdgeInsets.only(bottom: 30),
        child: Row(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Text(
              'Don\'t have account ? ',
              style: subtitleTextStyle.copyWith(
                fontSize: 12,
              ),
            ),
            Text(
              'Sign Up',
              style: purpleTextStyle.copyWith(fontSize: 12, fontWeight: medium),
            ),
          ],
        ),
      );
    }

    return Scaffold(
      backgroundColor: backgroundColor,
      resizeToAvoidBottomInset: false,
      body: SafeArea(
        child: Container(
          margin: EdgeInsets.symmetric(
            horizontal: defaultMargin,
          ),
          child: Column(
            children: [header(), signInButton(), Spacer(), footer()],
          ),
        ),
      ),
    );
  }
}
