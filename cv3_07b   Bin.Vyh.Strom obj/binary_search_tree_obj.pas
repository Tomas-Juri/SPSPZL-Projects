unit binary_search_tree_obj;

interface
 uses m_fronta; // pruchod do sirky
 Type
      P_Uzel = ^T_Uzel;
      T_Klic = integer;
      T_Uzel = record
                Klic:T_Klic;
                Left,Right:P_Uzel;
               end;

      T_BST = object        // Binarni vyhledavaci strom
               private
                Koren:P_Uzel;
                Function  Find(Hledany:T_Klic;var Uzel:P_Uzel):P_Uzel;
                Procedure Delete(var Uzel:P_Uzel; Hodnota:T_Klic);
                Procedure Destroy(var Uzel:P_Uzel);
                Function  UzelDepth(Uzel:P_Uzel):integer;
                Procedure Add(Klic:T_Klic);
                Procedure MaxDepth(var Uzel:P_UzeL;var I,max:integer);
               public
                Constructor Init();
                Function    Empty():boolean;
                Function    GetMaxDepth():integer;
                Procedure   UseDelete(Hodnota:T_Klic);
                Destructor  UseDestroy();
                Procedure   UseAdd(Hodnota:T_Klic);
                Procedure   ShowByLevels();
               end;

