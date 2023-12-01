use anyhow::Result;
use std::{
    fs::File,
    io::{BufRead, BufReader},
    path::Path,
};

fn main() -> Result<()> {
    let input_path = Path::new("./input/part1.txt");
    let file = File::open(input_path)?;

    let mut reader = BufReader::new(file);
    let mut buffer = String::new();

    let mut calibration_sum: u32 = 0;

    while let Ok(len) = reader.read_line(&mut buffer) {
        if len == 0 {
            break;
        }

        let mut first = 0;

        for c in buffer.chars() {
            match c.to_digit(10) {
                Some(digit) => {
                    first = digit;
                    break;
                }
                None => {}
            }
        }

        let mut second = 0;

        for c in buffer.chars().rev() {
            match c.to_digit(10) {
                Some(digit) => {
                    second = digit;
                    break;
                }
                None => {}
            }
        }

        calibration_sum += first * 10;

        calibration_sum += second;

        buffer.clear();
    }

    println!("sum => {calibration_sum}");

    Ok(())
}
