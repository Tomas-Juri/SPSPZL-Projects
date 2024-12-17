unit modul_doublelinkedlist_B;

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
         T_DLL=object
                private
                    active,
                    header:T_Ukaz;
                public
                 Constructor InitL();
                 Function EmptyL():boolean;         // true = prazdny
                 Procedure AddDalsi(d:T_Data);
                 Procedure AddPred(d:T_Data);
                 Procedure DeleteActive();
                 Procedure ActiveFirst();
                 Procedure ActiveDalsi();
                 Procedure ActivePred();
                 Function ReadActive():T_Data;
                 Procedure WriteActive(Data:T_data);
                 Procedure ShowList();
                 Destructor Destroy();
                 Function Length():integer;
                 Function FindZarazka(D:T_data):T_Ukaz;
                end;

implementation
 Constructor T_DLL.InitL();
  var head:T_Ukaz;
  begin
   new(head);
   active:=head;
   header:=head;
   head^.pred:=head;
   head^.dalsi:=head;
  end;
 Function    T_DLL.EmptyL():boolean;
  begin
   EmptyL:=active^.pred=active^.dalsi;
  end;
 Procedure   T_DLL.AddDalsi(d:T_Data);
  var pomoc,novy:T_Ukaz;
  begin
   new(novy);
   novy^.data:=d;
   novy^.dalsi:=active^.dalsi;
   novy^.pred:=active;
   pomoc:=active^.dalsi;
   pomoc^.pred:=novy;
   active^.dalsi:=novy;
   active:=novy;
  end;
 Procedure   T_DLL.AddPred(d:T_Data);
  var pomoc,novy:T_Ukaz;
  begin
   new(novy);
   novy^.data:=d;
   novy^.dalsi:=active;
   novy^.pred:=active^.pred;
   pomoc:=active^.pred;
   pomoc^.dalsi:=novy;
   active^.pred:=novy;
  end;
 Procedure   T_DLL.DeleteActive();  //active bude následující
  var pomoc:T_Ukaz;
  begin
    pomoc:=active^.pred;
    pomoc^.dalsi:=active^.dalsi;
    pomoc:=active^.dalsi;
    pomoc^.pred:=active^.pred;
    dispose(active);
    Active:=pomoc;
  end;
 Procedure   T_DLL.ActiveFirst(); //Presun active na pocatek(za header)
   begin
    active:=header^.dalsi
   end;
 Procedure   T_DLL.ActiveDalsi();        //Presun ukazatele L.active
   begin
    active:=active^.dalsi;
   end;
 Procedure   T_DLL.ActivePred();
  begin
   active:=active^.pred;
   end;
 Function    T_DLL.ReadActive():T_Data;     //Cteni dat z aktivniho prvku
  begin
   ReadActive:=active^.data;
  end;
 Procedure   T_DLL.WriteActive(Data:T_data); //Zapis do aktivniho prvku
  begin
   active^.data:=Data;
  end;
 Procedure   T_DLL.ShowList();        // Zobrazeni seznamu
  var     reader:T_Ukaz;
  begin
   reader:=header^.dalsi;
   While reader<>header do
    begin
     Write(reader^.data);
     reader:=reader^.dalsi;
    end;
  end;
 destructor  T_DLL.Destroy();  //Zruseni celeho seznamu vcetne hlavy
  var pomoc:T_Ukaz;
  begin
   pomoc:=Header^.dalsi;
   while active<>Header do
    begin
     Active:=pomoc^.dalsi;
     dispose(pomoc);
     pomoc:=active
    end;
   dispose(pomoc);
   active:=nil;
   header:=nil;
  end;
 Function    T_DLL.Length():integer; //Pocet prvku v seznamu
  var pomoc:T_Ukaz;
      I:integer;
  begin
   I:=0;
   pomoc:=Header^.dalsi;
   while pomoc<>Header do
    begin
     I:=I+1;
     pomoc:=pomoc^.dalsi
    end;
   Length:=I;
  end;
 Function    T_DLL.FindZarazka(D:T_data):T_Ukaz;
   var pomoc:T_Ukaz;
  begin
   pomoc:=header;
   Header^.data:=D;
   repeat
    pomoc:=pomoc^.dalsi;
   until pomoc^.data=D;
   if pomoc=header then FindZarazka:=nil else FindZarazka:=pomoc;
   Header^.data:=' ';
  end;
end.

