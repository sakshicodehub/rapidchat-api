# README

This README would normally document whatever steps are necessary to get the
application up and running.

Things you may want to cover:

* Ruby version

* System dependencies

* Configuration

* Database creation

* Database initialization

* How to run the test suite

* Services (job queues, cache servers, search engines, etc.)

* Deployment instructions

* ...


High-Level Architecture
                  +----------------------+
                  |     React Client     |
                  |----------------------|
                  | Chat UI              |
                  | Redux/Context        |
                  | WebSocket Client     |
                  +----------+-----------+
                             |
                             | WebSocket
                             |
+--------------------------------------------------------------+
|                     Rails Backend                            |
|--------------------------------------------------------------|
| API Controllers (REST)                                       |
| Authentication (JWT/Devise)                                  |
| Action Cable / AnyCable                                      |
| ChatChannel                                                  |
| Message Service                                               |
| ActiveRecord                                                  |
+-----------------------+--------------------------------------+
                        |
                        |
                PostgreSQL Database
                        |
             Messages, Users, Conversations