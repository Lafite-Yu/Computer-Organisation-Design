int main()
{
	int n = 0;
	int judge = 0;
	scanf("%d", &n);
	if( n % 4 == 0)
	{
		if ( n % 100 == 0)
		{
			if ( n % 400 == 0)
			{
				judge = 1;
			}
			else
			{
			    judge = 0;
			}
		}
		else
		{
			judge = 1;
		}
	}
	printf("%d\n", judge);
	return 0;
}
