class addAlbumFields {
    constructor() {
        console.log('aaaaaaaaaaaaaaaa')
        this.links = document.querySelectorAll('.add_album_fields')
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
        console.log(link)
        e.preventDefault()
        let newFields = document.querySelector('#song_fields_template')
        console.log(newFields)
        newFields = newFields.innerHTML.replace(/NEW_RECORD/g, new Date().getTime())
        link.insertAdjacentHTML('beforebegin', newFields)
    }
}

document.addEventListener('DOMContentLoaded', () => new addAlbumFields())
