


function handleFormSubmit(event) {
    event.preventDefault();
    const form = event.target.closest('form');
    const apiUrl = form.dataset.apiUrl;
  
    fetch(form.action, {
      method: form.method,
      body: new FormData(form),
      headers: { 'Accept': 'application/json' },
    })
    .then(response => response.json())
    .then(data => {
      fetchNewJoke(form, apiUrl);
      showSaveSuccess();
    })
    .catch(error => {
      console.error(error);
    });
  }
  
  function handleRefreshJoke(event) {
    event.preventDefault();
    const form = event.target.closest('form');
    const apiUrl = form.dataset.apiUrl;
    fetchNewJoke(form, apiUrl);
  }
  
  
  function fetchNewJoke(form, apiUrl) {
    fetch(apiUrl, {
      method: 'GET',
      headers: { 'Accept': 'application/json' },
    })
    .then(response => response.json())
    .then(data => {
      const jokeCardContent = form.querySelector('.card-content.grey.lighten-3');
      let joke;
  
      if (apiUrl === '/new_dad_joke') {
        joke = data.joke;
      } else if (apiUrl === '/new_official_joke') {
        joke = data.joke;
      } else if (apiUrl === '/new_jokeapi_joke') {
        joke = data.setup ? data.setup + ' ' + data.delivery : data.joke;
      } else if (apiUrl === '/new_geek_joke') {
        joke = data.joke;
      }
  
      jokeCardContent.textContent = joke;
      const jokeContentInput = form.querySelector('input[name="joke[content]"]');
      jokeContentInput.value = joke;
    })
    .catch(error => {
      console.error(error);
    });
  }
  
  
  
  function showSaveSuccess() {
    const saveSuccess = document.getElementById('save-success');
    saveSuccess.classList.remove('hidden');
    saveSuccess.style.opacity = '1';
  
    setTimeout(() => {
      saveSuccess.style.opacity = '0';
      setTimeout(() => {
        saveSuccess.classList.add('hidden');
      }, 400);
    }, 400);
  }
  
  function reloadAll() {
    const jokeCards = document.querySelectorAll('.card.joke-card');
    jokeCards.forEach(card => {
      const form = card
      const apiUrl = form.dataset.apiUrl;
      console.log(apiUrl, form);
      fetchNewJoke(form, apiUrl);
    });
  }
  
  document.addEventListener('DOMContentLoaded', () => {
  const reloadButton = document.getElementById('reload_all_jokes');
    const tooltip = document.getElementById('reloader_details');
  
    reloadButton.addEventListener('mouseenter', () => {
      tooltip.classList.remove('hidden');
    });
  
    reloadButton.addEventListener('mouseleave', () => {
      tooltip.classList.add('hidden');
    });
  
  });