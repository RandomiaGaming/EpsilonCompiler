#include <stdio.h>
#include <windows.h>

int main(int argc, char *argv[]) {
    if (argc < 2) {
        // No command line arguments, do nothing
        printf("No command line arguments provided.\n");
    } else {
        // Initialize the Windows clipboard
        if (!OpenClipboard(NULL)) {
            fprintf(stderr, "Failed to open clipboard.\n");
            return 1;
        }

        // Empty the clipboard
        if (!EmptyClipboard()) {
            fprintf(stderr, "Failed to empty clipboard.\n");
            CloseClipboard();
            return 1;
        }

        // Allocate memory for the text to be placed on the clipboard
        HGLOBAL hClipboardData;
        const char *textToCopy = argv[1];
        size_t len = strlen(textToCopy) + 1;
        hClipboardData = GlobalAlloc(GMEM_MOVEABLE, len);
        if (hClipboardData == NULL) {
            fprintf(stderr, "Failed to allocate memory for clipboard data.\n");
            CloseClipboard();
            return 1;
        }

        // Copy the text to the allocated memory
        char *clipboardText = (char *)GlobalLock(hClipboardData);
        strcpy(clipboardText, textToCopy);
        GlobalUnlock(hClipboardData);

        // Set the clipboard data
        if (SetClipboardData(CF_TEXT, hClipboardData) == NULL) {
            fprintf(stderr, "Failed to set clipboard data.\n");
            CloseClipboard();
            GlobalFree(hClipboardData);
            return 1;
        }

        // Close the clipboard
        CloseClipboard();

        printf("Copied \"%s\" to the clipboard.\n", textToCopy);
    }

    return 0;
}