implementation
 //Private
 Function    T_BST.Find(Hledany:T_Klic;var Uzel:P_Uzel):P_Uzel;
  { Vraci adresu uzlu s hledanou hodnotou klice.Pokud nenajde, vraci nil }
  begin
   if Uzel=nil then
     Find:=nil
    else
     if Hledany=Uzel^.Klic then
       Find:=Uzel
      else
       begin
        If Hledany<Uzel^.Klic then
          Find:=Find(Hledany,Uzel^.Left)
         else
          if Hledany>Uzel^.Klic then
            Find:=Find(Hledany,Uzel^.Right)
    end;
  end;
 Procedure   T_BST.Delete(var Uzel:P_Uzel; Hodnota:T_Klic);
 { Provede smazani uzlu s danou hodnotou.Pokud ma uzel podstrom(y) provede prislusne
   operace prepojeni podstromu.Tato procedura je private, nebot je vyzadovan vstup
   korene, ke kteremu uzivatel nema pristup. }
  var
    Predchozi:P_Uzel;
    Odebiratel:P_Uzel;
  begin
   if Hodnota<Uzel^.Klic then
     Delete(Uzel^.Left,Hodnota)
    else
     if Hodnota>Uzel^.Klic then
       Delete(Uzel^.Right,Hodnota)
       else

  begin
   Odebiratel:=nil;
   if Uzel^.Left=nil then
     Uzel:=Uzel^.Right
    else
     If Uzel^.Right=nil then
       Uzel:=Uzel^.Left
      else
       begin
        Predchozi:=nil;
        Odebiratel:=Uzel^.Left;
        while Odebiratel^.Right<>nil do
         begin
          Predchozi:=Odebiratel;
          Odebiratel:=Odebiratel^.Right;
         end;
        Uzel^.Klic:=Odebiratel^.Klic;
        If Predchozi=nil then
          Uzel^.Left:=Odebiratel^.Left
         else
          Predchozi^.Right:=Odebiratel^.Left
      end;
    Dispose(Odebiratel);
   end;
  end;
 Procedure   T_BST.Destroy(var Uzel:P_Uzel);
  { Provede Zruseni celeho stromu pomoci postupu postorder }
  begin
   if uzel <> nil then begin
   Destroy(uzel^.Left);
   Destroy(uzel^.Right);
   dispose(uzel);
   uzel:= nil;
   end;
  end;
 Function    T_BST.UzelDepth(Uzel:P_Uzel):integer;
  { Vraci cislo hladiny, na ktere se uzel nachazi - koren se nachazi na hladine 0 }
  var
    I:integer;
    Hledac:P_Uzel;
  begin
   Hledac:=koren;
   I:=0;
   while ((Hledac<>nil) and (Hledac^.Klic<>Uzel^.klic)) do
    begin
     if Uzel^.klic<Hledac^.Klic then
      Hledac:=Hledac^.Left
     else
      Hledac:=Hledac^.Right;
     Inc(I);
    end;
     UzelDepth:=I;
  end;
 Procedure   T_BST.Add(Klic:T_Klic);
  { Prida prvek s klicem do stromu (pokud se zde jiz nenachazi) }
  var lokator,predchozi:P_Uzel;
  begin
   if empty() then
     begin
      new(koren);
      koren^.Klic:=Klic;
      koren^.Left:=nil;
      koren^.Right:=nil;
     end
    else
     begin
      lokator:=koren;
      while lokator<>nil do
       begin
        predchozi:=lokator;
        if lokator^.Klic>Klic then
          begin
           lokator:=lokator^.Left
          end
         else
          if lokator^.Klic<Klic then
            lokator:=lokator^.Right;
       end;
       if klic<predchozi^.klic then
         begin
          new(predchozi^.Left);
          predchozi^.Left^.klic:=klic;
          predchozi^.Left^.Left:=nil;
          predchozi^.Left^.Right:=nil
         end
        else
         begin
          new(predchozi^.Right);
          predchozi^.Right^.klic:=klic;
          predchozi^.Right^.Left:=nil;
          predchozi^.Right^.Right:=nil;
         end;
     end;
  end;
 Procedure   T_BST.MaxDepth(var Uzel:P_UzeL;var I,Max:integer);
  { Treti parametr procedury vraci maximalni hloubku stromu }
  begin
   if Uzel^.Left<>nil then
     begin
      inc(i);
      MaxDepth(Uzel^.Left,I,Max)
     end;
   If Uzel^.Right<>nil then
     begin
      inc(i);
      MaxDepth(Uzel^.Right,I,Max);
     end;
   if Max<I then Max:=I;
   Dec(i);
  end;
 //Public
 Function    T_BST.Empty():boolean;
  {Pokud je strom prazdny, vraci true, v opacnem pripadne false}
  begin
   Empty:=(koren=nil);
  end;
 Constructor T_BST.Init();
 {Provede inicializaci binarniho vyhledavaciho stromu}
  begin
   koren:=nil;
  end;
 Procedure   T_BST.UseAdd(Hodnota:T_Klic);
  begin
   if Find(hodnota,koren)=nil then
     Add(Hodnota);
  end;
 Procedure   T_BST.UseDelete(Hodnota:T_Klic);
 { Zjisti, zda uzel s danym klicem je ve stromu.Pokud ano, provede jeho smazani pomoci
   podprogramu DeleteU }
  begin
   If Empty<>True then
     If Find(Hodnota,koren)<>nil then
       Delete(koren,Hodnota)
      else
       writeln('Uzel s klicem ',Hodnota,' se ve stromu nenachazi')
    else
       writeln('Strom je prazdny');

  end;
 Function    T_BST.GetMaxDepth():integer;
  { Vraci Maximalni  hloubku stromu, hloubka korene je 0 }
  var
    input:integer;
    Return:integer;
  begin
   if empty=false then
     begin
      input:=0;
      return:=0;
      MaxDepth(koren,input,Return);
      GetMaxDepth:=Return;
     end
   else
    GetMaxDepth:=-1;
  end;
 Procedure   T_BST.ShowByLevels();
  { Vypise na obrazovku hodnoty klicu po hladinach, kazda hladina je na jednom
    radku. Vyuziva frontu }
  var Fronta:Cqueue;
      active:P_Uzel;
      convertor:pointer;
      nextlevel:integer; //aktualni hladina
  begin
   Fronta.init();
   Fronta.push(koren);
   nextlevel:=0;
   while not(Fronta.empty) do
    begin
     Fronta.Remove(convertor);    //vytahne prvek z fronty
     active:=convertor; // convertor obsahuje adresu uzlu, neni vsak ukazatelem na uzel
     if active^.Left<>nil then
       Fronta.Push(active^.Left);
     if active^.Right<>nil then
         Fronta.Push(active^.Right);
     if (nextlevel<>UzelDepth(active)) then
      begin           //posun na dalsi hladinu
       nextlevel:=UzelDepth(active);
       writeln();
      end;
     write(active^.klic,' ');
    end;
  end;
 Destructor  T_BST.UseDestroy();
 {Spusti proceduru Destroy - zruseni stromu }
  begin
   Destroy(koren);
  end;
end.
