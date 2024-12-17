unit Modul_doublelinkedlist;

{$mode objfpc}{$H+}

interface

 uses
  Classes, SysUtils;
 Type    T_Ukaz=^T_Prvek;
         T_Data=char;
         T_Prvek=record
             dalsi,
             pred:T_Ukaz;
             data:T_Data
                  end;
         T_DLL=record
             active,
             header:T_Ukaz;
                end;



 Procedure InitL(var List:T_DLL);
 Function EmptyL(List:T_DLL):boolean;         // true = prazdny
 Procedure AddDalsi(d:T_Data;var List:T_DLL);
 Procedure AddPred(d:T_Data;var List:T_DLL);
 Procedure DeleteActive(var List:T_DLL);
 Procedure ActiveFirst(var List:T_DLL);
 Procedure ActiveDalsi(var List:T_DLL);
 Procedure ActivePred(var List:T_DLL);
 Function ReadActive(List:T_DLL):T_Data;
 Procedure WriteActive(List:T_DLL;Data:T_data);
 Procedure ShowList(List:T_DLL);
 Procedure Destroy(var List:T_DLL);
 Function Length(List:T_DLL):integer;
implementation
 Procedure InitL(var List:T_DLL);
  var head:T_Ukaz;
  begin
   new(head);
   List.active:=head;
   List.header:=head;
   head^.pred:=head;
   head^.dalsi:=head;
  end;
 Function EmptyL(List:T_DLL):boolean;
  begin
   EmptyL:=List.active^.pred=List.active^.dalsi;
  end;
 Procedure AddDalsi(d:T_Data;var List:T_DLL);
  var pomoc,novy:T_Ukaz;
  begin
   new(novy);
   novy^.data:=d;
   novy^.dalsi:=List.active^.dalsi;
   novy^.pred:=List.active;
   pomoc:=List.active^.dalsi;
   pomoc^.pred:=novy;
   List.active^.dalsi:=novy;
   List.active:=novy;
  end;
 Procedure AddPred(d:T_Data;var List:T_DLL);
  var pomoc,novy:T_Ukaz;
  begin
   new(novy);
   novy^.data:=d;
   novy^.dalsi:=List.active;
   novy^.pred:=List.active^.pred;
   pomoc:=List.active^.pred;
   pomoc^.dalsi:=novy;
   List.active^.pred:=novy;
  end;
 Procedure DeleteActive(var List:T_DLL);  //active bude následující
  var pomoc:T_Ukaz;
  begin
    pomoc:=List.active^.pred;
    pomoc^.dalsi:=List.active^.dalsi;
    pomoc:=List.active^.dalsi;
    pomoc^.pred:=List.active^.pred;
    dispose(List.active);
    List.Active:=pomoc;
  end;
 Procedure ActiveFirst(var List:T_DLL); //Presun active na pocatek(za header)
   begin
    List.active:=List.header^.dalsi
   end;
 Procedure ActiveDalsi(var List:T_DLL);        //Presun ukazatele L.active
   begin
    List.active:=List.active^.dalsi;
   end;
 Procedure ActivePred(var List:T_DLL);
  begin
   List.active:=List.active^.pred;
   end;
 Function ReadActive(List:T_DLL):T_Data;     //Cteni dat z aktivniho prvku
  begin
   ReadActive:=List.active^.data;
  end;
 Procedure WriteActive(List:T_DLL;Data:T_data); //Zapis do aktivniho prvku
  begin
   List.active^.data:=Data;
  end;
 Procedure ShowList(List:T_DLL);        // Zobrazeni seznamu
  var     reader:T_Ukaz;
  begin
   reader:=List.header^.dalsi;
   While reader<>List.header do
    begin
     Write(reader^.data);
     reader:=reader^.dalsi;
    end;
  end;
 Procedure Destroy(var List:T_DLL);  //Zruseni celeho seznamu vcetne hlavy
  var pomoc:T_Ukaz;
  begin
   pomoc:=List.Header^.dalsi;
   while List.active<>List.Header do
    begin
     List.Active:=pomoc^.dalsi;
     dispose(pomoc);
     pomoc:=List.active
    end;
   dispose(pomoc);
   List.active:=nil;
   List.header:=nil;
  end;
 Function Length(List:T_DLL):integer; //Pocet prvku v seznamu
  var pomoc:T_Ukaz;
      I:integer;
  begin
   I:=0;
   pomoc:=List.Header^.dalsi;
   while pomoc<>List.Header do
    begin
     I:=I+1;
     pomoc:=pomoc^.dalsi
    end;
   Length:=I;
  end;
 Function FindZarazka(List:T_DLL;D:T_data):T_Ukaz;
   var pomoc:T_Ukaz;
  begin
   pomoc:=List.header;
   List.Header^.data:=D;
   repeat
    pomoc:=pomoc^.dalsi;
   until pomoc^.data=D;
   if pomoc=List.header then FindZarazka:=nil else FindZarazka:=pomoc;
   List.Header^.data:=' ';
  end;
end.

