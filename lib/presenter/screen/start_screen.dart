import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:hive/hive.dart';
import '../../core/base_view_model.dart';
import '../../core/const/pref_key.dart';
import '../../data/hive/entity/space_entity.dart';
import '../../logic/cubit/start_controller.dart';
import 'main_screen.dart';
part '../view_model/start_view_model.dart';

class StartScreen extends StatefulWidget {
  StartScreen({Key? key}) : super();

  @override
  State<StartScreen> createState() => _StartScreenState();
}

class _StartScreenState extends State<StartScreen> {
  StartController controller = StartController();
  late StartViewModel model;

  @override
  void initState() {
    model = StartViewModel(view: this);
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return BlocProvider<StartController>(
      create: (context) => controller,
      child: BlocListener<StartController, StartFormState>(
        listener: (context, state) {
          if (state is SubmitSuccess) {
            model.onSuccess(state);
          }

          if (state is SubmitFailure) {
            model.onFailuer(state);
          }
        },
        child: Scaffold(
          backgroundColor: Colors.white,
          body: Center(
            child: Container(
              alignment: Alignment.center,
              margin: const EdgeInsets.all(20),
              padding: const EdgeInsets.all(16),
              width: 500,
              decoration: BoxDecoration(
                  color: Colors.amber, borderRadius: BorderRadius.circular(20)),
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  const Text(
                    'خوش آمدید.',
                    style: TextStyle(fontSize: 24, fontWeight: FontWeight.w700),
                  ),
                  const SizedBox(
                    height: 12,
                  ),
                  const Text(
                      'با وارد کردن آدرس اتاق یا ساخت اتاق جدید میتونید فایلهای خودتون رو توی یه فضا به اشتراک بگذارید.'),
                  const SizedBox(
                    height: 25,
                  ),
                  TextFormField(
                    onChanged: (value) => controller.name = value,
                    decoration: InputDecoration(
                        contentPadding: const EdgeInsets.symmetric(
                            horizontal: 8, vertical: 4),
                        hintText: 'نام خود را وارد نمایید.',
                        fillColor: Colors.white,
                        filled: true,
                        border: OutlineInputBorder(
                          borderRadius: BorderRadius.circular(10),
                        )),
                  ),
                  const SizedBox(
                    height: 12,
                  ),
                  TextFormField(
                    onChanged: (value) => controller.spaceId = value,
                    decoration: InputDecoration(
                        contentPadding: const EdgeInsets.symmetric(
                            horizontal: 8, vertical: 4),
                        hintText: 'آدرس اتاق را وارد کنید.',
                        fillColor: Colors.white,
                        filled: true,
                        border: OutlineInputBorder(
                          borderRadius: BorderRadius.circular(10),
                        )),
                  ),
                  const SizedBox(
                    height: 12,
                  ),
                  MaterialButton(
                      height: 58,
                      minWidth: double.infinity,
                      color: Colors.deepPurpleAccent,
                      shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(8)),
                      onPressed: () {
                        controller.submitSpace();
                      },
                      child: const Text(
                        'ورود به اتاق',
                        style: TextStyle(color: Colors.white),
                      )),
                  InkWell(
                    onTap: () => {
                      Navigator.of(context).push(MaterialPageRoute(
                          builder: (c) => _CreateSpace(
                              controller: controller, model: model)))
                    },
                    child: Container(
                      height: 50,
                      width: double.infinity,
                      alignment: Alignment.center,
                      child: const Text(
                        'ساخت اتاق جدید',
                        style: TextStyle(
                            decorationColor: Colors.deepPurpleAccent,
                            color: Colors.deepPurpleAccent,
                            decorationThickness: 3,
                            decorationStyle: TextDecorationStyle.solid,
                            decoration: TextDecoration.underline),
                      ),
                    ),
                  )
                ],
              ),
            ),
          ),
        ),
      ),
    );
  }
}

class _CreateSpace extends StatelessWidget {
  StartViewModel model;
  StartController controller;
  _CreateSpace({required this.model, required this.controller});
  TextEditingController _controller = TextEditingController();

  @override
  Widget build(BuildContext context) {
    return BlocProvider<StartController>.value(
      value: controller,
      child: BlocListener<StartController, StartFormState>(
        listener: (context, state) {
          if (state is SubmitSuccess) {
            model.onSuccess(state);
          }

          if (state is SubmitFailure) {
            model.onFailuer(state);
          }
        },
        child: Scaffold(
          backgroundColor: Colors.white,
          body: Center(
            child: Container(
              alignment: Alignment.center,
              margin: const EdgeInsets.all(20),
              padding: const EdgeInsets.all(16),
              width: 500,
              decoration: BoxDecoration(
                  color: Colors.amber, borderRadius: BorderRadius.circular(20)),
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  const Text(
                    'خوش آمدید.',
                    style: TextStyle(fontSize: 24, fontWeight: FontWeight.w700),
                  ),
                  const SizedBox(
                    height: 12,
                  ),
                  const Text(
                      'نام مورد نظر برای اتاق خود را انتخاب کرده و با نام خودتان وارد فضای اشتراکی'),
                  const SizedBox(
                    height: 25,
                  ),
                  TextFormField(
                    onChanged: (value) => controller.name = value,
                    decoration: InputDecoration(
                        contentPadding: const EdgeInsets.symmetric(
                            horizontal: 8, vertical: 4),
                        hintText: 'نام خود را وارد نمایید.',
                        fillColor: Colors.white,
                        filled: true,
                        border: OutlineInputBorder(
                            borderRadius: BorderRadius.circular(10),
                            borderSide: BorderSide.none)),
                  ),
                  const SizedBox(
                    height: 12,
                  ),
                  TextFormField(
                      controller: _controller,
                      decoration: InputDecoration(
                        contentPadding: const EdgeInsets.symmetric(
                            horizontal: 8, vertical: 4),
                        hintText: 'نام اتاق را انخاب کنید.',
                        fillColor: Colors.white,
                        filled: true,
                        border: OutlineInputBorder(
                            borderRadius: BorderRadius.circular(10),
                            borderSide: BorderSide.none),
                      )),
                  const SizedBox(
                    height: 12,
                  ),
                  MaterialButton(
                      height: 52,
                      minWidth: double.infinity,
                      color: Colors.deepPurpleAccent,
                      shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(8)),
                      onPressed: () {
                        controller.createRoom(_controller.text);
                      },
                      child: const Text(
                        'ورود به اتاق',
                        style: TextStyle(color: Colors.white),
                      ))
                ],
              ),
            ),
          ),
        ),
      ),
    );
  }
}
