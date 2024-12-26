function Get-ProjectName {
    param (
        [validateset("web", "console", "classlib")]
            [Parameter(Mandatory)]
        [string]$Template,
        [Parameter(Mandatory)]
        [string]$ProjectName
        )
        switch ($Template) {
            "web" { return "$ProjectName.WebApp" }
            "classlib" { return "$ProjectName.Lib" }
            "console" { return "$ProjectName.ConsoleApp" }            
        }
}

function New-DotnetProject {
    param (
	[validateset("web", "console", "classlib")]
        [Parameter(Mandatory)]
	[string]$Template,
	[Parameter(Mandatory)]
	[string]$ProjectName
    )

    $SlnDir = "${ProjectName}"
    $ProjectDir = Get-ProjectName -template $Template -ProjectName $ProjectName
    $ProjectCSPROJ = "./${ProjectDir}/${ProjectDir}.csproj"
    $TestsDir = "${ProjectName}.Tests"
    $TestCSPROJ = "./${TestsDir}/${TestsDir}.csproj"

    dotnet new sln -o $SlnDir    
    Set-Location $SlnDir
    dotnet new gitignore
    dotnet new $Template -o $ProjectDir
    dotnet sln add $ProjectCSPROJ
    dotnet new xunit -o $TestsDir
    dotnet sln add $TestCSPROJ
    dotnet add $TestCSPROJ reference $ProjectCSPROJ
}
