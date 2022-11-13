#include "stdio.h"
#include "stdlib.h"

void printUnique(char *arr, char *path)
{
    FILE *fp = fopen(path, "w");
    if (fp == NULL) {
        printf("you must provide 3 valid file paths\n");
        return;
    }

    int i;
    // print all true values
    for (i = 0; i < 128; i++) {
        if (arr[i] == 2) {
            fprintf(fp, "%c", i);
        }
    }
    fclose(fp);
}

int main(int argc, char *argv[]) {

    if (argc != 4) {
        printf("you must provide 3 valid file paths\n");
        return 1;
    }

    int i;
    char *a = (char *)malloc(128 * sizeof(char));
    char c;
    // initialize all values to 0
    for (i = 0; i < 128; i++) {
        a[i] = 0;
    }

    // read string from file
    FILE *fp1 = fopen(argv[1], "r");
    if (fp1 == NULL) {
        printf("you must provide 3 valid file paths\n");
        return 1;
    }
    while ((c = fgetc(fp1)) != EOF) {
        if (a[c] == 0) {
            a[c] = 1;
        }
    }
    fclose(fp1);

    FILE *fp2 = fopen(argv[2], "r");
    if (fp2 == NULL) {
        printf("you must provide 3 valid file paths\n");
        return 1;
    }
    while ((c = fgetc(fp2)) != EOF) {
        if (a[c] == 1) {
            a[c] = 2;
        }
    }
    fclose(fp2);

    printUnique(a, argv[3]);
    free(a);
    
    return 0;
}