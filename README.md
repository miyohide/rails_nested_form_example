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

### コントローラ

[Strong parameter](https://railsguides.jp/action_controller_overview.html#strong-parameters
)の設定を行います。`app/controllers/people_controller.rb`において下記のような記述を行います。

```ruby
params.require(:person).permit(:first_name, :last_name,
                               addresses_attributes: [:id, :kind, :street, :_destroy]
                               )
```

`permit`の中身や`addresses_attributes`の配列の中身は、それぞれのモデルの属性を記します。`addresses_attributes`の配列の中身はモデルの属性以外に`:id`と`:_destroy`を追加する必要があります。
