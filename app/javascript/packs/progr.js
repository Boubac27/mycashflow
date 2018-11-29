console.log("dans progr");

const updateProgressBar = () => {
  const page_new = document.getElementById('results');
  console.log(page_new);
  if (page_new) {
    window.setInterval(update, 200);
  }
};

function update() {
  const user_id = document.querySelector('h6').innerText;
  const url = `http://localhost:3000/users/${user_id}/progresses`;
  fetch(url).then((response) => { return response.json();} ).then((data) => {
    const squares = document.querySelectorAll('i');
    let counter = 0;
    squares.forEach((square) => {
      if (counter < data["scale"]) {
        square.style.color = "black"
      }
      else{
        square.style.color = "white"
      }
      counter += 1;
    });
  });
}

export { updateProgressBar, update }
