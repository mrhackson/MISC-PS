function StringifyArray{
    param(
        [arra]$Array
    )

    "@('" + $($array -join ', ') + "')"
}
