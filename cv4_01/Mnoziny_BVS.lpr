program Mnoziny_BVS;

uses number_generator, binary_search_tree_obj, modul_doublelinkedlist_b,
     Trida_Zasobnik, sysutils;
var  volba,nazev1,nazev2,nVystup:string;

Procedure VytvorPrunikMnozin(Naz1,Naz2,Vys:string);
{ Nacte cisla ze souboru Naz1, vytvori z nich bin. strom.
  Nacte cisla ze souboru Naz2, vyhleda je ve stromu z Naz1 a pokud najde shodu
  zapise ji do souboru Vys }

 var   StromMnoziny          :T_BST;
       S1,S2,Vystup          :text;
       radek,znak            :string;
       I,cislo,delkarad,D    :integer;

 begin
  Assign(S1,Naz1);         //
  reset(S1);               //
  StromMnoziny.Init();     // Inicializace promenych
  znak:='';                //
  I:=1;                    //

  While not(EOF(S1)) do             // Nacteni cisel v souboru do stromu
   begin
    I:=1;
    ReadLn(S1,radek);
    While I<length(radek) do        // Cyklus pro radek
     begin
      if radek[I]<>' ' then         // Cyklus pro cislo, mezera slouzi jako zarazka
        begin
         znak:=znak+Radek[I];
         inc(I);
        end
       else                          // Zapsani cisla do stromu
        begin                        //
         inc(I);                     //
         cislo:=StrToInt(znak);      //
         znak:='';                   //
         StromMnoziny.UseAdd(cislo); //
        end;
     end;
   end;  // Konec nacitani souboru

  Assign(S2,Naz2);            //
  Assign(Vystup,Vys);         //  Inicializace druhe mnoziny a vystupniho
  reset(S2);                  //  souboru
  rewrite(Vystup);            //
  delkarad:=0;                //
  znak:='';                   //

  While not(EOF(S2)) do             // Nacteni cisel v souboru do stromu
   begin
    I:=1;
    ReadLn(S2,radek);
    While I<length(radek) do        // Cyklus pro radek
     begin
      if radek[I]<>' ' then         // Cyklus pro cislo, mezera slouzi jako zarazka
        begin
         znak:=znak+Radek[I];
         inc(I);
        end
       else                                  // Vyhledani Cisla ve stromu
        begin                                //
         inc(I);                             //
         cislo:=StrToInt(znak);              //
         znak:='';                           //
         if StromMnoziny.UseFind(cislo) then //
           begin
            if cislo>99 then
              D:=3
             else
              if cislo>9 then
                D:=2
               else
                D:=1;
            if delkarad+D>65 then             // odradkovani
              begin
               writeln(Vystup,'');
               delkarad:=D;
              end
             else
               delkarad:=delkarad+D;
             write(Vystup,Cislo);
             write(Vystup,' ');
             inc(delkarad);
           end;
        end;
     end;
   end;  // Konec nacitani souboru

  close(S2);
  close(S1);
  close(Vystup);
  StromMnoziny.UseDestroy();
 end;
Procedure VytvorRozdilMnozin(Naz1,Naz2,Vys:string);
{ Nacte cisla ze souboru Naz1, vytvori z nich bin. strom.
  Nacte cisla ze souboru Naz2, vyhleda je ve stromu z Naz1 a pokud najde shodu
  smaze dany uzel. Nakonec vypise obsah stromu do souboru Vys }

 var   StromMnoziny          :T_BST;
       S1,S2,Vystup          :text;
       radek,znak            :string;
       I,cislo,delkarad,D    :integer;
       ZapisVystupu          :Tstack;

 begin
  Assign(S1,Naz1);         //
  reset(S1);               //
  StromMnoziny.Init();     // Inicializace promenych
  znak:='';                //
  I:=1;                    //

  While not(EOF(S1)) do             // Nacteni cisel v souboru do stromu
   begin
    I:=1;
    ReadLn(S1,radek);
    While I<=length(radek) do        // Cyklus pro radek
     begin
      if radek[I]<>' ' then         // Cyklus pro cislo, mezera slouzi jako zarazka
        begin
         znak:=znak+Radek[I];
         inc(I);
        end
       else                          // Zapsani cisla do stromu
        begin                        //
         inc(I);                     //
         cislo:=StrToInt(znak);      //
         znak:='';                   //
         StromMnoziny.UseAdd(cislo); //
        end;
     end;
   end;  // Konec nacitani souboru

  Assign(S2,Naz2);            //
  Assign(Vystup,Vys);         //  Inicializace druhe mnoziny a vystupniho
  reset(S2);                  //  souboru
  rewrite(Vystup);            //
  delkarad:=0;                //
  znak:='';                   //
  cislo:=0;                   //
  I:=1;                       //

  While not(EOF(S2)) do             // Nacteni cisel v souboru do stromu
   begin
    I:=1;
    ReadLn(S2,radek);
    While I<=length(radek) do        // Cyklus pro radek
     begin
      if radek[I]<>' ' then         // Cyklus pro cislo, mezera slouzi jako zarazka
        begin
         znak:=znak+Radek[I];
         inc(I);
        end
       else                                  // Vyhledani Cisla ve stromu
        begin                                //
         inc(I);                             //
         cislo:=StrToInt(znak);              //
         znak:='';                           //
         StromMnoziny.UseDelete(cislo);      //
        end;
     end;
   end;  // Konec nacitani souboru

  ZapisVystupu.Init_s();
  StromMnoziny.UseLIS(ZapisVystupu);

  While ZapisVystupu.Empty_s()=false do       // vypis cisel do vystupu
   begin
    cislo:=ZapisVystupu.Pull_s();
    if cislo>99 then
      D:=3
     else
      if cislo>9 then
        D:=2
       else
        D:=1;
     if delkarad+D>65 then
       begin
       writeln(Vystup,'');
       delkarad:=D;
       end
      else
       delkarad:=delkarad+D;
     write(Vystup,cislo);
     write(Vystup,' ');
     inc(delkarad);

   end;

  close(S2);
  close(S1);
  close(Vystup);
  StromMnoziny.UseDestroy();
 end;

begin

  nazev1:=ParamStr(1);     //
  nazev2:=ParamStr(2);     //
  randomize;               //
  GenerujMnoziny(nazev1);  //
  GenerujMnoziny(nazev2);  // Generovani mnozin do souboru predanych parametry z PR

  nVystup:=ParamStr(4);
  volba:=ParamStr(3);

  case volba of 'prunik':begin
                          VytvorPrunikMnozin(nazev1,nazev2,nVystup);
                          Writeln('Tvorba Pruniku mnozin probehla v poradku');
                         end;
                'rozdil':begin
                          VytvorRozdilMnozin(nazev1,nazev2,nVystup);
                          Writeln('Tvorba Rozdilu mnozin probehla v poradku');
                         end;
  end;
  readln();
end.

