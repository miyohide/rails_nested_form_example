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

### ビュー

`Address`モデルを作成するための部分テンプレートを作成します。ここでは、`app/views/people/_address_fields.html.erb`というファイルを作り、中身を以下のようにします。

```html
<div class='nested-fields form-row'>
  <%= f.hidden_field :_destroy %>
  <div class='form-group col-sm-4'>
    <%= f.label :kind %>
    <%= f.text_field :kind, class: 'form-control' %>
  </div>
  <div class='form-group col-sm-4'>
    <%= f.label :street %>
    <%= f.text_field :street, class: 'form-control' %>
  </div>
  <div>
    <%= link_to '削除', '#', class: 'remove_fields btn btn-danger' %>
  </div>
</div>
```

ポイントは、`f.hidden_field :_destroy`と`link_to '削除', '#', class: 'remove_fields btn btn-danger'`の2つです。

`f.hidden_field :_destroy`はモデルでの`allow_destory`に対応するために必要になります。`link_to '削除', '#', class: 'remove_fields btn btn-danger'`は後述のJavaScriptで具体的な処理を実装します。

上記で作成した部分テンプレートを`People`モデルを編集するフォームに追記します。

```html
<fieldset>
<legend>Addresses:</legend>
  <%= f.fields_for :addresses do |addresses_form| %>
    <%= render 'address_fields', f: addresses_form %>
  <% end %>
  <%= link_to_add_fields '住所の追加', f, :addresses %>
</fieldset>
```

`link_to_add_fields '住所の追加', f, :addresses`の処理は後述のJavaScriptで実装します。

