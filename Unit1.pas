unit Unit1;

interface

uses
  Winapi.Windows, Winapi.Messages, System.SysUtils, System.Variants,
  System.Classes, Vcl.Graphics, Vcl.Controls, Vcl.Forms, Vcl.Dialogs,
  Vcl.StdCtrls, Vcl.Mask, Vcl.ExtCtrls, System.DateUtils, System.UITypes,
  System.JSON, Vcl.Menus, System.ImageList, Vcl.ImgList, System.StrUtils,
  ShellApi, Vcl.Samples.Gauges;

type
  TJusticado = (tjLeft, tjCenter, tjRight);

type
  TCountryCapital = record
    Country : string;
    Capital : string;
  end;

type
  TForm1 = class(TForm)
    Button1: TButton;
    Memo1: TMemo;
    EdCant: TLabeledEdit;
    Button2: TButton;
    Gauge1: TGauge;
    procedure Button1Click(Sender: TObject);
    procedure FormCreate(Sender: TObject);
    procedure Button2Click(Sender: TObject);
  private
    FLastGeneratedCapital : string;
    CountriesCapitals : array of TCountryCapital;
    _firstName : array of string;
    _lastName : array of string;
    function GetRandomFirstName : string;
    function GetRandomLastName : string;
//    function GetRandomFullName : string;
    function GenerateRandomDate(StartDate, EndDate : TDate) : TDate;
    function GenerateRandomEmail : string;
    function GenerateRandomTime(StartTime, EndTime : TTime) : TTime;
    function GenerateRandomPhoneNumber : string;
    function GenerateRandomCountry : string;
//    function GenerateRandomCity : string;
    function GenerateRandomJobTitle : string;
    function GenerateRandomCompany : string;
    function Justifica(Texto : string; Longitud : SmallInt; Rellena : Char; Justificado : TJusticado) : string;
    function RandomRangeDecimal(Min, Max : Double) : Double;
    property LastGeneratedCapital : string read FLastGeneratedCapital write FLastGeneratedCapital;
  public
    { Public declarations }
  end;

var
  Form1: TForm1;

implementation

{$R *.dfm}

procedure TForm1.Button1Click(Sender: TObject);
var
  I, NumRecords : Integer;
  Texto         : TextFile;
  Ruta          : string;
begin
  Memo1.Lines.Clear;
  NumRecords := StrToInt(EdCant.Text);

  Ruta := ExtractFilePath(Application.ExeName);
  AssignFile(Texto, Ruta + 'Lista.txt');
  Rewrite(Texto);

  for I := 1 to NumRecords do
    begin
      Writeln(Texto, Justifica('codigo : ', 20, ' ', tjRight) + IntToStr(Random(99999) + 1));
      Writeln(Texto, Justifica('nombre : ', 20, ' ', tjRight) +  GetRandomFirstName);
      Writeln(Texto, Justifica('apellido : ', 20, ' ', tjRight) + GetRandomLastName);
      Writeln(Texto, Justifica('email : ', 20, ' ', tjRight) + GenerateRandomEmail);

      //se genera una hora aleatoria dentro de un horario típico de trabajo (de 8:00 AM a 5:00 PM).
      // HORA CORTA AM/PM
      Writeln(Texto, Justifica('hora : ', 20, ' ', tjRight) + FormatDateTime('hh:nn:ss am/pm', GenerateRandomTime(EncodeTime(8, 0, 0, 0), EncodeTime(17, 0, 0, 0))));

      // HORA LARGA 24 HORAS
  //    Writeln(Texto, Justifica('hora ', 20, ' ', tjRight) + FormatDateTime('hh:nn:ss', GenerateRandomTime(EncodeTime(8, 0, 0, 0), EncodeTime(17, 0, 0, 0))));
      Writeln(Texto, Justifica('telefono : ', 20, ' ', tjRight) + GenerateRandomPhoneNumber);
      Writeln(Texto, Justifica('pais : ', 20, ' ', tjRight) + GenerateRandomCountry);
      Writeln(Texto, Justifica('ciudad : ', 20, ' ', tjRight) + LastGeneratedCapital);
      Writeln(Texto, Justifica('compañia : ', 20, ' ', tjRight) + GenerateRandomCompany);
      Writeln(Texto, Justifica('cargo : ', 20, ' ', tjRight) + GenerateRandomJobTitle);
      Writeln(Texto, Justifica('salario : ', 20, ' ', tjRight) + FormatFloat(',0.00', RandomRangeDecimal(10000,50000)));
      Writeln(Texto, Justifica('fecha_contrato : ', 20, ' ', tjRight) + FormatDateTime('yyyy/mm/dd', GenerateRandomDate(StartOfTheYear(Now), EndOfTheYear(Now))));
      Writeln(Texto, ' ');
      Writeln(Texto, '======================================================================');
    end;

  CloseFile(Texto);

  Memo1.Lines.LoadFromFile(Ruta + 'Lista.txt');

  //ABRIMOS EL ARCHIVO GENERADO
  ShellExecute(Handle,'open','c:\windows\notepad.exe',
  PWideChar(Ruta + 'Lista.txt'), nil, SW_SHOWNORMAL);

