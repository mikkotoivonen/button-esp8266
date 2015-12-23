# Button ESP8266

Simple LUA code to make the ESP8266 work as an "Internet" button. When the button is pressed the ESP board resets and sends a string in the following format:
{"buttonPress","id"="xx:xx:xx:xx:xx:xx","tag"=""}

The id is the MAC address of the board.

Change the parameters to control where the board sends data.
