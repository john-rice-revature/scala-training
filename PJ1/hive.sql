CREATE TABLE OCT20_PAGEVIEWS_DB AS
SELECT DOMAIN_CODE, ARTICLE_NAME, SUM(PAGE_VIEWS) AS TOTAL
    FROM PAGEVIEWS
    WHERE DOMAIN_CODE="en" OR DOMAIN_CODE="en.m"
    GROUP BY DOMAIN_CODE, ARTICLE_NAME
    SORT BY TOTAL DESC
    LIMIT 10;

-- Q2, loaad
LOAD DATA INPATH '/user/jwr3a/input' INTO TABLE PRE_MRVIEWS;
-- Q2, step 1-- grab only en, en.m -- added up views  - LIMITED PAGEVIEWS to only 25 -- this limits unrealistic results
CREATE TABLE MRVIEWS AS 
SELECT ARTICLE, SUM(PAGE_VIEWS) AS TOTAL_VIEWS
    FROM PRE_MRVIEWS
    WHERE DOMAIN_CODE="en" OR DOMAIN_CODE="en.m"
    GROUP BY ARTICLE
    SORT BY TOTAL_VIEWS DESC
    LIMIT 25;
-- Q2, step 2 -- join internal links from clickstream & pageview totals, article name on a new table
CREATE TABLE Q2_MERGED_MR AS
    SELECT MRVIEWS.ARTICLE, MRVIEWS.TOTAL_VIEWS, MRCLICKS.INTERNAL_LINK
    FROM MRCLICKS 
    JOIN MRVIEWS ON (MRVIEWS.ARTICLE = MRCLICKS.ARTICLE)
    LIMIT 25;


-- Q2, step 3 - final
CREATE TABLE Q2_RESULTS AS
    SELECT *, CAST (INTERNAL_LINK / TOTAL_VIEWS * 100 AS DECIMAL(5, 3)) AS PERCENT_INTERNAL
    FROM Q2_MERGED_MR
    SORT BY PERCENT_INTERNAL DESC
    LIMIT 10;



-- Q3, step 1 -- receive clickstream in Hive for analysis
create table link_trace_cs
    (referrer string, 
    requested_article string,
    type_traffic string,
    occurences int)
    row format delimited
    fields terminated by '\t';

-- Q3, step 2 -- load table with pure clickstream tsv
LOAD DATA LOCAL INPATH '/mnt/d/Documents/BDB/Projects/PJ1/Datasets/Q3' INTO TABLE link_trace_cs;

-- Q3, step 3 -- reduce data down to type traffic internal and referrer won't return anything unless it's a article title
create table link_trace_internal as
    select * from link_trace_cs
    where type_traffic="link" and referrer like "Eagles_(box_set)" and not (referrer = "other-internal" 
    or referrer= "other-search" or referrer="other-external"or referrer="other-empty"or referrer ="other-other")
    sort by occurences desc 
    limit 100;

-- Q3, step 4 -- reduce data down to type traffic internal and referrer returns specifically the article that high 
-- the next highest internal clicks. both referrer and requested article was queried to see which returns
-- the best result for internal link pipeline. Referrer gave the highest popularity. 

-- The step 4 sql commands are repetitive of what you see on step 3. the only thing that changes is "referrer like" and the new 
-- article is then inputted.

-- Q3, step 5 -- gather and chain results

Hotel_California(2222) -> Hotel_California_(Eagles_Album)(2010) -> The_Long_Run_(album)(2127) -> 
Eagles_Live(1322) -> Eagles_Greatest_Hits,_Vol._2(1136) -> The_Very_Best_of_the_Eagles(996) -> 
Hell_Freezes_Over(892) -> Selected_Works:_1972–1999(735) -> The_Very_Best_Of_(Eagles_album)(705) -> 
Eagles_(box_set)(646)


-- Q4, 


-- Q5, set up table

