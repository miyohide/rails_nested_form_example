class removeSongFields {
    constructor() {
        this.iterateLinks()
    }

    iterateLinks() {
        document.addEventListener('click', (e) => {
            if (e.target && e.target.classList.contains('remove_song_fields')) {
                this.handleClick(e.target, e)
            }
        })
    }

    handleClick(link, e) {
        if (!link || !e) {
            return
        }
        e.preventDefault()
        let fieldParent = link.closest('.nested-fields')
        if (fieldParent == null) {
            return
        }
        if (fieldParent.dataset.newRecord === 'true') {
            fieldParent.remove()
        } else {
            fieldParent.querySelector('input[name*=_destroy]').value = '1'
            fieldParent.style.display = 'none'
        }
    }
}

document.addEventListener('DOMContentLoaded', () => new removeSongFields())
