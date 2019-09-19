use std::ffi::OsStr;
use std::path::Path;

fn main() {
    if let Err(()) = main_() {
        std::process::exit(1);
    }
}

fn main_() -> Result<(), ()> {
    let mut args = std::env::args_os();
    let _ = args.next();
    if args.len() == 0 {
        usage();
        return Err(());
    }

    for path in args {
        // safety mechanism because we only provide an in-place mode;
        // we don't want to destroy a binary file!
        if !file_is_text(&path) {
            let path: &Path = path.as_ref();
            eprintln!("skipping file not detected as text: {}", path.display());
            continue;
        }

        let input = std::fs::read(&path).unwrap();

        let output = strip_stuff_before_crs(&input);

        std::fs::write(&path, output).unwrap();
    }

    Ok(())
}

fn strip_stuff_before_crs(mut input: &[u8]) -> Vec<u8> {
    let mut output = vec![];
    let mut push_text_without_crs = |line: &[u8]| {
        let start = line.iter().rposition(|&c| c == b'\r').map_or(0, |cr| cr + 1);
        output.extend(line[start..].iter().copied());
    };

    while let Some(newline) = input.iter().position(|&c| c == b'\n') {
        let (line, remainder) = input.split_at(newline + 1);
        push_text_without_crs(line);
        input = remainder;
    }
    push_text_without_crs(input);

    output
}

fn file_is_text(path: impl AsRef<OsStr>) -> bool {
    use std::process::{Command, Stdio};
    let output = {
        Command::new("file")
            .arg("-b").arg("--mime-type")
            .arg(path)
            .stdout(Stdio::piped())
            .output().unwrap().stdout
    };
    trim_bstr(&output) == b"text/plain"
}

fn trim_bstr(bytes: &[u8]) -> &[u8] {
    match bytes.iter().position(|&b| !b.is_ascii_whitespace()) {
        None => b"",
        Some(start) => {
            let end = 1 + bytes.iter().rposition(|b| !b.is_ascii_whitespace()).unwrap();
            &bytes[start..end]
        },
    }
}

fn usage() {
    eprintln!("USAGE: no-cr FILE [FILE...]");
    eprintln!("Removes lines ending in CR (0x0d, ^M) from a log file, to resemble console output.");
}
