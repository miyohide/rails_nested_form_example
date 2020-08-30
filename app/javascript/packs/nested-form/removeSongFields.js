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
        if (fieldParent !== null && fieldParent.dataset.newRecord === 'true') {
            fieldParent.remove()
        }
    }
}

document.addEventListener('DOMContentLoaded', () => new removeSongFields())
