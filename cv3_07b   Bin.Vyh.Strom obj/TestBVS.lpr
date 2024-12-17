program TestBVS;

uses M_Fronta, binary_search_tree_obj,crt;
var
  BVS:T_BST;
  konec:boolean;
  menu:0..5;
  vstup:integer;
begin
  clrscr;
  konec:=false;
  BVS.Init();
  repeat
   begin
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
           BVS.UseAdd(Vstup);
        end;
        2:begin
          write('Zadejte hodnotu: ');
          readln(vstup);
          BVS.UseDelete(vstup);
        end;
        3:begin
         if BVS.Empty()=false then
           begin
            writeln('Vypis stromu po hladinach');
            BVS.ShowByLevels();
           end;
          else
           writeln('Strom je prazdny');
        end;
        4:begin
         if BVS.Empty()=false then
           Writeln('Maximalni hloubka stromu je ',BVS.GetMaxDepth())
          else
           Writeln('Strom je prazdny');
        end;
   end;
   readln;
  end;
   until konec;
  BVS.UseDestroy();
end.


