
#include <stdio.h>
#include <string.h>
#include "roman.h"

/* Get value of a Roman character */
static int roman_value(char ch)
{
    switch (ch)
    {
        case 'I': return 1;
        case 'V': return 5;
        case 'X': return 10;
        case 'L': return 50;
        case 'C': return 100;
        case 'D': return 500;
        case 'M': return 1000;
        default: return 0;
    }
}

/* Convert Roman numeral to Integer */
int roman_to_int(const char *roman)
{
    int total = 0;
    int i;
    int len = strlen(roman);

    for (i = 0; i < len; i++)
    {
        int current = roman_value(roman[i]);
        int next = 0;

        if (i + 1 < len)
            next = roman_value(roman[i + 1]);

        if (current < next)
            total -= current;
        else
            total += current;
    }

    return total;
}

/* Convert Integer to Roman numeral */
void int_to_roman(int number, char *result)
{
    int values[] = {
        1000, 900, 500, 400,
        100, 90, 50, 40,
        10, 9, 5, 4, 1
    };

    const char *symbols[] = {
        "M", "CM", "D", "CD",
        "C", "XC", "L", "XL",
        "X", "IX", "V", "IV", "I"
    };

    int i;

    result[0] = '\0';

    if (number <= 0 || number > 3999)
    {
        strcpy(result, "Invalid");
        return;
    }

    for (i = 0; i < 13; i++)
    {
        while (number >= values[i])
        {
            strcat(result, symbols[i]);
            number -= values[i];
        }
    }
}
