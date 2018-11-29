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
    const squares = document.querySelectorAll('.fas .fa-square-full');
    console.log(squares);
    let counter = 0;
    squares.forEach((square) => {
      if (counter < data) {
        console.log("counter < data");
        square.style.color = "black"
      }
      else{
        console.log("dans le else");
        square.style.color = "white"
      }
      counter += 1;
    });
  });
}

export { updateProgressBar, update }
