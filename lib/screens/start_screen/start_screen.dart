import 'package:flutter/material.dart';
import 'package:lossy/size_config/size_config.dart';

class StartScreen extends StatelessWidget {
  static String routeName = '/start-screen';
  StartScreen({Key? key}) : super(key: key);

  final controller = PageController(
    viewportFraction: 0.9,
  );

  @override
  Widget build(BuildContext context) {
    SizeConfig().init(context);
    return Container(
      color: Colors.white,
      child: Padding(
        padding: EdgeInsets.all(getProportionateScreenWidth(15)),
        child: Container(
          padding:
              EdgeInsets.symmetric(vertical: getProportionateScreenHeight(15)),
          decoration: BoxDecoration(
            borderRadius: BorderRadius.circular(55),
          ),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              SizedBox(
                height: getProportionateScreenHeight(20),
              ),
              Padding(
                padding: const EdgeInsets.only(left: 20.0),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Row(
                      children: [
                        Container(
                          decoration: BoxDecoration(
                            color: Colors.white,
                            borderRadius: BorderRadius.circular(20.0),
                          ),
                          child: Image.asset(
                            'assets/images/logo.webp',
                            height: getProportionateScreenHeight(85),
                            width: getProportionateScreenWidth(83),
                          ),
                        ),
                        SizedBox(
                          width: getProportionateScreenWidth(12),
                        ),
                        const Text(
                          'WeightTracker',
                          style: TextStyle(
                            color: Colors.grey,
                            fontWeight: FontWeight.bold,
                            fontSize: 18,
                          ),
                        ),
                      ],
                    ),
                    SizedBox(
                      height: getProportionateScreenHeight(30),
                    ),
                    Row(
                      children: [
                        Text(
                          'Weight',
                          style: TextStyle(
                              color: Colors.black,
                              fontWeight: FontWeight.bold,
                              fontSize: getProportionateScreenWidth(35)),
                        ),
                        SizedBox(
                          width: getProportionateScreenWidth(8),
                        ),
                        Text(
                          'Loss',
                          style: TextStyle(
                              color: ThemeData().primaryColorDark,
                              fontWeight: FontWeight.bold,
                              fontSize: getProportionateScreenWidth(30)),
                        ),
                      ],
                    ),
                    Text(
                      'can be easy',
                      style: TextStyle(
                          color: Colors.black,
                          fontWeight: FontWeight.bold,
                          fontSize: getProportionateScreenWidth(30)),
                    ),
                    SizedBox(
                      height: getProportionateScreenHeight(28),
                    ),
                    SizedBox(
                      height: getProportionateScreenHeight(60),
                    ),
                    const Text(
                      'Start to measure your weight every day and analyze your dynamic.',
                      style: TextStyle(
                        fontSize: 18,
                        color: Colors.grey,
                        fontWeight: FontWeight.w600,
                      ),
                    ),
                  ],
                ),
              ),
              SizedBox(
                height: getProportionateScreenHeight(35),
              ),
              Column(
                crossAxisAlignment: CrossAxisAlignment.center,
                children: [
                  SizedBox(
                    height: getProportionateScreenHeight(30),
                  ),
                  SizedBox(
                    height: getProportionateScreenHeight(60),
                  ),
                  ElevatedButton(
                    onPressed: () {
                      // Navigator.of(context)
                      //     .pushReplacementNamed(AuthScreen.routeName);
                    },
                    style: ElevatedButton.styleFrom(
                      padding: EdgeInsets.symmetric(
                        horizontal: getProportionateScreenWidth(135),
                        vertical: getProportionateScreenHeight(13),
                      ),
                      shape: const StadiumBorder(),
                    ),
                    child: const Text(
                      'Start',
                      style: TextStyle(
                        fontSize: 28,
                      ),
                    ),
                  ),
                  SizedBox(
                    height: getProportionateScreenHeight(20),
                  ),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      Text(
                        'Do you have an account? ',
                        style: Theme.of(context).textTheme.bodyText1,
                      ),
                      TextButton(
                        onPressed: () {},
                        child: const Text(
                          'Login',
                          style: TextStyle(
                            color: Color.fromARGB(255, 30, 158, 83),
                          ),
                        ),
                      ),
                    ],
                  ),
                ],
              ),
            ],
          ),
        ),
      ),
    );
  }
}
