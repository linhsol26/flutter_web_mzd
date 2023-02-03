import 'dart:async';
import 'dart:math';

import 'package:confetti/confetti.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flash/flash.dart';
import 'package:flat_3d_button/flat_3d_button.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:flutter_fortune_wheel/flutter_fortune_wheel.dart';
import 'package:flutter_hooks/flutter_hooks.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';
import 'package:image_picker_web/image_picker_web.dart';
import 'package:material_color_generator/material_color_generator.dart';
import 'package:web_mzd/core/domain/user.dart';
import 'package:web_mzd/core/presentation/themes.dart';

const defaultImgUrl =
    'https://scontent.fsgn5-10.fna.fbcdn.net/v/t1.15752-9/323595288_1586938908468563_1483698212520144839_n.jpg?_nc_cat=100&ccb=1-7&_nc_sid=ae9488&_nc_ohc=xLhHmzLSncYAX9xu8LA&_nc_ht=scontent.fsgn5-10.fna&oh=03_AdTI4rvxsoiAke9yVYyVki-dKfL4S0SfBRMVzBQqbHLqxw&oe=63E4F0D1';

class HomeScreen extends HookConsumerWidget {
  const HomeScreen({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final streamController = useStreamController<int>();
    final completedSubmitForm = useState(false);
    final count = useState(1);

    final fName = useTextEditingController(text: kDebugMode ? 'ten fb nek' : null);
    final dName = useTextEditingController(text: kDebugMode ? 'ten dnt nek' : null);
    final rName = useTextEditingController(text: kDebugMode ? 'ten ng nhan nek' : null);
    final phone = useTextEditingController(text: kDebugMode ? 'sdt nek' : null);
    final address = useTextEditingController(text: kDebugMode ? 'dchi nek' : null);

    return GestureDetector(
      onTap: () => FocusManager.instance.primaryFocus?.unfocus(),
      child: Scaffold(
        appBar: AppBar(
          centerTitle: true,
          title: const Text('MZD Randomize'),
          actions: [
            TextButton.icon(
                onPressed: () {
                  completedSubmitForm.value = !completedSubmitForm.value;
                  // ref.read(authRepoProvider).signOut();
                },
                icon: const Icon(
                  Icons.rotate_90_degrees_ccw,
                  color: Colors.white,
                ),
                label: const Text('Rotate')),
          ],
        ),
        body: Container(
          decoration: const BoxDecoration(
            image: DecorationImage(
              image: AssetImage('assets/background-1.jpg'),
              fit: BoxFit.cover,
            ),
          ),
          child: Center(
            child: completedSubmitForm.value
                ? _Wheels(streamController: streamController)
                : _FormInformations(
                    count: count,
                    fName: fName,
                    dName: dName,
                    rName: rName,
                    phone: phone,
                    address: address,
                    callback: () async {
                      final user = UserModel(
                        uid: FirebaseAuth.instance.currentUser!.uid,
                        typeOfGifts: 'Keycharm',
                        numbersOfGifts: count.value,
                        facebookName: fName.text.trim(),
                        donateName: dName.text.trim(),
                        receiverName: rName.text.trim(),
                        receiverAddress: address.text.trim(),
                        receiverPhoneNumber: phone.text.trim(),
                        bills: [],
                        gifts: [],
                      );

                      // await ref.read(authRepoProvider).updateUserInfo(user);
                    },
                  ),
          ),
        ),
      ),
    );
  }
}

class _FormInformations extends HookWidget {
  const _FormInformations({
    Key? key,
    required this.count,
    required this.fName,
    required this.dName,
    required this.rName,
    required this.phone,
    required this.address,
    required this.callback,
  }) : super(key: key);

  final ValueNotifier<int> count;
  final TextEditingController fName;
  final TextEditingController dName;
  final TextEditingController rName;
  final TextEditingController phone;
  final TextEditingController address;
  final VoidCallback callback;

