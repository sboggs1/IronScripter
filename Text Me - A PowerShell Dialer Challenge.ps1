# IronSripter.us
# Text Me – A PowerShell Dialer Challenge
# technique: find letter in delimited string, count delimiters
cls

#delimited alphabet string, break in keypad number blocks, No.1 has no letters
$a='||abc|def|ghi|jkl|mno|pqrs|tuv|wxyz'

#Infinite loop to keep doing more words
While($true){
    #set arr to null, then accept entry when arr is not null
    $arr=$null
    Do{
        #validate var $str entry : Word chars, qty 1-5 (nums are valid word chars); $arr will be valid only if $str is valid
        Try{[ValidatePattern('^\w{1,5}$')][string]$str = Read-host -Prompt 'Enter your word '
            $arr = $str.ToCharArray()
        }
        Catch{Write-Host 'Invalid, 5 chars maximum, only letters and numbers'}
    }Until($arr -ne $null)
    #set result to blank string
    [string]$result=''
    ForEach($ltr in $arr){
        # if entry had a num, simply paste it to the result
        If($ltr -match '\d'){$result += $ltr}
        # otherwise,
        Else{
            # create a substring $b from $a, to length of current $ltr
            $b = $a.Substring(0,$a.IndexOf($ltr))
            # make var b into an array, select only the delims, then measure the char count, add that numerical count to the result string
            $result += (($b.ToCharArray().Where({$_ -match '\|'}) | Measure-Object -Character).Characters)
        }
    }
    $result
    # add a CFLF and loop to While
    ''
}

