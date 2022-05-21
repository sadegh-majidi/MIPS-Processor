module ORsix1bit(i5, i4, i3, i2, i1, i0, Out);
input i5, i4, i3, i2, i1, i0;
output reg Out;
always @(i5, i4, i3, i2, i1, i0)
begin
Out = i5 | i4 | i3 | i2 | i1 | i0;
end
endmodule
