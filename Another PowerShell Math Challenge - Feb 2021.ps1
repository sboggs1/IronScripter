
# Another PowerShell Math Challenge 
# IronScripter Feb 2021

cls
Sleep -m 100
Function Add-Chars(){
    param(
        [Parameter(Mandatory=$true, 
                   ValueFromPipeline=$true,
                   Position=0)]
        [ValidateNotNullOrEmpty()]
        [ValidatePattern('^\d{1,10}$')]
        [string]
        $val
    )
    
    Begin { [int32]$ans = 0 }
    Process{
        Write-Verbose "Input value: $val"
        For($i=0;$i -le ($val.Length-1);$i++){
            Write-Verbose -Message "Add $ans plus $($val[$i])"
            $ans = $ans + [System.Int32]::Parse($val[$i])
        }
        Write-Verbose "Char sum =  $ans"
    }
    End{ Return $ans }
}

Function Add-CharsToPipeline(){
    param(
        [Parameter(Mandatory=$true, 
                   ValueFromPipeline=$true,
                   Position=0)]
        [ValidateNotNullOrEmpty()]
        [ValidatePattern('^\d{1,10}$')]
        [string]
        $val
    )
    
    Begin { [int32]$ans = 0 }
    Process{
        Write-Verbose "Input value: $val"
        For($i=0;$i -le ($val.Length-1);$i++){
            Write-Verbose -Message "Add $ans plus $($val[$i])"
            $ans = $ans + [System.Int32]::Parse($val[$i])
        }
        Write-Verbose "Char sum =  $ans"
    }
    End{
        $obj = New-Object -TypeName PSObject -Property ([ordered]@{Input=$val;ElementCount=$val.Length;Sum=$ans})
        Return $obj 
        }
}

Function Get-Subsets ($a){
    # modified from https://stackoverflow.com/questions/28331257/unique-combos-from-powershell-array-no-duplicate-combos
    #create an array to store output
    $l = @()
    #for any set of length n the maximum number of subsets is 2^n
    for ($i = 0; $i -lt [Math]::Pow(2,$a.Length); $i++)
    { 
        #temporary array to hold output
        [string[]]$out = New-Object string[] $a.length
        #iterate through each element
        for ($j = 0; $j -lt $a.Length; $j++)
        { 
            #start at the end of the array take elements, work your way towards the front
            if (($i -band (1 -shl ($a.Length - $j - 1))) -ne 0)
            {
                #store the subset in a temp array
                $out[$j] = $a[$j]
            }
        }
        #stick subset into an array
        # do not add blank entry to list
        If((-join $out).Trim() -ne ''){$l += -join $out}
    }
    #group the subsets by length, iterate through them and sort
        ($l | Group-Object -Property Length | %{$_.Group | sort})
}

'Add Character values'
Add-Chars 2563 -Verbose
''
'Add Character values - out to Pipeline'
2563 | Add-CharsToPipeline -Verbose | FL *
''
'Add Character values - out to Pipeline, select only the character sum'
2563 | Add-CharsToPipeline | Select -ExpandProperty Sum 
''
'List all possible character sums in string'
$a = @(2,5,6,3)
Get-Subsets ($a -join '') | % {Add-Chars $_} | Sort | Select -Unique

break

