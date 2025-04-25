# Указываем путь к файлу с именами компьютеров
$computersFile = "C:\Users\mukhitda\Desktop\Zip.txt"

# Указываем имя коллекции, в которую нужно добавить компьютеры
$collectionName = "7-Zip"

# Получаем объект коллекции по имени
$collection = Get-CMDeviceCollection -Name $collectionName

# Если коллекция не найдена, выводим сообщение об ошибке и завершаем скрипт
if (-not $collection) {
    Write-Host "Коллекция с именем $collectionName не найдена."
    exit
}

# Читаем имена компьютеров из файла
$computersToAdd = Get-Content $computersFile

# Добавляем каждый компьютер в коллекцию
foreach ($computerName in $computersToAdd) {
    $computer = Get-CMDevice -Name $computerName
    if (-not $computer) {
        Write-Host "$computerName, не найден."
    } else {
        Add-CMDeviceCollectionDirectMembershipRule -CollectionName $collectionName -ResourceId $computer.ResourceId
        Write-Host "$computerName, успешно добавлен в коллекцию $collectionName."
    }
}