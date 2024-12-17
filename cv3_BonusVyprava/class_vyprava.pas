unit class_vyprava;
 // Trida vyprava je potomkem Linearniho jednosmerneho seznamu, vyuzita v simulaci vysokohorske vypravy
 // Serpove jsou ulozeni postupne za sebou, ti kteri jsou behem vypravy vygenerovani se pridaji v seznamu
 // za ty, kteri byli vytvoreni na pocatku vypravy.
interface
 Uses
    LinearniSeznam,modul_serpa;
 // Trida predka, prvky seznamu

 Type
    P_Vyprava =^C_Vyprava;
    C_Vyprava =object(TSeznam) // potomek seznamu
                private
                  Function  VyberVypadnuti():string;
                public
                  CelkovyNaklad:integer;
                  Procedure VytvorVypravu();
                  Procedure SmazSerpu();
                  Function  JePritomen(HledejJmeno:T_Jmeno):boolean;
                  Procedure SetActToJmeno(JmenoS:T_Jmeno);
                  Function  GetPocetPuvodnich():integer;
              end;
implementation
 Procedure C_Vyprava.VytvorVypravu();
  { Vygeneruje ve vyprave nahodny pocet serpu - spoustena pouze pri zacatku vypravy    }
  var
   PocetClenu,I:integer;
   Pomoc       :P_Serpa;
  begin
   CelkovyNaklad:=0;
   Modul_serpa.LoadJmena();
   PocetClenu:=random(20)+1;     // Pocet serpu ve vyprave je 1-20
   for I:= 1 to PocetClenu do
    begin
     AddS(GenerujSerpa);
     Pomoc:=CopyS();
     CelkovyNaklad:=CelkovyNaklad+Pomoc^.Naklad;
     Pomoc^.Puvodni:=True;               // Puvodni serpa vypravy- muze vypadnout
    end;
   ActToFirst();
  end;
 Procedure C_Vyprava.SmazSerpu();
  { Provedene smazani serpy s danym jmenem, prerozdeli naklad ktery nesl a
    pripadne zavola noveho serpu }
  var Prerozdelit:integer; // Naklad ktery nesl vypadnuty serpa
      SmazatJmeno:string;
  begin
   ActToFirst();
   Prerozdelit:=0;
   SmazatJmeno:=VyberVypadnuti;                  // Vybere nahodneho serpu
   Prerozdelit:=CopyS()^.Naklad;

   Writeln('Vypadl serpa jmenem ',CopyS()^.Jmeno,' s nakladem ',CopyS()^.Naklad,'kg');    //Bohuzel vypis zde
                                                                                          //Spatna konstrukce
   if GlobalJmena.FindZarazka(SmazatJmeno)=nil then   // Prida jmeno do GlobalJmena, aby
     GlobalJmena.AddDalsi(SmazatJmeno);               // jej bylo mozne znovu pouzit
   DeleteS();                               //Odstrani se serpa

   ActToFirst();                            // Prerozdeleni nakladu
   While Prerozdelit<>0 do                  // Cyklus Vypravy
    begin
     While (CopyS()^.Naklad<75) and (Prerozdelit<>0) do           // Cyklus serpy , max 75kg
      begin
       Inc(CopyS()^.Naklad);
       Dec(Prerozdelit);
      end;
     SuccS();               // Dalsi serpa
     if IsActFree() then
       break;
    end;
   If Prerozdelit>0 then
    begin                    // Je potreba noveho serpy
     AddS(ZavolejNoveho());      // Novy serpa s nulovou zatezeni a neni puvodni
     CopyS()^.Naklad:=Prerozdelit;  // Dostane prebyvajici naklad

     WriteLn('Byl zavolan novy serpa jmenem ',CopyS()^.Jmeno,' a dostal naklad ',CopyS()^.Naklad,'kg');
    end;
   ActToFirst();
  end;
 Function  C_Vyprava.VyberVypadnuti():string;
  { Nahodne vybere serpu ktery v dalsim kroku vypadne }
  var    I            :Integer;
  begin
   ActToFirst();
   For I:=1 to Random(Length()) do
    SuccS();
   While CopyS()^.Puvodni=false do
    begin
     PredS();
    end;
  VyberVypadnuti:=CopyS()^.Jmeno;
  end;
 Function  C_Vyprava.JePritomen(HledejJmeno:T_Jmeno):boolean;
  { Vraci, zda je serpa s danym jmenem pritomen ve vyprave}
  begin
   ActToFirst();
   while (not(IsActFree()) and (CopyS()^.Jmeno<>HledejJmeno)) do
    begin
     SuccS();
    end;
   if IsActFree() then
     JePritomen:=false
    else
     if CopyS()^.Jmeno=HledejJmeno then
       JePritomen:=true
      else
       JePritomen:=false;
  end;
 Procedure C_Vyprava.SetActToJmeno(JmenoS:T_Jmeno);
  { Nastavi active na dane prvek s danym jmenem serpy }
  begin
   ActToFirst();
   while CopyS()^.Jmeno<>JmenoS do
    SuccS();
  end;
 Function  C_Vyprava.GetPocetPuvodnich():integer;
  { vraci pocet serpu s atributem puvodni=true }
  var  PocetP:integer;
  begin
   ActToFirst();
   PocetP:=0;
   While IsActFree()=false do
    begin
     if CopyS()^.Puvodni=true then
      inc(PocetP);
     SuccS();
    end;
   GetPocetPuvodnich:=PocetP;
  end;
 end.



