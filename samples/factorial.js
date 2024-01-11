#!/usr/bin/node
const argv = process.argv.slice(2);
const num = parseInt(argv[0]);

function factorial (n) {
  if (n === 0 || isNaN(n)) return 1;
  return n * factorial(n - 1);
}

console.log(factorial(num));
