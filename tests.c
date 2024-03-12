#include <stdio.h>
#include "src/db.h"
#include "src/data.h"
#include "src/string+.h"
#include "src/varenv.h"

#include "tests/db_postgres_test.h"

int main(int argc, char** argv){
	loadEnvVars(NULL);
	
	db_postgres_test();	
	
	return 0;
}