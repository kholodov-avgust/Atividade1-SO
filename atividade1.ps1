$escolha = 0
while ($escolha -ne 11) {
    Clear-Host
    Write-Host "======================= MENU GERAL ======================= "-ForegroundColor Yellow
    Write-Host "1  - Abrir Programa (Números Antecessor e Sucessor)"
    Write-Host "2  - Abrir Programa (Rendimento do Aluno)"
    Write-Host "3  - Abrir Processos Customizados"
    Write-Host "4  - Listar Processos Customizados"
    Write-Host "5  - Iniciar o Navegador Edge"
    Write-Host "6  - Finalizar Processos por ID"
    Write-Host "7  - Finalizar Processos por Nome"
    Write-Host "8  - Verificar se um processo está rodando (Customizado)"
    Write-Host "9  - Listar Serviços do Sistema Operacional Parados"
    Write-Host "10 - Listar os 20 processos que ocupam mais memória RAM"
    Write-Host "11 - Sair do Script"
    Write-Host "========================================================== "-ForegroundColor Yellow

    $escolha = Read-Host "Escolha uma opção"

    switch ($escolha) {
        1 {
            $num = [int](Read-Host "Digite um número")
            Write-Host "Antecessor: $($num - 1) | Sucessor: $($num + 1)" -ForegroundColor Cyan
        }
        2 {
            $n1 = [double](Read-Host "Nota 1")
            $n2 = [double](Read-Host "Nota 2")
            $m = ($n1 + $n2) / 2
            $sit = if ($m -ge 6) { "Aprovado" } elseif ($m -ge 4) { "Exame" } else { "Retido" }
            Write-Host "Média: $m - Situação: $sit" -ForegroundColor Magenta
        }
        3 {
            $proc = Read-Host "Nome do processo para abrir"
            Start-Process $proc
        }
        4 {
            Get-Process | Select-Object Name, ID -First 15 | Format-Table
        }
        5 {
            Start-Process "msedge.exe"
            Write-Host "Microsoft Edge iniciado!" -ForegroundColor Green
        }
        6 {
            $id = Read-Host "Digite o ID do processo"
            Stop-Process -Id $id -Force
        }
        7 {
            $nome = Read-Host "Digite o nome do processo"
            Stop-Process -Name $nome -Force
        }
        8 {
            $busca = Read-Host "Nome do processo para verificar"
            if (Get-Process -Name $busca -ErrorAction SilentlyContinue) {
                Write-Host "O processo $busca está em execução." -ForegroundColor Green
            } else {
                Write-Host "Processo não encontrado." -ForegroundColor Red
            }
        }
        9 {
            Get-Service | Where-Object {$_.Status -eq "Stopped"} | Select-Object Name, DisplayName -First 20 | Format-Table
        }
        10 {
            Write-Host "Top 20 processos por consumo de RAM:" -ForegroundColor Cyan
            Get-Process | Sort-Object WorkingSet64 -Descending | Select-Object Name, @{Name="RAM(MB)"; Expression={$_.WorkingSet64 / 1MB}} -First 20 | Format-Table
        }
        11 {
            Write-Host "Saindo..." -ForegroundColor Yellow
        }
        Default {
            Write-Host "Opção inválida!" -ForegroundColor Red
        }
    }
    if ($escolha -ne 11) { Read-Host "`nPressione Enter para continuar..." }
}