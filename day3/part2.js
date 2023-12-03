const fsp = require("fs").promises;

const createGrid = (rows, cols) => {
  const grid = Array(rows);
  for (let i = 0; i < rows; i++) {
    grid[i] = Array(cols);
    for (let j = 0; j < cols; j++) {
      grid[i][j] = {};
    }
  }
  return grid;
};

const solve = async (inputPath) => {
  const input = await fsp.readFile(inputPath, "utf-8");
  let grid = input.split("\n");
  let gridCols = grid[0].length;
  let gridRows = grid.length;
  const stars = [];
  let partsGrid = createGrid(gridRows, gridCols);
  let numCount = 0;
  for (const [row, line] of grid.entries()) {
    const num = [];
    let start = -1;
    for (let col = 0; col < line.length; col++) {
      const char = line[col];
      if (char == "*") {
        stars.push({ row, col });
      }
      if (Number.isInteger(parseInt(char))) {
        if (num.length == 0) {
          start = col;
        }
        num.push(char);
      } else {
        if (num.length > 0) {
          numCount++;
          for (let idx = start; idx < col; idx++) {
            partsGrid[row][idx] = {
              number: parseInt(num.join("")),
              numCount,
            };
          }
          num.length = 0;
          start = -1;
        }
      }
    }

    if (num.length > 0) {
      numCount++;
      for (let idx = start; idx < line.length; idx++) {
        partsGrid[row][idx] = {
          number: parseInt(num.join("")),
          numCount,
        };
      }
      num.length = 0;
      start = -1;
      num.length = 0;
      start = -1;
    }
  }

  const gearRatios = [];

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

  for (const star of stars) {
    let intersections = [];
    for (const [x, y] of directions) {
      const cX = star.col + x;
      const cY = star.row + y;
      if (cX >= 0 && cX < gridCols && cY >= 0 && cY < gridRows) {
        let ele = grid[cY][cX];
        if (Number.isInteger(parseInt(ele))) {
          intersections.push({ row: cY, col: cX });
        }
      }
    }
    if (intersections.length < 2) {
      continue;
    }

    const adjacentNumbers = {};
    for (const intersection of intersections) {
      adj = partsGrid[intersection.row][intersection.col];
      adjacentNumbers[adj.numCount] = adj.number;
    }
    if (Object.keys(adjacentNumbers).length == 2) {
      //   debugArr.push(part);
      gearRatios.push(
        Object.entries(adjacentNumbers)
          .map(([_, v]) => v)
          .reduce((acc, curr) => acc * curr, 1)
      );
    }
  }

  const gearRatioSum = gearRatios.reduce((acc, curr) => acc + curr, 0);

  return gearRatioSum;
};

const main = async () => {
  console.log(await solve("./example.txt"));
  console.log(await solve("./input.txt"));
};

main();