create table revisions (WIKI_DB STRING, 
                EVENT_ENTITY STRING,
                EVENT_TYPE STRING,
                EVENT_TIMESTAMP STRING,
                EVENT_COMMENT STRING,
                EVENT_USER_ID BIGINT,
                EVENT_USER_TEXT_HISTORICAL STRING,
                EVENT_USER_TEXT STRING,
                EVENT_USER_BLOCKS_HISTORICAL STRING,
                EVENT_USER_BLOCKS ARRAY<STRING>,
                EVENT_USER_GROUPS_HISTORICAL ARRAY<STRING>,
                EVENT_USER_GROUPS ARRAY<STRING>,
                event_user_is_bot_by_historical ARRAY<STRING>,
                event_user_is_bot_by ARRAY<STRING>,
                event_user_is_created_by_self BOOLEAN,
                event_user_is_created_by_system BOOLEAN,
                event_user_is_created_by_peer BOOLEAN,
                event_user_is_anonymous BOOLEAN,
                event_user_registration_timestamp STRING,
                event_user_creation_timestamp STRING,
                event_user_first_edit_timestamp STRING,
                event_user_revision_count BIGINT,
                event_user_seconds_since_previous_revision BIGINT,
                page_id BIGINT,
                page_title_historical STRING,
                page_title STRING,
                page_namespace_historical INT,
                page_namespace_is_content_historical BOOLEAN,
                page_namespace INT,
                page_namespace_is_content BOOLEAN,
                page_is_redirect BOOLEAN,
                page_is_deleted BOOLEAN,
                page_creation_timestamp STRING,
                page_first_edit_timestamp STRING,
                page_revision_count BIGINT,
                page_seconds_since_previous_revision BIGINT,
                user_id BIGINT,
                user_text_historical STRING,
                user_text STRING,
                user_blocks_historical ARRAY<STRING>,
                user_blocks ARRAY<STRING>,
                user_groups_historical ARRAY<STRING>,
                user_groups ARRAY<String>,
                user_is_bot_by_historical ARRAY<STRING>,
                user_is_bot_by Array<STRING>,
                user_is_created_by_self BOOLEAN,
                user_is_created_by_system boolean,
                user_is_created_by_peer BOOLEAN,
                user_is_anonymous boolean,
                user_registration_timestamp String,
                user_creation_timestamp STRING,
                user_first_edit_timestamp STRING,
                revision_id bigint,
                revision_parent_id bigint,
                revision_minor_edit boolean,
                revision_deleted_parts Array<String>,
                revision_deleted_parts_are_suppressed boolean,
                revision_text_bytes bigint,
                revision_text_bytes_diff bigint,
                revision_text_sha1 string,
                revision_content_model string,
                revision_content_format string,
                revision_is_deleted_by_page_deletion boolean,
                revision_deleted_by_page_deletion_timestamp string,
                revision_is_identity_reverted boolean,
                revision_first_identity_reverting_revision_id bigint,
                revision_seconds_to_identity_revert bigint,
                revision_is_identity_revert boolean,
                revision_is_from_before_page_creation boolean,
                revision_tags Array<string>
                )
            ROW FORMAT DELIMITED 
            FIELDS TERMINATED BY '\t';

-- Q5, initial filter through important columns

select WIKI_DB, EVENT_ENTITY, page_title, page_id, page_revision_count, 
        AVG(revision_seconds_to_identity_revert) AS REVISION_REVERT, 
        AVG(page_seconds_since_previous_revision) AS SECS_SINCE_REVISE FROM revisions
        where revision_seconds_to_identity_revert > 0
        Group By WIKI_DB, EVENT_ENTITY, page_title, page_id, page_revision_count
        order by EVENT_ENTITY desc 
        limit 60;
 -- Q5, aggressive attempt to get sum of revise reversal and average previous reversal, obtained sum then averaged
 -- the 2 columns. once average revise reversal is concrete, user average traffic during that time will help 
 -- find out amount of users that visit a vandalized wiki article before its fixed - eliminated useless columns
 --      
create table q5_revision_final as
select WIKI_DB AS DB, EVENT_ENTITY AS UAction, EVENT_TYPE as type, 
        page_title AS TITLE, page_revision_count AS Revise_Count,
        Round(AVG(Distinct revision_seconds_to_identity_revert/60),2) AS Avrg_Revise_Rvrse, 
        Round(AVG(Distinct page_seconds_since_previous_revision/60),2) AS Avrg_Prev_Rev FROM revisions
        where revision_seconds_to_identity_revert > 0 
        and page_seconds_since_previous_revision > 0 
        GROUP By Wiki_db, EVENT_ENTITY, event_type, page_title, page_revision_count,
        revision_seconds_to_identity_revert, page_seconds_since_previous_revision
        sort by Avrg_Revise_Rvrse desc 
        limit 25;        



-- Q6, find the number of desktop pageviews vs mobile page views

-- Q6, step 1 - create database
create database q6_pageviews_db;

-- Q6, step 2 - create table into load pageviews for every hour and day of september - this is the master table
-- that will be used to extra desktop data and mobile data into two separate tables eventually these tables will be 
-- rejoined and matched by article name to present data for each article for mobile and desktop page views side
-- by side.

