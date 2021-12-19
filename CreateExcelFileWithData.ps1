#Creates Excel application
$excel = New-Object -ComObject excel.application
#Makes Excel Visable
$excel.Application.Visible = $false
$excel.DisplayAlerts = $false
#Creates Excel workBook
$book = $excel.Workbooks.Add()
#Adds worksheets

#gets the work sheet and Names it
$sheet = $book.Worksheets.Item(1)
$sheet.name = 'Alle Benutzer'
#Select a worksheet
$sheet.Activate() | Out-Null
#Create a row and set it to Row 1
$row = 1
#Create a Column Variable and set it to column 1
$column = 1

$fontSize = 12
$fontBold = $true

#Create Intial row so you can add borders later
$initalRow = $row
#create Headers for your sheet
$sheet.Cells.Item($row,$column) = "Vorname"
$sheet.Cells.Item($row,$column).Font.Size = $fontSize
$sheet.Cells.Item($row,$column).Font.Bold = $fontBold
$column++
$sheet.Cells.Item($row,$column) = "Nachname"
$sheet.Cells.Item($row,$column).Font.Size = $fontSize
$sheet.Cells.Item($row,$column).Font.Bold = $fontBold
$column++
$sheet.Cells.Item($row,$column) = "Vollständiger Name"
$sheet.Cells.Item($row,$column).Font.Size = $fontSize
$sheet.Cells.Item($row,$column).Font.Bold = $fontBold
$column++
$sheet.Cells.Item($row,$column) = "E-Mail Adresse"
$sheet.Cells.Item($row,$column).Font.Size = $fontSize
$sheet.Cells.Item($row,$column).Font.Bold = $fontBold

#Now that the headers are done we go down a row and back to column 1
$row++
$column = 1
#command you want to use to get infromation

$users = Import-Csv C:\_Scripts\Names.csv
foreach($i in $users){
    $sheet.Cells.Item($row,$column) = $i.Vorname
    $column++
    $sheet.Cells.Item($row,$column) = $i.Nachname
    $column++
    $sheet.Cells.Item($row,$column) = $i.'Vollständiger Name'
    $column++
    $sheet.Cells.Item($row,$column) = $i.'E-Mail Adresse'
    $row++
    $column = 1
}

$row--
$dataRange = $sheet.Range(("A{0}" -f $initalRow),("D{0}"  -f $row))
7..12 | ForEach {
    $dataRange.Borders.Item($_).LineStyle = 1
    $dataRange.Borders.Item($_).Weight = 2
}

#Fits cells to size
$UsedRange = $sheet.UsedRange
$UsedRange.EntireColumn.autofit() | Out-Null

$outputpath = "C:\_Scripts\alleBenutzer.xlsx"
$book.SaveAs($outputpath)
$excel.Quit()
