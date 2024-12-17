program Test_DoubleLinkedList;

uses Modul_doublelinkedlist,crt;
var
  konec:boolean;
  menu,I:0..11;
  Seznam:T_DLL;
  dat:T_Data;
begin
  clrscr;
  konec:=false;
  InitL(Seznam);
  repeat
   begin
   clrscr;
   writeln('Dvousmerny linearni seznam s hlavou    ');
   writeln('---------------------------------------');
   writeln('2.Test Prazdnosti ');
   writeln('3.Pridani prvku za active  ');
   writeln('4.Pridani prvku pred active  ');
   writeln('5.Smazani aktivniho prvku  ');
   writeln('6.Posun active na prvni prvek - za header  ');
   writeln('7.Posun active na nasledujici prvek  ');
   writeln('8.Posun active na predchozi prvek  ');
   writeln('9.Zapis dat do aktivniho prvku  ');
   writeln('10.Zruseni celeho seznamu vcetne hlavy  ');
   writeln('11.Pocet prvku v seznamu  ');
   writeln('0.Konec  ');
   write('Aktualni stav Seznamu :  ');ShowList(Seznam);
   writeln('  Aktivni prvek: ',Readactive(Seznam));
   writeln('---------------------------------------');
   readln(menu);

   case menu of
        0:begin
               konec:=true
        end;
        1:begin
           InitL(Seznam);
           For I:=1 to 10 do AddDalsi(chr(I+47),Seznam);
        end;
        2:begin
           if EmptyL(Seznam) then writeln('prazdny') else writeln('naplneny');
        end;
        3:begin
           write('Zadej data: ');
           readln(Dat);
           AddDalsi(dat,Seznam);
        end;
        4:begin
           write('Zadej data: ');
           readln(Dat);
           AddPred(dat,Seznam);
        end;
        5:begin
           DeleteActive(Seznam);
        end;
        6:begin
          ActiveFirst(Seznam);
        end;
        7:begin
          ActiveDalsi(Seznam);
        end;
        8:begin
          ActivePred(Seznam);
        end;
        9:begin
           write('Zadej data: ');
           readln(Dat);
           WriteActive(Seznam,dat);
        end;
        10:begin
           Destroy(Seznam);
           initL(Seznam);
        end;
         11:begin
           Write('PP:');
           Writeln(Length(Seznam));
        end;
   end;
   readln;
  end;
   until konec

end.

