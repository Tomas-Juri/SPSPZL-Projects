program TestTridySeznam;

uses linearniseznam,crt;

var
  konec:boolean;
  menu:0..5;
begin
  clrscr;
  konec:=false;
  repeat
   begin
   clrscr;
   writeln('    ');
   writeln('---------------------------------------');
   writeln('1.  ');
   writeln('2.  ');
   writeln('3.  ');
   writeln('4.  ');
   writeln('5.  ');
   writeln('0.  ');
   writeln('---------------------------------------');
   readln(menu);
   case menu of
        0:begin
               konec:=true
        end;
        1:begin

        end;
        2:begin

        end;
        3:begin

        end;
        4:begin

        end;
        5:begin

        end;
   end;
  end;
   until konec

end.
