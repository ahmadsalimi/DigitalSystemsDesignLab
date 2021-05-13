`define WL          8
`define complex     [2*`WL-1:0]
`define Re(c)       c[2*`WL-1:`WL]
`define Im(c)       c[`WL-1:0]
`define sRe(c)      $signed(`Re(c))
`define sIm(c)      $signed(`Im(c))
