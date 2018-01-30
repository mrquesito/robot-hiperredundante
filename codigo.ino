
#define PINDIR 13
int lectura;
boolean direccion = 0;
void setup() {
  // put your setup code here, to run once:
  TCCR0A = 66;
  TCCR0B = 4;
  OCR0A = 16;
  DDRD = 64;
  pinMode(PINDIR,OUTPUT);
  digitalWrite(PINDIR,direccion);
}

void loop() {
  // put your main code here, to run repeatedly: 
  lectura = analogRead(A0);
  if(lectura>512){
    direccion = !direccion;
    digitalWrite(PINDIR,direccion);
  }
  delay(10);
}
