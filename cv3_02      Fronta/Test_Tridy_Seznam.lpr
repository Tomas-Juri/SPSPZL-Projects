program Test_Tridy_Fronta;

uses M_Fronta,crt;
var
  konec:boolean;
  menu:0..8;
  fronta:Cqueue;
  znak:Tdata;
  Dfronta:^Cqueue;
begin
  clrscr;
  konec:=false;
  fronta.init;
  new(Dfronta,init);
  repeat
   begin
   clrscr;
   writeln('Test objektu fronta     ');
   writeln('---------------------------------------');
   writeln('1.Pridat prvek (do cela) pouze cisla ');
   writeln('2.Odebrat prvek (z konce)  ');
   writeln('3.Zruseni fronty  ');
   writeln('4.Nerovi otroci');
   writeln('0.Konec  ');
   writeln('---------------------------------------');
   if fronta.empty then writeln('Fronta je prazdna') else
     writeln('Ve fronte jsou prvky');
   writeln('Delka fronty = ',fronta.length);
   write('Stav fronty: <');fronta.show;writeln('<');
   writeln('---------------------------------------');
   writeln('Test objektu fronta dynamicky    ');
   writeln('---------------------------------------');
   writeln('5.Pridat prvek (do cela) pouze cisla ');
   writeln('6.Odebrat prvek (z konce)  ');
   writeln('7.Zruseni fronty  ');
   writeln('8.Nerovi otroci');
   writeln('0.Konec  ');
   writeln('---------------------------------------');
   if Dfronta^.empty then writeln('Fronta je prazdna') else
     writeln('Ve fronte jsou prvky');
   writeln('Delka fronty = ',Dfronta^.length);
   write('Stav fronty: <');Dfronta^.show;writeln('<');
   writeln('---------------------------------------');
   readln(menu);
   case menu of
        0:begin
               konec:=true
        end;
        1:begin
           writeln('Zadej prvek:');
           readln(znak);
           fronta.push(znak);
        end;
        2:begin
           fronta.remove(znak);
           if fronta.empty then writeln('fronta je prazdna') else
           writeln('Odebrany prvek:',znak);
        end;
        3:begin
          fronta.destroy;
          fronta.init; //problemy s menu
        end;
        4:begin
          writeln('prezije otrok na ',fronta.otroci,' miste');
        end;
        5:begin
           writeln('Zadej prvek:');
           readln(znak);
           Dfronta^.push(znak);
        end;
        6:begin
           Dfronta^.remove(znak);
           if Dfronta^.empty then writeln('fronta je prazdna') else
           writeln('Odebrany prvek:',znak);
        end;
        7:begin
          Dfronta^.destroy;
          Dfronta^.init; //problemy s menu
        end;
        8:begin
          writeln('prezije otrok na ',Dfronta^.otroci,' miste');
        end;
   end;
   readln;
  end;
   until konec

end.


