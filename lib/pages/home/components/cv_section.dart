import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:responsive_framework/responsive_framework.dart';
import 'package:url_launcher/url_launcher.dart';
import 'package:web_portfolio/models/design_process.dart';
import 'package:web_portfolio/utils/constants.dart';
import 'package:web_portfolio/utils/screen_helper.dart';

final List<DesignProcess> designProcesses = [
  DesignProcess(
    title: "DISEÑO",
    imagePath: "assets/design.png",
    subtitle:
        "El diseño es el proceso de creación de un producto o servicio con un propósito específico y un público objetivo",
  ),
  DesignProcess(
    title: "DESARROLLO",
    imagePath: "assets/develop.png",
    subtitle:
        "El desarrollo es el proceso de completar un producto o servicio para satisfacer las necesidades de un público objetivo",
  ),
  DesignProcess(
    title: "CALIDAD",
    imagePath: "assets/write.png",
    subtitle:
        "La calidad es el grado en que un conjunto de características inherentes satisfacen las necesidades",
  ),
  DesignProcess(
    title: "MANTENIMIENTO",
    imagePath: "assets/promote.png",
    subtitle:
        "El mantenimiento es el proceso de mantener un producto o servicio en un estado deseado de funcionamiento",
  ),
];

class CvSection extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Container(
      width: double.infinity,
      child: ScreenHelper(
        desktop: _buildUi(context, kDesktopMaxWidth),
        tablet: _buildUi(context, kTabletMaxWidth),
        mobile: _buildUi(context, getMobileMaxWidth(context)),
      ),
    );
  }

  Widget _buildUi(BuildContext context, double width) {
    // we need the context to get maxWidth before the constraints below
    return ResponsiveWrapper(
      maxWidth: width,
      minWidth: width,
      defaultScale: false,
      child: Column(
        mainAxisAlignment: MainAxisAlignment.start,
        children: [
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Text(
                "CALIDAD DE SERVICIO,\nCALIDAD DE TRABAJO",
                style: GoogleFonts.oswald(
                  color: Colors.white,
                  fontWeight: FontWeight.w900,
                  height: 1.8,
                  fontSize: 18.0,
                ),
              ),
              GestureDetector(
                onTap: () async {
                  if (!await launchUrl(
                      Uri.parse('https://github.com/andresadar'))) {
                    throw 'Could not launch \$GITHUB/ANDRESADAR';
                  }
                },
                child: MouseRegion(
                  cursor: SystemMouseCursors.click,
                  child: Text(
                    "DESCARGAR CV",
                    style: GoogleFonts.oswald(
                      color: kPrimaryColor,
                      fontWeight: FontWeight.w900,
                      fontSize: 16.0,
                    ),
                  ),
                ),
              ),
            ],
          ),
          SizedBox(
            height: 50.0,
          ),
          Container(
            child: LayoutBuilder(
              builder: (_context, constraints) {
                return ResponsiveGridView.builder(
                  padding: EdgeInsets.all(0.0),
                  shrinkWrap: true,
                  physics: NeverScrollableScrollPhysics(),
                  alignment: Alignment.topCenter,
                  gridDelegate: ResponsiveGridDelegate(
                    mainAxisSpacing: 20.0,
                    crossAxisSpacing: 20.0,
                    maxCrossAxisExtent: ScreenHelper.isTablet(context) ||
                            ScreenHelper.isMobile(context)
                        ? constraints.maxWidth / 2.0
                        : 250.0,
                    // Hack to adjust child height
                    childAspectRatio: ScreenHelper.isDesktop(context)
                        ? 1
                        : MediaQuery.of(context).size.aspectRatio * 1.5,
                  ),
                  itemBuilder: (BuildContext context, int index) {
                    return Container(
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Row(
                            mainAxisAlignment: MainAxisAlignment.start,
                            children: [
                              Image.asset(
                                designProcesses[index].imagePath,
                                width: 40.0,
                              ),
                              SizedBox(
                                width: 15.0,
                              ),
                              Text(
                                designProcesses[index].title,
                                style: GoogleFonts.oswald(
                                  fontSize: 20.0,
                                  fontWeight: FontWeight.w700,
                                  color: Colors.white,
                                ),
                              )
                            ],
                          ),
                          SizedBox(
                            height: 15.0,
                          ),
                          Text(
                            designProcesses[index].subtitle,
                            style: TextStyle(
                              color: kCaptionColor,
                              height: 1.5,
                              fontSize: 14.0,
                            ),
                          )
                        ],
                      ),
                    );
                  },
                  itemCount: designProcesses.length,
                );
              },
            ),
          )
        ],
      ),
    );
  }
}
