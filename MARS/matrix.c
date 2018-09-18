a = 1;
while( a <= n )
{
    b = 1;
    while( b <= m )
    {
        scanf("%d", &t);
        if (t != 0)
        {
            write a into row;
            write b into column;
            write n into value;
            the address of row, column, value += 4;
        }
        b++;
    }
    a++;
}
