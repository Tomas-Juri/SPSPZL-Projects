unit modul_serpa;
 // Temer trida serpa, "vystupem" je ukazatel na serpu - prvek ve Vyprave(Jednosmerny Seznam)
 interface
  Uses
   class_doublelinkedlist_B; // nacitani nahodnych jmen
  Type
   T_Jmeno=String[6];
   T_Serpa=Record
            Jmeno:T_Jmeno;   // jmeno serpy
            Naklad:integer;  // naklad kterych nese (40-50kg)
            Puvodni:Boolean; // Urcuje, zda muze serpa vypadnout- viz zadani
                 end;
   P_Serpa=^T_Serpa;
  Const
   MaxNaklad=75;       // Maximalni naklad ktery muze serpa nest
  Var
   GlobalJmena:C_DLL;  // obsahuje seznam pouzitelnych jmen nactenych pomoci procedury
                       // LoadJmena().Nacita ze souboru jmena_serpu
 Procedure LoadJmena();
 Function  GenerujJmeno():T_Jmeno;
 Function  GenerujNaklad():integer;
 Function  GenerujSerpa():P_Serpa;
 Function  ZavolejNoveho():P_Serpa;
implementation
 Procedure LoadJmena();
  { Nacte jmena ze souboru jmena_serpu. Jmena v souboru zacinaji velkym pismenem
    , nejsou oddeleny mezerou a na konci seznamu jmen je tecka. }
  var F:text;
      radek:string;
      I:integer;
      jmeno:T_Jmeno;
  begin
   GLobalJmena.InitL();
   assign(f,'jmena_serpu.txt');
   reset(f);
   I:=1;
   jmeno:='';
   readln(f,radek);              // Inicializace

   while radek[I]<>'.' do        // Cyklus pro radek
    begin
     if (radek[I]<#97) and (I>1)  then        // Cyklus pro jmeno
       begin
        GlobalJmena.AddDalsi(jmeno);   // Dosel k dalsimu jmenu, predchozi ulozi do GlobalJmena
        jmeno:=radek[I];
       end
      else
       begin
        jmeno:=jmeno+radek[I];       // Nacita jmeno po znacich
       end;
     inc(I);
   end;
   GlobalJmena.AddDalsi(jmeno);
   GlobalJmena.ActiveFirst();
  end;
 Function  GenerujJmeno():T_Jmeno;
 // Vraci nahodne vybrane jmeno serpy, vyuziva dvousmerne vazaneho seznamu pro nahodnost.
  var
      nahoda,i:integer;
  begin
   nahoda:=random(GlobalJmena.Length())+1;   // 1 az pocet jmen v seznamu
   for i:=1 to nahoda do                     // posun ukazetele o nahodny pocet mist dopredu
    begin
     GlobalJmena.ActiveDalsi();
     if GlobalJmena.IsActiveHeader() then   // je treba preskocit hlavu, jinak error s nacitanim jmena
       GlobalJmena.ActiveDalsi();
    end;
   GenerujJmeno:=GlobalJmena.ReadActive();  //  Nacte data z aktivniho prvku (jmeno)
   GlobalJmena.DeleteActive();              //  smaze jej, aby nemohlo byt jmeno znovu vytazeno a
   GlobalJmena.ActiveFirst();               //  presune ukazatel na zacatek seznamu
  end;
 Function  GenerujNaklad():integer;
 // Vraci hodnotu nakladu, hodnota se pohybuje mezi 40-50kg
  begin
   GenerujNaklad:=random(11)+40;
  end;
 Function  GenerujSerpa():P_Serpa;
  //Vygeneruje ukazatel na serpu s nahodnym jmenem a hmotnosti nakladu
  var novyS:P_Serpa;
  begin
    new(novyS);
    novyS^.jmeno:=GenerujJmeno();
    novyS^.naklad:=GenerujNaklad();
    novyS^.Puvodni:=true;
    GenerujSerpa:=novyS;
  end;
 Function  ZavolejNoveho():P_Serpa;
  var novy:P_Serpa;
  begin
   novy:=GenerujSerpa();
   novy^.Naklad:=0;
   novy^.Puvodni:=false;
   ZavolejNoveho:=Novy;
  end;
end.

