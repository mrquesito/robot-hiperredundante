#define pinDIR 13
#define pinSTEP 6

#define maxPositivo 4250  //DIR: HIGH
#define maxNegativo 3480  //DIR: LOW
/*
PONERLO A CERO AL INICIO, MANUALMENTE
 */

// Pin 13 has an LED connected on most Arduino boards.
// Pin 11 has the LED on Teensy 2.0
// Pin 6  has the LED on Teensy++ 2.0
// Pin 13 has the LED on Teensy 3.0
// give it a name:


int nPasos;

// the setup routine runs once when you press reset:
void setup() {                
  Serial.begin(9600); 
  // initialize the digital pin as an output.
  pinMode(pinDIR, OUTPUT);     
  pinMode(pinSTEP,OUTPUT);
  digitalWrite(pinDIR, HIGH);
}

// the loop routine runs over and over again forever:
void loop() {
  nPasos = 0;
  if (Serial.available()){

    //Avanzamos hasta el máximo positivo
    for (int i = 0; i < maxPositivo; i++){
      digitalWrite(pinSTEP, HIGH);   // turn the LED on (HIGH is the voltage level)
      delayMicroseconds(200);              // wait for a second
      digitalWrite(pinSTEP, LOW);    // turn the LED off by making the voltage LOW
      delayMicroseconds(200); 
    }    
    for (char j = 0; j < 10; j++){
      //Cambiamos de sentido
      digitalWrite(pinDIR,LOW);

      //Nos vamos al otro extremo
      for (int i = 0; i < maxPositivo+maxNegativo; i++){
        digitalWrite(pinSTEP, HIGH);   // turn the LED on (HIGH is the voltage level)
        delayMicroseconds(200);               // wait for a second
        digitalWrite(pinSTEP, LOW);    // turn the LED off by making the voltage LOW
        delayMicroseconds(200); 
      }  

      //Volvemos a cambiar de signo
      digitalWrite(pinDIR,HIGH);
      //Nos vamos al otro extremo
      for (int i = 0; i < maxPositivo+maxNegativo; i++){
        digitalWrite(pinSTEP, HIGH);   // turn the LED on (HIGH is the voltage level)
        delayMicroseconds(200);               // wait for a second
        digitalWrite(pinSTEP, LOW);    // turn the LED off by making the voltage LOW
        delayMicroseconds(200); 
      }  
    }
  }
}


