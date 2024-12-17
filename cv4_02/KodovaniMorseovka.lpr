program KodovaniMorseovka;
 uses crt,morseunit, filehelp;

begin
  clrscr;
  if souborJe(ParamStr(1)) then    // Test existence souboru
    case ParamStr(3) of            // kod = kodovani, dekod = dekodovani
        'Kod':begin
               Kodovani(ParamStr(1),ParamStr(2)); // 1 - Nazev vstupniho, 2 - Nazev vystupniho
               Writeln('Kodovani');
              end;
      'Dekod':begin
               Dekodovani(ParamStr(1),ParamStr(2)); // 1 - Nazev vstupniho, 2 - Nazev vystupniho
               Writeln('Dekodovani');
              end;
         else begin
               Writeln('Chyba vstupniho parametru');
              end;

    end
   else
    Writeln('Vstupni soubor nenalezen');
   Writeln('Operace byla uspesna');
   readln;
end.
