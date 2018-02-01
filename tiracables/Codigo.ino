//Motor 0
#define PIN_STEP 6
#define PIN_DIR  7
#define DIRSIGN   1
#define M0 10
#define M1 9
#define M2 8

//FDC
#define PIN_FDC_HOME 53
#define PIN_REF_HOME 52 //A masa (rojos)
#define PIN_FDC_TOP 51
#define PIN_REF_TOP 50 //A masa
#define PIN_FDC_CABLE 49
#define PIN_REF_CABLE 48 //A masa

//Serial
String mensaje = "Hola";
char comando = 0;   //1: H (Home)  -  2: M (Medir)  -  3: L (Laxo)  -  4: T (Tenso)
float distancia = 0;

//Tiempos
#define DELAY_US_NORMAL 400
#define DELAY_US_LENTO 800

//Variables de programa
long pasoActual = 0;
long pasosMax = 0;

float xActual = 0;
float xMax = 0;

void setup() {
  //Serial
  Serial.begin(19200);

  //Dirección y estado pines
  pinMode(PIN_STEP, OUTPUT);
  pinMode(PIN_DIR,  OUTPUT);
  digitalWrite(PIN_STEP, LOW);
  digitalWrite(PIN_DIR,  LOW);

  pinMode(M0, OUTPUT);  //Micropasos, 1/4
  pinMode(M1, OUTPUT);
  pinMode(M2, OUTPUT);
  digitalWrite(M0, LOW);
  digitalWrite(M1, HIGH);
  digitalWrite(M2, LOW);

  pinMode(PIN_FDC_HOME, INPUT);
  pinMode(PIN_FDC_TOP, INPUT);
  pinMode(PIN_FDC_CABLE, INPUT);
  digitalWrite(PIN_FDC_HOME, HIGH); //Pullups
  digitalWrite(PIN_FDC_TOP, HIGH);
  digitalWrite(PIN_FDC_CABLE, HIGH);

  pinMode(PIN_REF_HOME, OUTPUT);
  pinMode(PIN_REF_TOP, OUTPUT);
  pinMode(PIN_REF_CABLE, OUTPUT);
  digitalWrite(PIN_REF_HOME, LOW);  //Mandamos a masa
  digitalWrite(PIN_REF_TOP, LOW);
  digitalWrite(PIN_REF_CABLE, LOW);

  irAHome();
//  Serial.println(pasosMax);
//  Serial.println(xMax);
}


void loop() {
  if (Serial.available()) {
    mensaje = Serial.readString();
    procesarString(mensaje, &comando, &distancia);
    //imprimirComando(comando, distancia);
    //imprimirFDC();
    if (comando != 0) {
      switch (comando) {
        case 1:
          Serial.print("Yendo a home...");
          irAHome();
          Serial.println(" y aparcao.");
          break;
        case 2:
          Serial.println("Midiendo recorrido del carro...");
          medirRecorrido();
          Serial.print("Limite en pasos: ");
          Serial.print(pasosMax);
          Serial.print(". Limite en mm: ");
          Serial.println(xMax);
          break;
        case 3:
          Serial.print("Yendo laxo a ");
          Serial.print(distancia);
          Serial.print(" mm.");
          irAPosicion(distancia);
          Serial.println(" Hecho.");
          break;
        case 4:
          Serial.print("Yendo a ");
          Serial.print(distancia);
          Serial.print(" mm.");
          irAPosicionTensado(distancia);
          Serial.print(" Y tensado. La posicion es ");
          Serial.print(xActual);
          Serial.println(" mm.");
          break;
      }
    }
  }
}

void procesarString(String mensaje, char *comando, float *distancia) {
  char p = mensaje[0];
  switch (p) {
    case 'H':
      *comando = 1;
      break;
    case 'M':
      *comando = 2;
      break;
    case 'L':
      *comando = 3;
      break;
    case 'T':
      *comando = 4;
      break;
    default:
      *comando = 0;
      break;
  }

  if ((p == 'T') || (p == 'L')) {
    mensaje[0] = '0';
    *distancia = mensaje.toFloat();
  } else {
    *distancia = 0;
  }

}

