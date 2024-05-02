
/*
 * Copyright (C) Igor Sysoev
 * Copyright (C) Nginx, Inc.
 */


#ifndef _NGX_TIME_H_INCLUDED_
#define _NGX_TIME_H_INCLUDED_


#include <ngx_config.h>
#include <ngx_core.h>


typedef ngx_rbtree_key_t      ngx_msec_t;
typedef ngx_rbtree_key_int_t  ngx_msec_int_t;
#if (T_NGX_RET_CACHE)
typedef ngx_rbtree_key_t      ngx_usec_t;
#endif
#if (T_NGX_VARS)
typedef ngx_rbtree_key_int_t  ngx_usec_int_t;
#endif

typedef SYSTEMTIME            ngx_tm_t;
typedef FILETIME              ngx_mtime_t;

#define ngx_tm_sec            wSecond
#define ngx_tm_min            wMinute
#define ngx_tm_hour           wHour
#define ngx_tm_mday           wDay
#define ngx_tm_mon            wMonth
#define ngx_tm_year           wYear
#define ngx_tm_wday           wDayOfWeek

#define ngx_tm_sec_t          u_short
#define ngx_tm_min_t          u_short
#define ngx_tm_hour_t         u_short
#define ngx_tm_mday_t         u_short
#define ngx_tm_mon_t          u_short
#define ngx_tm_year_t         u_short
#define ngx_tm_wday_t         u_short


#define NGX_HAVE_GETTIMEZONE  1

#define  ngx_timezone_update()

ngx_int_t ngx_gettimezone(void);
void ngx_libc_localtime(time_t s, struct tm *tm);
void ngx_libc_gmtime(time_t s, struct tm *tm);
void ngx_gettimeofday(struct timeval *tp);
void ngx_msleep(int);
void ngx_sleep(int);


#endif /* _NGX_TIME_H_INCLUDED_ */
