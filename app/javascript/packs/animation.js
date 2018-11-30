const displayAnimation = () => {
  let img = new Image(1518);

  // Variables utilisateur - les personnaliser pour changer l'image qui défile, ses
  // directions, et la vitesse.
  img.src="https://hostnfly.blog/wp-content/uploads/2018/03/conciergerie-airbnb_lyon.jpg";
  const CanvasXSize = 1518; //800
  const CanvasYSize = 150; //200
  const speed = 50; // plus elle est basse, plus c'est rapide
  const scale = 1.05;
  const y = -4.5; // décalage vertical

  // Programme principal

  const dx = 0.75;
  let imgW;
  let imgH;
  let x = 0;
  let clearX;
  let clearY;
  let ctx;

  img.onload = function() {
      imgW = img.width + scale;
      imgH = img.height * scale;

      if (imgW > CanvasXSize) {
          // image plus grande que le canvas
          x = CanvasXSize - imgW;
      }
      if (imgW > CanvasXSize) {
          // largeur de l'image plus grande que le canvas
          clearX = imgW;
      } else {
          clearX = CanvasXSize;
      }
      if (imgH > CanvasYSize) {
          // hauteur de l'image plus grande que le canvas
          clearY = imgH;
      } else {
          clearY = CanvasYSize;
      }

      // récupérer le contexte du canvas
      ctx = document.getElementById('canvas').getContext('2d');

      // définir le taux de rafraichissement
      return setInterval(draw, speed);
  }

  function draw() {
      ctx.clearRect(0, 0, clearX, clearY); // clear the canvas

      // si image est <= taille du canvas
      if (imgW <= CanvasXSize) {
          // réinitialise, repart du début
          if (x > CanvasXSize) {
              x = -imgW + x;
          }
          // dessine image1 supplémentaire
          if (x > 0) {
              ctx.drawImage(img, -imgW + x, y, imgW, imgH);
          }
          // dessine image2 supplémentaire
          if (x - imgW > 1) {
              ctx.drawImage(img, -imgW * 2 + x, y, imgW, imgH);
          }
      }

      // image est > taille du canvas
      else {
          // réinitialise, repeart du début
          if (x > (CanvasXSize)) {
              x = CanvasXSize - imgW;
          }
          // dessine image supplémentaire
          if (x > (CanvasXSize-imgW)) {
              ctx.drawImage(img, x - imgW + 1, y, imgW, imgH);
          }
      }
      // dessine image
      ctx.drawImage(img, x, y,imgW, imgH);
      // quantité à déplacer
      x += dx;
  }
}

export { displayAnimation };
