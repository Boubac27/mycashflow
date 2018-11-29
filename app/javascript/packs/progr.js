function updateProgressBar() {
  page_new = document.getElementById('results');
  if (page_new) {
    window.setInterval(update, 200)
  }
}

function update() {
  const url = `localhost:3000/users/${user_id}/progresses`
  fetch(url).then((response) => { return response.json();} ).then((data) => console.log(data));
}