void irAHome(void) {
  while (!FDC_Home_Pulsado()) {
    moverPasoNormal(1);
  }
  for (int i = 0; i < 1000; i++) {
    moverPasoLento(0);
  }
  while (!FDC_Home_Pulsado()) {
    moverPasoLento(1);
  }
  pasoActual = 0;
  xActual = 0;
}

void irATop(void) {
  while (!FDC_Top_Pulsado()) {
    moverPasoNormal(0);
  }
  for (int i = 0; i < 1000; i++) {
    moverPasoLento(1);
  }
  while (!FDC_Top_Pulsado()) {
    moverPasoLento(0);
  }
}

void moverPasoNormal(boolean sentido) { //0: positivo, 1: negativo [signo]
  digitalWrite(PIN_DIR, !sentido);
  digitalWrite(PIN_STEP, LOW);
  delayMicroseconds(DELAY_US_NORMAL);
  digitalWrite(PIN_STEP, HIGH);
  delayMicroseconds(DELAY_US_NORMAL);
  if (sentido) {
    pasoActual--;
  } else {
    pasoActual++;
  }
}

void moverPasoLento(boolean sentido) { //0: positivo, 1: negativo [signo]
  digitalWrite(PIN_DIR, !sentido);
  digitalWrite(PIN_STEP, LOW);
  delayMicroseconds(DELAY_US_LENTO);
  digitalWrite(PIN_STEP, HIGH);
  delayMicroseconds(DELAY_US_LENTO);
  if (sentido) {
    pasoActual--;
  } else {
    pasoActual++;
  }
}

void medirRecorrido(void) {
  irAHome();
  irATop();
  pasosMax = pasoActual;
  xMax = (float) pasosMax / 100;  //x en mm

}

void irAPaso(long paso) {   //Ir a la posicion paso, medida en pasos desde el origen
  long diff = paso - pasoActual;
  for (int i = 0; i < abs(diff); i++) {
    moverPasoNormal(diff < 0);
    if ((diff > 0 && FDC_Top_Pulsado()) || (diff < 0 && FDC_Home_Pulsado())) {
      break;
    }
  }
}

void irAPosicion(float x) {
  long paso = (long) x * 100;
  irAPaso(paso);
  actualizarPosicionActual();
}

void irAPosicionTensado(float x){
  irAPosicion(x);
  tensar();
  actualizarPosicionActual();
}

void tensar(void){
  while(!FDC_Cable_Pulsado() && !FDC_Home_Pulsado()){
    moverPasoLento(1);
  }
}

void actualizarPosicionActual(void){
  xActual = ((float) pasoActual)/100;
}

void imprimirComando(char comando, float distancia) {
  switch (comando) {
    case 0:
      Serial.println("No hay comandos");
      break;
    case 1:
      Serial.println("Home");
      break;
    case 2:
      Serial.println("Medir");
      break;
    case 3:
      Serial.print("Laxo, ");
      Serial.println(distancia);
      break;
    case 4:
      Serial.print("Tenso, ");
      Serial.println(distancia);
      break;
  }
}

void imprimirFDC(void) {
  Serial.print("Home: ");
  Serial.print(FDC_Home_Pulsado());
  Serial.print(", Top: ");
  Serial.print(FDC_Top_Pulsado());
  Serial.print(", Cable: ");
  Serial.println(FDC_Cable_Pulsado());
}

boolean FDC_Home_Pulsado(void) {
  return !digitalRead(PIN_FDC_HOME);
}

boolean FDC_Top_Pulsado(void) {
  return !digitalRead(PIN_FDC_TOP);
}

boolean FDC_Cable_Pulsado(void) {
  return !digitalRead(PIN_FDC_CABLE);
}




