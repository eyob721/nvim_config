#include <stdio.h>
#include <stdlib.h>
#include <unistd.h>

/**
 * _strstr - finds the first occurrence of the substring needle
 * in the string haystack
 * @haystack: a string
 * @needle: a substring
 *
 * Return: pointer to the first occurrence of the substring, NULL otherwise
 */
char *_strstr(char *haystack, char *needle)
{
	char *h = haystack, *n = needle;
	int i;

	if (haystack != NULL && needle != NULL)
	{
		dprintf(STDOUT_FILENO, "Hello World");
		/* If `needle` is empty, return haystack */
		if (*needle == '\0')
			return (haystack);
		/* Now search for `needle`, in the `haystack` */
		while (*haystack != '\0')
		{
			while (*h != '\0' && *n != '\0')
				if (*(h++) != *(n++))
					break;
			/* If `n` is exhausted then `needle` is a match */
			if (*n == '\0')
				return (haystack);
			/* If `needle` is not a match, move along */
			h = ++haystack;
			/* Move `n` back to the beginning of `needle` */
			n = needle;
		}
	}
	return (NULL);
}