end;

procedure TForm1.Button2Click(Sender: TObject);
var
  I, NumRecords : Integer;
  Archivo       : TextFile;
  Ruta, Linea   : string;
begin
  Memo1.Lines.Clear;
  NumRecords := StrToInt(EdCant.Text);

  Ruta := ExtractFilePath(Application.ExeName);
  AssignFile(Archivo, Ruta + 'Lista.txt');
  Rewrite(Archivo);

  Gauge1.Progress := 0;
  Gauge1.MaxValue := NumRecords;

  // Escribir la cabecera
  Writeln(Archivo, Justifica('Código', 8, ' ', tjRight) +StringOfChar(' ',3)+
                   Justifica('Nombre', 10, ' ', tjLeft) +' '+
                   Justifica('Apellido', 10, ' ', tjLeft) +' '+
                   Justifica('Email', 30, ' ', tjLeft) +' '+
                   Justifica('Hora', 12, ' ', tjLeft) +StringOfChar(' ',3)+
                   Justifica('Telefono', 15, ' ', tjLeft) +StringOfChar(' ',3)+
                   Justifica('Pais', 15, ' ', tjLeft) +' '+
                   Justifica('Salario', 10, ' ', tjRight) +StringOfChar(' ',5)+
                   Justifica('Fecha Contrato', 15, ' ', tjLeft));

  for I := 1 to NumRecords do
    begin
      Linea := Justifica(IntToStr(Random(99999) + 1), 8, ' ', tjRight) +StringOfChar(' ',3)+
               Justifica(GetRandomFirstName, 10, ' ', tjLeft) +' '+
               Justifica(GetRandomLastName, 10, ' ', tjLeft) +' '+
               Justifica(GenerateRandomEmail, 30, ' ', tjLeft) +' '+
               //se genera una hora aleatoria dentro de un horario t pico de trabajo (de 8:00 AM a 5:00 PM).
               // HORA CORTA AM/PM
               Justifica(FormatDateTime('hh:nn:ss am/pm', GenerateRandomTime(EncodeTime(8, 0, 0, 0), EncodeTime(17, 0, 0, 0))), 12, ' ', tjLeft) +StringOfChar(' ',3)+
               // HORA LARGA 24 HORAS
//               Justifica(FormatDateTime('hh:nn:ss', GenerateRandomTime(EncodeTime(8, 0, 0, 0), EncodeTime(17, 0, 0, 0))), 12, ' ', tjLeft) +StringOfChar(' ',3)+

               Justifica(GenerateRandomPhoneNumber, 15, ' ', tjLeft) +StringOfChar(' ',3)+
               Justifica(GenerateRandomCountry, 15, ' ', tjLeft) +' '+
               Justifica(FormatFloat('#,##0.00', RandomRangeDecimal(10000,50000)), 10, ' ', tjRight) +StringOfChar(' ',5)+
               Justifica(FormatDateTime('yyyy/mm/dd', GenerateRandomDate(StartOfTheYear(Now), EndOfTheYear(Now))), 15, ' ', tjLeft);

      Writeln(Archivo, Linea);

      Gauge1.Progress := Gauge1.Progress + 1;
      Gauge1.Refresh;
    end;

  CloseFile(Archivo);

  Memo1.Lines.LoadFromFile(Ruta + 'Lista.txt');

  //ABRIMOS EL ARCHIVO GENERADO
  ShellExecute(Handle,'open','c:\windows\notepad.exe',
  PWideChar(Ruta + 'Lista.txt'), nil, SW_SHOWNORMAL);

