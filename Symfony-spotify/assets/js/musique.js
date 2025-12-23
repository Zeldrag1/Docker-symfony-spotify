const trackButtons = document.querySelectorAll('.track-item .btn-love');
if (trackButtons.length === 0) {
    // Pas de tracks sur cette page → ne rien faire
    console.log("musique.js : aucune track trouvée, script ignoré");
} else {
    trackButtons.forEach(btn => {
        btn.addEventListener('click', function () {
            const trackItem = this.closest('.track-item');
            const containerTrack = trackItem.closest('.tracks');
            const isFavoritesPageTrack = containerTrack.classList.contains('tracks-favorites');

            const id_track = this.dataset.trackId;
            const name_track = this.dataset.trackName;
            const heart = this.querySelector('.fa-heart');

            fetch('/track/like', {
                method: 'POST',
                headers: {'Content-Type': 'application/json'},
                body: JSON.stringify({ id: id_track, name: name_track })
            })
                .then(response => response.json())
                .then(data => {
                    if (data.success) {
                        if (isFavoritesPageTrack) {
                            trackItem.remove();
                        } else {
                            if (this.classList.contains('act')) {
                                this.classList.remove('act');
                                heart.style.color = '#c0c1c3';
                            } else {
                                this.classList.add('act');
                                heart.style.color = '#e3274d';
                            }
                        }
                    }
                })
                .catch(error => console.error('Erreur fetch:', error));
        });
    });
}
