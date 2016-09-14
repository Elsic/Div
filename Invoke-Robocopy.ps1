#requires -Version 3

function Invoke-Robocopy
{
    param
    (
        [String]
        [Parameter(Mandatory)]
        $Source,

        [String]
        [Parameter(Mandatory)]
        $Destination,

        [String]
        $Filter = '*',
        
        [Switch]
        $Recurse,
        
        [Switch]
        $Open
    )

    if ($Recurse)
    {
        $DoRecurse = '/S'
    }
    else
    {
        $DoRecurse = ''
    }

    
    robocopy $Source $Destination $Filter $DoRecurse /R:0 
    
  if ($Open)
  {
      explorer.exe $Destination
  }    
}
