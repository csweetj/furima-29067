# README

# テーブル設計
## users テーブル
| Column   | Type   | Options     |
| -------- | ------ | ----------- |
| name     | string | null: false |
| email    | string | null: false |
| password | string | null: false |

### Association
- has_many :comments
- has_many :items, through: user_item
- has_many :likes
- has_many :purchase


## item テーブル
| Column   | Type   | Options     |
| -------- | ------ | ----------- |
| name       | string | null: false |
| sellername | string | null: false |
| price      |integer | null: false |
| image      | text   | null: false |
| category   | string   | null: false |
| stock      | integer | null: false | 

### Association
- has_many :comments
- has_many :likes
- has_many :purchase
- has_one :users, through: user_item

## user_item テーブル
| Column | Type       | Options                        |
| ------ | ---------- | ------------------------------ |
| user   | references | null: false, foreign_key: true |
| item   | references | null: false, foreign_key: true |

### Association
- belongs_to :users
- belongs_to :items


## comment テーブル
| Column | Type       | Options                        |
| ------ | ---------- | ------------------------------ |
| text   | text       |                                |
| user   | references | null: false, foreign_key: true |
| item   | references | null: false, foreign_key: true |

### Association
- belongs_to :users
- belongs_to :items


## like テーブル
| Column | Type       | Options                        |
| ------ | ---------- | ------------------------------ |
| user   | references | null: false, foreign_key: true |
| item   | references | null: false, foreign_key: true |

### Association
- belongs_to :users
- belongs_to :items


## purchase テーブル
| Column | Type       | Options                        |
| ------ | ---------- | ------------------------------ |
| user   | references | null: false, foreign_key: true |
| item   | references | null: false, foreign_key: true |

### Association
- belongs_to :users
- belongs_to :items
- has_one :shipping


## shipping テーブル
| Column | Type       | Options                        |
| ------ | ---------- | ------------------------------ |
| purchase   | references | null: false, foreign_key: true |
| address   | string | null: false |

### Association
- belongs_to :purchase
