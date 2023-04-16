const canvas = document.getElementById("canvas");
const ctx = canvas.getContext("2d");
canvas.width = window.innerWidth;
canvas.height = window.innerHeight;
const vs = [0.5, 0.25, 0.1];

const numDots = 256;
const dots = Array.from({ length: numDots }, () => {
  const v = vs[Math.floor(Math.random() * vs.length)];
  return {
    x: Math.random() * canvas.width,
    y: Math.random() * canvas.height,
    vx: v,
    vy: -v,
  };
});

function draw() {
  ctx.clearRect(0, 0, canvas.width, canvas.height);

  for (let i = numDots; i--;) {
    for (let j = i + 1; j < numDots; j++) {
      const dx = dots[i].x - dots[j].x;
      const dy = dots[i].y - dots[j].y;
      const dist = Math.sqrt(dx * dx + dy * dy);
      if (dist < 10) {
        dots[i].vx *= -1;
      }
      else if (dist < 25) {
        dots[i].vy *= -1;
      }
      else if (dist < 95) {
        ctx.beginPath();
        ctx.moveTo(dots[i].x, dots[i].y);
        ctx.lineTo(dots[j].x, dots[j].y);
        ctx.strokeStyle = "#75057a";
        ctx.stroke();
      }
    }
  }

  dots.forEach((dot, i) => {
    dot.x += dot.vx;
    dot.y += dot.vy;

    if (dot.x < 0 || dot.x > canvas.width) dot.vx *= -1;
    if (dot.y < 0 || dot.y > canvas.height) dot.vy *= -1;

    ctx.beginPath();
    ctx.arc(dot.x, dot.y, 4, 0, 2 * Math.PI);
    if(i == 0) {
      ctx.fillStyle = "#FFF";
    } else if(i % 2 == 0) {
      ctx.fillStyle = "#640469";
    } else if(i % 3 == 0) {
      ctx.fillStyle = "#8414A9";
    } else {
      ctx.fillStyle = "#940499";
    }
    ctx.fill();
  });

  requestAnimationFrame(draw);
}

draw();
