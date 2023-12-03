const fsp = require("fs").promises;

const solve = async (inputPath) => {
  const input = await fsp.readFile(inputPath, "utf-8");
  const partNumbers = [];
  let grid = input.split("\n");
  let gridCols = grid[0].length;
  let gridRows = grid.length;
  for (const [row, line] of grid.entries()) {
    const num = [];
    let start = -1;
    for (let col = 0; col < line.length; col++) {
      const char = line[col];
      if (Number.isInteger(parseInt(char))) {
        if (num.length == 0) {
          start = col;
        }
        num.push(char);
      } else {
        if (num.length > 0) {
          partNumbers.push({
            number: parseInt(num.join("")),
            row,
            start,
            end: col - 1,
          });
          num.length = 0;
          start = -1;
        }
      }
    }

    if (num.length > 0) {
      partNumbers.push({
        number: parseInt(num.join("")),
        row,
        start,
        end: line.length - 1,
      });
      num.length = 0;
      start = -1;
    }
  }

  const enginePartNumbers = [];

  const directions = [
    [-1, -1], // tl
    [0, -1], // tt
    [1, -1], // tr
    [-1, 0], // ml
    [1, 0], // mr
    [1, 1], // br
    [0, 1], // bm
    [-1, 1], // bl
  ];

  for (const part of partNumbers) {
    let enginePart = false;
    for (let i = part.start; i <= part.end; i++) {
      for (const [x, y] of directions) {
        const cX = i + x;
        const cY = part.row + y;
        if (cX >= 0 && cX < gridCols && cY >= 0 && cY < gridRows) {
          let ele = grid[cY][cX];
          if (Number.isNaN(parseInt(ele)) && ele != ".") {
            enginePart = true;
          }
        }
      }
    }
    if (enginePart) {
      enginePartNumbers.push(part.number);
    }
  }

  const enginePartSum = enginePartNumbers.reduce((acc, curr) => acc + curr, 0);
  return enginePartSum;
};

const main = async () => {
  console.log(await solve("./example.txt"));
  console.log(await solve("./input.txt"));
};

main();
