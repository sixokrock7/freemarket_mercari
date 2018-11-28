# DB design

## users table

|Column|Type|Option|
|------|----|------|
|nickname|string|index: true, null: false, unique: true|
|email|string|default: "", null: false, unique: true|
|password|string|default: "", null: false|
|reset_password_token|string||
|reset_password_sent_at|datetime||
|avatar|text||
|sign_in_count|integer|default: 0, null: false|
|current_sign_in_at|datetime||
|last_sign_in_at|datetime||
|crreunt_sign_in_ip|string||
|last_sign_in_ip|string||
|created_at|datetime|null: false|
|updated_at|datetime|null: false|

### Assocation

- has_one :address, dependent: :destroy
- has_one :payments, dependent: :destoroy
- has_many :authorizations, dependent: :destroy
- has_many :products, through: user_products, dependent: :destroy
- has_many :purchase_histories, foregin_key: :purchase_id
- belongs_to: user_product

## adresses table

|Column|Type|Option|
|------|----|------|
|family_name|string|null: false|
|first_name|string|null: false|
|family_name_kana|string|null: false|
|first_name_kana|string|null: false|
|zipcode|string|null: false|
|prefecture|string|null: false|
|city|string|null: false|
|block_number|string|null: false|
|building_name|string||
|phone_number|string||
|user_id|bigint||
|created_at|datetime|null: false|
|updated_at|datetime|null: false|

### Association

- belongs_to :user

## authentications table

|Column|Type|Option|
|------|----|------|
|user_id|bigint|null: false|
|provider|string|null: false|
|uid|string|null: false|
|created_at|datetime|null: false|
|updated_at|datetime|null: false|

### Association

- belongs_to :user

## payments table
|Column|Type|Option|
|------|----|------|
|user_id|bigint|null: false|
|payjp_customer_id|string|null: false|
|created_at|datetime|null: false|
|updated_at|datetime|null: false|

### Association
- belongs_to :user

## product_images table
|Column|Type|Option|
|------|----|------|
|image|string|null: false|
|product_id|bigint||
|created_at|datetime|null: false|
|updated_at|datetime|null: false|

### Assocation

- belongs_to :product

## products table

|Column|Type|Option|
|------|----|------|
|name|string|index: true, null: false|
|detail|text||
|shipping_fee|integer||
|expected_date|integer||
|price|integer|index: true, null: false|
|user_id|bigint|null: false, foreign_key: true|
|brand_id|integer|null: false, forein_key: true|
|like_count|integer|default: 0|
|status|string|null: false|
|size|string|null: false|
|purchaser_id|integer||
|category_id|integer|null: false, foreign_key: true|
|subcategory_id|integer|null: false, foreign_key: true|
|item_id|integer|null: false: foreign_key: true|
|subitem_id|integer|foreign_key: true|
|created_at|datetime|null: false|
|updated_at|datetime|null: false|
|shipping_from|string|null: false|
|shipping_method|integer|null: false|
|purchased|boolean|default: false, null: false|
|published|boolean|default: true, null: false|

### Association

- belongs_to :user_product
- belongs_to :category_products
- has_many :payments
- has_many :comments
- has_many :likes, dependent: :destroy
- has_many :category, through: category_products
- has_many :users, through: user_products
- has_many :images, class_name: "ProductImage", dependent: :destroy
- has_one :purchase_history

## user_products table

|Column|Type|Option|
|------|----|------|
|purchaser_id|integer||
|product_id|integer||
|business_status|enum||

### Association

- belongs_to :purchaser
- belongs_to :product

## comments table

|Column|Type|Option|
|------|----|------|
|body|string||
|user_id|integer|foreign_key: true|
|product_id|integer|foreign_key: true|

### Association

- belongs_to :product
- belongs_to :user

## likes table

## Association

- belongs_to :product, counter_cache: :likes_count
- belongs_to :user

## categories table

### awesome_nested_setを使用

|Column|Type|Option|
|------|----|------|
|name|string|index: true|
|parent_id|integer|index: true|
|lft|integer|index: true|
|rgt|integer|index: true|

### Association

- has_many: product, through: category_products
- belongs_to: category_products

## categories_products table

|Column|Type|Option|
|------|----|------|
|product_id|bigint||
|category|bigint||

## purchase_histories table

|Column|Type|Option|
|------|----|------|
|purchase_id|bigint|null: false|
|product_id|bigint|null: false|
|payjp_charge_id|string|null: false|
|creted_at|datetime|null: false|
|updated_at|datetime|null: false|

### Association

- belongs_to :purchaser, class_name: "User", foreign_key: :purchaser_id
- belongs_to :product

*---
