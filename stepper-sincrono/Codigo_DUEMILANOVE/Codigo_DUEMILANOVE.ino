#define PIN_ENABLE 8
//Motor 0
#define PIN_STEP_0 2
#define PIN_DIR_0  5
#define DIRSIGN_0   0
//Motor 1
#define PIN_STEP_1 3
#define PIN_DIR_1  6
#define DIRSIGN_1   0
//Motor 2
#define PIN_STEP_2 4
#define PIN_DIR_2  7
#define DIRSIGN_2   0
//Motor 3
#define PIN_STEP_3 12
#define PIN_DIR_3  13
#define DIRSIGN_3   1

boolean enComando = false;
char i = 0;
int signoInt = 0; //Signo para leer del String
char palabra;
unsigned char ENABLE = 1;

const unsigned char PIN_STEP[] = {PIN_STEP_0, PIN_STEP_1, PIN_STEP_2, PIN_STEP_3};  //Pines de pulsos
const unsigned char PIN_DIR[] = {PIN_DIR_0, PIN_DIR_1, PIN_DIR_2, PIN_DIR_3};       //Pines de dirección
const unsigned char DIRSIGN[] = {DIRSIGN_0, DIRSIGN_1, DIRSIGN_2, DIRSIGN_3};            //Sentido de giro
volatile unsigned char CNT[] = {0, 0, 0, 0};     //Contadores de división de frecuencia
unsigned char MOD[] = {19, 19, 19, 19};   //División de frecuencia (módulo) para cada motor
volatile boolean enMovimiento[] = {false, false, false, false};  //El motor tiene un movimiento en proceso
volatile unsigned int nPasos[] = {0, 0, 0, 0};   //Pasos restantes que dar, para cada motor
boolean signo[] = {false, false, false, false};   //Signo del movimiento actual

void setup() {
  //Serial
  Serial.begin(19200);

  //Dirección y estado pines
  for(i = 0; i < 4; i++){
    pinMode(PIN_STEP[i], OUTPUT);
    pinMode(PIN_DIR[i],  OUTPUT);
    digitalWrite(PIN_STEP[i], LOW);
    digitalWrite(PIN_DIR[i],  LOW);
  }
  digitalWrite(PIN_ENABLE,LOW);
  pinMode(PIN_ENABLE, OUTPUT);  
  ENABLE = 1;

  //Configuración ISR como CTC
  TCCR1A = 1; //0000xx01
  TCCR1B = 3; //00x00011, 250kHz
  TCCR1C = 0; //00xxxxxx
  OCR1A = 24; //Divisón para 25 -> 10kHz
  TIMSK1 = 2; //xx0xx010, interrupción activada
   
}

void loop() {
  if (Serial.available()){
    enComando = enMovimiento[0] || enMovimiento[1] || enMovimiento[2] || enMovimiento[3];  
    if(!enComando){
      //Serial.print('A');
      TIMSK1 = 0; //Interrupción desactivada
      for(i = 0; i < 4; i++){
        //Serial.print(i,HEX);
        signoInt = Serial.parseInt();
        if(signoInt){
          signo[i] = true;
          digitalWrite(PIN_DIR[i],DIRSIGN[i]);
        }else{
          signo[i] = false;
          digitalWrite(PIN_DIR[i],!DIRSIGN[i]); 
        }
        nPasos[i] = (unsigned int)Serial.parseInt();
        if(nPasos[i]){
          enMovimiento[i] = true;
        }
        MOD[i] = (unsigned char)Serial.parseInt();
      }
      ENABLE = (unsigned char)Serial.parseInt();
      if(ENABLE){
        digitalWrite(PIN_ENABLE,LOW);
      }else{
        digitalWrite(PIN_ENABLE,HIGH);
      }
      Serial.print('C');
      imprimeConf();
      palabra = Serial.read();  //Chapucilla para limpiar el final de línea
      palabra = Serial.read();
      TIMSK1 = 2; //Interrupción activada
    }
  }
}

//Esto se ejecuta cada 0.1ms
ISR(TIMER1_COMPA_vect){
  //Serial.print('1');
  for(i = 0; i < 4; i++){
    if(enMovimiento[i]){
      CNT[i]++;
      if(CNT[i] == MOD[i]){
        CNT[i] = 0;
        digitalWrite(PIN_STEP[i],HIGH); //Toggle
        nPasos[i]--;
        if(!nPasos[i]){
          enMovimiento[i] = false;
          //Miramos si queda alguno
          if(!(enMovimiento[0] || enMovimiento[1] || enMovimiento[2] || enMovimiento[3])){
              Serial.print("D");
          }
        }
        digitalWrite(PIN_STEP[i],LOW);
      }
    }
  } 
}

void imprimeConf(void){    
  Serial.print("\n");
  for(i = 0; i < 4; i++){
    Serial.print(" | M");
    Serial.print(i,HEX);
    Serial.print(": ");
    if(!signo[i]){
      Serial.print("+");
    }else{
      Serial.print("-");
    }
    Serial.print(nPasos[i]);
    Serial.print(", ");
    Serial.print(MOD[i]);
  }
  Serial.print(" | EN: ");
  Serial.print(ENABLE);
  Serial.print("\n");
}

