
(() => {
  const grid = document.getElementById('galleryGrid');
  const search = document.getElementById('search');
  const category = document.getElementById('category');
  const total = document.getElementById('total');

  const items = [
    {
      id: '1',
      title: 'SMA Unique Creation 001',
      category: 'Other Creations',
      description: 'A unique handcrafted creation by SMA.',
      image_urls: [
        'images/27460dbf-2c38-a7a8-3904-1e668623cdd5.jpeg'
      ]
    }
  ];

  function render() {
    const q = search.value.trim().toLowerCase();
    const c = category.value;

    const list = items.filter(x =>
      (!c || x.category === c) &&
      (`${x.title} ${x.description} ${x.category}`)
        .toLowerCase().includes(q)
    );

    total.textContent = `${list.length} CREATION${list.length === 1 ? '' : 'S'}`;

    grid.innerHTML = list.length
      ? list.map(x => `
        <article class="art-card">
          <img src="${x.image_urls[0]}" alt="${x.title}">
          <div class="art-info">
            <p class="category">${x.category}</p>
            <h3>${x.title}</h3>
            <p>${x.description}</p>
          </div>
        </article>
      `).join('')
      : '<p class="empty">No artwork found.</p>';
  }

  search.addEventListener('input', render);
  category.addEventListener('change', render);

  render();
})();

