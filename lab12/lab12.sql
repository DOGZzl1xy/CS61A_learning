CREATE TABLE finals AS
  SELECT 'RSF' AS hall, '61A' AS course UNION
  SELECT 'Wheeler'    , '61A'           UNION
  SELECT 'Pimentel'   , '61A'           UNION
  SELECT 'Li Ka Shing', '61A'           UNION
  SELECT 'Stanley'    , '61A'           UNION
  SELECT 'RSF'        , '61B'           UNION
  SELECT 'Wheeler'    , '61B'           UNION
  SELECT 'Morgan'     , '61B'           UNION
  SELECT 'Wheeler'    , '61C'           UNION
  SELECT 'Pimentel'   , '61C'           UNION
  SELECT 'Soda 310'   , '61C'           UNION
  SELECT 'Soda 306'   , '10'            UNION
  SELECT 'RSF'        , '70';

CREATE TABLE sizes AS
  SELECT 'RSF' AS room, 900 AS seats    UNION
  SELECT 'Wheeler'    , 700             UNION
  SELECT 'Pimentel'   , 500             UNION
  SELECT 'Li Ka Shing', 300             UNION
  SELECT 'Stanley'    , 300             UNION
  SELECT 'Morgan'     , 100             UNION
  SELECT 'Soda 306'   , 80              UNION
  SELECT 'Soda 310'   , 40              UNION
  SELECT 'Soda 320'   , 30;

CREATE TABLE sharing AS
  SELECT a.course, COUNT(Distinct a.hall) as shared
  FROM finals as a 
  join finals as b on (b.hall = a.hall) and (a.course != b.course)
  Group by a.course
  having COUNT(Distinct a.hall) >= 1
  ;

CREATE TABLE pairs AS
  SELECT a.room || " and " || b.room || " together have " || (a.seats + b.seats) || " seats"
  FROM sizes as a 
  join sizes as b on a.room < b.room
  where (a.seats + b.seats >= 1000)
  order by (a.seats + b.seats) DESC;

CREATE TABLE big AS
  SELECT a.course
  FROM finals as a 
  join sizes as b on a.hall = b.room
  Group by a.course
  having sum(b.seats)>=1000
  ;

CREATE TABLE remaining AS
  SELECT a.course, (sum(b.seats) - max(b.seats)) as remaining
  from finals as a
  join sizes as b on a.hall = b.room
  Group by a.course
  ;

