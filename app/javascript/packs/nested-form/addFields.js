class addFields {
    constructor() {
        this.links = document.querySelectorAll('.add_fields')
        this.iterateLinks()
    }

    iterateLinks() {
        if (this.links.length === 0) {
            return
        }
        this.links.forEach((link) => {
            link.addEventListener('click', (e) => {
                this.handleClick(link, e)
            })
        })
    }

    handleClick(link, e) {
        if (!link || !e) {
            return
        }
        e.preventDefault()
        let time = new Date().getTime()
        // 現在作られているフォームのIDを取得
        let linkId = link.dataset.id
        // idを置換する正規表現を生成
        let regexp = linkId ? new RegExp(linkId, 'g') : null
        // 追加するフォームにあるIDの値を一律Date().getTime()で作成したIDにて置換
        let newFields = regexp ? link.dataset.fields.replace(regexp, time) : null
        // フォームを追加
        newFields ? link.insertAdjacentHTML('beforebegin', newFields) : null
    }
}

document.addEventListener('DOMContentLoaded', () => new addFields())
