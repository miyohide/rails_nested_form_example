module PersonHelper
  # Personモデルと1対多の関係にあるAbilityモデルに対してaccepts_nested_attributes_forとして
  # 指定した際に生成されるname属性の文字列を返す。
  # @param [Integer] index フォーム内で一意となる番号
  # @return [String] "person[abilities_attributes][" + index + "]"
  def ability_name_prefix(index)
    "person[abilities_attributes][#{index}]"
  end

  # Personモデルと1対多の関係にあるAbilityモデルに対してaccepts_nested_attributes_forとして
  # 指定した際に生成されるid属性の文字列を返す。
  # @param [Integer] index フォーム内で一意となる番号
  # @return [String] "person_abilities_attributes_" + index
  def ability_id_prefix(index)
    "person_abilities_attributes_#{index}"
  end

  # すでに登録されているAbilityのidを値に持つhiddenタグを作成する
  # @param [Integer] index フォーム内で一意となる番号
  # @param [Symbol] ability_name AbilityName
  # @param [Person] person Abilityに紐づくPersonのインスタンス
  # @return [String] 作成したhiddenタグのHTML
  def ability_hidden_tag(index, ability_name, person)
    record = person.ability_selections[ability_name]
    tag.input type: 'hidden',
              id: "#{ability_id_prefix(index)}_id",
              name: "#{ability_name_prefix(index)}[id]",
              value: record.try(:id)
  end

  # Abilityが取りうるAbilityNameに対応したチェックボックスを作成する
  # すでにチェックされているものに対してはチェックを入れる。
  # @param [Integer] index フォーム内で一意となる番号
  # @param [Symbol] ability_name AbilityName
  # @param [Person] person Abilityに紐づくPersonのインスタンス
  # @return [String] 作成したチェックボックスのHTML
  def ability_checkbox_tag(index, ability_name, person)
    tag.input type: 'checkbox',
              id: "#{ability_id_prefix(index)}_ability_name",
              name: "#{ability_name_prefix(index)}[ability_name]",
              value: ability_name,
              checked: person.checked?(ability_name)
  end

  # Abilityが取りうるAbilityNameを登録するためのチェックボックスやラベルなどを作成する
  # すでにチェックされているものに対してはチェックを入れる。
  # @param [Symbol] ability_name AbilityName
  # @param [Integer] index フォーム内で一意となる番号
  # @param [Person] person Abilityに紐づくPersonのインスタンス
  # @return [String] 作成したチェックボックスやラベルなどのHTML
  def ability_form(ability_name, index, person)
    tag.label class: 'form-check-label' do
      ability_hidden_tag(index, ability_name, person) + ability_checkbox_tag(index, ability_name, person)+ "#{ability_name}"
    end
  end
end
