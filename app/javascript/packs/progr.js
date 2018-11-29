
const updateProgressBar = () => {
  const page_new = document.getElementById('waiting');
  const subm = document.querySelector('.form-actions > input');
  if (page_new) {
    subm.addEventListener('click', function(){
      window.waiting = window.setInterval(update, 500);
    });
  }
};

function update() {
  const user_id = document.querySelector('h6').innerText;
  const url = `http://localhost:3000/users/${user_id}/progresses`;
  fetch(url).then((response) => { return response.json();} ).then((data) => {
    const squares = document.querySelectorAll('i');
    let counter = 0;
    let millis = 0;
    let after_point = "100";
    let int_after_point = 100;
    squares.forEach((square) => {
      if (counter < data["scale"]) {
        square.style.color = "black"
      }
      else{
        square.style.color = "white"
      }
      if (counter === data["scale"]) {
        millis = Date.now().toString();
        after_point = millis.substr(millis.length - 3);
        int_after_point = Number.parseInt(after_point, 10);
        if (int_after_point < 500) {
          square.style.color = "black"
        }
        else {
          square.style.color = "white"
        }
      }
      counter += 1;
    });
  });
}

export { updateProgressBar, update }