  @override
  Widget build(BuildContext context) {
    final bill = useState<Image?>(null);

    return ListView(
      padding: const EdgeInsets.all(16),
      children: [
        ListTile(
          title: Row(
            children: [
              const Expanded(child: Text('Loại: ')),
              Expanded(
                flex: context.flex,
                child: DropdownButton(
                  value: 'keycharm',
                  items: const [
                    DropdownMenuItem(value: 'keycharm', enabled: false, child: Text('Keycharm')),
                  ],
                  onChanged: null,
                ),
              ),
            ],
          ),
        ),
        ListTile(
          title: Row(
            children: [
              const Expanded(child: Text('Số lượng: ')),
              Expanded(
                flex: context.flex,
                child: DropdownButton<int>(
                  value: count.value,
                  items: List.generate(
                    10,
                    (index) => DropdownMenuItem(
                      value: index + 1,
                      child: Text('${index + 1}'),
                    ),
                  ),
                  onChanged: (v) => count.value = v!,
                ),
              ),
            ],
          ),
        ),
        ListTile(
          title: Row(
            children: [
              const Expanded(child: Text('Tên Facebook: ')),
              Expanded(
                flex: context.flex,
                child: TextFormField(
                  controller: fName,
                  decoration: const InputDecoration(),
                ),
              ),
            ],
          ),
        ),
        ListTile(
          title: Row(
            children: [
              const Expanded(child: Text('Tên Donate: ')),
              Expanded(
                flex: context.flex,
                child: TextFormField(
                  controller: dName,
                  decoration: const InputDecoration(),
                ),
              ),
            ],
          ),
        ),
        ListTile(
          title: Row(
            children: [
              const Expanded(child: Text('Tên người nhận: ')),
              Expanded(
                flex: context.flex,
                child: TextFormField(
                  controller: rName,
                  decoration: const InputDecoration(),
                ),
              ),
            ],
          ),
        ),
        ListTile(
          title: Row(
            children: [
              const Expanded(child: Text('Số điện thoại người nhận: ')),
              Expanded(
                flex: context.flex,
                child: TextFormField(
                  controller: phone,
                  keyboardType: TextInputType.phone,
                  decoration: const InputDecoration(),
                ),
              ),
            ],
          ),
        ),
        ListTile(
          title: Row(
            children: [
              const Expanded(child: Text('Địa chỉ nhận: ')),
              Expanded(
                flex: context.flex,
                child: TextFormField(
                  controller: address,
                  keyboardType: TextInputType.multiline,
                  maxLines: null,
                  decoration: const InputDecoration(),
                ),
              ),
            ],
          ),
        ),
        ListTile(
          title: Row(
            children: const [
              Expanded(
                child: Text('Thanh toán: '),
              ),
              // Expanded(
              //   flex: context.flex,
              //   child: Image.asset(
              //     'momo.jpeg',
              //     width: context.sizes,
              //     height: context.sizes,
              //     fit: BoxFit.contain,
              //   ),
              // ),
              // Expanded(
              //   flex: context.flex,
              //   child: Image.asset(
              //     'vp.jpeg',
              //     width: context.sizes,
              //     height: context.sizes,
              //     fit: BoxFit.contain,
              //   ),
              // ),
            ],
          ),
        ),
        InkWell(
          onTap: () async {
            final image = await ImagePickerWeb.getImageAsWidget();

            if (image != null) {
              bill.value = image;
            }
          },
          child: Card(
            shape: RoundedRectangleBorder(
              side: const BorderSide(),
              borderRadius: BorderRadius.circular(16),
            ),
            margin: const EdgeInsets.symmetric(horizontal: 64.0),
            child: Column(
              children: const [
                SizedBox(height: 4),
                Text('Up bills ở đây.'),
                Icon(Icons.cloud_upload_outlined, size: 64),
              ],
            ),
          ),
        ),
        if (bill.value != null) Center(child: bill.value),
        const SizedBox(height: 64),
        Padding(
            padding: EdgeInsets.symmetric(horizontal: MediaQuery.of(context).size.width / 3),
            child: ElevatedButton(
              onPressed: callback,
              style: ButtonStyle(
                shape: MaterialStateProperty.all(const CircleBorder()),
                padding: MaterialStateProperty.all(const EdgeInsets.all(20)),
                // backgroundColor: MaterialStateProperty.all(), // <-- Button color
                overlayColor: MaterialStateProperty.resolveWith<Color?>((states) {
                  if (states.contains(MaterialState.pressed)) return Colors.red;
                  return null; // <-- Splash color
                }),
              ),
              child: const Icon(Icons.arrow_circle_right_rounded),
            )),
      ],
    );
  }
}

class _Wheels extends HookConsumerWidget {
  const _Wheels({
    Key? key,
    required StreamController<int> streamController,
  })  : _streamController = streamController,
        super(key: key);