end;

procedure TForm1.FormCreate(Sender: TObject);
var
  I : Integer;

//DECLARAMOS UN ARRAY DE ACUERDO AL TIPO DEFINIDO Y LO INICIALIZAMOS
const
  CountryData : array[0..19] of TCountryCapital = (
   (Country : 'Venezuela'; Capital : 'Caracas'),
   (Country : 'Argentina'; Capital : 'Buenos Aires'),
   (Country : 'Estados Unidos'; Capital : 'Washington'),
   (Country : 'México'; Capital : 'Ciudad de México'),
   (Country : 'Brasil'; Capital : 'Brasilia'),
   (Country : 'Colombia'; Capital : 'Bogotá'),
   (Country : 'Perú'; Capital : 'Lima'),
   (Country : 'Chile'; Capital : 'Santiago de Chile'),
   (Country : 'Ecuador'; Capital : 'Quito'),
   (Country : 'Uruguay'; Capital : 'Montevideo'),
   (Country : 'Canadá'; Capital : 'Ottawa'),
   (Country : 'Paraguay'; Capital : 'Asunción'),
   (Country : 'Bolivia'; Capital : 'Sucre'),
   (Country : 'Guatemala'; Capital : 'Ciudad de Guatemala'),
   (Country : 'Cuba'; Capital : 'La Habana'),
   (Country : 'España'; Capital : 'Madrid'),
   (Country : 'Portugal'; Capital : 'Lisboa'),
   (Country : 'Francia'; Capital : 'París'),
   (Country : 'Alemania'; Capital : 'Berlín'),
   (Country : 'Italia'; Capital : 'Roma'));

begin
  _firstName := ['Adam', 'Alex', 'Mario', 'Jonathan', 'Carlos', 'Juan', 'David',
                 'Eduardo', 'Fredi', 'Frank', 'Agustin', 'Mariela', 'Marcos', 'Jose',
                 'Madeline', 'Elizabet', 'Ruth', 'David', 'Enmanuel', 'Wendy', 'Maria',
                 'Natanael', 'Samuel', 'Pablo', 'Pedro', 'Roger', 'Ivelise', 'Elva',
                 'Tomas', 'Erika', 'Jorge', 'Victor', 'Walter'];

  _lastName := ['García', 'Rodríguez', 'Martínez', 'Hernández', 'López', 'González', 'Pérez',
                'Sánchez', 'Ramírez', 'Torres', 'Flores', 'Rivera', 'Gómez', 'Díaz',
                'Reyes', 'Morales', 'Cruz', 'Ortiz', 'Gutiérrez', 'Jiménez', 'Mendoza',
                'Romero', 'Castillo', 'Vázquez', 'Ramos', 'Vega', 'Ruiz', 'Castro',
                'Delgado', 'Espinoza', 'Méndez', 'Silva', 'Guzmán', 'Molina', 'Castro',
                'Lozano', 'Alvarez', 'Herrera', 'Marquez', 'Peña', 'Guerrero', 'Rivas',
                'Sosa', 'Navarro', 'Solís', 'Campos', 'Vargas', 'Cervantes', 'Pineda',
                'Aguilar', 'Salazar', 'Quintero', 'Rojas', 'Zamora', 'Cardenas', 'Cortés',
                'Ayala', 'Gallegos', 'Ochoa', 'Rangel', 'Montoya', 'Ortega', 'Rubio',
                'Maldonado', 'Valdez', 'Padilla', 'Serrano', 'Acosta', 'Aguirre', 'Escobar',
                'Salinas', 'Valencia', 'Barrios', 'Carrillo', 'Peñaloza', 'Fuentes',
                'Arroyo', 'Villanueva', 'Montero', 'Barrera', 'Navarrete', 'Salgado',
                'Medina', 'Santos', 'Escalante', 'Nieto', 'Peralta', 'Zarate', 'Bautista',
                'Roldán', 'Santillán', 'Paz', 'Pacheco', 'Cano', 'Bravo', 'Nava', 'Arias',
                'Solano', 'Sierra', 'Godoy', 'Moreno', 'Páez', 'Calderón', 'Castañeda',
                'Villalobos', 'Portillo', 'Lara', 'Márquez', 'Amador', 'Solano', 'Ferrera',
                'Ponce', 'Felipe', 'Luna', 'Collado', 'Duarte', 'Pozo', 'Mejía', 'Varela',
                'Benítez', 'Manzano', 'Suárez', 'Varela', 'Cabrera', 'Santacruz', 'Vallejo'];

