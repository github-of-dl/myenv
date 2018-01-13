/**
 * statically link mysqlclient lib so that this program can be used on server without mysql
 * usage:
 *		exe {HOST} {USER} {PASSWORD} {DB} {SQL}
 *
 *
 */

#include <stdio.h>

#include <mysql.h>

int wrapper_conn(MYSQL *conn, const char *host, const char *user, const char *password, const char *db);
int wrapper_exe(MYSQL *conn, const char *sql);

/**
 *
 */
int main(int argc, char *argv[])
{
	if(argc<=5)
	{
		fprintf(stderr, "need param\n");
		return 1;
	}

	const char *host = argv[1];
	const char *user = argv[2];
	const char *password = argv[3];
	const char *db = argv[4];
	const char *sql = argv[5];

	MYSQL conn;
	int ret = wrapper_conn(&conn, host, user, password, db);
	if(0!=ret)
	{
		fprintf(stderr, "failed to connect to mysql");
		return 1;
	}

	wrapper_exe(&conn, sql);

	return 0;
}
int wrapper_conn(MYSQL *conn, const char *host, const char *user, const char *password, const char *db)
{
	if(!mysql_init(conn))
	{
		fprintf(stderr, "error to initialize mysql connection\n");
		return 1;
	}
	if(!mysql_real_connect(conn, host, user, password, db, 3306, NULL, 0))
	{
		fprintf(stderr, "error to connect mysql:%s\n", mysql_error(conn));
		return 1;
	}
	mysql_set_character_set(conn, "utf8");
	return 0;
}
int wrapper_exe(MYSQL *conn, const char *sql)
{
	if(mysql_query(conn, sql))
	{
		fprintf(stderr, "error to execute sql[%s]. %s\n", sql, mysql_error(conn));
		return 1;
	}else
	{
		MYSQL_RES *result;
		result=mysql_store_result(conn);
		if(result)
		{
			unsigned int num_fields = mysql_num_fields(result);
			enum_field_types *fields_type = new enum_field_types[num_fields];
			if(NULL==fields_type)
			{
				fprintf(stderr, "failed to allocate memory for fields-type");
				return 1;
			}
			MYSQL_FIELD *field;
			int i=0;
			while((field = mysql_fetch_field(result)))
			{
				fields_type[i++] = field->type;
			}

			MYSQL_ROW row;
			while((row=mysql_fetch_row(result)))
			{
				unsigned long int *lengths;//指向一个数组, 存储当前记录各个字段长度
				lengths=mysql_fetch_lengths(result);
				if(lengths==NULL)
				{
					fprintf(stderr, "error to get length of field in query-result-set: %s\n", mysql_error(conn));
					break;
				}
				for(unsigned int i=0; i<num_fields; ++i)
				{
					switch(fields_type[i])
					{
						case MYSQL_TYPE_TINY:
						case MYSQL_TYPE_SHORT:
						case MYSQL_TYPE_LONG:
						case MYSQL_TYPE_INT24:
						case MYSQL_TYPE_LONGLONG:
							printf("%s", row[i]);
							break;

						case MYSQL_TYPE_STRING:
						case MYSQL_TYPE_VAR_STRING:
							printf("%s", row[i]);
							break;

						case MYSQL_TYPE_DECIMAL:
						case MYSQL_TYPE_FLOAT:
						case MYSQL_TYPE_DOUBLE:
						case MYSQL_TYPE_NEWDECIMAL:
						case MYSQL_TYPE_TIMESTAMP:
						case MYSQL_TYPE_DATE:
						case MYSQL_TYPE_TIME:
						case MYSQL_TYPE_DATETIME:
						case MYSQL_TYPE_YEAR:
						case MYSQL_TYPE_BLOB:
						case MYSQL_TYPE_SET:
						case MYSQL_TYPE_ENUM:
						case MYSQL_TYPE_GEOMETRY:
						case MYSQL_TYPE_NULL:
						case MYSQL_TYPE_BIT:
							printf("what?");
							break;
						default:
							break;
					}
					if(i+1!=num_fields)
						printf(" ");
				}
				printf("\n");
			}
		}
		mysql_free_result(result);
	}
	return 0;
}
