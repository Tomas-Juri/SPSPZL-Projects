unit ucAPL;

interface

type cAPL = OBJECT
              constructor init;
              procedure run;
              destructor done;
            end;

var aplikace :cAPL;

implementation

uses crt, GeoTvarD, KruhD, ObdD, PlochaD;

var uoGeoTvar :tucGeoTvar;
        oKruh :tucKruh;
    oObdelnik :tucObd;
      oPlocha :tucPlocha;
        obvod :real;

constructor cAPL.init;
begin
  uoGeoTvar :=NIL;
  new(oPlocha,init);
  new(oKruh,init(2));
  new(oObdelnik,init(1.4,100));
end;

destructor cAPL.done;
begin
  oKruh^.done;
  oObdelnik^.done;
  oPlocha^.done;
  uoGeoTvar :=NIL
end;

procedure cAPL.run;
begin
  Writeln('Obvody jednotlivych objektu - aktivace jejich metody urciObvod');
  Writeln('--------------------------------------------------------------');
  Writeln('Obvod kruhu (oKruh.urciObvod):         ',oKruh^.urciObvod:24:3);
  Writeln('Obvod obdelniku (oObdelnik.urciObvod): ',oObdelnik^.urciObvod:24:3);
  Write('Celkovy obvod (oKruh.urciObvod + oObdelnik.urciObvod): ');
  Writeln(oKruh^.urciObvod + oObdelnik^.urciObvod:8:3);
  Writeln('Obvody jednotlivych objektu pomoci kompatibility mezi ukazateli');
  Writeln('---------------------------------------------------------------');
  uoGeoTvar :=@oKruh; //Polymorfní objekt
  obvod :=uoGeoTvar^.urciObvod;
  Writeln('Obvod kruhu (uoGeoTvar^.urciObvod): ',obvod:12:3);
  uoGeoTvar :=@oObdelnik; //Polymorfní objekt
  Write('Obvod obdelniku (uoGeoTvar^.urciObvod): ');
  Writeln(uoGeoTvar^.urciObvod:8:3);
  obvod :=obvod + uoGeoTvar^.urciObvod;
  Writeln('Celkovy obvod:                          ', obvod:8:3);
  Writeln;
  Writeln('Celkovy obvod slozeneho objektu metodou oPlocha.urciObvody: ');
  Writeln('------------------------------------------------------------');
  oPlocha^.pridej(@oKruh);
  oPlocha^.pridej(@oObdelnik);
  obvod :=oPlocha^.urciObvody;
  Writeln('Celkovy obvod (oPlocha.urciObvody): ', obvod:8:3);
  Writeln;
  Writeln('Konec [ENTER]');
  Readln
end;

end.

