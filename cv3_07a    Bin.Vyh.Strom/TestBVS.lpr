program TestBVS;

uses binary_search_tree, M_Fronta,crt;
var
  konec:boolean;
  menu:0..5;
  vstup:integer;
  Stromecek:T_BST;
  hloubka,I:integer;
begin
  clrscr;
  konec:=false;
  Init(Stromecek);
  repeat
   begin
   hloubka:=0;
   I:=0;
   clrscr;
   writeln('Test Binarniho Vyhledavaciho Stromu    ');
   writeln('---------------------------------------');
   writeln('1.Pridani uzlu s hodnotou');
   writeln('2.Odebrani uzlu s hodnotou  ');
   writeln('3.Vypis Stromu po hladinach  ');
   writeln('4.Maximalni hloubka stromu  ');
   writeln('0.Konec  ');
   writeln('---------------------------------------');
   readln(menu);
   case menu of
        0:begin
               konec:=true
        end;
        1:begin
           write('Zadejte hodnotu: ');
           readln(vstup);
           Add(Stromecek,Vstup);
        end;
        2:begin
          write('Zadejte hodnotu: ');
          readln(vstup);
          Delete(Stromecek.koren,vstup);
        end;
        3:begin
           if Empty(Stromecek)=false then
           begin
            writeln('Vypis stromu po hladinach');
            ShowByLevels(Stromecek);
           end
          else
           writeln('Strom je prazdny');
        end;
        4:begin
         if Empty(Stromecek)=false then
           begin
            MaxDepth(Stromecek.koren,I,hloubka);
            writeln('Hloubka stromu je ',hloubka)
           end
          else
           Writeln('Strom je prazdny');
        end;
   end;
   readln;
  end;
   until konec;
  Destroy(Stromecek.koren);
end.