{
  Es crucial llamar a la función Randomize en algún punto inicial de tu
  aplicación para garantizar que la generación de números aleatorios varíe
  cada vez que se ejecute tu programa.
}
  Randomize;

  SetLength(CountriesCapitals, Length(CountryData));
  for I:= 0 to High(CountryData) do
    begin
      CountriesCapitals[I]:= CountryData[I];
    end;

end;

function TForm1.GetRandomFirstName: string;
begin
  Result := _firstName[Random(Length(_firstName))];
end;

function TForm1.GetRandomLastName : string;
begin
  Result := _lastName[Random(Length(_lastName))];
end;

//function TForm1.GetRandomFullName : string;
//begin
//  Result := GetRandomFirstName + ' ' + GetRandomLastName;
//end;

function TForm1.GenerateRandomDate(StartDate, EndDate : TDate) : TDate;
var
  Range : Integer;
begin
  // Calcula la diferencia en días entre las dos fechas
  Range := DaysBetween(EndDate, StartDate);

  // Genera un número aleatorio entre 0 y la diferencia de días
  Result := IncDay(StartDate, Random(Range + 1));
end;

function TForm1.GenerateRandomEmail : string;
const
  Providers : array[1..10] of string = (
    'hubspot.com', 'gmail.com', 'protonmail.com', 'icloud.com', 'zohomail.com',
    'outlook.com', 'mailbox.org', 'yahoo.com', 'bluehost.com', 'rackspace.com'
  );
var
  LocalPart, Domain : string;
begin
  // Genera la parte local del correo electrónico
  LocalPart := 'user' + IntToStr(Random(10000));

  // Selecciona un dominio aleatorio de la lista
  Domain := Providers[Random(Length(Providers)) + 1];

  // Devuelve el correo electrónico completo
  Result := LocalPart + '@' + Domain;
end;

function TForm1.GenerateRandomTime(StartTime, EndTime : TTime) : TTime;
var
  MinutesRange : Integer;
  RandomMinutes : Integer;
begin
  // Calcula la cantidad de minutos entre las dos horas
  MinutesRange := MinutesBetween(EndTime, StartTime);

  // Genera un número aleatorio de minutos para añadir a la hora de inicio
  RandomMinutes := Random(MinutesRange + 1);

  // Incrementa la hora de inicio por el número aleatorio de minutos
  Result := IncMinute(StartTime, RandomMinutes);
end;

function TForm1.GenerateRandomPhoneNumber : string;
const
  AreaCodes : array[1..20] of string = (
    '212', '305', '323', '415', '520',  // Algunos códigos de área de EE.UU.
    '809', '829', '849',               // Códigos de área de República Dominicana
    '506',                            // Código de área de Costa Rica
    '55', '81',                       // Códigos de área de México
    '0212', '0412', '0414',           // Códigos de área de Venezuela
    '011', '351',                     // Códigos de área de Argentina
    '02', '04',                       // Códigos de área de Ecuador
    '57', '44'                        // Códigos de área de Perú y UK (ejemplo diverso)
  );
var
  LocalNumber, AreaCode : string;
