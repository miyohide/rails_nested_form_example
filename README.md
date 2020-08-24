# README

## これはなにか

ベースとなるモデルと`has_many`な関係になっているモデルとを一緒に作成・更新するためのサンプル実装です。

## ポイント

### 前提

このサンプルでは、`Person`モデルに対して`Address`モデルが`has_many`という関係になっています。`app/models/person.rb`において

```ruby
has_many :addresses
```

また、`app/models/address.rb`において

```ruby
belongs_to :person
```

と書かれている状態です。

### モデル

[accepts_nested_attributes_for](https://api.rubyonrails.org/classes/ActiveRecord/NestedAttributes/ClassMethods.html#method-i-accepts_nested_attributes_for)を使うのが一番お手軽です。具体的にはPersonモデルに対して

```ruby
accepts_nested_attributes_for :addresses, allow_destroy: true, reject_if: :all_blank
```

を追記します。オプションの`allow_destory`は既存のメンバーを削除することを許すか否かの設定、`reject_if`は送られてきた属性から無視する設定です。詳細は上記ドキュメントを参照してください。


