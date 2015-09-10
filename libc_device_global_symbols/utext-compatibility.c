#include <pthread.h>
#include <dlfcn.h>

static pthread_mutex_t mutex;
static void *dll;
static char *(*fn_u_errorName)(int);
static int (*fn_u_digit)(int, char);
static void *(*fn_utext_close)(void *);
static void *(*fn_utext_openUChars)(void *, const char *, int64_t, void *);

static void
load_utext_locked(void)
{
    if (dll != NULL) {
        /* Someone else concurrently opened it, we can just use it */
        return;
    }

    dll = dlopen("icuuc", 0);
    if (dll == NULL) {
        /* TODO REPORT ERROR */
    } else {
        fn_u_digit = dlsym(dll, "u_digit_53");
        fn_u_errorName = dlsym(dll, "u_errorName_53");
        fn_utext_close = dlsym(dll, "utext_close_53");
        fn_utext_openUChars = dlsym(dll, "utext_openUChars_53");
        if (fn_u_digit == NULL ||
            fn_u_errorName == NULL ||
            fn_utext_close == NULL ||
            fn_utext_openUChars == NULL) {
            /* TODO REPORT ERROR */
            dlclose(dll);
            dll = NULL;
        }
    }
}

static int
ensure_utext_loaded(void) {
    if (dll == NULL) {
        pthread_mutex_lock(&mutex);
        load_utext_locked();
        pthread_mutex_unlock(&mutex);
    }

    return dll != NULL;
}

int u_digit_51(int ch, char radix) {
    return fn_u_digit(ch, radix);
}

void *u_errorName_51(int code) {
    if (! ensure_utext_loaded()) {
        return NULL;
    }
    return fn_u_errorName(code);
}

char *utext_close_51(void *ut) {
    if (! ensure_utext_loaded()) {
        return NULL;
    }
    return fn_utext_close(ut);
}

void *utext_openUChars_51(void *ut, const char *s, int64_t length, void *status) {
    if (! ensure_utext_loaded()) {
        return NULL;
    }
    return fn_utext_openUChars(ut, s, length, status);
}

