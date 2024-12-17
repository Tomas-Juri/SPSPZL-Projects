unit KruhD;

interface

uses GeoTvarD;

type tucKruh =^cKruh;
     cKruh = OBJECT (cGeoTvar)
               private
                 r :real;
               public
                 constructor init(ar :real);
                 function urciObvod :real;  VIRTUAL;
                 destructor done; VIRTUAL;
             end;

implementation

constructor cKruh.init(ar :real);
begin
  r :=ar
end;

function cKruh.urciObvod :real;
begin
  urciObvod :=2 * PI * r
end;

destructor cKruh.done;
begin
  r :=0
end;

end.

