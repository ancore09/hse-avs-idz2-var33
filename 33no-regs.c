#include "stdio.h"
#include "stdlib.h"

void printUnique(char *arr, char *path)
{
    FILE *fp = fopen(path, "w");
    // print all true values
    for (int i = 0; i < 128; i++) {
        if (arr[i] == 2) {
            fprintf(fp, "%c", i);
        }
    }
    fclose(fp);
}

int main(int argc, char *argv[]) {
    char *a = (char *)malloc(128 * sizeof(char));
    char c;
    // initialize all values to 0
    for (int i = 0; i < 128; i++) {
        a[i] = 0;
    }

    // read string from file
    FILE *fp1 = fopen(argv[1], "r");
    while ((c = fgetc(fp1)) != EOF) {
        if (a[c] == 0) {
            a[c] = 1;
        }
    }
    fclose(fp1);

    FILE *fp2 = fopen(argv[2], "r");
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