  final StreamController<int> _streamController;

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final choosen = useState(-1);
    final controllerCenter = useMemoized(
      () => ConfettiController(duration: const Duration(seconds: 5)),
    );

    useEffect(() {
      _streamController.stream.listen((item) => choosen.value = item);
      return null;
    }, []);
    return Column(
      children: [
        const SizedBox(height: 36),
        Image.asset('smy-pray.jpg'),
        const SizedBox(height: 36),
        Flat3dButton(
          onPressed: () => _roll(controllerCenter, context),
          color: generateMaterialColor(color: Colors.deepPurple.shade200),
          child: const Text('Roll', style: TextStyle(color: Colors.white, fontSize: 24)),
        ),
        Expanded(
          child: SizedBox(
            height: MediaQuery.of(context).size.height / 2,
            child: FortuneWheel(
              selected: _streamController.stream,
              animateFirst: false,
              physics: CircularPanPhysics(
                duration: const Duration(seconds: 1),
                curve: Curves.decelerate,
              ),
              duration: const Duration(seconds: 3),
              indicators: const [],
              alignment: Alignment.bottomCenter,
              onFling: () => _roll(controllerCenter, context),
              onAnimationEnd: () async {
                final item = items.entries.elementAt(choosen.value);
                items[item.key] = item.value - 1;
                items.removeWhere((key, value) => value == 0);
                if (choosen.value != -1) {
                  controllerCenter.play();
                  showGeneralDialog<bool>(
                      context: context,
                      transitionBuilder: (context, a1, a2, widget) {
                        return Transform.scale(
                          scale: a1.value,
                          child: Opacity(
                            opacity: a1.value,
                            child: Dialog(
                              shape: const CircleBorder(),
                              child: ConfettiWidget(
                                confettiController: controllerCenter,
                                blastDirectionality: BlastDirectionality
                                    .explosive, // don't specify a direction, blast randomly
                                shouldLoop:
                                    false, // start again as soon as the animation is finished
                                colors: const [
                                  Colors.green,
                                  Colors.blue,
                                  Colors.pink,
                                  Colors.orange,
                                  Colors.purple
                                ], // manually specify the colors to be used
                                createParticlePath: drawStar, // define a custom shape/path.
                                child: SizedBox(
                                  width: MediaQuery.of(context).size.height / 4,
                                  height: MediaQuery.of(context).size.height / 4,
                                  child: Hero(
                                    tag: 'item-${choosen.value + 1}',
                                    child: CircleAvatar(
                                      maxRadius: 16,
                                      backgroundImage:
                                          AssetImage('keycharm/keycharm${choosen.value + 1}.png'),
                                    ),
                                  ),
                                ),
                              ),
                            ),
                          ),
                        );
                      },
                      transitionDuration: const Duration(milliseconds: 200),
                      barrierDismissible: true,
                      barrierLabel: '',
                      pageBuilder: (context, __, _) {
                        return const SizedBox.shrink();
                      }).whenComplete(() => controllerCenter.stop());
                }
              },
              items: List.generate(
                items.length,
                (index) => FortuneItem(
                  style: const FortuneItemStyle(
                    color: Colors.transparent,
                    borderWidth: 0.0,
                  ),
                  child: Hero(
                    tag: ValueKey('item-$index'),
                    child: CircleAvatar(
                      radius: 45,
                      backgroundImage: AssetImage('keycharm/keycharm${index + 1}.png'),
                    ),
                  ),
                ),
              ),
            ),
          ),
        ),
      ],
    );
  }

  void _roll(ConfettiController controllerCenter, BuildContext context) {
    controllerCenter.stop();

    if (items.entries.isEmpty) {
      context.showInfoBar(content: const Text('Hết rùi!!'));
      return;
    }

    final random = Random().nextInt(items.entries.length);
    _streamController.add(random);

    debugPrint(items.toString());
  }
}

Map<String, int> items = {
  'item-0': 3,
  'item-1': 3,
  'item-2': 3,
  'item-3': 3,
  'item-4': 3,
  'item-5': 3,
};
