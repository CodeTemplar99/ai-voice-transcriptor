import 'package:alindor_tech/configs/colors.dart';
import 'package:alindor_tech/configs/dimension.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:loading_animation_widget/loading_animation_widget.dart';
import 'package:loading_indicator/loading_indicator.dart';
import 'package:provider/provider.dart';

import '../../controllers/record_controller.dart';
import '../../controllers/play_controller.dart';

class ChatScreen extends StatefulWidget {
  const ChatScreen({super.key});

  @override
  State<ChatScreen> createState() => _ChatScreenState();
}

class _ChatScreenState extends State<ChatScreen> {
  List<String> metricsTitle = ['Trust', 'Sentiment', 'Empathy', 'Charisma'];
  List<double> metricsValue = [0.5, 0.9, 0.1, 0.4];
  List<String> interests = [
    'Happiness',
    'Love',
    'Adventure',
    'Family',
    'Friendship',
    'Pets'
  ];
  List<String> dislikes = [
    'Failure',
    'Disappointment',
    'Sadness',
    'Fear',
    'Anger',
    'Surprise'
  ];

  bool showFullText = false;

  @override
  // Initialize the state by calling the super.initState() method.
  // Initializes the record controller stream and initializes the audio controller and sound play controller.
  void initState() {
    super.initState();
    RecordController();
    // initialize audio controller
    context.read<RecordController>().initAudioController();
    context.read<RecordController>().initStream();
    context.read<AudioPlayController>().initPlayController();
  }

