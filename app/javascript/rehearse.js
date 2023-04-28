

function createAssignButton(jokeId, content, setId) {
    const btn = document.createElement('button');
    btn.classList.add('btn', 'assign-btn');
    btn.id = jokeId;
    btn.dataset.id = jokeId;
    btn.dataset.content = content;
    btn.dataset.url = `/standup_sets/${setId}/jokes/${jokeId}`;
    btn.innerHTML = 'assign';
    btn.onclick = assignJokeToCurrentSet;
    btn.style.marginTop = '9px';
  
    return btn;
  }
  
  
  function createUnassignButton(jokeId, content, url) {
    const unassignBtn = document.createElement('button');
    unassignBtn.classList.add('btn', 'unassign-btn', 'unassign-joke');
    unassignBtn.id = jokeId;
    unassignBtn.dataset.id = jokeId;
    unassignBtn.dataset.content = content;
    unassignBtn.dataset.url = url;
    unassignBtn.innerHTML = 'unassign';
    unassignBtn.onclick = removeJokeFromCurrentSet;
    unassignBtn.style.marginTop = '9px';
    return unassignBtn;
  }
  
  
  function getSelectedSetId() {
    const selectedSet = document.querySelector('#set-list .set-item.selected');
    return selectedSet ? selectedSet.dataset.setId : null;
  }
  
  
  function assignJokeToCurrentSet(event) {
    var btn = event.target;
    const jokeId = btn.dataset.id;
    const url = btn.dataset.url;
    const standupSetId = getSelectedSetId();
    if (!standupSetId) {
      console.error('No set is selected.');
      return;
    }
    console.log(`Assigning joke ${jokeId} to set ${standupSetId}...`);
  
    fetch(url, {
      method: 'POST',
      headers: {
        'Accept': 'application/json',
        'Content-Type': 'application/json',
        'X-CSRF-Token': getMetaContent('csrf-token')
      },
      credentials: 'same-origin'
    })
      .then(response => {
        if (response.ok) {
          console.log('Joke added to the standup set');
          const currentSetJokes = document.getElementById('current-set-jokes');
          const emptySetMessage = document.getElementById('empty-set');
  
          if (emptySetMessage) {
            emptySetMessage.remove();
          }
          
          currentSetJokes.innerHTML += `
            <li class="justify-between flip-axis-col">
  
              <span class="set-joke-content">${btn.dataset.content}</span>
  
              <button class="btn unassign-btn" id=${jokeId} data-id=${jokeId} data-content="${btn.dataset.content}" data-url=${url} onclick="removeJokeFromCurrentSet(event)">unassign</button>
            </li>`;
            btn.classList.remove('assign-btn');
            btn.classList.remove('assign-joke');
            btn.classList.add('unassign-btn');
            btn.classList.add('unassign-joke');
            btn.innerHTML = 'unassign';
            btn.onclick = removeJokeFromCurrentSet;
        } else {
          console.error('Error adding joke to the standup set');
        }
      })
      .catch(error => {
        console.error('Error:', error);
      });
  }
  
  function removeJokeFromSetList(jokeId) {
          const currentSetJokes = document.getElementById('current-set-jokes');
          if (!jokeId) {
            console.log('deleting all jokes from list')
            console.log(jokeId)
          const setListItems = currentSetJokes.querySelectorAll('li');
          setListItems.forEach(joke => joke.remove());
          currentSetJokes.innerHTML = `<span id="empty-set">This set is empty. Assign some jokes from below!</span>`;
          return;
        }
          const jokeToRemoveContainer = currentSetJokes.querySelector(`[data-id="${jokeId}"]`)
          if (jokeToRemoveContainer) {
            const jokeToRemove = jokeToRemoveContainer.closest('li');
            if (jokeToRemove) {
              jokeToRemove.remove();
            }
          }
          
  
          if (currentSetJokes.childElementCount === 0) {
            currentSetJokes.innerHTML = `<span id="empty-set">This set is empty. Assign some jokes from below!</span>`;
          }
  }
  
  function removeJokeFromCurrentSet(event) {
    const btn = event.target;
    const jokeId = btn.dataset.id;
    const standupSetId = getSelectedSetId();
    const url = `/standup_sets/${standupSetId}/jokes/${jokeId}`
  
    fetch(url, {
      method: 'DELETE',
      headers: {
        'Accept': 'application/json',
        'Content-Type': 'application/json',
        'X-CSRF-Token': getMetaContent('csrf-token')
      },
      credentials: 'same-origin'
    })
      .then(response => {
        if (response.ok) {
          
          removeJokeFromSetList(jokeId);
  
          btn.classList.remove('unassign-btn');
          btn.classList.remove('unassign-joke');
          btn.classList.add('assign-btn');
          btn.classList.add('assign-joke');
          btn.innerHTML = 'assign';
          btn.onclick = assignJokeToCurrentSet;
  
          const otherBtn = document.querySelector(`[data-id="${jokeId}"]`);
          if (otherBtn) {
            otherBtn.classList.remove('unassign-btn');
            otherBtn.classList.remove('unassign-joke');
            otherBtn.classList.add('assign-btn');
            otherBtn.classList.add('assign-joke');
            otherBtn.innerHTML = 'assign';
            otherBtn.dataset.url = url;
            otherBtn.dataset.id = jokeId;
            otherBtn.dataset.content = btn.dataset.content;
            console.log(btn.dataset.content)
            otherBtn.onclick = assignJokeToCurrentSet;
          }
  
        } else {
          console.error('Error removing joke from the standup set');
        }
      })
      .catch(error => {
        console.error('Error:', error);
      });
  }
  
  
  
  
  function createNoJokesScreen() {
    const savedJokesSection = document.getElementById('saved-jokes');
      const noJokesImagePath = savedJokesSection.dataset.noJokesImagePath;
      savedJokesSection.innerHTML = `
        <div class="column w-100 h-100 align-center">
          <image src="${noJokesImagePath}" width=333 height=300>
          <span id="no-saved-jokes" class="w-100 f-large justify-center">Laugh react to jokes and add them to your sets.</span>
          </div>
      `;
  }
  
  function handleDeleteJokeClick(event) {
    const span = event.target;
    const url = span.dataset.url;
    const confirmationMessage = span.dataset.confirm;
  
    if (confirm(confirmationMessage)) {
      fetch(url, {
        method: 'DELETE',
        headers: { 'Accept': 'application/json', 'X-CSRF-Token': getMetaContent('csrf-token') },
        credentials: 'same-origin'
      })
      .then(response => {
        if (response.ok) {
          const jokeLi = span.closest('li');
          jokeLi.remove();
          const jokeId = span.dataset.id;
  
          console.log(jokeId)
          removeJokeFromSetList(jokeId);
  
          const remainingJokes = document.querySelectorAll('#joke-list li');
          console.log(remainingJokes);
          if (remainingJokes.length === 0) {
            createNoJokesScreen();
          }
        } else {
          console.error('Error deleting the joke');
        }
      })
      .catch(error => {
        console.error(error);
      });
    }
  }
  
  
  
  function getMetaContent(name) {
    const element = document.querySelector(`meta[name="${name}"]`);
    return element ? element.content : null;
  }
  
  function handleDeleteAllJokesClick(event) {
    if (confirm('Are you sure you want to delete all jokes?')) {
      fetch('/jokes', {
        method: 'DELETE',
        headers: {
          'Accept': 'application/json',
          'X-CSRF-Token': document.querySelector('meta[name="csrf-token"]').content
        },
      })
      .then(response => {
        if (response.ok) {
          createNoJokesScreen();
          removeJokeFromSetList(null);
        } else {
          console.error('Failed to delete all jokes');
        }
      })
      .catch(error => {
        console.error('Error:', error);
      });
    }
  }
  
  
  
  
  
  
  function updateSavedJokesButtons(jokesInSet, setId) {
    const savedJokesLists = document.querySelectorAll('#saved-jokes #joke-list');
  
    savedJokesLists.forEach(savedJokesList => {
      const savedJokes = savedJokesList.querySelectorAll('li');
  
      savedJokes.forEach((joke) => {
        const jokeId = joke.querySelector('button').dataset.id;
        const jokeInSet = jokesInSet.find((j) => j.id == jokeId);
        const button = joke.querySelector('button');
  
        if (jokeInSet) {
          const unassignBtn = createUnassignButton(jokeId, button.dataset.content, button.dataset.url);
          joke.replaceChild(unassignBtn, button);
        } else {
          const assignBtn = createAssignButton(jokeId, button.dataset.content, setId);
          joke.replaceChild(assignBtn, button);
        }
      });
    });
  }
  
  
  
  
  document.addEventListener('DOMContentLoaded', () => {
    const setList = document.getElementById('set-list');
    const setItems = setList.querySelectorAll('li');
    let selectedSet = setList.querySelector('li.selected');
  
    setItems.forEach((setItem) => {
      setItem.addEventListener('click', () => {
        if (selectedSet) {
          selectedSet.classList.remove('selected');
        }
  
        setItem.classList.add('selected');
        selectedSet = setItem;
        const setUrl = setItem.dataset.url;
  
        fetch(setUrl)
          .then(response => response.json())
          .then(data => {
            const jokes = Array.isArray(data) ? data : data.jokes;
            const currentSetJokes = document.getElementById('current-set-jokes');
  
            if (jokes.length === 0) {
              currentSetJokes.innerHTML = `<span id="empty-set">This set is empty. Assign some jokes from below!</span>`;
            } else {
              const jokeItems = jokes.map(joke => `
                <li class="justify-between flip-axis-col">
  
                  <span class="set-joke-content">${joke.content}</span>
  
                  <button class="btn unassign-btn" data-content="${joke.content}" id=${joke.id} data-id=${joke.id} data-url=${joke.url} onclick="removeJokeFromCurrentSet(event)">unassign</button>
                </li>
              `).join('');
  
              currentSetJokes.innerHTML = jokeItems;
            }
  
            const setId = setItem.dataset.setId;
            updateSavedJokesButtons(jokes, setId);
          })
          .catch(error => {
            console.error('Error:', error);
          });
      });
    });
  });
  