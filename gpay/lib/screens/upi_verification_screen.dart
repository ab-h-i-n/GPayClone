import 'package:flutter/material.dart';
import 'package:gpay/constants/app_logos.dart';

class UPIVerificationScreen extends StatelessWidget {
  const UPIVerificationScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      body: SafeArea(
        child: Column(

          children: [
            // Bank Info Header
            Padding(
              padding: const EdgeInsets.all(20),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text('State Bank of India',
                          style: TextStyle(
                            fontSize: 14,
                            fontWeight: FontWeight.bold,
                          )),
                      Text('XXX0064',
                          style: TextStyle(
                            fontSize: 16,
                            color: Colors.grey[600],
                          )),
                    ],
                  ),
                  Image(
                    image: AssetImage(AppLogos.upiLogo),
                    height: 40,
                  )
                ],
              ),
            ),

            // Account Selector
            Container(
              padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 16),
              decoration: BoxDecoration(
                color: Colors.grey[200],
                border: Border(
                  bottom: BorderSide(
                    color: Colors.grey[300]!,
                    width: 1,
                  ),
                ),
              ),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Text('XXXXXXX0064'),
                  Icon(Icons.keyboard_arrow_down)
                ],
              ),
            ),

            // PIN Entry Section
            Container(
              padding: const EdgeInsets.all(20),
              child: Column(
                children: [
                  Text('ENTER 6-DIGIT UPI PIN',
                      style: TextStyle(
                        fontSize: 14,
                        fontWeight: FontWeight.bold,
                      )),
                  SizedBox(height: 32),
                  LineStylePinInput(
                    onPinCompleted: (pin) {
                      debugPrint("Entered PIN: $pin");
                      // Handle PIN verification here
                    },
                  ),
                ],
              ),
            ),

            SizedBox(height: 30),

            Text(
              'UPI PIN will keep your account secure from unauthorized access. Do not share this PIN with anyone.',
              textAlign: TextAlign.center,
              style: TextStyle(
                fontSize: 12,
                color: Colors.grey[500],
              ),
            ),


            //keyboard section at bottom 
            
          ],
        ),
      ),
    );
  }
}

class LineStylePinInput extends StatefulWidget {
  final Function(String) onPinCompleted;

  const LineStylePinInput({super.key, required this.onPinCompleted});

  @override
  _LineStylePinInputState createState() => _LineStylePinInputState();
}

class _LineStylePinInputState extends State<LineStylePinInput> {
  List<String> digits = List.filled(6, '');
  List<FocusNode> focusNodes = List.generate(6, (index) => FocusNode());

  @override
  Widget build(BuildContext context) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceEvenly,
      children: List.generate(6, (index) {
        return Container(
          width: 40,
          decoration: BoxDecoration(
            border: Border(
              bottom: BorderSide(
                color: focusNodes[index].hasFocus 
                  ? const Color.fromARGB(255, 0, 0, 0) 
                  : Colors.grey,
                width: 2,
              ),
            ),
          ),
          child: TextField(
            obscureText: true,
            keyboardType: TextInputType.number,
            textAlign: TextAlign.center,
            maxLength: 1,
            style: TextStyle(fontSize: 24),
            cursorColor: Colors.black,
            decoration: InputDecoration(
              counterText: '',
              border: InputBorder.none,
              contentPadding: EdgeInsets.only(bottom: 10),
            ),
            onChanged: (value) {
              setState(() {
                if (value.length == 1) {
                  digits[index] = value;
                  if (index < 5) {
                    FocusScope.of(context).requestFocus(focusNodes[index + 1]);
                  } else {
                    widget.onPinCompleted(digits.join());
                  }
                } else if (value.isEmpty && index > 0) {
                  FocusScope.of(context).requestFocus(focusNodes[index - 1]);
                }
              });
            },
            focusNode: focusNodes[index],
          ),
        );
      }),
    );
  }

  @override
  void dispose() {
    for (var node in focusNodes) {
      node.dispose();
    }
    super.dispose();
  }
}