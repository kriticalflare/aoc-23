use std::{
    fs::File,
    io::{BufRead, BufReader},
    path::Path,
};

use anyhow::Result;
use peekmore::PeekMore;

struct Stack {
    pub inner: Vec<u32>,
}

impl Stack {
    fn new() -> Self {
        return Stack { inner: vec![] };
    }

    fn push(&mut self, ele: u32) {
        if self.inner.len() < 2 {
            self.inner.push(ele);
        } else {
            while self.inner.len() > 1 {
                self.inner.pop();
            }
            self.inner.push(ele);
        }
    }
}

fn find_calibration(line: &String) -> u32 {
    let mut c_iter = line.chars().peekmore();
    let mut stack = Stack::new();

    loop {
        match c_iter.next() {
            Some(c) => match c.to_digit(10) {
                Some(digit) => {
                    stack.push(digit);
                }
                None => {
                    match (c, c_iter.peek_amount(2)) {
                        ('o', [Some('n'), Some('e')]) => {
                            stack.push(1);
                        }
                        ('t', [Some('w'), Some('o')]) => {
                            stack.push(2);
                        }
                        ('s', [Some('i'), Some('x')]) => {
                            stack.push(6);
                        }
                        _ => {}
                    }
                    match (c, c_iter.peek_amount(4)) {
                        ('t', [Some('h'), Some('r'), Some('e'), Some('e')]) => {
                            stack.push(3);
                        }
                        ('s', [Some('e'), Some('v'), Some('e'), Some('n')]) => {
                            stack.push(7);
                        }
                        ('e', [Some('i'), Some('g'), Some('h'), Some('t')]) => {
                            stack.push(8);
                        }
                        _ => {}
                    }
                    match (c, c_iter.peek_amount(3)) {
                        ('f', [Some('o'), Some('u'), Some('r')]) => {
                            stack.push(4);
                        }
                        ('f', [Some('i'), Some('v'), Some('e')]) => {
                            stack.push(5);
                        }
                        ('n', [Some('i'), Some('n'), Some('e')]) => {
                            stack.push(9);
                        }
                        _ => {}
                    }
                }
            },
            None => break,
        }
    }
    let digits = stack.inner;
    dbg!(&digits);
    match digits.len() {
        0 => {
            return 0;
        }
        1 => {
            return digits[0] * 10 + digits[0];
        }
        2 => {
            return digits[0] * 10 + digits[1];
        }
        _ => {
            panic!("illegal state");
        }
    }
}

fn main() -> Result<()> {
    let input = Path::new("./input/part2.txt");
    let input_file = File::open(input)?;
    let mut buf_reader = BufReader::new(input_file);
    let mut buffer = String::new();

    let mut calibration_sum = 0;

    while let Ok(len) = buf_reader.read_line(&mut buffer) {
        if len == 0 {
            break;
        }
        let calibration = find_calibration(&buffer);
        println!("calibration for line {buffer} is {calibration}");
        calibration_sum += calibration;
        buffer.clear();
    }

    println!("sum => {calibration_sum}");

    Ok(())
}
