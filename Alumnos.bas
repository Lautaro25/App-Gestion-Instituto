B4A=true
Group=Default Group
ModulesStructureVersion=1
Type=Activity
Version=12.2
@EndOfDesignText@
#Region  Activity Attributes 
	#FullScreen: False
	#IncludeTitle: True
#End Region

Sub Process_Globals
	'These global variables will be declared once when the application starts.
	'These variables can be accessed from all modules.
	Private xui As XUI
	Dim Consulta As SQL
	Dim Resultado_Consulta As Cursor
End Sub

Sub Globals
	'These global variables will be redeclared each time the activity is created.
	'These variables can only be accessed from this module.

	Private Button3 As Button
	Private B4XTable1 As B4XTable
End Sub

Sub Activity_Create(FirstTime As Boolean)
	'Do not forget to load the layout file created with the visual designer. For example:
	Activity.LoadLayout("Alumnos")
	If File.Exists(File.DirInternal,"gestorinstituto.s3db") = False Then
		File.Copy(File.DirAssets,"gestorinstituto.s3db",File.DirInternal,"gestorinstituto.s3db")
	End If

	If Consulta.IsInitialized = False Then
		
		Consulta.Initialize(File.DirInternal,"gestorinstituto.s3db",False)
	End If
	
	B4XTable1.AddColumn("ID", B4XTable1.COLUMN_TYPE_NUMBERS)
	B4XTable1.AddColumn("DNI", B4XTable1.COLUMN_TYPE_TEXT)
	B4XTable1.AddColumn("Nombre y Apellido", B4XTable1.COLUMN_TYPE_TEXT)
	B4XTable1.AddColumn("Dirección", B4XTable1.COLUMN_TYPE_TEXT)
	B4XTable1.AddColumn("Edad", B4XTable1.COLUMN_TYPE_TEXT)
	
	Dim Data As List
	Data.Initialize
	Resultado_Consulta = Consulta.ExecQuery("SELECT * FROM Alumnos")
	
	For i = 0 To Resultado_Consulta.RowCount-1
		Resultado_Consulta.Position = i
		Dim row(5) As Object
		row(0) = Resultado_Consulta.GetInt("ID")
		row(1) = Resultado_Consulta.GetString("DNI")
		row(2) = Resultado_Consulta.GetString("NombreyApellido")
		row(3) = Resultado_Consulta.GetString("Direccion")
		row(4) = Resultado_Consulta.GetString("Edad")
		' Manejar valores nulos
		For j = 0 To 4
			If row(j) = Null Then row(j) = "" ' Convertir valores nulos a cadenas vacías
		Next
		Data.Add(row)
	Next

	B4XTable1.SetData(Data)
	Resultado_Consulta.Close
End Sub

Sub Activity_Resume

End Sub

Sub Activity_Pause (UserClosed As Boolean)

End Sub


Private Sub Button3_Click
	ExitApplication()
End Sub