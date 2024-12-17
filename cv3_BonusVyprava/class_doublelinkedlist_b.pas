unit class_doublelinkedlist_B;

{$mode objfpc}{$H+}

interface

 uses
  Classes, SysUtils;
 Type    T_Ukaz=^T_Prvek;
         T_Data=string[6];
         T_Prvek=record
             dalsi,
             pred:T_Ukaz;
             data:T_Data
                  end;
         C_DLL=object
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
                 Function IsActiveHeader():boolean;
                end;

implementation
 Constructor C_DLL.InitL();
  var head:T_Ukaz;
  begin
   new(head);
   active:=head;
   header:=head;
   head^.pred:=head;
   head^.dalsi:=head;
  end;
 Function    C_DLL.EmptyL():boolean;
  begin
   EmptyL:=active^.pred=active^.dalsi;
  end;
 Procedure   C_DLL.AddDalsi(d:T_Data);
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
 Procedure   C_DLL.AddPred(d:T_Data);
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
 Procedure   C_DLL.DeleteActive();  //active bude následující
  var pomoc:T_Ukaz;
  begin
    pomoc:=active^.pred;
    pomoc^.dalsi:=active^.dalsi;
    pomoc:=active^.dalsi;
    pomoc^.pred:=active^.pred;
    dispose(active);
    Active:=pomoc;
  end;
 Procedure   C_DLL.ActiveFirst(); //Presun active na pocatek(za header)
   begin
    active:=header^.dalsi
   end;
 Procedure   C_DLL.ActiveDalsi();        //Presun ukazatele L.active
   begin
    active:=active^.dalsi;
   end;
 Procedure   C_DLL.ActivePred();
  begin
   active:=active^.pred;
   end;
 Function    C_DLL.ReadActive():T_Data;     //Cteni dat z aktivniho prvku
  begin
   ReadActive:=active^.data;
  end;
 Procedure   C_DLL.WriteActive(Data:T_data); //Zapis do aktivniho prvku
  begin
   active^.data:=Data;
  end;
 Procedure   C_DLL.ShowList();        // Zobrazeni seznamu
  var     reader:T_Ukaz;
  begin
   reader:=header^.dalsi;
   While reader<>header do
    begin
     Write(reader^.data);
     reader:=reader^.dalsi;
    end;
  end;
 destructor  C_DLL.Destroy();  //Zruseni celeho seznamu vcetne hlavy
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
 Function    C_DLL.Length():integer; //Pocet prvku v seznamu
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
 Function    C_DLL.FindZarazka(D:T_data):T_Ukaz;
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
 Function    C_DLL.IsActiveheader():boolean;         // pokud je active ukazuje na free = true
 begin
  IsActiveheader:=active=header;
 end;
end.

