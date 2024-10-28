

import 'package:awesome_snackbar_content/awesome_snackbar_content.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

class UIHelper {

  static Color primaryButtonGreen= Color.fromARGB(255, 20, 124, 107);
  static Color primaryButtonBlue= Color.fromARGB(255, 5, 142, 255);
  static Color primaryBorderTextFieldGray= Color.fromARGB(255, 139, 161, 180);
  static Color primaryBorderTableGray= Color.fromARGB(255, 193, 203, 211);
  static Color primaryPaymentYellow= Color.fromARGB(255, 255, 211, 67);

  static Color primaryBlueBold = const Color.fromRGBO(101, 192, 212, 1);
  static Color primaryBlueLight = const Color.fromRGBO(163, 217, 229, 1);
  static Color primaryBlueCard = const Color.fromRGBO(224, 242, 246, 1);
  static Color darkBlueTextCard = const Color.fromRGBO(61, 115, 127, 1);
  static Color primaryOrange = const Color.fromRGBO(255, 186, 118, 1);

  static ConstrainedBox getElevatedButton(Widget? svg,  double borderRadius, String text, double? width , double height, double? elevationButton, BorderSide borderSide, Color bgColor, VoidCallback? onPressed, [double? fontSizeText, Color? colorText, FontWeight? fontWeightText]){
    return ConstrainedBox(
      constraints:  BoxConstraints.tightFor(width: width, height: height),
      child: ElevatedButton(
        style: ElevatedButton.styleFrom(
          //si no asignas un color explícitamente el texto lo hace un poco mas "bold"
          //textStyle: TextStyle(
          //  color: colorText

          //),
          padding: EdgeInsets.symmetric(horizontal: 5, vertical: 0),
          elevation: elevationButton,
          backgroundColor: bgColor,
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(borderRadius),
            //si lo quieres sin estilos en border envía BorderSide.none
            //ejemplo de estilo: BorderSide(color: Colors.orange, width: 2),
            side: borderSide,
          ),

        ),
        onPressed: onPressed,
        child: svg==null?
          getText(text, fontSizeText, colorText, fontWeightText):
          getRowTextIcon(svg,  text, fontSizeText, colorText, fontWeightText)
      ),
    );
  }

  static Text getText(String text, [double? fontSize, Color? color, FontWeight? fontWeight]){
    return Text(
      text,
      style: GoogleFonts.poppins(
        fontSize: fontSize,
        color: color,
        fontWeight: fontWeight
      ),

    );
  }



  static Row getRowTextIcon(Widget svg,  String text, [double? fontSize, Color? color, FontWeight? fontWeight]){
    return Row(
      mainAxisAlignment: MainAxisAlignment.center,
      children: [
        svg,
        const SizedBox(width: 10.0,),
        getText(text, fontSize, color, fontWeight)
      ],
    );
  }

  static SnackBar getSnackBar(String title, String message, ContentType contentType){
    return SnackBar(
      /// need to set following properties for best effect of awesome_snackbar_content
      elevation: 0,
      behavior: SnackBarBehavior.floating,
      backgroundColor: Colors.transparent,
      duration: const Duration(seconds: 5),
      content: AwesomeSnackbarContent(
        title: title,
        message:message,
        contentType: contentType
      ),
    );
  }
  

}