function StringifyArray{
    param(
        [array]$Array
    )

    "@('" + $($array -join ', ') + "')"
}
