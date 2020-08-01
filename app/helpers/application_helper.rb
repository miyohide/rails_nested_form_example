module ApplicationHelper
  # fと関連付けられたassociationのフォームを作成し、data属性に生成したHTMLデータを格納した
  # リンクを生成して呼び出し元にかえす。実際これを使うにはapp/javascript/packs/nested-form/addFields.js
  # にてフォームを画面としてレンダリングさせる処理を実施する必要がある
  def link_to_add_fields(name, f, association)
    new_obj = f.object.send(association).klass.new
    # idは一意であれば何でもよい。
    id = new_obj.object_id

    fields = f.fields_for(association, new_obj, child_index: id) do |builder|
      render(association.to_s.singularize + "_fields", f: builder)
    end

    link_to(name, '#', class: 'add_fields btn btn-primary', data: {id: id, fields: fields.gsub('\n', '')})
  end
end
