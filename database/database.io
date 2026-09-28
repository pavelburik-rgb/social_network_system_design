// Use DBML to define your database structure
// Docs: https://dbml.dbdiagram.io/docs

Table subcriptions {
  following_traveller_id uuid [not null]
  followed_traveller_id uuid [not null]
  created_at timestamp
}

Table travellers {
  id uuid [primary key]
  name varchar
  surname varchar
  traveller_logo varchar
  created_at timestamp
  updated_at timestamp
}

Table posts {
  id uuid [primary key]
  title varchar
  body text
  traveller_id varchar [not null]
  photos array
  geo_name varchar
  geo_position_l float
  geo_position_2 float
  created_at timestamp
  updated_at timestamp
}

Table comments {
  id uuid [primary key]
  body text
  post_id varchar [not null]
  travellers_id varchar [not null]
  created_at timestamp
  updated_at timestamp
}

Ref travellers_posts: posts.traveller_id ?> travellers.id

Ref: travellers.id <? subcriptions.following_traveller_id

Ref: travellers.id <? subcriptions.followed_traveller_id

Ref: "comments"."post_id" ?> "posts"."id"

Ref: "comments"."travellers_id" ?> "travellers"."id"
