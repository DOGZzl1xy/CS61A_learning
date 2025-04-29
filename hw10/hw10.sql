CREATE TABLE parents AS
  SELECT "ace" AS parent, "bella" AS child UNION
  SELECT "ace"          , "charlie"        UNION
  SELECT "daisy"        , "hank"           UNION
  SELECT "finn"         , "ace"            UNION
  SELECT "finn"         , "daisy"          UNION
  SELECT "finn"         , "ginger"         UNION
  SELECT "ellie"        , "finn";

CREATE TABLE dogs AS
  SELECT "ace" AS name, "long" AS fur, 26 AS height UNION
  SELECT "bella"      , "short"      , 52           UNION
  SELECT "charlie"    , "long"       , 47           UNION
  SELECT "daisy"      , "long"       , 46           UNION
  SELECT "ellie"      , "short"      , 35           UNION
  SELECT "finn"       , "curly"      , 32           UNION
  SELECT "ginger"     , "short"      , 28           UNION
  SELECT "hank"       , "curly"      , 31;

CREATE TABLE sizes AS
  SELECT "toy" AS size, 24 AS min, 28 AS max UNION
  SELECT "mini"       , 28       , 35        UNION
  SELECT "medium"     , 35       , 45        UNION
  SELECT "standard"   , 45       , 60;


-- All dogs with parents ordered by decreasing height of their parent
CREATE TABLE by_parent_height AS
    SELECT parents.child AS chil
    from parents 
    Join dogs ON dogs.name = parents.parent 
    order by dogs.height DESC;


-- The size of each dog
CREATE TABLE size_of_dogs AS
  SELECT dogs.name, sizes.size
  from dogs
  Join sizes on dogs.height > sizes.min and dogs.height <= sizes.max
  ;


-- [Optional] Filling out this helper table is recommended
CREATE TABLE siblings AS
  SELECT p1.child as a, p2.child as b
  from parents as p1
  Join parents as p2 on p1.parent = p2.parent and p1.child < p2.child;

-- Sentences about siblings that are the same size
CREATE TABLE sentences AS
  SELECT "The two siblings, " || a ||" and "|| b || ", have the same size: " || s1.size
  from siblings
  Join size_of_dogs as s1 on siblings.a = s1.name
  Join size_of_dogs as s2 on siblings.b = s2.name
  where s1.size = s2.size;


-- Height range for each fur type where all of the heights differ by no more than 30% from the average height
CREATE TABLE low_variance AS
  SELECT fur, (max(height) - min(height)) as height_range
  from dogs 
  Group by fur
  having (max(height) <= avg(height) * 1.3) and (min(height) >= avg(height) * 0.7)

  ;