  @override
  void dispose() {
    // dispose audio controller
    context.read<RecordController>().disposeAudioController();
    context.read<RecordController>().voiceStream.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    SizeConfig().init(context);
    return Scaffold(
      backgroundColor: const Color(0xFF0F0827),
      appBar: AppBar(
        backgroundColor: Colors.transparent,
        elevation: 0,
        centerTitle: true,
        title: Text(
          'Alindor personal AI',
          style: GoogleFonts.manrope(
            color: Colors.white54,
            fontSize: getScreenHeight(16),
            fontWeight: FontWeight.w600,
          ),
        ),
      ),
      body: SingleChildScrollView(
        child: Padding(
          padding: EdgeInsets.symmetric(horizontal: getScreenHeight(15)),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              context.watch<RecordController>().hasRecord == null
                  ? const SizedBox.shrink()
                  : context.watch<RecordController>().isRecording
                      ? Row(
                          crossAxisAlignment: CrossAxisAlignment.center,
                          mainAxisAlignment: MainAxisAlignment.start,
                          children: [
                            Text(
                              'Listening',
                              style: GoogleFonts.manrope(
                                color: Colors.white,
                                fontSize: getScreenHeight(18),
                                fontWeight: FontWeight.w600,
                              ),
                            ),
                            Padding(
                              padding:
                                  EdgeInsets.only(top: getScreenHeight(10)),
                              child: LoadingAnimationWidget.prograssiveDots(
                                color: Colors.white,
                                size: getScreenHeight(50),
                              ),
                            ),
                          ],
                        )
                      : Container(
                          height: getScreenHeight(60),
                          width: MediaQuery.of(context).size.width,
                          padding: EdgeInsets.symmetric(
                              horizontal: getScreenHeight(15)),
                          decoration: BoxDecoration(
                              color: const Color(0xFF4B3886),
                              borderRadius:
                                  BorderRadius.circular(getScreenHeight(20))),
                          child: Row(
                            mainAxisAlignment: MainAxisAlignment.spaceBetween,
                            children: [
                              if (context.read<AudioPlayController>().isPlaying)
                                SizedBox(
                                  height: getScreenHeight(25),
                                  child: Row(
                                    children: [
                                      Text(
                                        'Playing: ',
                                        style: GoogleFonts.manrope(
                                          color: Colors.white,
                                          fontSize: getScreenHeight(14),
                                          fontWeight: FontWeight.w400,
                                        ),
                                      ),
                                      ...List.generate(
                                          5,
                                          (index) => Container(
                                                margin: EdgeInsets.only(
                                                    right: getScreenHeight(5)),
                                                child: const LoadingIndicator(
                                                  indicatorType:
                                                      Indicator.lineScaleParty,
                                                  colors: [Colors.white],
                                                ),
                                              ))
                                    ],
                                  ),
                                )
                              else
                                const SizedBox(),
                              GestureDetector(
                                onTap: () {
                                  context
                                      .read<RecordController>()
                                      .toggleRecording(context);
                                },
                                child: context
                                        .watch<AudioPlayController>()
                                        .isPlaying
                                    ? const Icon(Icons.pause,
                                        color: Colors.white)
                                    : const Icon(Icons.play_arrow,
                                        color: Colors.white),
                              )
                            ],
                          ),
                        ),
              VerticalSpacingMobile(heightValue: getScreenHeight(20)),
              context.watch<RecordController>().hasRecord == null
                  ? const SizedBox.shrink()
                  : Align(
                      alignment: Alignment.centerRight,
                      child: GestureDetector(
                        onTap: () => showModalBottomSheet(
                          isScrollControlled: true,
                          context: context,
                          builder: (context) => Container(
                            height: MediaQuery.of(context).size.height / 1.3,
                            width: double.infinity,
                            padding: EdgeInsets.fromLTRB(getScreenHeight(15),
                                getScreenHeight(20), getScreenHeight(10), 0),
                            decoration: BoxDecoration(
                                color: const Color(0xFF30264B),
                                borderRadius: BorderRadius.only(
                                  topLeft: Radius.circular(getScreenHeight(20)),
                                  topRight:
                                      Radius.circular(getScreenHeight(20)),
                                )),
                            child: SingleChildScrollView(
                              child: Text(
                                context.watch<RecordController>().transcript,
                                textAlign: TextAlign.left,
                                style: GoogleFonts.manrope(
                                  color: Colors.white,
                                  fontSize: getScreenHeight(16),
                                  fontWeight: FontWeight.w600,
                                ),
                              ),
                            ),
                          ),
                        ),
                        child: Text(
                          'Show full transcript',
                          style: GoogleFonts.manrope(
                            color: blue01,
                            fontSize: getScreenHeight(14),
                            fontWeight: FontWeight.w600,
                          ),
                        ),
                      ),
                    ),
              VerticalSpacingMobile(heightValue: getScreenHeight(10)),
              context.watch<RecordController>().hasFinishedRecording == null
                  ? Column(
                      children: [
                        VerticalSpacingMobile(
                            heightValue:
                                MediaQuery.of(context).size.height / 3),
                        Center(
                          child: Text(
                            'Tap the button to start a\nvoice chat with Alindor',
                            textAlign: TextAlign.center,
                            style: GoogleFonts.manrope(
                              color: Colors.white38,
                              fontSize: getScreenHeight(18),
                              fontWeight: FontWeight.w500,
                            ),
                          ),
                        ),
                      ],
                    )
                  : context.watch<RecordController>().hasFinishedRecording ==
                          true
                      ? Column(
                          children: [
                            Container(
                              height: getScreenHeight(250),
                              width: MediaQuery.of(context).size.width,
                              padding: EdgeInsets.all(getScreenHeight(15)),
                              decoration: BoxDecoration(
                                color: const Color.fromARGB(38, 255, 255, 255),
                                borderRadius:
                                    BorderRadius.circular(getScreenHeight(10)),
                              ),
                              child: SingleChildScrollView(
                                child: Text(
                                  context.watch<RecordController>().transcript,
                                  style: GoogleFonts.manrope(
                                    color: Colors.white,
                                    fontSize: getScreenHeight(25),
                                    fontWeight: FontWeight.w600,
                                  ),
                                ),
                              ),
                            ),
                            VerticalSpacingMobile(
                                heightValue: getScreenHeight(20)),
                            ...List.generate(
                                metricsTitle.length,
                                (index) => ListTile(
                                    title: Text(
                                      metricsTitle[index],
                                      style: GoogleFonts.manrope(
                                        color: Colors.white,
                                        fontSize: getScreenHeight(14),
                                        fontWeight: FontWeight.w600,
                                      ),
                                    ),
                                    trailing: SizedBox(
                                      height: getScreenHeight(20),
                                      width: getScreenHeight(140),
                                      child: Row(
                                        children: [
                                          SizedBox(
                                            height: getScreenHeight(10),
                                            width: getScreenHeight(90),
                                            child: LinearProgressIndicator(
                                              value: metricsValue[index],
                                              color: Colors.white,
                                              borderRadius:
                                                  BorderRadius.circular(
                                                      getScreenHeight(10)),
                                              backgroundColor:
                                                  const Color(0xFF4B3886)
                                                      .withOpacity(0.5),
                                              minHeight: getScreenHeight(10),
                                            ),
                                          ),
                                          SizedBox(
                                            width: getScreenHeight(5),
                                          ),
                                          Text(
                                            '${metricsValue[index] * 100}%',
                                            style: GoogleFonts.manrope(
                                              color: Colors.white,
                                              fontSize: getScreenHeight(12),
                                              fontWeight: FontWeight.w600,
                                            ),
                                          ),
                                        ],
                                      ),
                                    ))),
                            VerticalSpacingMobile(
                                heightValue: getScreenHeight(20)),
                            Text(
                              'Actions',
                              style: GoogleFonts.manrope(
                                color: Colors.white70,
                                fontSize: getScreenHeight(18),
                                fontWeight: FontWeight.w600,
                              ),
                            ),
                            VerticalSpacingMobile(
                                heightValue: getScreenHeight(10)),
                            Container(
                              width: MediaQuery.of(context).size.width,
                              padding: EdgeInsets.all(getScreenHeight(15)),
                              decoration: BoxDecoration(
                                color: const Color.fromARGB(38, 255, 255, 255),
                                borderRadius:
                                    BorderRadius.circular(getScreenHeight(10)),
                              ),
                              child: SingleChildScrollView(
                                child: Column(
                                  crossAxisAlignment: CrossAxisAlignment.start,
                                  children: [
                                    Row(
                                      children: [
                                        CircleAvatar(
                                            radius: getScreenHeight(17),
                                            child: const Icon(
                                                Icons.workspace_premium_rounded,
                                                color: Colors.white)),
                                        SizedBox(
                                          width: getScreenHeight(5),
                                        ),
                                        Text(
                                          'Behaviour',
                                          style: GoogleFonts.manrope(
                                            color: Colors.white,
                                            fontSize: getScreenHeight(18),
                                            fontWeight: FontWeight.w600,
                                          ),
                                        ),
                                      ],
                                    ),
                                    VerticalSpacingMobile(
                                        heightValue: getScreenHeight(10)),
                                    Text(
                                      'User is an introvert, friendly. User is a good listener, but does not like to keep up with social situations.',
                                      style: GoogleFonts.manrope(
                                        color: Colors.white,
                                        fontSize: getScreenHeight(14),
                                        fontWeight: FontWeight.w600,
                                      ),
                                    ),
                                  ],
                                ),
                              ),
                            ),
                            VerticalSpacingMobile(
                                heightValue: getScreenHeight(15)),
                            Container(
                              width: MediaQuery.of(context).size.width,
                              padding: EdgeInsets.all(getScreenHeight(15)),
                              decoration: BoxDecoration(
                                color: const Color.fromARGB(38, 255, 255, 255),
                                borderRadius:
                                    BorderRadius.circular(getScreenHeight(10)),
                              ),
                              child: SingleChildScrollView(
                                child: Column(
                                  crossAxisAlignment: CrossAxisAlignment.start,
                                  children: [
                                    Row(
                                      children: [
                                        CircleAvatar(
                                            radius: getScreenHeight(17),
                                            child: const Icon(Icons.people,
                                                color: Colors.white)),
                                        SizedBox(
                                          width: getScreenHeight(5),
                                        ),
                                        Text(
                                          'Summary',
                                          style: GoogleFonts.manrope(
                                            color: Colors.white,
                                            fontSize: getScreenHeight(18),
                                            fontWeight: FontWeight.w600,
                                          ),
                                        ),
                                      ],
                                    ),
                                    VerticalSpacingMobile(
                                        heightValue: getScreenHeight(10)),
                                    Text(
                                      'User Mentioned he/she does not like to keep up with social situations.',
                                      style: GoogleFonts.manrope(
                                        color: Colors.white,
                                        fontSize: getScreenHeight(14),
                                        fontWeight: FontWeight.w600,
                                      ),
                                    ),
                                  ],
                                ),
                              ),
                            ),
                            VerticalSpacingMobile(
                                heightValue: getScreenHeight(15)),
                            Container(
                              width: MediaQuery.of(context).size.width,
                              padding: EdgeInsets.all(getScreenHeight(15)),
                              decoration: BoxDecoration(
                                color: const Color.fromARGB(38, 255, 255, 255),
                                borderRadius:
                                    BorderRadius.circular(getScreenHeight(10)),
                              ),
                              child: SingleChildScrollView(
                                child: Column(
                                  crossAxisAlignment: CrossAxisAlignment.start,
                                  children: [
                                    Row(
                                      children: [
                                        CircleAvatar(
                                            radius: getScreenHeight(17),
                                            child: const Icon(
                                                Icons.animation_outlined,
                                                color: Colors.white)),
                                        SizedBox(
                                          width: getScreenHeight(5),
                                        ),
                                        Text(
                                          'Interests',
                                          style: GoogleFonts.manrope(
                                            color: Colors.white,
                                            fontSize: getScreenHeight(18),
                                            fontWeight: FontWeight.w600,
                                          ),
                                        ),
                                      ],
                                    ),
                                    VerticalSpacingMobile(
                                        heightValue: getScreenHeight(10)),
                                    Wrap(runSpacing: 8, spacing: 8, children: [
                                      ...List.generate(
                                          interests.length,
                                          (index) => ChoiceChip(
                                                label: Text(interests[index]),
                                                showCheckmark: false,
                                                labelStyle: TextStyle(
                                                  fontSize: getScreenHeight(14),
                                                  fontWeight: FontWeight.w500,
                                                  color: primaryBlack,
                                                ),
                                                selected: true,
                                                selectedColor: Colors.white,
                                                backgroundColor:
                                                    Colors.transparent,
                                              ))
                                    ])
                                  ],
                                ),
                              ),
                            ),
                            VerticalSpacingMobile(
                                heightValue: getScreenHeight(15)),
                            Container(
                              width: MediaQuery.of(context).size.width,
                              padding: EdgeInsets.all(getScreenHeight(15)),
                              decoration: BoxDecoration(
                                color: const Color.fromARGB(38, 255, 255, 255),
                                borderRadius:
                                    BorderRadius.circular(getScreenHeight(10)),
                              ),
                              child: SingleChildScrollView(
                                child: Column(
                                  crossAxisAlignment: CrossAxisAlignment.start,
                                  children: [
                                    Row(
                                      children: [
                                        CircleAvatar(
                                            radius: getScreenHeight(17),
                                            child: const Icon(
                                                Icons.thumb_down_alt_rounded,
                                                color: Colors.white)),
                                        SizedBox(
                                          width: getScreenHeight(5),
                                        ),
                                        Text(
                                          'Dislikes',
                                          style: GoogleFonts.manrope(
                                            color: Colors.white,
                                            fontSize: getScreenHeight(18),
                                            fontWeight: FontWeight.w600,
                                          ),
                                        ),
                                      ],
                                    ),
                                    VerticalSpacingMobile(
                                        heightValue: getScreenHeight(10)),
                                    Wrap(runSpacing: 8, spacing: 8, children: [
                                      ...List.generate(
                                          interests.length,
                                          (index) => ChoiceChip(
                                                label: Text(dislikes[index]),
                                                showCheckmark: false,
                                                labelStyle: TextStyle(
                                                  fontSize: getScreenHeight(14),
                                                  fontWeight: FontWeight.w500,
                                                  color: primaryBlack,
                                                ),
                                                selected: true,
                                                selectedColor: Colors.white,
                                                backgroundColor:
                                                    Colors.transparent,
                                              ))
                                    ])
                                  ],
                                ),
                              ),
                            ),
                            VerticalSpacingMobile(
                                heightValue: getScreenHeight(50))
                          ],
                        )
                      : const SizedBox.shrink()
            ],
          ),
        ),
      ),
      floatingActionButton: FloatingActionButton(
        backgroundColor: primaryColor,
        child: context.watch<RecordController>().isRecording
            ? const Icon(
                Icons.stop,
                color: Colors.white,
              )
            : const Icon(
                Icons.mic,
                color: Colors.white,
              ),
        onPressed: () {
          context.read<RecordController>().toggleRecording(context);
        },
      ),
    );
  }
}
