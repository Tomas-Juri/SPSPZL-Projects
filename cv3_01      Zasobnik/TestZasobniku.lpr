program TestZasobniku;
uses Trida_Zasobnik,crt;

var
  konec:boolean;
  menu:0..14;
  zasobnik:Tstack;
  Dzasobnik:^Tstack;
  znak:Tdata;
  veta:string;
begin
  clrscr;
  konec:=false;
  repeat
   begin
   clrscr;
   writeln('Prace se zasobnikem Stat obj');
   writeln('---------------------------------------');
   writeln('1.Inicializace zasobniku');
   writeln('2.Test prazdnosti zasobniku');
   writeln('3.Pridani noveho prvku');
   writeln('4.Hloubka zasobniku');
   writeln('5.Zruseni zasobniku');
   writeln('6.Vytahnuti prvku');
   writeln('7.Cteni vety pozpatku');
   writeln('0.Konec');
   writeln('---------------------------------------');
   writeln('Prace se zasobnikem Dyn obj');
   writeln('8.Inicializace zasobniku');
   writeln('9.Test prazdnosti zasobniku');
   writeln('10.Pridani noveho prvku');
   writeln('11.Hloubka zasobniku');
   writeln('12.Zruseni zasobniku');
   writeln('13.Vytahnuti prvku');
   writeln('14.Cteni vety pozpatku');
   writeln('0.Konec');
   writeln('---------------------------------------');
   readln(menu);
   case menu of
    1:zasobnik.Init_S();
    2:begin
       case zasobnik.Empty_S() of true:writeln('Zasobnik je prazdny');
                                 false:writeln('V zasobniku jsou prvky');

      end;
       readln;
      end;
    3:begin
       writeln('zadejte znak');
       readln(znak);
       zasobnik.Push_s(znak);
      end;
    4:begin
       writeln('Delka zasobniku:',zasobnik.Depth_s());
       readln;
      end;
    5:begin
       zasobnik.Destroy_s();
       writeln('Zasobnik byl zrusen');
       readln;
      end;
    6:begin
       if (zasobnik.Empty_s()) then
        writeln('Vas zasobnik je prazdny')
       else writeln('Vytahnuty prvek:',zasobnik.Pull_s());
       readln;
      end;
    7:begin
       write('Zadejte vetu: ');
       readln(veta);
       writeln(zasobnik.CteniVetyP(veta));
       readln;
      end;
    0:konec:=true;
    8:new(Dzasobnik,Init_S());
    9:begin
       case Dzasobnik^.Empty_S() of true:writeln('Zasobnik je prazdny');
                                 false:writeln('V zasobniku jsou prvky');

      end;
       readln;
      end;
    10:begin
       writeln('zadejte znak');
       readln(znak);
       Dzasobnik^.Push_s(znak);
      end;
    11:begin
       writeln('Delka zasobniku:',Dzasobnik^.Depth_s());
       readln;
      end;
    12:begin
       Dzasobnik^.Destroy_s();
       writeln('Zasobnik byl zrusen');
       readln;
      end;
    13:begin
       if (Dzasobnik^.Empty_s()) then
        writeln('Vas zasobnik je prazdny')
       else writeln('Vytahnuty prvek:',Dzasobnik^.Pull_s());
       readln;
      end;
    14:begin
       write('Zadejte vetu: ');
       readln(veta);
       writeln(Dzasobnik^.CteniVetyP(veta));
       readln;
      end;

    end;

   end;

  until konec;
end.

