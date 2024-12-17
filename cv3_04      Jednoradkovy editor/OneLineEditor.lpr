program OneLineEditor;

uses M_LinearList,crt;
Type Tstr40 = string[40];
     Tstr15 = string[15];
var     veta:TStr40;

function readStr(popis : Tstr15; x,y : byte) : Tstr40;
 var
  Seznam:T_list;
  akce,special,kurzor:byte;
  posun:0..2;           // 1=doleva 2=doprava 0=zustava
  konec:boolean;
begin
  Seznam.init;
  gotoxy(x,y);
  writeln(popis);
  kurzor:=(x+length(popis));
  gotoxy(kurzor,y);
  konec:=false;
  repeat
  begin
  akce:=ord(readkey);
  case akce of  43..57: begin                  //(+ - . ,) a cisla
                         if(Seznam.length<40) then
                          begin
                           Seznam.add(chr(akce));
                           //Seznam.succ;
                           posun:=2;
                          end;
                        end;
               97..122: begin                  //velke pismeno
                         if(Seznam.length<40) then
                          begin
                           Seznam.add(chr(akce));
                           //Seznam.succ;
                           posun:=2;
                          end;
                        end;
                65..90: begin                  //male pismeno
                         if(Seznam.length<40) then
                          begin
                           Seznam.add(chr(akce));
                           //Seznam.succ;
                           posun:=2;
                          end;
                        end;
                     8: begin                  //backspace
                        if Seznam.isfirst<>true then
                         begin
                         Seznam.Pred;
                         Seznam.Delete;
                         posun:=1;
                         end;
                        end;
                     13: begin                 //enter
                          konec:=true;
                        end;
                     0: begin
                         special:=ord(readkey);
                         case special of   77: begin            // doprava
                                                if Seznam.IsLast<>true then
                                                 begin
                                                 posun:=2;
                                                 Seznam.succ;
                                                 end;
                                               end;
                                           75: begin            // doleva
                                                if Seznam.isfirst<>true then
                                                 begin
                                                 posun:=1;
                                                 Seznam.pred;
                                                 end;
                                               end;
                                           83: begin            //delete
                                                Seznam.Delete;
                                                posun:=0;
                                               end;
                         end;



                        end;




  end;
  case posun of 0: begin end;       // 1=doleva 2=doprava 0=zustava
                1: begin
                   kurzor:=kurzor-1;
                    Gotoxy(kurzor,y);
                   end;
                2: begin
                   kurzor:=kurzor+1;
                    Gotoxy(kurzor,y)
                   end;
  end;
  gotoxy(x+length(popis),y);
  ClrEOL;
  writeln(Seznam.show);
  gotoxy(kurzor,y);
  posun:=0;
  end;
  until konec=true;
  readstr:=Seznam.show;
 end;
begin
 clrscr;
 veta:=Readstr('Zadejte vetu:',1,1);
 writeln;
 writeln('vysledna veta:',veta);
 readln;
end.