create table pageviews (
    domain_code string,
    page_title string, 
    view_count int,
    response_size int)
    row format delimited
    fields terminated by ' ';

-- Q6, step 3 - Load data from local into table
LOAD DATA LOCAL INPATH '/mnt/d/Documents/BDB/Projects/PJ1/Datasets/Q2/Pageviews_Sept' INTO TABLE pageviews;

-- Q6, step 4 - Query desktop pageviews and create a table to store results in. will also add pageviews and display as
-- total_views. 

create table desktop_pv as
SELECT DOMAIN_CODE, page_title AS ARTICLE, SUM(view_count) AS TOTAL_VIEWS
    FROM pageviews
    WHERE DOMAIN_CODE="en"
    GROUP BY DOMAIN_CODE, page_title
    SORT BY TOTAL_VIEWS DESC;

--Q6, step 5 -- Repeat above query but for mobile views only.
    
create table mobile_pv as
SELECT DOMAIN_CODE AS DOMAIN_CODE_M, page_title AS ARTICLE_M, SUM(view_count) AS TOTAL_VIEWS_M
    FROM pageviews
    WHERE DOMAIN_CODE="en.m"
    GROUP BY DOMAIN_CODE, page_title
    SORT BY TOTAL_VIEWS_M DESC;

--Q6, step 6 -- merge both desktop and mobile tables together with join so that the article matches desktop and mobile
-- for each row

CREATE TABLE Q6_mergedpv AS
    SELECT desktop_pv.domain_code AS Desktop_Code, desktop_pv.Article AS DESKTOP_ARTICLE, 
    desktop_pv.total_views AS DESKTOP_TOTAL_VIEWS, mobile_pv.DOMAIN_CODE_M as Mobile_code,
    mobile_pv.ARTICLE_M AS Mobile_article, mobile_pv.TOTAL_VIEWS_M AS Mobile_Total_views
    FROM desktop_pv
    JOIN mobile_pv ON (mobile_pv.ARTICLE_M = desktop_pv.ARTICLE)
    Group By desktop_pv.domain_code, desktop_pv.Article, desktop_pv.total_views, 
    mobile_pv.DOMAIN_CODE_M, mobile_pv.ARTICLE_M, mobile_pv.TOTAL_VIEWS_M;

-- use this query to retrieve specific limit of 20.  
 select desktop_code as d_code,desktop_article as d_article, desktop_total_views as d_views, mobile_code as m_code, 
 mobile_article as m_article, mobile_total_views as m_views from q6_mergedpv sort by d_views desc limit 20;

-- Q4, Step 1 - create database for q4
create database q4_regionviews;

-- Q4, step 2 - create tables for us, uk and australia
create table us_views 
    (domain string, article string, views int, response int)
    row format delimited
    fields terminated by ' ';

create table uk_views 
    (domain string, article string, views int, response int)
    row format delimited
    fields terminated by ' ';

create table aus_views 
    (domain string, article string, views int, response int)
    row format delimited
    fields terminated by ' ';

Q4, step 3 -- load inpath the 5 hour block for each country
LOAD DATA LOCAL INPATH '/mnt/d/Documents/BDB/Projects/PJ1/Datasets/Q4/USA' INTO TABLE us_views;

LOAD DATA LOCAL INPATH '/mnt/d/Documents/BDB/Projects/PJ1/Datasets/Q4/UK' INTO TABLE uk_views;

LOAD DATA LOCAL INPATH '/mnt/d/Documents/BDB/Projects/PJ1/Datasets/Q4/AUS' INTO TABLE aus_views;

Q4, step 4 -- run query to get total views in hour blockset for each country.
CREATE TABLE us_views_final AS
SELECT ARTICLE, SUM(VIEWS) AS TOTAL
    FROM us_views
    WHERE DOMAIN="en" OR DOMAIN="en.m"
    GROUP BY ARTICLE
    SORT BY TOTAL DESC
    LIMIT 20;

CREATE TABLE uk_views_final AS
SELECT ARTICLE, SUM(VIEWS) AS TOTAL
    FROM uk_views
    WHERE DOMAIN="en" OR DOMAIN="en.m"
    GROUP BY ARTICLE
    SORT BY TOTAL DESC
    LIMIT 20;

CREATE TABLE aus_views_final AS
SELECT ARTICLE, SUM(VIEWS) AS TOTAL
    FROM aus_views
    WHERE DOMAIN="en" OR DOMAIN="en.m"
    GROUP BY ARTICLE
    SORT BY TOTAL DESC
    LIMIT 20;