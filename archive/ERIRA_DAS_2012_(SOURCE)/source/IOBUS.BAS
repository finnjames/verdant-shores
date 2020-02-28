Attribute VB_Name = "IOBUS"
'Global declarations for IOBUS

Private Declare Function bytein Lib "xxio.dll" (ByVal ioPort As Integer) As Integer
Private Declare Sub byteout Lib "xxio.dll" (ByVal ioPort As Integer, ByVal oValue As Integer)

'Declare Function InByte Lib "BUS.DLL" (ByVal Number As Integer) As Integer
'Declare Sub OutByte Lib "BUS.DLL" (ByVal Number As Integer, ByVal Number As Integer)

