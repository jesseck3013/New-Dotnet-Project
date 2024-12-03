function New-DotnetProject {
    param (
	[validateset("web", "console", "classlib")]
        [Parameter(Mandatory)]
	[string]$Template,
	[Parameter(Mandatory)]
	[string]$ProjectName
    )

    $SlnDir = "${ProjectName}-test"
    $ProjectDir = "${ProjectName}"
    $TestsDir = "${ProjectName}.Tests"

    dotnet new sln -o $SlnDir
    cd $SlnDir
    dotnet new $Template -o $ProjectName
    dotnet sln add "./${ProjectName}/${ProjectName}.csproj"
    dotnet new xunit -o $TestsDir
    dotnet add "./${ProjectName}.Tests/${ProjectName}.Tests.csproj" reference "./${ProjectName}/${ProjectName}.csproj"
    dotnet sln add "./${ProjectName}.Tests/${ProjectName}.Tests.csproj"
}