begin
  // Selecciona un código de área aleatorio de la lista
  AreaCode := AreaCodes[Random(Length(AreaCodes)) + 1];

  // Genera una secuencia de 7 dígitos como número local
  LocalNumber := Format('%.7d', [Random(10000000)]);

  // Devuelve el número de teléfono completo
  Result := '(' + AreaCode + ') ' + Copy(LocalNumber, 1, 3) + '-' + Copy(LocalNumber, 4, 4);
end;

function TForm1.GenerateRandomCountry : string;
var
  RandomIndex : Integer;
begin
  RandomIndex := Random(Length(CountriesCapitals));
  Result      := CountriesCapitals[RandomIndex].Country;
  // Devuelve la capital correspondiente como propiedad de la función
  // (Debido a las limitaciones de Pascal, podemos utilizar una variable global o
  // una propiedad de la clase para almacenar la capital)
  Form1.LastGeneratedCapital := CountriesCapitals[RandomIndex].Capital;
end;

function TForm1.GenerateRandomJobTitle : string;
var
  JobTitles : array of string;
begin
  // Inicializa el array dinámico directamente con los valores
  JobTitles := ['Supervisor', 'Associate', 'Executive', 'Liason', 'Officer',
                'Manager', 'Engineer', 'Specialist', 'Director', 'Coordinator',
                'Administrator', 'Architect', 'Analyst', 'Designer', 'Planner',
                'Synergist', 'Orchestrator', 'Technician', 'Developer', 'Producer',
                'Consultant', 'Assistant', 'Facilitator', 'Agent', 'Representative',
                'Strategist'];

  // Selecciona un job title aleatorio de la lista
  Result := JobTitles[Random(Length(JobTitles))];
end;

function TForm1.GenerateRandomCompany : string;
var
  Companies: array of string;
begin
  // Inicializa el array dinámico directamente con los valores
  Companies := ['Bed Bath & Beyond', 'EMCOR Group', 'Tyson Foods', 'Capital One Financial',
                'Albertsons', 'Tesla', 'Alaska Air Group', 'Norfolk Southern', 'World Fuel Services',
                'MGM Resorts International', 'Caesars Entertainment', 'Cheniere Energy',
                'United Continental Holdings', 'Sherwin-Williams', 'Ingredion', 'Charles Schwab',
                'ABM Industries', 'Windstream Holdings', 'NetApp', 'Bank of America',
                'Advanced Micro Devices', 'Dick''s Sporting Goods', 'McKesson', 'Henry Schein',
                'W.R. Berkley', 'Owens-Illinois', 'Robert Half International', 'IQVIA Holdings',
                'Land O''Lakes', 'Kellogg', 'Walmart', 'Amgen', 'Walt Disney', 'General Motors',
                'Aflac', 'Republic Services', 'Adobe', 'Cintas', 'Graphic Packaging Holding',
                'Dollar Tree', 'Southern', 'Johnson & Johnson', 'XPO Logistics', 'Performance Food Group',
                'Markel', 'CarMax', 'Dean Foods', 'Alliance Data Systems', 'Targa Resources',
                'Guardian Life Ins. Co. of America'];

  // Selecciona una compañía aleatoria de la lista
  Result := Companies[Random(Length(Companies))];
end;

function TForm1.Justifica(Texto : string; Longitud : SmallInt; Rellena : Char; Justificado : TJusticado) : string;

  function RellenaLinea(Longitud : SmallInt; Rellena : Char) : String;
  begin
    Result := '';
    while Length(Result) < Longitud do
      Result := Result + Rellena;
  end;

var
  LongTexto : SmallInt;
begin
  LongTexto := Length(Texto);
  if  LongTexto  < Longitud then
    begin
      LongTexto := Longitud - LongTexto;
      case Justificado of
        tjLeft   : Texto := Texto + RellenaLinea(LongTexto, Rellena);
        tjRight  : Texto := RellenaLinea(LongTexto, Rellena) + Texto;
        tjCenter : Texto := RellenaLinea((LongTexto - Round(LongTexto/ 2)), Rellena) +
                            Texto + RellenaLinea((Round(LongTexto/ 2)), Rellena);
      end;
    end;
   Result := Texto;
end;

function TForm1.RandomRangeDecimal(Min, Max : Double) : Double;
begin
  Result := Min + Random * (Max - Min);
end;


end.
