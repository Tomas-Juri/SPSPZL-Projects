program Test_DoubleLinkedList_B;
uses modul_doublelinkedlist_B,crt;
var
  konec:boolean;
  menu,I:0..11;
  Seznam:^T_DLL;
  dat:T_Data;
begin
  clrscr;
  konec:=false;
  new(Seznam,initL());
  repeat
   begin
   clrscr;
   writeln('Dvousmerny linearni seznam s hlavou    ');
   writeln('---------------------------------------');
   writeln('1.Napln Seznam prvky 0...9');
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
   write('Aktualni stav Seznamu :  ');Seznam^.ShowList();
   writeln('  Aktivni prvek: ',Seznam^.ReadActive());
   writeln('---------------------------------------');
   readln(menu);
   case menu of
        0:begin
               konec:=true
        end;
        1:begin
           Seznam^.InitL(); //naplneni seznamu prvky 0..9
           For I:=1 to 10 do Seznam^.AddDalsi(chr(I+47));
        end;
        2:begin
           if Seznam^.EmptyL() then writeln('prazdny') else writeln('naplneny');
        end;
        3:begin
           write('Zadej data: ');
           readln(Dat);
           Seznam^.AddDalsi(dat);
        end;
        4:begin
           write('Zadej data: ');
           readln(Dat);
           Seznam^.AddPred(dat);
        end;
        5:begin
           Seznam^.DeleteActive();
        end;
        6:begin
          Seznam^.ActiveFirst();
        end;
        7:begin
          Seznam^.ActiveDalsi();
        end;
        8:begin
          Seznam^.ActivePred();
        end;
        9:begin
           write('Zadej data: ');
           readln(Dat);
           Seznam^.WriteActive(dat);
        end;
        10:begin
           Seznam^.Destroy();
           Seznam^.initL(); //kvuli neustalemu vypisovani v "menu",jinak error
        end;
         11:begin
           Write('PP:');
           Writeln(Seznam^.Length());
        end;
   end;
   readln;
  end;
   until konec

end.
